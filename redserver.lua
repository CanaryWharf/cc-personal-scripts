-- Server metaclass
RedServer = {}

--- Create a new redserver
-- @param side rednet is connected to
-- @param order map, key with the request type (in header)
--        and value being the function that will be called
function RedServer:new(modemSide, orderMap)
    serverInstance = {
        modemSide = modemSide,
        orderMap = orderMap,
    }
    self.__index = self
    return setmetatable(serverInstance, self)
end

function RedServer:listenForRequests()
    rednet.open(self.modemSide)
    senderId, message = rednet.receive()
    rednet.close(self.modemSide)
    return senderId, textutils.unserialize(message)
end


function RedServer:processRequest(message)
    requestType = message.requestType
    messageArgs = message.args
    response = self.orderMap[requestType](messageArgs)
end

function RedServer:sendResponse(recipientId, response)
    rednet.open(self.modemSide)
    rednet.send(recipientId, textutils.serialize(response))
    rednet.close(self.modemSide)
end

function RedServer:serverLoop()
    senderId, message = self.listenForRequests()
    response = self.processRequest(message)
    sendResponse(senderId, response)
end

function RedServer:serve()
    while true do
        self.serverLoop()
    end
end
