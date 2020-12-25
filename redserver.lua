MODEM_SIDE = "top"

function getItemCount(tab)
    return 0
end

function findItem(tab)
    return 9
end

ORDER_MAP = {
    ["count"] = getItemcount,
    ["find"] = findItem,
}

function listenForRequests()
    rednet.open(MODEM_SIDE)
    senderId, message = rednet.receive()
    rednet.close(MODEM_SIDE)
    return senderId, textutils.unserialize(message)
end


function processRequest(message)
    requestType = message.requestType
    messageArgs = message.args
    response = ORDER_MAP[requestType](messageArgs)
end

function sendResponse(recipientId, response)
    rednet.open(MODEM_SIDE)
    rednet.send(recipientId, textutils.serialize(response))
    rednet.close(MODEM_SIDE)
end

function serverLoop()
    senderId, message = listenForRequests()
    response = processRequest(message)
    sendResponse(senderId, response)
end

function main()
    while true do
        serverLoop()
    end
end


print(getItemcount(tab))
