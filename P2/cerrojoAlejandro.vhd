library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cerrojo is
    port (
        rst: in std_logic;
        clk: in std_logic;
        boton: in std_logic;
        clave: in std_logic_vector(7 downto 0);
        intentos: out std_logic_vector(6 downto 0);
        leds: out std_logic_vector(15 downto 0);
        an: out std_logic_vector(3 downto 0)
     );
end cerrojo;

architecture Behavioral of cerrojo is
    
    type tipo_estado is (inicial, S1, S2, S3, final);
    signal estadoActual, estadoSiguiente: tipo_estado;
    signal estadoNumero: std_logic_vector(3 downto 0);
    signal boton2: std_logic;
    signal clave_final: std_logic_vector(7 downto 0);
    
    
    component conv_7seg 
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component debouncer 
        PORT (
            rst: IN std_logic;
            clk: IN std_logic;
            x: IN std_logic;
            xDeb: OUT std_logic;
            xDebFallingEdge: OUT std_logic;
            xDebRisingEdge: OUT std_logic
        );
    END component;
    
    
begin
    an <= "1110";
    mod_conv: conv_7seg port map(estadoNumero,intentos);
    mod_debouncer: debouncer port map(rst,clk,boton,open,open,boton2);
    
    SYNC: process(clk, rst)
	begin
	   --if rst = '1' then
			--	estadoActual <= inicial;
		--elsif rising_edge(clk) then
			--	estadoActual <= estadoSiguiente;
		--end if;
		if rising_edge(clk) then
			if rst = '1' then
				estadoActual <= inicial;
			else
				estadoActual <= estadoSiguiente;
			end if;
		end if;
	end process SYNC;
	
	COMB: process(estadoActual, boton2, clave,clave_final)
	begin
	
		estadoSiguiente <= estadoActual;
		leds <= (others => '0');
		estadoNumero <= "0000";
        
		case estadoActual is
		
			when inicial =>
			    leds <= (others => '1');
			    estadoNumero <= "0011";
				if (boton2 = '1') then
					estadoSiguiente <= S3;
					clave_final <= clave;
				end if;
				
			when S3 =>
			    estadoNumero <= "0011";
				if (boton2 = '1') then
					if(clave = clave_final) then
					   estadoSiguiente <= inicial;
					else 
					   estadoSiguiente <= S2; 
				    end if;
				end if;			
			
			when S2 =>
			    estadoNumero <= "0010";
				if (boton2 = '1') then
					if(clave = clave_final) then
					   estadoSiguiente <= inicial;
					else 
					   estadoSiguiente <= S1; 
				    end if;
				end if;			
				
			when S1 =>
			    estadoNumero <= "0001";
				if (boton2 = '1') then
					if(clave = clave_final) then
					   estadoSiguiente <= inicial;
					else 
					   estadoSiguiente <= final; 
				    end if;
				end if;	
			when final =>
			
		end case;
	end process COMB;


end Behavioral;
