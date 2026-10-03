library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_path is 
  port (
    Clock       : in std_logic;
    Reset       : in std_logic;  
    address     : out std_logic_vector(7 downto 0);
    from_memory : in std_logic_vector(7 downto 0);
    to_memory   : out std_logic_vector(7 downto 0);
    
    --INCLUDE ALL CONTROL UNIT INPUT SIGNALS TO ENTITY
    IR_Load  : in std_logic;
    MAR_Load : in std_logic; 
    PC_Load  : in std_logic;
    PC_Inc   : in std_logic;
    A_Load   : in std_logic;
    B_Load   : in std_logic;
    CCR_Load : in std_logic; 
    Bus2_Sel : in std_logic_vector(1 downto 0);
    Bus1_Sel : in std_logic_vector(1 downto 0));
end data_path;

architecture data_path_arch of data_path is 
  --declarations 
  signal BUS1: std_logic_vector(7 downto 0);
  signal BUS2: std_logic_vector(7 downto 0);

  --COMPONENTS(Internal Signals)
  signal IR     : std_logic_vector(7 downto 0);
  signal MAR    : std_logic_vector(7 downto 0);
  signal PC     : std_logic_vector(7 downto 0);
  signal PC_uns : unsigned(7 downto 0);
  signal A      : std_logic_vector(7 downto 0);
  signal B      : std_logic_vector(7 downto 0);
  signal CCR    : std_logic_vector(7 downto 0);  

  begin
    --Modeling D FlipFlop Sequential Logic 
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
                  PC_uns; <= x"00";
                elsif (rising_edge(Clock)) then 
                  PC_Temp <= PC_uns;
            
                  if (PC_Load = '1') then 
                    PC_uns <= unsigned(BUS2);
            
                  elsif (PC_Inc = '1') then
                    PC_uns <= PC_Temp + 1;
            
                  end if;
                end if;
      end process;

      PC <= std_logic_vector(PC_uns);

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


      --MULTIPLEXER COMBINATIONAL LOGIC
      --ALU Result is included from ALU.vhdl 
      MUX_BUS2: process(Bus2_Sel, ALU_Result, BUS2, from_memory)
                  begin 
                    with(Bus2_Sel)
                      BUS2 <= ALU_Result      when "00",
                              BUS1            when "01",
                              from_memory     when "10",
                              (others => '0') when others;
      end process;

      MUX_BUS1: process(Bus1_Sel, PC, A, B, BUS1)
                    begin 
                      with(Bus1_Sel)
                        BUS1 <= PC when "00",
                                A  when "01",
                                B  when "10",
                                (others => '0') when others;
      end process; 

  end architecture; 
                        
                        

        
                    
                    
              
                

