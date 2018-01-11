unit MainUnit;

//***************************************************************************************
// XMVector Sample by Frank Luna (C) 2015 All Rights Reserved.
//***************************************************************************************
// Pascal Translation by Sonnleitner Norbert (C) 2018
// Coding DirectX is fun, Coding Pascal is more fun, Coding DirectX with Pascal is the best
//***************************************************************************************

{$mode delphi}{$H+}

interface

uses
    Windows, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
    DirectX.Math;

type

    { TForm1 }

    TForm1 = class(TForm)
        btnInitFunctions: TButton;
        btnTolerance: TButton;
        btnXMVec3: TButton;
        btnVectorOops: TButton;
        Memo1: TMemo;
        procedure btnInitFunctionsClick(Sender: TObject);
        procedure btnToleranceClick(Sender: TObject);
        procedure btnVectorOopsClick(Sender: TObject);
        procedure btnXMVec3Click(Sender: TObject);
    private

    public

    end;

var
    Form1: TForm1;

implementation

uses
    Math;

{$R *.lfm}


function DebugXMVectorFloat(constref v: TXMVector): ansistring;
begin
    Result := 'X: ' + formatfloat('0.000000000E+00', V.f32[0]) + ', Y: ' + formatfloat('0.000000000E+00', V.f32[1]) +
        ', Z: ' + formatfloat('0.000000000E+00', V.f32[2]) + ', W: ' + formatfloat('0.000000000E+00', V.f32[3]);
end;



function DebugXMVectorIntHex(constref v: TXMVector): ansistring;
begin
    Result := 'X: ' + IntToHex(V.u32[0], 8) + ', Y: ' + IntToHex(V.u32[1], 8) + ', Z: ' + IntToHex(V.u32[2], 8) + ', W: ' + IntToHex(V.u32[3], 8);
end;



function DebugXMVectorInt(constref v: TXMVector): ansistring;
begin
    Result := 'X: ' + formatfloat('0.000000000E+00', V.u32[0]) + ', Y: ' + formatfloat('0.000000000E+00', V.u32[1]) +
        ', Z: ' + formatfloat('0.000000000E+00', V.u32[2]) + ', W: ' + formatfloat('0.000000000E+00', V.u32[3]);
end;



{ TForm1 }

procedure TForm1.btnInitFunctionsClick(Sender: TObject);
var
    p, q, u, v, w: TXMVECTOR;
begin
    Memo1.Clear;
    p := XMVectorZero();
    q := XMVectorSplatOne();
    u := XMVectorSet(1.0, 2.0, 3.0, 0.0);
    v := XMVectorReplicate(-2.0);
    w := XMVectorSplatZ(u);

    Memo1.Lines.Add('p := XMVectorZero();');
    Memo1.Lines.Add('p: ' + DebugXMVectorFloat(p));
    Memo1.Lines.Add('');

    Memo1.Lines.Add('q := XMVectorSplatOne();');
    Memo1.Lines.Add('q: ' + DebugXMVectorFloat(q));
    Memo1.Lines.Add('');

    Memo1.Lines.Add('u := XMVectorSet(1.0, 2.0, 3.0, 0.0);');
    Memo1.Lines.Add('u: ' + DebugXMVectorFloat(u));
    Memo1.Lines.Add('');

    Memo1.Lines.Add('v := XMVectorReplicate(-2.0);');
    Memo1.Lines.Add('v: ' + DebugXMVectorFloat(v));
    Memo1.Lines.Add('');

    Memo1.Lines.Add('w := XMVectorSplatZ(u);');
    Memo1.Lines.Add('w: ' + DebugXMVectorFloat(w));
end;



procedure TForm1.btnToleranceClick(Sender: TObject);
var
    u, n: TXMVECTOR;
    LU, powLU: single;
begin
    Memo1.Clear;

    u := XMVectorSet(1.0, 1.0, 1.0, 0.0);
    n := XMVector3Normalize(u);

    LU := XMVectorGetX(XMVector3Length(n));

    // Mathematically, the length should be 1.  Is it numerically?
    Memo1.Lines.Add('LU: ' + formatfloat('0.000000000E+00', LU));
    if (LU = 1.0) then
        Memo1.Lines.Add('Length 1')
    else
        Memo1.Lines.Add('Length not 1');
    Memo1.Lines.Add('');

    // Raising 1 to any power should still be 1.  Is it?
    powLU := power(LU, 1.0e6);
    Memo1.Lines.Add('LU^(10^6): ' + formatfloat('0.000000000E+00', powLU));

end;



procedure TForm1.btnVectorOopsClick(Sender: TObject);
var
    p, q, u, v, w: TXMVECTOR;
