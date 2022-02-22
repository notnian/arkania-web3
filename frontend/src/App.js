import logo from './logo.png';
import './App.css';
import Metamask from './Metamask';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Homework collectibles</h1>
        <img src={logo} className="App-logo" alt="logo" />
        <h3>Metamask connect x Nft Mint</h3>
        <p>Mint cost: 0.001eth</p>
        <Metamask></Metamask>
      </header>
    </div>
  );
}

export default App;
