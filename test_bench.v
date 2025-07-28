module test();
parameter A0REG=0;
parameter A1REG=1;
parameter B0REG=0;
parameter B1REG=1;
parameter CREG=1;
parameter DREG=1;
parameter MREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;
parameter B_INPUT="DIRECT";
parameter CARRYINSEL="OPMODE5";
parameter RSTTYPE="SYNC";
integer i;
/////////////////////////////////////
reg [17:0] A,B,D,B_CIN;
reg [7:0] OPMODE;
reg [47:0] C,PCIN;
reg clk,CARRYIN,RSTA,RSTB,RSTM,RSTP,RSTC,
RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEM,CEP,
CEC,CED,CECARRYIN,CEOPMODE;
/////////////////////////////////////
wire [17:0]  BCOUT;
wire  [47:0]  P,PCOUT;
wire  [35:0]  M;
wire  CARRYOUT,CARRYOUTF;
/////////////////////////////////////
circuit DUT(.A(A),.B(B),.D(D),.B_CIN(B_CIN),.OPMODE(OPMODE)
,.C(C),.PCIN(PCIN),.clk(clk),.CARRYIN(CARRYIN),.RSTA(RSTA)
,.RSTB(RSTB),.RSTM(RSTM),.RSTP(RSTP),.RSTC(RSTC),.RSTD(RSTD)
,.RSTCARRYIN(RSTCARRYIN),.RSTOPMODE(RSTOPMODE),.CEA(CEA)
,.CEB(CEB),.CEM(CEM),.CEP(CEP),.CEC(CEC),.CED(CED)
,.CECARRYIN(CECARRYIN),.CEOPMODE(CEOPMODE),.BCOUT(BCOUT)
,.P(P),.PCOUT(PCOUT),.M(M),.CARRYOUT(CARRYOUT),.CARRYOUTF(CARRYOUTF));
/////////////////////////////////////
initial begin
    clk=0;
    CEA=1;
    CEB=1;
    CEM=1;
    CEP=1;
    CEC=1;
    CED=1;
    CECARRYIN=1;
    CEOPMODE=1;
    forever begin
        #1 clk=~clk;
    end
end
//////////////////////////////////////
initial begin
    RSTA=1;
    RSTB=1;
    RSTC=1;
    RSTCARRYIN=1;
    RSTD=1;
    RSTM=1;
    RSTOPMODE=1;
    RSTP=1;
    for (i=0;i<=9;i=i+1) begin
        A=$random;
        B=$random;
        D=$random;
        B_CIN=$random;
        C=$random;
        OPMODE=$random;
        PCIN=$random;
        CARRYIN=$random;
        @(negedge clk);
        if (P!=0 && PCOUT!=0 && M!=0 && BCOUT!=0 && CARRYOUT!=0 && CARRYOUTF!=0) begin
            $display("error in 2.1");
            $stop;
        end else begin
            $display("2.1 is right");
        end
    end
/////////////////////////////////////////////////////////////
    RSTA=0;
    RSTB=0;
    RSTC=0;
    RSTCARRYIN=0;
    RSTD=0;
    RSTM=0;
    RSTOPMODE=0;
    RSTP=0;
    OPMODE=8'b11011101;
       A=20;
       B=10;
       C=350;
       D=25;
    for (i=0;i<=9;i=i+1) begin
        B_CIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(4) @(negedge clk);
        if (BCOUT!=1'hf && M!=3'h12c && P!=2'h32 && PCOUT!=2'h32 && CARRYOUT!=0 && CARRYOUTF!=0 ) begin
            $display("error in 2.2");
            $stop;
        end else begin
            $display("2.2 is right");
        end
    end
 /////////////////////////////////////////////////////////////
    OPMODE=8'b00010000;
       A=20;
       B=10;
       C=350;
       D=25;
    for (i=0;i<=9;i=i+1) begin
        B_CIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if (BCOUT!=2'h23 && M!=3'h2bc && P!=0 && PCOUT!=0 && CARRYOUT!=0 && CARRYOUTF!=0 ) begin
            $display("error in 2.3");
            $stop;
        end else begin
            $display("2.3 is right");
        end
    end 
 /////////////////////////////////////////////////////////////
    OPMODE=8'b00001010;
       A=20;
       B=10;
       C=350;
       D=25;
    for (i=0;i<=9;i=i+1) begin
        B_CIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if (BCOUT!=1'ha && M!=2'hc8 && P!=0 && PCOUT!=0 && CARRYOUT!=0 && CARRYOUTF!=0 ) begin
            $display("error in 2.4");
            $stop;
        end else begin
            $display("2.4 is right");
        end
    end   
 /////////////////////////////////////////////////////////////
    OPMODE=8'b10100111;
       A=5;
       B=6;
       C=350;
       D=25;
       PCIN=3000;
    for (i=0;i<=9;i=i+1) begin
        B_CIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if (BCOUT!=1'h6 && M!=2'h1e && P!=12'hfe6fffec0bb1 && PCOUT!=12'hfe6fffec0bb1 && CARRYOUT!=1 && CARRYOUTF!=1 ) begin
            $display("error in 2.5");
            $stop;
        end else begin
            $display("2.5 is right");
        end
    end   
 /////////////////////////////////////////////////////////////
    OPMODE=8'b10100111;
       A=5;
       B=6;
       C=350;
       D=25;
       PCIN=3000;
    for (i=0;i<=9;i=i+1) begin
        B_CIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if (BCOUT!=1'h6 && M!=2'h1e && P!=12'hfe6fffec0bb1 && PCOUT!=12'hfe6fffec0bb1 && CARRYOUT!=1 && CARRYOUTF!=1 ) begin
            $display("error in 2.6");
            $stop;
        end else begin
            $display("2.6 is right");
        end
    end    
    $stop;
end
endmodule
