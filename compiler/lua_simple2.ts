-----------------------------------------------------------------------------
-- Low level FTP API
-----------------------------------------------------------------------------
local metat = { __index = {} }
local a={"aaa",1,2}

function open(server, port, create)
    local tp = socket.try(tp.connect(server, port or PORT, TIMEOUT, create))
    local f = base.setmetatable({ tp = tp }, metat)
    --make sure everything gets closed in an exception
    f.try = socket.newtry(function() f:close() end)
    return f
end

function metat.__index:portconnect()
    self.try(self.server:settimeout(TIMEOUT))
    self.data = self.try(self.server:accept())
    self.try(self.data:settimeout(TIMEOUT))
end

function metat.__index:pasvconnect()
    self.data = self.try(socket.tcp())
    self.try(self.data:settimeout(TIMEOUT))
    self.try(self.data:connect(self.pasvt.ip, self.pasvt.port))
end

function metat.__index:login(user, password)
    self.try(self.tp:command("user", user or USER))
    local code, reply = self.try(self.tp:check{"2..", 331})
    if code == 331 then
        self.try(self.tp:command("pass", password or PASSWORD))
        self.try(self.tp:check("2.."))
    end
    return 1
end

function metat.__index:pasv()
    self.try(self.tp:command("pasv"))
    local code, reply = self.try(self.tp:check("2.."))
    local pattern = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
    local a, b, c, d, p1, p2 = socket.skip(2, string.find(reply, pattern))
    self.try(a and b and c and d and p1 and p2, reply)
    self.pasvt = {
        ip = string.format("%d.%d.%d.%d", a, b, c, d),
        port = p1*256 + p2
    }
    if self.server then
        self.server:close()
        self.server = nil
    end
    return self.pasvt.ip, self.pasvt.port
end