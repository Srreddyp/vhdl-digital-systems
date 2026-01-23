
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador02 is
    port(
        rst_global : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        enable : in std_logic;
        count : in std_logic;
        salida : out std_logic_vector(3 downto 0)
    );
end contador02;

architecture Behavioral of contador02 is
    
    signal contActual : std_logic_vector(3 downto 0);

begin
    
    SYNC: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' or rst_global = '1' then
				contActual <= (others => '0');
			elsif enable = '1' and count = '1' then
		      if(contActual = "1001") then
		          contActual <= (others => '0');
		      else
		          contActual <= contActual + 1;
		      end if;
			end if;
		end if;
	end process SYNC;

    salida <= contActual;

end Behavioral;
