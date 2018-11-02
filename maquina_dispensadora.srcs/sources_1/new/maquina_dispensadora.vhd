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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
                D<='0';
                state <=waitt;
                        
            when waitt =>
                if(C='1') then
                    state<=add;
                elsif(C='0' and tot>=S) then 
                    state<=disp;
                 end if;   
            when add =>
                tot<= tot+A;
            when disp =>
            D<='1';
            state<=init; 
       end case;
    end if;
end process;
CAMBIAR: PROCESO MÁS DONDE PONGA QUE D=1 SI EL STATE ES DISP, ELSE D=0; IMPORTANTE, ASI CON D, NO TE USA UN REGISTRO.
borrar D en el proceso principal y solo usarlo en el proceso que tengo que crear.
COMO VERSION INICIAL ESTO ESTA BIEN. SUBIRLO A GITHUB Y MEJORARLO CON EL PROCESO NUEVO.
TAMBIEN TENGO QUE CREAR EL TEST BENCH

end fsmd;
