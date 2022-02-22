import React, { useState, useCallback } from "react";
import logo from "../../assets/images/logo.png";
import "./App.css";
import Metamask from "../../components/Metamask";
import Collection from "../../components/Collection";

function App() {
  const [menu, setMenu] = useState(0);

  const handleMenuChange = useCallback((id) => {
    setMenu(id)
  }, [menu])

  const isSelectedMenu = useCallback((id) => {
    return menu === id
  }, [menu])

  const selectedMenuStyle = useCallback((id) => {
    return menu === id ? {textDecoration: "underline", color: "#e0537d"} : {}
  }, [menu])
  
  return (
    <div className="App">
      <header className="App-header">
        <h1>Homework collectibles</h1>

        <img src={logo} className="App-logo" alt="logo" />

        <ul className="App-menu">
          <li style={selectedMenuStyle(0)} onClick={()=>{handleMenuChange(0)}}>Buy</li>
          <li style={selectedMenuStyle(1)} onClick={()=>{handleMenuChange(1)}}>Collection</li>
          <li style={selectedMenuStyle(2)} onClick={()=>{handleMenuChange(2)}}>Useful links</li>
        </ul>

        { isSelectedMenu(0) &&
          <Metamask></Metamask>
        }
        { isSelectedMenu(1) &&
          <Collection></Collection>
        }
      </header>
    </div>
  );
}

export default App;
