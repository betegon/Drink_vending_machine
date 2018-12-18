----------------------------------------------------------------------------------
-- Company: UC
-- Engineer: Miguel Betegón García
-- 
-- Create Date: 10/30/2018 12:23:49 PM
-- Design Name:  Vendor machine 
-- Module Name: maquina_dispensadora - fsmd
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maquina_dispensadora is 
Port(   CLK:  in std_logic;
        RESET:  in std_logic;
        A:      in unsigned(7 downto 0); -- Value of inserted coin
        S:      in unsigned(7 downto 0); -- Value of soda product
        C:      in std_logic; -- Coin inserted
        D:      out std_logic); -- Dispens the product
end maquina_dispensadora;

architecture fsmd of maquina_dispensadora is
-- signals here. better to use signals than variables.

type state_type is (init, waitt, add, disp); -- wait is a reserved word, so we use waitt for the state.
signal state: state_type;
signal tot: unsigned(7 downto 0);

begin

main_synch_process: process(CLK,RESET)

begin
    if (RESET='1') then 
        state<= init; -- assign to variable :=, assign to signal <=
        tot<=(others=>'0'); -- reset tot signal.
    elsif (CLK='1' and CLK'EVENT) then
        case state is
            when init =>
            --    D<='0'; -- quitamos D de este proceso. ponemos proceso a parte porque aqui sino añadiria un ciclo de reloj adicional (D se actualizaria al final del ciclo). y nos ahorramos un registro.
                state <=waitt;
                tot<=(others=>'0');      
            when waitt =>
                if(C='1') then
                    state<=add;
                elsif(C='0' and tot>=S) then 
                    state<=disp;
                 end if;   
            when add =>
                tot<= tot+A;
                state<= waitt;
            when disp =>
            --    D<='1';
            state<=init; 
       end case;
    end if; 
end process;


-- con este siguiente proceso, lo que conseguimos es un proceso combinacional (en vez de secuencial, caso anterior de D). asi nos ahorramos un ciclo y un registro
D_process: process(state) -- usando este proceso, evitamos que se actualizen los valores al final del ciclo (esto anadiria un ciclo ode reloj adicional).

begin
	case state is
	when disp =>
 		D<='1';
	when others =>    
		D<='0';
	end case;
end process;

end fsmd;
