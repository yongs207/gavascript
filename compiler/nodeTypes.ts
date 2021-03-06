// Copyright (c) Microsoft. All rights reserved. Licensed under the Apache License, Version 2.0. 
// See LICENSE.txt in the project root for complete license information.

///<reference path='typescript.ts' />

module TypeScript {
    export enum NodeType {
        None,
        Empty,
        EmptyExpr,
        True,
        False,
        Self,
        Super,
        QString,
        Regex,
        Null,
        ArrayLit,
        ObjectLit,
        Void,
        Comma,
        Pos,
        Neg,
        Delete,
        Await,
        In,
        Dot,
        Colon,
        From,
        Is,
        InstOf,
        Typeof,
        NumberLit,
        Name,
        TypeRef,
        Index,
        Call,
        New,
        Asg,
        SignalObj,
        AsgList,
        //AsgAdd,
        //AsgSub,
        //AsgDiv,
        //AsgMul,
        //AsgMod,
        //AsgAnd,
        //AsgXor,
        //AsgOr,
        //AsgLsh,
        //AsgRsh,
        //AsgRs2,
        QMark,
        LogOr,
        LogAnd,
        Or,
        //Xor,
        And,
        Eq,
        Ne,
        //Eqv,
        //NEqv,
        Lt,
        Le,
        Gt,
        Ge,
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        //Lsh,
        //Rsh,
        //Rs2,
        Not,
        LogNot,
        //IncPre,
        //DecPre,
        //IncPost,
        //DecPost,
        TypeAssertion,
        FuncDecl,
        Member,
        VarDecl,
        ArgDecl,
        Return,
        Break,
        Continue,
        Throw,
        For,
        ForIn,
        If,
        While,
        Repeat,
        Block,
        //Case,
        //Switch,
        //Try,
        //TryCatch,
        //TryFinally,
        //Finally,
        //Catch,
        List,
        Script,
        Class,
        Interface,
        Module,
        Import,
        //With,
        Label,
        LabeledStatement,
        EBStart,
        GotoEB,
        EndCode,
        Error,
        Comment,
        Debugger,
        GeneralNode = FuncDecl,
        //LastAsg = AsgRs2,
    }
}