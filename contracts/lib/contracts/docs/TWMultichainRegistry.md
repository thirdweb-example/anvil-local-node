# TWMultichainRegistry









## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### OPERATOR_ROLE

```solidity
function OPERATOR_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### add

```solidity
function add(address _deployer, address _deployment, uint256 _chainId, string metadataUri) external nonpayable
```

Add a deployment for a deployer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _deployer | address | undefined |
| _deployment | address | undefined |
| _chainId | uint256 | undefined |
| metadataUri | string | undefined |

### count

```solidity
function count(address _deployer) external view returns (uint256 deploymentCount)
```

Get the total number of deployments for a deployer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _deployer | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| deploymentCount | uint256 | undefined |

### getAll

```solidity
function getAll(address _deployer) external view returns (struct ITWMultichainRegistry.Deployment[] allDeployments)
```

Get all deployments for a deployer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _deployer | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| allDeployments | ITWMultichainRegistry.Deployment[] | undefined |

### getMetadataUri

```solidity
function getMetadataUri(uint256 _chainId, address _deployment) external view returns (string metadataUri)
```

Returns the metadata IPFS URI for a deployment on a given chain if previously registered via add().



#### Parameters

| Name | Type | Description |
|---|---|---|
| _chainId | uint256 | undefined |
| _deployment | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| metadataUri | string | undefined |

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```



*Returns the admin role that controls `role`. See {grantRole} and {revokeRole}. To change a role&#39;s admin, use {_setRoleAdmin}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### getRoleMember

```solidity
function getRoleMember(bytes32 role, uint256 index) external view returns (address)
```



*Returns one of the accounts that have `role`. `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive. Role bearers are not sorted in any particular way, and their ordering may change at any point. WARNING: When using {getRoleMember} and {getRoleMemberCount}, make sure you perform all queries on the same block. See the following https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post] for more information.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| index | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getRoleMemberCount

```solidity
function getRoleMemberCount(bytes32 role) external view returns (uint256)
```



*Returns the number of accounts that have `role`. Can be used together with {getRoleMember} to enumerate all bearers of a role.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### grantRole

```solidity
function grantRole(bytes32 role, address account) external nonpayable
```



*Grants `role` to `account`. If `account` had not been already granted `role`, emits a {RoleGranted} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleGranted} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```



*Returns `true` if `account` has been granted `role`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isTrustedForwarder

```solidity
function isTrustedForwarder(address forwarder) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| forwarder | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### multicall

```solidity
function multicall(bytes[] data) external nonpayable returns (bytes[] results)
```



*Receives and executes a batch of function calls on this contract.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| data | bytes[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| results | bytes[] | undefined |

### remove

```solidity
function remove(address _deployer, address _deployment, uint256 _chainId) external nonpayable
```

Remove a deployment for a deployer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _deployer | address | undefined |
| _deployment | address | undefined |
| _chainId | uint256 | undefined |

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from the calling account. Roles are often managed via {grantRole} and {revokeRole}: this function&#39;s purpose is to provide a mechanism for accounts to lose their privileges if they are compromised (such as when a trusted device is misplaced). If the calling account had been revoked `role`, emits a {RoleRevoked} event. Requirements: - the caller must be `account`. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from `account`. If `account` had been granted `role`, emits a {RoleRevoked} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |



## Events

### Added

```solidity
event Added(address indexed deployer, address indexed deployment, uint256 indexed chainId, string metadataUri)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| deployer `indexed` | address | undefined |
| deployment `indexed` | address | undefined |
| chainId `indexed` | uint256 | undefined |
| metadataUri  | string | undefined |

### Deleted

```solidity
event Deleted(address indexed deployer, address indexed deployment, uint256 indexed chainId)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| deployer `indexed` | address | undefined |
| deployment `indexed` | address | undefined |
| chainId `indexed` | uint256 | undefined |

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| previousAdminRole `indexed` | bytes32 | undefined |
| newAdminRole `indexed` | bytes32 | undefined |

### RoleGranted

```solidity
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### RoleRevoked

```solidity
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |



