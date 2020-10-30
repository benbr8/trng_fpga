
library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

entity trng is
    generic (
        n_order_g : positive := 4
    );
    port (
        clk  : in std_logic;
        rst  : in std_logic;
        rand : out std_logic
    );
end trng;

architecture rtl of trng is
    constant n_roc_c       : positive := n_order_g*3+1;

    signal ro_out : std_logic_vector(n_roc_c*3 downto 0);
    signal ff_out : std_logic_vector(n_roc_c*3-1 downto 0);
    
    attribute dont_touch : string;
    attribute dont_touch of ro_out : signal is "true";
    attribute dont_touch of ff_out : signal is "true";
begin

    ro_p: process(all)
    begin
        ro_out(n_roc_c*3) <= ro_out(n_roc_c*3-1);
        ro_out(0) <= not ro_out(3);
        ro_out(n_roc_c*3-1) <= not ro_out(n_roc_c*3-2);
        for i in 1 to n_roc_c*3-2 loop
            if i mod 3 = 2 then
                ro_out(i) <= ro_out(i-1) xor ro_out(i+4);
            else
                ro_out(i) <= not ro_out(i-1);
            end if;
        end loop;
    end process;
    
    ff_p: process(clk)
    begin
        if rising_edge(clk) then
            ff_out <= ro_out(n_roc_c*3-1 downto 0);
        end if;
    end process;
    
    xor_p : process(clk)
        variable result : std_logic;
    begin
        if rising_edge(clk) then
            result := ff_out(0) xor ff_out(1);
            for i in 2 to ff_out'length-1 loop
                result := result xor ff_out(i);
            end loop;
            rand <= result and not rst;
        end if;
    end process;
    
end architecture;
