library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_path is 
  port (
    Clock    : in std_logic;
    Reset    : in std_logic;  
    
    --INCLUDE ALL CONTROL UNIT INPUT SIGNALS TO ENTITY
    IR_Load  : in std_logic;
    MAR_Load : in std_logic; 
    PC_Load  : in std_logic;
    PC_Inc   : in std_logic;
    A_Load   : in std_logic;
    B_Load   : in std_logic;
    CCR_Load : in std_logic; 
    Bus2_Sel : in std_logic;
    Bus1_Sel : in std_logic
  );
end data_path;

architecture data_path_arch of data_path is 
  --declarations 
  signal BUS1: std_logic_vector(7 downto 0);
  signal BUS2: std_logic_vector(7 downto 0);

  --COMPONENTS(Internal Signals)
  signal IR  : std_logic_vector(7 downto 0);
  signal MAR : std_logic_vector(7 downto 0);
  signal PC  : std_logic_vector(7 downto 0);
  signal A   : std_logic_vector(7 downto 0);
  signal B   : std_logic_vector(7 downto 0);
  signal CCR : std_logic_vector(7 downto 0);  

  begin
    --Modeling D FlipFlop Logic 
    INSTRUCTION_REGISTER: process(Clock, Reset)
      begin
        if (Reset = '0') then 
          IR <= x"00";
        elsif (rising_edge(clock)) then 
          --CONTROL UNIT SIGNAL FROM SEPARATE FILE (control_unit.vhd)
          if (IR_Load = '1') then 
            --GIVE IR THE DATA ON BUS2
            IR <= Bus2;
           end if;
        end if;
    end process; 

     MEMORY_ADDRESS_REGISTER: process(Clock, Reset)
          begin 
            if (Reset = '0') then 
              MAR <= x"00";
            elsif (rising_edge(Clock)) then 
              if (MAR_Load = '1') then 
                MAR <= BUS2;
              end if;
            end if;
    end process;

    PROGRAM_COUNTER: process(Clock, Reset)
            variable PC_Temp : unsigned(7 downto 0);
    
              begin 
                if (Reset = '0') then
                  PC <= x"00";
                elsif (rising_edge(Clock)) then 
                  PC_Temp = PC;
                  if(PC_Load = '1') then 
                    PC <= unsigned(BUS2);
                  elsif(PC_Inc = '1') then
                    PC_Temp = PC;
                    PC <= PC_Temp + 1;
                  end if;
                end if;
      end process;

      A_Register: process(Clock, Reset)
                    begin 
                      if (Reset = '0') then 
                        A <= x"00";
                      elsif(rising_edge(Clock)) then 
                        if(A_Load = '1') then
                          A <= BUS2;
                        end if;
                      end if;
      end process;

      B_Register: process(Clock, Reset)
                    begin
                      if (Reset = '0') then 
                        B <= x"00";
                      elsif(rising_edge(Clock)) then
                        if (B_Load = '1') then 
                          B <= BUS2;
                        end if;
                      end if;
      end process; 

  end architecture; 
                        
                        

        
                    
                    
              
                