begin
    Memo1.Clear;

    p := XMVectorSet(2.0, 2.0, 1.0, 0.0);
    q := XMVectorSet(2.0, -0.5, 0.5, 0.1);
    u := XMVectorSet(1.0, 2.0, 4.0, 8.0);
    v := XMVectorSet(-2.0, 1.0, -3.0, 2.5);
    w := XMVectorSet(0.0, XM_PIDIV4, XM_PIDIV2, XM_PI);

    Memo1.Lines.Add('XMVectorAbs(v)                 = ' + DebugXMVectorFloat(XMVectorAbs(v)));
    Memo1.Lines.Add('XMVectorCos(w)                 = ' + DebugXMVectorFloat(XMVectorCos(w)));
    Memo1.Lines.Add('XMVectorLog(u)                 = ' + DebugXMVectorFloat(XMVectorLog(u)));
    Memo1.Lines.Add('XMVectorExp(p)                 = ' + DebugXMVectorFloat(XMVectorExp(p)));

    Memo1.Lines.Add('XMVectorPow(u, p)              = ' + DebugXMVectorFloat(XMVectorPow(u, p)));
    Memo1.Lines.Add('XMVectorSqrt(u)                = ' + DebugXMVectorFloat(XMVectorSqrt(u)));

    Memo1.Lines.Add('XMVectorSwizzle(u, 2, 2, 1, 3) = ' + DebugXMVectorFloat(XMVectorSwizzle(u, 2, 2, 1, 3)));
    Memo1.Lines.Add('XMVectorSwizzle(u, 2, 1, 0, 3) = ' + DebugXMVectorFloat(XMVectorSwizzle(u, 2, 1, 0, 3)));

    Memo1.Lines.Add('XMVectorMultiply(u, v)         = ' + DebugXMVectorFloat(XMVectorMultiply(u, v)));
    Memo1.Lines.Add('XMVectorSaturate(q)            = ' + DebugXMVectorFloat(XMVectorSaturate(q)));
    Memo1.Lines.Add('XMVectorMin(p, v               = ' + DebugXMVectorFloat(XMVectorMin(p, v)));
    Memo1.Lines.Add('XMVectorMax(p, v)              = ' + DebugXMVectorFloat(XMVectorMax(p, v)));
end;



procedure TForm1.btnXMVec3Click(Sender: TObject);
var
    n, u, v, w, a, b, c, L, d, s, e: TXMVECTOR;
    projW, perpW: TXMVECTOR;
    equal, notEqual: boolean;
    angleVec: TXMVECTOR;
    angleRadians, angleDegrees: single;
begin
    Memo1.Clear;

    n := XMVectorSet(1.0, 0.0, 0.0, 0.0);
    u := XMVectorSet(1.0, 2.0, 3.0, 0.0);
    v := XMVectorSet(-2.0, 1.0, -3.0, 0.0);
    w := XMVectorSet(0.707, 0.707, 0.0, 0.0);

    // Vector addition: XMVECTOR operator +
    a := u + v;

    // Vector subtraction: XMVECTOR operator -
    b := u - v;

    // Scalar multiplication: XMVECTOR operator *
    c := u * 10;

    // ||u||
    L := XMVector3Length(u);

    // d = u / ||u||
    d := XMVector3Normalize(u);

    // s = u dot v
    s := XMVector3Dot(u, v);

    // e = u x v
    e := XMVector3Cross(u, v);

    // Find proj_n(w) and perp_n(w)

    XMVector3ComponentsFromNormal(projW, perpW, w, n);

    // Does projW + perpW == w?
    equal := XMVector3Equal(projW + perpW, w);
    notEqual := XMVector3NotEqual(projW + perpW, w);

    // The angle between projW and perpW should be 90 degrees.
    angleVec := XMVector3AngleBetweenVectors(projW, perpW);
    angleRadians := XMVectorGetX(angleVec);
    angleDegrees := XMConvertToDegrees(angleRadians);

    Memo1.Lines.Add('u                   = ' + DebugXMVectorFloat(u));
    Memo1.Lines.Add('v                   = ' + DebugXMVectorFloat(v));
    Memo1.Lines.Add('w                   = ' + DebugXMVectorFloat(w));
    Memo1.Lines.Add('n                   = ' + DebugXMVectorFloat(n));
    Memo1.Lines.Add('a = u + v           = ' + DebugXMVectorFloat(a));
    Memo1.Lines.Add('b = u - v           = ' + DebugXMVectorFloat(b));
    Memo1.Lines.Add('c = 10 * u          = ' + DebugXMVectorFloat(c));
    Memo1.Lines.Add('d = u / ||u||       = ' + DebugXMVectorFloat(d));
    Memo1.Lines.Add('e = u x v           = ' + DebugXMVectorFloat(e));
    Memo1.Lines.Add('L  = ||u||          = ' + DebugXMVectorFloat(L));
    Memo1.Lines.Add('s = u.v             = ' + DebugXMVectorFloat(s));
    Memo1.Lines.Add('projW               = ' + DebugXMVectorFloat(projW));
    Memo1.Lines.Add('perpW               = ' + DebugXMVectorFloat(perpW));
    Memo1.Lines.Add('projW + perpW == w  = ' + BoolToStr(equal, True));
    Memo1.Lines.Add('projW + perpW != w  = ' + BoolToStr(notEqual, True));
    Memo1.Lines.Add('angle               = ' + formatfloat('0.000000000E+00', angleDegrees));
end;

end.
