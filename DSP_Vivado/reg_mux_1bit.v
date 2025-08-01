module reg_and_mux_1(in,out,enclk,rst,clk);

parameter sel=0;
parameter RSTTYPE="SYNC";
input clk,rst,enclk;
input in;
output out;
reg clk_enable;
reg in_reg;

    generate
    if (RSTTYPE == "ASYNC") begin 
        always @(posedge clk or posedge rst) begin
            if(enclk==1'b1) begin
            if (rst)
                in_reg <= 1'b0;
            else
                in_reg <= in;
            end
        end
    end else begin 
        always @(posedge clk) begin
            if(enclk==1'b1) begin
            if (rst)
                in_reg <= 1'b0;
            else
                in_reg <= in;
            end
        end
    end
    
     endgenerate
assign out = (sel==1'b1)? in_reg:in;
endmodule
