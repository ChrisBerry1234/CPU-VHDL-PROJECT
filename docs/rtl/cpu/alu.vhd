library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port (
    ALU_Sel     : in std_logic_vector(2 downto 0);
    A           : in std_logic_vector(2 downto 0);
    B           : in std_logic_vector(2 downto 0);
    ALU_Result  : out std_logic_vector(2 downto 0);
    CCR_Result  : out std_logic_vector(3 downto 0)
  );
end ALU; 


architecture ALU_arch of ALU is 
  --Declarations
  signal NZCV = std_logic_vector(7 downto 0);

  begin 

    ALU: process(A, B, ALU_Sel)
        variable Sum_uns : unsigned(8 downto 0);  
        variable a_u     : unsigned(7 downto 0);
        variable b_u     : unsigned(7 downto 0); 

        a_u := unsigned(A);
        b_u := unsigned(B);

        begin 
          case(ALU_Select) is 
            when "000" => 
              Sum_uns <= ('0' & a_u) + ('0' & a_u);
              ALU_Result <= std_logic_vector(Sum_uns);
              
            when "001"
            when "010"
