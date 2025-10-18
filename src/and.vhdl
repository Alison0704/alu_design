library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity and_gate is
    port (
        a : in std_logic;
        b : in std_logic;
        y : out std_logic
    );
end entity and_gate;
architecture Behavioral of and_gate is
begin
    process (a, b)
    begin
        y <= a and b;
    end process;
end architecture Behavioral;
