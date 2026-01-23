----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
-- Entity
----------------------------------------------------------------------------------
entity tb_cerrojo is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           boton : in STD_LOGIC;
           clave : in STD_LOGIC_VECTOR (7 downto 0);
           display : out STD_LOGIC_VECTOR(6 downto 0);
           s_display: OUT std_logic_vector (3 DOWNTO 0);
           bloqueado: out STD_LOGIC_VECTOR (15 downto 0));
end tb_cerrojo;
----------------------------------------------------------------------------------
-- Architecture
----------------------------------------------------------------------------------
architecture beh of tb_cerrojo is
-- Component Declaration for the Unit Under Test (UUT)
component conv_7seg is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

component debouncer is
    PORT (
    rst: IN std_logic;
    clk: IN std_logic;
    x: IN std_logic;
    xDeb: OUT std_logic;
    xDebFallingEdge: OUT std_logic;
    xDebRisingEdge: OUT std_logic
  );
end component;

signal intentos: std_logic_vector(3 downto 0);
signal b: std_logic_vector(15 downto 0);
signal E: std_logic_vector(7 downto 0);
signal deb,rising,falling: std_logic;
signal disp: std_logic_vector(6 downto 0);
type estados is (S0,S1,S2,S3,S4);
signal estadoActual,estadoSig: estados;

begin

mod_e: debouncer port map (rst,clk,boton,deb,falling,rising);
mod_c: conv_7seg port map (intentos,disp);
s_display <= "1110";

S: process (clk,rst)
begin
    if (rising_edge(clk)) then 
        if(rst = '1') then
            estadoActual <= S0;
        else
            estadoActual <= estadoSig;
        end if;
    end if;
end process S;

C: process(rising,estadoActual,clave,E,b,disp)
  begin
  
                 estadoSig <= estadoActual;
        case estadoActual is
        when S0 => 
            if (rising = '1') then 
                intentos <= "0011";
                b <= "0000000000000000";
                E <= clave;
                estadoSig <= S1;
             else 
                E <= "00000000";
                 intentos <= "0011";
                 b <= "1111111111111111";
                 
                  
             end if;
        when S1 =>
            b <= "0000000000000000";
            if (rising = '1') then
                if (clave = E) then 
                    estadoSig <= S0;
                    b <= "1111111111111111";
                else
                    intentos <= "0010";
                    estadoSig <= S2;
                end if;
            end if;
        when S2 =>
            if (rising = '1') then
                if (clave = E) then 
                    estadoSig <= S0;
                    b <= "1111111111111111";
                else 
                    intentos <= "0001";
                    estadoSig <= S3;
                end if;
            end if;
        when S3 =>
            if (rising = '1') then
                if (clave = E) then 
                    estadoSig <= S0;
                    b <= "1111111111111111"; 
                else 
                    intentos <= "0000";
                    estadoSig <= S4;
                end if;  
            end if;                
        when S4 => 
        end case;          
    
  end process C;
  
  bloqueado <= b; 
  display <= disp;

end beh;
