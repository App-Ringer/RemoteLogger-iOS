# RemoteLogger-iOS


## Configure
RemoteLogger.register("BLOCK_CALLS")

## setTag
`RemoteLogger.setTag("Kush")`

## setLevel
`RemoteLogger.setLevel("Info")`

## Log Description with json[optional] & tag[optional]
`RemoteLogger.log(desc, json, tag)`

## Log Exception
`RemoteLogger.log(exception)`

## Debug level directly: Irrespective of current level
### Log Description  with json[optional] & tag[optional] 
`RemoteLogger.debug(desc, json, tag)`

### Log Exception
`RemoteLogger.debug(exception)`

## Info level directly: Irrespective of current level
### Log Description with json[optional] & tag[optional]
`RemoteLogger.info(desc, json, tag)`

### Log Exception
`RemoteLogger.info(exception)`

## Error level directly: Irrespective of current level
### Log Description with json[optional] & tag[optional]
`RemoteLogger.error(desc, json, tag)`

### Log Exception
`RemoteLogger.error(exception)`


## Possible Errors:
* Invalid API key: Key you passed in `register` method is invalid
* API key is missing: You forgot to call `register` method
