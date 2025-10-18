library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity FA is
    port (
        A    : in  std_logic;
        B    : in  std_logic;
        Cin  : in  std_logic;
        Sub  : in  std_logic;
        Sum  : out std_logic;
        Cout : out std_logic
    );
end entity FA;
architecture Structural of FA is
    signal W1,W2,W3,W4: std_logic;

    component and_gate is
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
    component or_gate is
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;
begin
    -- Concurrent component instantiations
    inst_xor1: xor_gate port map(a => B, b => Sub, y => W1);
    inst_xor2: xor_gate port map(a => A, b => W1, y => W2);
    inst_and1: and_gate port map(a => Cin, b => W2, y => W3);
    inst_and2: and_gate port map(a => A, b => W1, y => W4);
    inst_xor3: xor_gate port map(a => W2, b => Cin, y => Sum);
    inst_or1: or_gate port map(a => W3, b => W4, y => Cout);

end architecture Structural;