import React from "react";

const Card = ({ id, title, children }) => {
  return (
    <div className="Card">
      <img
        className="Card-image"
        src={`https://github.com/notnian/arkania-web3/blob/main/assets/build/pixel_images/${id}.png?raw=true`}
        alt={id}
      />
      <div className="Card-title">
        <strong>
          {title} #{id}
        </strong>
        <div>
          <a className="Card-link" href={`https://testnets.opensea.io/assets/0xb591c7e605341357df6aF4c5142d840e1D21F609/${id}`}>
            Voir sur opensea
          </a>
        </div>
      </div>
    </div>
  );
};

export default Card;
