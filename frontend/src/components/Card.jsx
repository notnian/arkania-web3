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
          <a className="Card-link" href={`https://testnets.opensea.io/assets/0xf4f2fcd073912d08eedea09ac49eed4f40803364/${id}`}>
            Voir sur opensea
          </a>
        </div>
      </div>
    </div>
  );
};

export default Card;
