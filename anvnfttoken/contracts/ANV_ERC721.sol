pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address payable newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


contract ANV_ERC721 is ERC721 , Ownable {

    /* This generates a public event on the blockchain that will notify clients */
    event FrozenFunds(address target, bool frozen);



    constructor ()
    ERC721("Aniverse NFT", "ANVNFT")

    {

    }

    /**
    * create NFT token

    */
    function mint(
        address _to,
        uint256 _tokenId,
        string memory  _IPFSHASH
    ) public virtual onlyOwner
    {
        super._mint(_to, _tokenId);
        super._setIPFSHASH(_tokenId, _IPFSHASH);
    }

    /**
    * burn NFT token
    */
    function burn (
        uint256 _tokenId
    ) public virtual
    {
        address owner = ERC721.ownerOf(_tokenId);
        require(msg.sender != owner, "ERC721: not owner");

        super._burn( _tokenId);
    }


    /// @notice `freeze? Prevent | Allow` `target` from sending & receiving tokens
    /// @param target Address to be frozen
    /// @param freeze either to freeze it or not
    function freezeAccount(address target, bool freeze)  public onlyOwner {
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }


}