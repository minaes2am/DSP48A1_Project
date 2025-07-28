module reg_and_mux_18bits(in,out,enclk,rst,clk);
parameter width=18;
parameter sel=0;
parameter RSTTYPE="SYNC";
input clk,rst,enclk;
input [17:0] in;
output [17:0] out;
reg [17:0] in_reg;

    generate
    if (RSTTYPE == "ASYNC") begin 
        always @(posedge clk or posedge rst) begin
            if(enclk==1'b1) begin
            if (rst)
                in_reg <= {width{1'b0}};
            else
                in_reg <= in;
        end
        end
    end else begin 
        always @(posedge clk) begin
            if(enclk==1'b1) begin
            if (rst)
                in_reg <= {width{1'b0}};
            else
                in_reg <= in;
            end
        end
    end
    
     endgenerate
assign out = (sel==1'b1)? in_reg:in;
endmodule