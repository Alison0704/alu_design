library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        sel : in std_logic_vector(2 downto 0);

        ANS : out std_logic_vector(3 downto 0);

        Equals : out std_logic;
        Carry : out std_logic;
        Zero : out std_logic
    );
end top_module;

architecture Structural of top_module is
    -- Internal signals
    signal sub_s : std_logic;
    signal NotB_s : std_logic_vector(3 downto 0);
    signal NotA_s : std_logic_vector(3 downto 0);
    signal OR_AB_s : std_logic_vector(3 downto 0);
    signal AND_AB_s : std_logic_vector(3 downto 0);
    signal XOR_AB_s : std_logic_vector(3 downto 0);
    signal COUT_s : std_logic_vector(3 downto 0);
    signal SUM_s : std_logic_vector(3 downto 0);
    signal ANS_s : std_logic_vector(3 downto 0);
begin
    -- Instantiate the bit1ALU component
    sub_s <= '0';
    bit1ALU_inst0: entity work.bit1ALU
        port map (
            A => A(0),
            B => B(0),
            CIN => '0',
            SUB => sub_s,
            NotB => NotB_s(0),
            NotA => NotA_s(0),
            OR_AB => OR_AB_s(0),
            AND_AB => AND_AB_s(0),
            XOR_AB => XOR_AB_s(0),
            COUT => COUT_s(0),
            SUM => SUM_s(0)
        );
    bit1ALU_inst1: entity work.bit1ALU
        port map (
            A => A(1),
            B => B(1),
            CIN => COUT_s(0),
            SUB => sub_s,
            NotB => NotB_s(1),
            NotA => NotA_s(1),
            OR_AB => OR_AB_s(1),
            AND_AB => AND_AB_s(1),
            XOR_AB => XOR_AB_s(1),
            COUT => COUT_s(1),
            SUM => SUM_s(1)
        );
    bit1ALU_inst2: entity work.bit1ALU
        port map (
            A => A(2),
            B => B(2),
            CIN => COUT_s(1),
            SUB => sub_s,
            NotB => NotB_s(2),
            NotA => NotA_s(2),
            OR_AB => OR_AB_s(2),
            AND_AB => AND_AB_s(2),
            XOR_AB => XOR_AB_s(2),
            COUT => COUT_s(2),
            SUM => SUM_s(2)
        );
    bit1ALU_inst3: entity work.bit1ALU
        port map (
            A => A(3),
            B => B(3),
            CIN => COUT_s(2),
            SUB => sub_s,
            NotB => NotB_s(3),
            NotA => NotA_s(3),
            OR_AB => OR_AB_s(3),
            AND_AB => AND_AB_s(3),
            XOR_AB => XOR_AB_s(3),
            COUT => COUT_s(3),
            SUM => SUM_s(3)
        );
        Equals <= '1' when A = B else '0';
        --Instantiate the 4-to-1 multiplexer for each output
    process(sel, SUM_s, NotA_s, OR_AB_s, AND_AB_s, NotB_s, XOR_AB_s)
    begin
        case sel is
            when "000" =>
                ANS_s <= SUM_s;
                sub_s <= '0';
            when "001" =>
                ANS_s <= NotA_s;
            when "010" =>
                ANS_s <= OR_AB_s;
            when "011" =>
                ANS_s <= AND_AB_s;
            when "100" =>
                ANS_s <= SUM_s;
                sub_s <= '1';
            when "101" =>
                ANS_s <= NotB_s;
            when "110" =>
                ANS_s <= XOR_AB_s;
            when others =>
                ANS_s <= (others => '0');
        end case;
        ANS <= ANS_s;
        Carry <= COUT_s(3);
        if ANS_s = "0000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Structural;