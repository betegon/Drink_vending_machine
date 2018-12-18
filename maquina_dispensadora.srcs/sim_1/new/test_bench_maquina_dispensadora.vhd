
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_soda_fsmd IS
END tb_soda_fsmd;
 
ARCHITECTURE behavior OF tb_soda_fsmd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT soda_fsmd
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         C : IN  std_logic;-- Coin inserted
         A : IN  unsigned(7 downto 0); -- Value of inserted coin
         S : IN  unsigned(7 downto 0); -- Value of soda product
         D : OUT  std_logic -- Dispens the product
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal C : std_logic := '0';
   signal A : unsigned(7 downto 0) := (others => '0');
   signal S : unsigned(7 downto 0) := (others => '0');

 	--Outputs
   signal D : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: soda_fsmd PORT MAP (
          -- puerto=>senal
          CLK => CLK,
          RESET => RESET,
          C => C,
          A => A,
          S => S,
          D => D
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      RESET<='1';
      C<='0';
      A<=to_unsigned(0,8);
      S<=to_unsigned(100,8); -- ponemos que cuesta 100 la bebida
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      RESET<='0';
      -- COIN 1 (50)
      wait for 100 ns;
      C<='1';
      A<=to_unsigned(50,8);
      wait for 10 ns;
      C<='0';
      -- COIN 2 (70)
      wait for 100 ns;
      C<='1';
      A<=to_unsigned(20,8);
      wait for 10 ns;
      C<='0';
      -- COIN 3 (90)
      wait for 100 ns;
      C<='1';
      A<=to_unsigned(20,8);
      wait for 10 ns;
      C<='0';
      -- COIN 3 (110)
      wait for 100 ns;
      C<='1';
      A<=to_unsigned(20,8);
      wait for 10 ns;
      C<='0';
      wait;
   end process;

END;
