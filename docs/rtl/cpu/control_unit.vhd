library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_path is 
    port (
        Clock       : in  std_logic;
        Reset       : in  std_logic;  
        write       : out std_logic; 
        
        address     : out std_logic_vector(7 downto 0);
        from_memory : in  std_logic_vector(7 downto 0);
        to_memory   : out std_logic_vector(7 downto 0);

        IR_Load     : out std_logic;
        IR          : in  std_logic_vector(7 downto 0); 
        MAR_Load    : out std_logic; 
        PC_Load     : out std_logic;
        PC_Inc      : out std_logic;
        A_Load      : out std_logic;
        B_Load      : out std_logic;
        ALU_Sel     : out std_logic_vector(3 downto 0);
        CCR_Result  : in  std_logic_vector(3 downto 0);
        CCR_Load    : out std_logic; 
        Bus2_Sel    : out std_logic_vector(1 downto 0);
        Bus1_Sel    : out std_logic_vector(1 downto 0)
    );
end data_path;

architecture data_path_arch of data_path is 

    signal BUS1     : std_logic_vector(7 downto 0);
    signal BUS2     : std_logic_vector(7 downto 0);

    signal IR       : std_logic_vector(7 downto 0);
    signal MAR      : std_logic_vector(7 downto 0);
    signal PC_uns   : unsigned(7 downto 0);
    signal PC       : std_logic_vector(7 downto 0);
    signal A        : std_logic_vector(7 downto 0);
    signal B        : std_logic_vector(7 downto 0);
    signal CCR      : std_logic_vector(7 downto 0);
    signal ALU_Result : std_logic_vector(7 downto 0);

begin

    -- external connections
    address   <= MAR;
    to_memory <= BUS2;
    PC        <= std_logic_vector(PC_uns);

    -- IR
    INSTRUCTION_REGISTER : process(Clock, Reset)
    begin
        if Reset = '0' then 
            IR <= x"00";
        elsif rising_edge(Clock) then 
            if IR_Load = '1' then 
                IR <= BUS2;
            end if;
        end if;
    end process; 

    -- MAR
    MEMORY_ADDRESS_REGISTER : process(Clock, Reset)
    begin 
        if Reset = '0' then 
            MAR <= x"00";
        elsif rising_edge(Clock) then 
            if MAR_Load = '1' then 
                MAR <= BUS2;
            end if;
        end if;
    end process;

    -- PC
    PROGRAM_COUNTER : process(Clock, Reset)
        variable PC_Temp : unsigned(7 downto 0);
    begin 
        if Reset = '0' then
            PC_uns <= (others => '0');
        elsif rising_edge(Clock) then 
            PC_Temp := PC_uns;

            if PC_Load = '1' then 
                PC_uns <= unsigned(BUS2);
            elsif PC_Inc = '1' then
                PC_uns <= PC_Temp + 1;
            end if;
        end if;
    end process;

    -- A
    A_Register : process(Clock, Reset)
    begin 
        if Reset = '0' then 
            A <= x"00";
        elsif rising_edge(Clock) then 
            if A_Load = '1' then
                A <= BUS2;
            end if;
        end if;
    end process;

    -- B
    B_Register : process(Clock, Reset)
    begin
        if Reset = '0' then 
            B <= x"00";
        elsif rising_edge(Clock) then
            if B_Load = '1' then 
                B <= BUS2;
            end if;
        end if;
    end process; 

    -- BUS2 MUX (combinational)
    MUX_BUS2 : process(Bus2_Sel, ALU_Result, BUS1, from_memory)
    begin 
        case Bus2_Sel is
            when "00" =>
                BUS2 <= ALU_Result;
            when "01" =>
                BUS2 <= BUS1;
            when "10" =>
                BUS2 <= from_memory;
            when others =>
                BUS2 <= (others => '0');
        end case;
    end process;

    -- BUS1 MUX (combinational)
    MUX_BUS1 : process(Bus1_Sel, PC, A, B)
    begin 
        case Bus1_Sel is
            when "00" =>
                BUS1 <= PC;
            when "01" =>
                BUS1 <= A;
            when "10" =>
                BUS1 <= B;
            when others =>
                BUS1 <= (others => '0');
        end case;
    end process; 

end data_path_arch;
