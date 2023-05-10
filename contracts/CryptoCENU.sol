// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}
contract CryptoCENU {
    using SafeMath for uint256;
    mapping(address => uint256) private _balance;

    mapping(address => mapping(address => uint256)) private _allowance;
    uint256 private _totalSupply;
    uint8 private _decimals;
    string private _symbol;
    string private _name;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor() {
        _name = "consensus token";
        _symbol = "CENU";
        _decimals = 18;
        _totalSupply = 10000000 * 10**26;
        _balance[msg.sender] = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }
    function currency_circulation()external view returns(uint256){
        return _totalSupply.sub(_balance[address(0)].add(_balance[address(0xdead)]));
    }
    function name() external view returns (string memory) {
      return _name;
    }
    function balanceOf(address account)external view returns(uint256){
        return _balance[account];
    }
    function symbol() external view returns (string memory) {
      return _symbol;
    }
    function decimals() external view returns (uint8) {
      return _decimals;
    }
    function allowance(address owner, address spender) external view returns(uint256){
        return _allowance[owner][spender];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowance[sender][msg.sender].sub(
                amount,
                "CENU: transfer amount exceeds _allowance"
            )
        );
        return true;
    }

    function increase_allowance(address spender, uint256 addedValue)
        external
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            _allowance[msg.sender][spender].add(addedValue)
        );
        return true;
    }

    function decrease_allowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            _allowance[msg.sender][spender].sub(
                subtractedValue,
                "CENU: decreased _allowance below zero"
            )
        );
        return true;
    }

    event Burn(address indexed from, address indexed to, uint256 value);

    function burn(uint256 amount) external returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "CENU: burn from the zero address");
        _balance[account] = _balance[account].sub(
            amount,
            "CENU: burn amount exceeds balance"
        );
        _balance[address(0)] = _balance[address(0)].add(amount);
        emit Burn(account, address(0), amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "CENU: transfer from the zero address");
        require(recipient != address(0), "CENU: transfer to the zero address");

        _balance[sender] = _balance[sender].sub(
            amount,
            "CENU: transfer amount exceeds balance"
        );
        _balance[recipient] = _balance[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual  {
        require(owner != address(0), "CENU: approve from the zero address");
        require(spender != address(0), "CENU: approve to the zero address");

        _allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}