import React, { useState } from "react";
import { ethers } from "ethers";
import HomeworkToken_abi from './contracts/HomeworkToken_abi.json'

const Metamask = ()=>{
    const contractAddress = '0xf4f2fcD073912D08EEDeA09Ac49eEd4F40803364';

    const [account, setAccount] = useState("");
    const [buttonText, setButtonText] = useState("Connect to metamask");
    const [balance, setBalance] = useState(0);
    const [errorMessage, setErrorMessage] = useState(null);

    const [provider, setProvider] = useState(null);
    const [signer, setSigner] = useState(null);
    const [contract, setContract] = useState(null);
    const [etherscanLink, setEtherscanLink] = useState(null);

    const connectHandler = ()=>{
        if(window.ethereum && window.ethereum.isMetaMask){
            window.ethereum.request({method: "eth_requestAccounts"})
            .then((result) => {
                accountChangeHandler(result[0])
                setButtonText('Wallet Connected')
            })
            .catch(error => {
				setErrorMessage(error.message)
			});
        } else {
            setErrorMessage("Please install metamask")
        }
    }

    const accountChangeHandler = (newAccount)=>{
        setAccount(newAccount)
        fetchUserBalance(newAccount.toString())
        updateEthers();
    }

    const fetchUserBalance = (address)=>{
        window.ethereum.request({method: 'eth_getBalance', params: [address, 'latest']})
        .then(b => setBalance(ethers.utils.formatEther(b).toString() + " eth"))
    }

    const updateEthers = () => {
		let tempProvider = new ethers.providers.Web3Provider(window.ethereum);
		setProvider(tempProvider);

		let tempSigner = tempProvider.getSigner();
		setSigner(tempSigner);

		let tempContract = new ethers.Contract(contractAddress, HomeworkToken_abi, tempSigner);
		setContract(tempContract);
    }

    const mintNft = async ()=> {
        const tx = await contract.safeMint({value: ethers.utils.parseEther("0.001")})
        setEtherscanLink(`https://${provider.network.name}.etherscan.io/tx/${tx.hash}`)
    }

    window.ethereum.on('accountsChanged', accountChangeHandler)
    window.ethereum.on("chainChanged", () => window.location.reload());

    return (
        <div className="metamask">
            <button onClick={connectHandler}>{buttonText}</button><br />
            <div>
                <p>Address: {account}</p>
            </div>
            <div>
                <p>Balance: {balance}</p>
            </div>
            <hr />

            <button onClick={mintNft}>Mint nft</button>

            <p><strong>Etherscan link:</strong><a href={etherscanLink}>{etherscanLink}</a></p>

            {errorMessage}
        </div>
    )
}

export default Metamask;