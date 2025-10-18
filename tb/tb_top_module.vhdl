--=============================================================
-- Testbench Template (VHDL)
--=============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- No entity ports for a testbench
entity tb_top_module is
end entity;

architecture behavior of tb_top_module is
    --=========================================================
    -- DUT (Design Under Test) Component Declaration
    --=======================`==================================
    component top_module
        port (
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(2 downto 0);

            ANS : out std_logic_vector(3 downto 0);

            Equals : out std_logic;
            Carry : out std_logic;
            Zero : out std_logic
        );
    end component;
    --=========================================================
    -- Internal Signal Declarations, constants and clock period
    --========================================================
    signal A_s   : std_logic_vector(3 downto 0) := (others => '0');
    signal B_s   : std_logic_vector(3 downto 0) := (others => '0');
    signal sel_s : std_logic_vector(2 downto 0) := (others => '0');
    -- Optional: capture outputs (use signals instead of open if you want waves)
    signal ANS_s  : std_logic_vector(3 downto 0);
    signal Equals_s   : std_logic;
    signal Carry_s    : std_logic;
    signal Zero_s     : std_logic;
begin
    --=========================================================
    -- Instantiate the DUT
    --=========================================================
    uut: top_module
        port map (
            A        => A_s,
            B        => B_s,
            sel      => sel_s,
            ANS      => ANS_s,
            Equals   => Equals_s,
            Carry    => Carry_s,
            Zero     => Zero_s
        );
    --=========================================================
    -- Clock Generation Process
    --=========================================================
        --None needed for this DUT
    --=========================================================
    -- Reset and Stimulus Process
    --=========================================================
    stim_proc : process
    begin
        -- Apply test vectors to DUT inputs
        A_s   <= "0001";
        B_s   <= "1010";
        sel_s <= "000";  -- Select ADD operation
        wait for 100 ns;
        sel_s <= "001";  -- Select NOT A operation
        wait for 100 ns;
        sel_s <= "010";  -- Select OR operation
        wait for 100 ns;
        sel_s <= "011";  -- Select AND operation
        wait for 100 ns;
        sel_s <= "100";  -- Select SUB operation
        wait for 100 ns;
        sel_s <= "101";  -- Select NOT B operation
        wait for 100 ns;
        sel_s <= "110";  -- Select XOR operation
        wait for 100 ns;
        sel_s <= "111";  -- Select ZERO operation
        wait for 100 ns;
        wait; -- end of stimulus
    end process;
end architecture;
