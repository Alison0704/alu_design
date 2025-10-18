library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit1ALU is
    port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        CIN : in STD_LOGIC;
        SUB : in STD_LOGIC;
        
        NotB : out STD_LOGIC;
        NotA : out STD_LOGIC;
        OR_AB : out STD_LOGIC;
        AND_AB : out STD_LOGIC;
        XOR_AB : out STD_LOGIC;
        COUT : out STD_LOGIC;
        SUM : out STD_LOGIC
    );
end entity bit1ALU;

architecture Structural of bit1ALU is

    signal B_xor_SUB : STD_LOGIC;
   
    component FA is
        port (
            A    : in  std_logic;
            B    : in  std_logic;
            Cin  : in  std_logic;
            Sub  : in  std_logic;
            Sum  : out std_logic;
            Cout : out std_logic
        );
    end component;
    component and_gate is
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;
    component or_gate is
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;
    component xor_gate is
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;

begin
    -- Instantiate the AND gate -> 011
    AND_inst: and_gate
        port map (
            a => A,
            b => B,
            y => AND_AB
        );

    -- Instantiate the OR gate -> 010
    OR_inst: or_gate
        port map (
            a => A,
            b => B,
            y => OR_AB
        );

    -- Instantiate the XOR gate -> 110
    XOR_inst: xor_gate
        port map (
            a => A,
            b => B,
            y => XOR_AB
        );

    -- Instantiate the FA (Full Adder) --> 000 / 100
    FA_inst: FA
        port map (
            A => A,
            B => B,
            Cin => CIN,
            Sub => SUB,
            Sum => SUM,
            Cout => COUT
        );
    -- Arithmetic Logic Unit Operations
    NotB <= not B; --> 101
    NotA <= not A; --> 001

end Structural; 