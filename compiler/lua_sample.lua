var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
function afun() {
    var i, b;
    for(i = 1; 10; 2) {
        print(i);
        print(i);
    }
}
var M;
(function (M) {
    var Token;
    (function (Token) {
        Token._map = [];
        Token._map[0] = "ID";
        Token.ID = 0;
        Token._map[1] = "Param";
        Token.Param = 1;
        Token._map[2] = "Oper";
        Token.Oper = 2;
    })(Token || (Token = {}));
    var Parent = (function () {
        function Parent() { }
        Parent.prototype.say = function () {
            print("say");
        };
        Parent.prototype.test = function () {
        };
        Parent.prototype.why = function () {
        };
        return Parent;
    })();    
    var Child = (function (_super) {
        __extends(Child, _super);
        function Child(field, date) {
            supper();
            this.field = field;
            this.date = date;
        }
        Child.prototype.say = function () {
            print("say");
        };
        Child.prototype.test = function () {
        };
        return Child;
    })(Parent);    
})(M || (M = {}));
1 + 2 ~= 3;
function afun2() {
    for(i = 1; 10; 2) {
        print(i);
        print(i);
    }
}
if(1 + 1 == 2 and 1 + 2 >= 3) {
    print("true");
} else {
    print("false");
}
do {
    print("Hello");
}while(1 + 1 ~= 2)
while(1 + 1 ~= 2) {
    print("true");
}
var i = 5;
var a, b;
var c = 1, d = "a", e;
