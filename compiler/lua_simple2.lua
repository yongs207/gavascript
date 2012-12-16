local metat = {
    __index = {
    }
}
function open(server, port, create) 
    local tp = socket.try(tp.connect(server, port or PORT, TIMEOUT, create))
    local f = base.setmetatable({
        tp = tp
    }, metat)
    f.try = socket.newtry(function () 
        f:close();
    end);
    return f ;
end
function metat.__index:portconnect() 
    self.try(self.server:settimeout(TIMEOUT));
    self.data = self.try(self.server:accept());
    self.try(self.data:settimeout(TIMEOUT));
end
function metat.__index:pasvconnect() 
    self.data = self.try(socket.tcp());
    self.try(self.data:settimeout(TIMEOUT));
    self.try(self.data:connect(self.pasvt.ip, self.pasvt.port));
end
function metat.__index:login(user, password) 
    self.try(self.tp:command("user", user or USER));
    local code, reply = self.try(self.tp:check({
        "2..",
        331
    }))
    if code == 331 then 
        self.try(self.tp:command("pass", password or PASSWORD));
        self.try(self.tp:check("2.."));
    end
    return 1 ;
end
function metat.__index:pasv() 
    self.try(self.tp:command("pasv"));
    local code, reply = self.try(self.tp:check("2.."))
    local pattern = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
    local a, b, c, d, p1, p2 = socket.skip(2, string.find(reply, pattern))
    self.try(a and b and c and d and p1 and p2, reply);
    self.pasvt = {
        ip = string.format("%d.%d.%d.%d", a, b, c, d),
        port = p1 * 256 + p2
    };
    if self.server then 
        self.server:close();
        self.server = nil;
    end
    return self.pasvt.ip, self.pasvt.port ;
end
function metat.__index:port(ip, port) 
    self.pasvt = nil;
    if  not ip then 
        ip, port = self.try(self.tp:getcontrol():getsockname());
        self.server = self.try(socket.bind(ip, 0));
        ip, port = self.try(self.server:getsockname());
        self.try(self.server:settimeout(TIMEOUT));
    end
    local pl = math.mod(port, 256)
    local ph = (port - pl) / 256
    local arg = string.gsub(string.format("%s,%d,%d", ip, ph, pl), "%.", ",")
    self.try(self.tp:command("port", arg));
    self.try(self.tp:check("2.."));
    return 1 ;
end
function metat.__index:send(sendt) 
    self.try(self.pasvt or self.server, "need port or pasv first");
    if self.pasvt then 
        self:pasvconnect();
    end
    local argument = sendt.argument or url.unescape(string.gsub(sendt.path or "", "^[/\\]", ""))
    if argument == "" then 
        argument = nil;
    end
    local command = sendt.command or "stor"
    self.try(self.tp:command(command, argument));
    local code, reply = self.try(self.tp:check({
        "2..",
        "1.."
    }))
    if  not self.pasvt then 
        self:portconnect();
    end
    local step = sendt.step or ltn12.pump.step
    local readt = {
        self.tp.c
    }
    local checkstep = function (src, snk) 
        local readyt = socket.select(readt, nil, 0)
        if readyt[tp] then 
            code = self.try(self.tp:check("2.."));
        end
        return step(src, snk) ;
    end
    local sink = socket.sink("close-when-done", self.data)
    self.try(ltn12.pump.all(sendt.source, sink, checkstep));
    if string.find(code, "1..") then 
        self.try(self.tp:check("2.."));
    end
    self.data:close();
    local sent = socket.skip(1, self.data:getstats())
    self.data = nil;
    return sent ;
end
function metat.__index:receive(recvt) 
    self.try(self.pasvt or self.server, "need port or pasv first");
    if self.pasvt then 
        self:pasvconnect();
    end
    local argument = recvt.argument or url.unescape(string.gsub(recvt.path or "", "^[/\\]", ""))
    if argument == "" then 
        argument = nil;
    end
    local command = recvt.command or "retr"
    self.try(self.tp:command(command, argument));
    local code = self.try(self.tp:check({
        "1..",
        "2.."
    }))
    if  not self.pasvt then 
        self:portconnect();
    end
    local source = socket.source("until-closed", self.data)
    local step = recvt.step or ltn12.pump.step
    self.try(ltn12.pump.all(source, recvt.sink, step));
    if string.find(code, "1..") then 
        self.try(self.tp:check("2.."));
    end
    self.data:close();
    self.data = nil;
    return 1 ;
end
function metat.__index:cwd(dir) 
    self.try(self.tp:command("cwd", dir));
    self.try(self.tp:check(250));
    return 1 ;
end
function metat.__index:type(type) 
    self.try(self.tp:command("type", type));
    self.try(self.tp:check(200));
    return 1 ;
end
function metat.__index:greet() 
    local code = self.try(self.tp:check({
        "1..",
        "2.."
    }))
    if string.find(code, "1..") then 
        self.try(self.tp:check("2.."));
    end
    return 1 ;
end
function metat.__index:quit() 
    self.try(self.tp:command("quit"));
    self.try(self.tp:check("2.."));
    return 1 ;
end
function metat.__index:close() 
    if self.data then 
        self.data:close();
    end
    if self.server then 
        self.server:close();
    end
    return self.tp:close() ;
end
