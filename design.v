module circuit
(A,B,B_CIN,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,
clk,OPMODE,CEA,CEB,CEC,CECARRYIN,CED,CEM,
CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,
RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT);
///////////////////////////
parameter width=48;
///////////////////////////
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
parameter CARRYINSEL="OPMODE5" ;
parameter RSTTYPE="SYNC";
/////////////////////////////////
input [17:0] A,B,D,B_CIN;
input [7:0] OPMODE;
input [47:0] C,PCIN;
input clk,CARRYIN,RSTA,RSTB,RSTM,RSTP,RSTC,
RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEM,CEP,
CEC,CED,CECARRYIN,CEOPMODE;
///////////////////////////////////
output  [17:0]  BCOUT;
output  [47:0]  P,PCOUT;
output  [35:0]  M;
output  CARRYOUT,CARRYOUTF;
//////////////////////////////////
wire [17:0] A2;
wire [17:0] B2;
wire [17:0] D2;
wire [47:0] C2;
wire [17:0] A3;
wire [17:0] B3;
wire [17:0] BD;
wire [17:0] BD1;
wire [17:0] BD2;
wire[35:0] M1;
wire [35:0] M2;
wire CYL1;
wire CIN;
wire [47:0] A_SEL;
wire [47:0] A_SEL2;
wire [47:0] P1;
wire [47:0] P2;
wire CYO1;
wire [7:0] OPMODE2;
////////////////////////////////////////
reg_and_mux_8bits  #(.RSTTYPE(RSTTYPE),.sel(OPMODEREG)) OPMODE_REG(.in(OPMODE),.out(OPMODE2),.enclk(CEOPMODE),.rst(RSTOPMODE),.clk(clk));
reg_and_mux_18bits #(.RSTTYPE(RSTTYPE),.sel(A0REG)) A0_REG(.in(A),.out(A2),.enclk(CEA),.rst(RSTA),.clk(clk));
reg_and_mux_18bits #(.RSTTYPE(RSTTYPE),.sel(B0REG)) B0_REG(.in(B2),.out(B3),.enclk(CEB),.rst(RSTB),.clk(clk));
reg_and_mux_18bits #(.RSTTYPE(RSTTYPE),.sel(DREG)) D_REG(.in(D),.out(D2),.enclk(CED),.rst(RSTD),.clk(clk));
reg_and_mux_48bits #(.RSTTYPE(RSTTYPE),.sel(CREG)) C_REG(.in(C),.out(C2),.enclk(CEC),.rst(RSTC),.clk(clk));
reg_and_mux_18bits #(.RSTTYPE(RSTTYPE),.sel(A1REG)) A1_REG(.in(A2),.out(A3),.enclk(CEA),.rst(RSTA),.clk(clk));
reg_and_mux_18bits #(.RSTTYPE(RSTTYPE),.sel(B1REG)) B1_REG(.in(BD1),.out(BD2),.enclk(CEB),.rst(RSTB),.clk(clk));
reg_and_mux_36bits #(.RSTTYPE(RSTTYPE),.sel(MREG)) M_REG(.in(M1),.out(M2),.enclk(CEM),.rst(RSTM),.clk(clk));
reg_and_mux_1 #(.RSTTYPE(RSTTYPE),.sel(CARRYINREG)) CYL(.in(CYL1),.out(CIN),.enclk(CECARRYIN),.rst(RSTCARRYIN),.clk(clk));
reg_and_mux_48bits #(.RSTTYPE(RSTTYPE),.sel(PREG)) P_REG(.in(P1),.out(P2),.enclk(CEP),.rst(RSTP),.clk(clk));
reg_and_mux_1 #(.RSTTYPE(RSTTYPE),.sel(CARRYOUTREG)) CYO(.in(CIN),.out(CYO1),.enclk(CECARRYIN),.rst(RSTCARRYIN),.clk(clk));

///////////////////////////////////////////////////

assign B2 =(B_INPUT=="DIRECT")? B:B_CIN;
assign BD = (OPMODE2[6]==1'b0)? (D2+B3):(D2-B3);
assign BD1 = (OPMODE2[4]==1'b1)? BD:B3;
assign BCOUT = BD2;
assign M1 = A3*BD2;
assign M = (MREG==1'b1)? M2:M1;
assign CYL1 = (CARRYINSEL=="OPMODE5")? 
OPMODE2[5]:(CARRYINSEL=="CARRYIN")? 
CARRYIN:1'b0;
assign A_SEL = (OPMODE2[1:0]==2'b01)?
{12'b0000_0000_0000,M2}:(OPMODE2[1:0]==2'b10)?
PCOUT:(OPMODE2[1:0]==2'b11)?
{D,A,B}:{width{1'b0}};
assign A_SEL2 = (OPMODE2[3:2]==2'b01)?
PCIN:(OPMODE2[3:2]==2'b10)?
PCOUT:(OPMODE2[3:2]==2'b11)?
C2:{width{1'b0}};
assign P1 = (OPMODE2[7]==1'b1)? (A_SEL2-(A_SEL+CIN)):(A_SEL2+A_SEL);
assign P = P2;
assign PCOUT = P2;
assign CARRYOUT = CYO1;
assign CARRYOUTF = CYO1;
endmodule