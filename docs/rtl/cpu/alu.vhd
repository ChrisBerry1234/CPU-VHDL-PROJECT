library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port (
    ALU_Sel     : in std_logic_vector(2 downto 0);
    A           : in std_logic_vector(7 downto 0);
    B           : in std_logic_vector(7 downto 0);
    ALU_Result  : out std_logic_vector(2 downto 0);
    CCR_Result  : out std_logic_vector(3 downto 0)
  );
end ALU; 


architecture ALU_arch of ALU is 
  --Declarations
  signal NZCV <= std_logic_vector(3 downto 0);

  begin 

    ALU: process(A, B, ALU_Sel)

        --declarations 
        variable Sum_uns := unsigned(8 downto 0);  
        variable Sub_uns := unsigned(8 downto 0);
        variable a_u     := unsigned(7 downto 0);
        variable b_u     := unsigned(7 downto 0); 

        begin 
          --executable statements 
          a_u := unsigned(A);
          b_u := unsigned(B);

          case(ALU_Sel) is 
            when "000" => 
              --Addition-- 
              Sum_uns <= ('0' & a_u) + ('0' & b_u);
              ALU_Result <= std_logic_vector(Sum_uns(7 downto 0);

              -----------Carry-Flag---------
              ---the MSB will either be 0 or 1, determining whether the flag is asserted or not------
              NZCV(1) = Sum_uns(8);

              ----------OverFlow------------------
              --Two cases for overflow--
             if (a_u(7) = '1' and b_u(7) = '1' and Sum_uns(8) = '1' ) or 
                (a_u(7) = '0' and b_u(7) = '0' and Sum_uns(8) = '1') then 

               NZCV(0) = '1';
            else
               NZCV(0) = '0';
            end if; 

            ------------Zero-Flag---------------
            if(Sum_uns(7 downto 0) = x"00" ) then 
              NZCV(2) = '1';
            else
              NZCV(2) = '0';

            ---------Negative-Flag-------------
            -----MSB-1 will either be 0 or 1, determing whether the flag is assert or not -----------
            NZCV(3) = Sum_uns(7);
              
            when "001" =>
              --Subtraction--
              Sub_uns = ('0' & a_u) - ('0' & b_u);
              ALU_Result <= std_logic_vector(Sub_uns(7 downto 0);

              -----Carry/Borrow-Flag--------
              NZCV(1) = Subs_uns(8);
                                             
              ---------OverFlow-------------
              A < B, requiring a borrow from outside the MSB.
              if (a_u = '1' and b_u = '0' and Sub_uns(8) = '1') or
              (a_u = '0' and b_u = '1' and Sub_uns(8) = '0' ) then 
                                             
                NZCV(0) = '1';

              else
                NZCV(0) = '0';
                                                              
              -----NegativeFlag------
              NZCV(3) = Sub_uns(7);
                                             
              -----ZeroFlag----------
              if (Sub_uns(7 downto 0) = x"00") then 
                  NZCV(2) = '1';
              else 
                  NZCV(2) = '0''
              end if;
                                            
                                             
            when "010"

            end case;
          end process;
        end architecture ALU_arch;
