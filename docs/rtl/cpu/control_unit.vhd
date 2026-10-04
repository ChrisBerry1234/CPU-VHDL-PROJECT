library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
    port (
        Clock       : in  std_logic;
        Reset       : in  std_logic;  
        write       : out std_logic; 
        
        IR_Load     : out std_logic;
        IR          : in  std_logic_vector(7 downto 0); 
        MAR_Load    : out std_logic; 
        PC_Load     : out std_logic;
        PC_Inc      : out std_logic;
        A_Load      : out std_logic;
        B_Load      : out std_logic;
        ALU_Sel     : out std_logic_vector(2 downto 0);
        CCR_Result  : in  std_logic_vector(3 downto 0);
        CCR_Load    : out std_logic; 
        Bus2_Sel    : out std_logic_vector(1 downto 0);
        Bus1_Sel    : out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture control_unit_arch of control_unit is 
   --Declarations
   -- Include Instructions Package
   -- Announce State Types For FSM traversal 
    
    type state_type is ( S_FETCH_0,         -- Opcode fetch states
                         S_FETCH_1,
                         S_FETCH_2,

                         S_DECODE_3         -- OpCode decode State

                        --LIST ALL OPERATION STATES 
begin
    
    

end control_unit_arch;
