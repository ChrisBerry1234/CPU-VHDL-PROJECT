library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MNEMONICS.all;

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
                        
                         S_LDA_IMM_4,       -- Load A (Immediate) states
                         S_LDA_IMM_5,
                         S_LDA_IMM_6, 

                         S_LDA_DIR_4,       -- Load B (Direct) states
                         S_LDA_DIR_5, 
                         S_LDA_DIR_6,
                         S_LDA_DIR_7);
    
    signal current_state := state_type;
    signal next_state: state_type;

    begin

        STATE_MEMORY: process(Clock, Reset)
            begin 
                if (Reset = '1')
                    current_state <= S_FETCH_0;
                elsif (rising_edge(Clock))
                    current_state <= next_state; 
                end if;
       end process;


      NEXT_STATE_LOGIC: process(current_state, IR)
                begin 
                   if (current_state = S_FETCH_0) then 
                       next_state <= S_FETCH_1;
                   elsif (current_state = S_FETCH_1) then
                       next_state <= S_FETCH_2;
                   elsif (current_state = S_FETCH_2) then 
                       next_state <= S_DECODE_3; 
                   elsif (current_state = S_DECODE_3) then --starting decode along te different paths within FSM 

                            -- Different FSM Operation states from IR 
                            if (IR = LDA_IMM) then         -- Register A
                                next_state <= S_LDA_IMM_4;
                            elsif ( IR = LDA_DIR) then 
                                next_state <= S_LDA_DIR_4;
                            --elsif ( IR = STA_DIR) then 
                                --next_state <= 

    OUTPUT_LOGIC: process(current_state)
                begin
                    case(current_state) is 
                        when (S_FETCH_0) =>
                            IR_Load   <= '0';
                            MAR_Load  <= '1';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel  = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel  = "01"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                        when (S_FETCH_1) =>
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '1';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            --Bus1_Sel  = "00"; --PC = "00", A="01", B="10"
                            --Bus2_Sel  = "00"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                        when (S_FETCH_2) =>
                            IR_Load   <= '1';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            --Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "10"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                       --NOT SIGNALS ASSERTED AT ALL
                       when (S_DECODE_3) => 
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "00"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                     --------------------LDA_IMM------------------------------------- 
                      when (S_LDA_IMM_4) => 
                            IR_Load   <= '0';
                            MAR_Load  <= '1';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "01"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                       when (S_LDA_IMM_5) => 
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '1';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "10"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';   

                     --Always Increment PC when waiting to retrieve data from memory
                      when (S_LDA_IMM_6) => 
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '1';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "10"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                    --------------------LDA_IMM------------------------------------- 
                        when (S_LDA_DIR_4) =>
                            IR_Load   <= '0';
                            MAR_Load  <= '1';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "01"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';
                            

                       when (S_LDA_DIR_5) =>
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '1';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            --Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            --Bus2_Sel = "00"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                     when (S_LDA_DIR_6) =>
                            IR_Load   <= '0';
                            MAR_Load  <= '1';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '0';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            --Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            Bus2_Sel = "10"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';

                    when(S_LDA_DIR_7) => 
                            IR_Load   <= '0';
                            MAR_Load  <= '0';
                            PC_Load   <= '0';
                            PC_Inc    <= '0';
                            A_Load    <= '1';
                            B_Load    <= '0';
                            ALU_Sel   <= "000";
                            CCR_Load  <= '0';
                            --Bus1_Sel = "00"; --PC = "00", A="01", B="10"
                            --Bus2_Sel = "10"; --ALU_Result = "00", BUS1 = "01", from_memory = "10"
                            write     <= '0';
                     
                    ----------------------LDA_IMM------------------------------------- 


end control_unit_arch;
