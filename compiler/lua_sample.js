local i = 5
local a, b
local c, d, e = 1, "a"
function afun() 
    local i, b
    for i = 1, 10, 2 do 
        print(i);
        print(i);
    end 
end
(function (M) {
    (function (Token) {
        Token._map
        Token._map[0] = "ID";
        Token.ID
        Token._map[1] = "Param";
        Token.Param
        Token._map[2] = "Oper";
        Token.Oper
    })(M.Token || (M.Token = {}));
    var Token = M.Token;
    local Parent = Object:extend()
    function initialize:initialize(id) 
    end
    function Parent:say() 
        print(self.name);
        print(self.id);
    end
    function Parent:test() 
    end
    function Parent:why() 
    end

    M.Parent = Parent;    
    local Child = Parent:extend()
    function initialize:initialize(field, date) 
        _super.call(this, 2);
        self.field = field;
        self.date = date;
    end
    function Child:say() 
        print("say");
    end
    function Child:test() 
    end
Parent    
})(exports.M || (exports.M = {}));
var M = exports.M;
1 + 2 ~= 3;
function afun2() 
    for i = 1, 10, 2 do 
        print(i);
        print(i);
    end 
end
local ifa
if ifa == nil then 
    print(a);
end
if 1 + 1 == 2 and 1 + 2 >= 3 then 
    print("true");
elseif 1 + 2 ~= 3 then 
    print("true");
else 
    print("false");
end
repeat 
    print("Hello");
until 1 + 1 ~= 2
while 1 + 1 ~= 2 do 
    print("true");
end 
