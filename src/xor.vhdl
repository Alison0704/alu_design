library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xor_gate is
    port (
        a : in std_logic;
        b : in std_logic;
        y : out std_logic
    );
end entity xor_gate;

architecture Behavioral of xor_gate is
begin
    process (a, b)
    begin
        y <= a xor b;
    end process;
end architecture Behavioral;
