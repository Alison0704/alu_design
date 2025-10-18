library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    port (
        A   : in  std_logic_vector(3 downto 0);
        B   : in  std_logic_vector(3 downto 0);
        sel : in  std_logic_vector(2 downto 0);
        
        ANS : out std_logic_vector(3 downto 0);

        Equals : out std_logic;
        Carry  : out std_logic;
        Zero   : out std_logic
    );
end top_module;

architecture Structural of top_module is
    -- Internal signals
    signal sub     : std_logic := '0';
    signal NotB    : std_logic_vector(3 downto 0);
    signal NotA    : std_logic_vector(3 downto 0);
    signal OR_AB   : std_logic_vector(3 downto 0);
    signal AND_AB  : std_logic_vector(3 downto 0);
    signal XOR_AB  : std_logic_vector(3 downto 0);
    signal COUT    : std_logic_vector(3 downto 0);
    signal SUM     : std_logic_vector(3 downto 0);
    signal RES_AB  : std_logic_vector(3 downto 0);

    component bit1ALU is
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
    end component;
begin
    bit1ALU_inst0: bit1ALU
        port map (
            A      => A(0),
            B      => B(0),
            CIN    => sub,
            SUB    => sub,
            NotB   => NotB(0),
            NotA   => NotA(0),
            OR_AB  => OR_AB(0),
            AND_AB => AND_AB(0),
            XOR_AB => XOR_AB(0),
            COUT   => COUT(0),
            SUM    => SUM(0)
        );

    bit1ALU_inst1: bit1ALU
        port map (
            A      => A(1),
            B      => B(1),
            CIN    => COUT(0),
            SUB    => sub,
            NotB   => NotB(1),
            NotA   => NotA(1),
            OR_AB  => OR_AB(1),
            AND_AB => AND_AB(1),
            XOR_AB => XOR_AB(1),
            COUT   => COUT(1),
            SUM    => SUM(1)
        );

    bit1ALU_inst2: bit1ALU
        port map (
            A      => A(2),
            B      => B(2),
            CIN    => COUT(1),
            SUB    => sub,
            NotB   => NotB(2),
            NotA   => NotA(2),
            OR_AB  => OR_AB(2),
            AND_AB => AND_AB(2),
            XOR_AB => XOR_AB(2),
            COUT   => COUT(2),
            SUM    => SUM(2)
        );

    bit1ALU_inst3: bit1ALU
        port map (
            A      => A(3),
            B      => B(3),
            CIN    => COUT(2),
            SUB    => sub,
            NotB   => NotB(3),
            NotA   => NotA(3),
            OR_AB  => OR_AB(3),
            AND_AB => AND_AB(3),
            XOR_AB => XOR_AB(3),
            COUT   => COUT(3),
            SUM    => SUM(3)
        );

    -- Simple flags independent of selection
    Equals <= '1' when A = B else '0';

    -- Select which output bus is active based on sel; provide defaults to avoid latches
    process(sel, SUM, NotA, OR_AB, AND_AB, NotB, XOR_AB)
    begin
        -- defaults
        RES_AB   <= (others => '0');
        sub      <= '0';

        case sel is
            when "000" =>
                ANS <= SUM;
                RES_AB  <= SUM;
                sub     <= '0';
            when "001" =>
                ANS <= NotA;
                RES_AB   <= NotA;
            when "010" =>
                ANS <= OR_AB;
                RES_AB  <= OR_AB;
            when "011" =>
                ANS <= AND_AB;
                RES_AB  <= AND_AB;
            when "100" =>
                --//TODO review the subtraction operation
                ANS <= SUM;
                RES_AB  <= SUM;
                sub     <= '1';
            when "101" =>
                ANS <= NotB;
                RES_AB   <= NotB;
            when "110" =>
                ANS <= XOR_AB;
                RES_AB   <= XOR_AB;
            when others =>
                ANS <= (others => '0');
                RES_AB   <= (others => '0');
        end case;
    end process;

    ANS <= RES_AB;

    -- Zero flag and Carry flag derived from selected operation
    Zero  <= '1' when RES_AB = "0000" else '0';
    Carry <= COUT(3) when (sel = "000" or sel = "100") else '0';

end Structural;