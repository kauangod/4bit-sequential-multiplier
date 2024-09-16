Library ieee; 
use ieee.std_logic_1164.all; 



ENTITY controller IS
   PORT(
      clk      : IN   STD_LOGIC;
      entrada    : IN   STD_LOGIC;
      reset_n    : IN   STD_LOGIC;
		zero : IN STD_LOGIC;
      saida   : OUT  STD_LOGIC_VECTOR(1 downto 0));
END controller;


ARCHITECTURE funcionamento OF controller IS
   TYPE STATE_TYPE IS (s0, s1, s2);
   SIGNAL estado   : STATE_TYPE;
   
BEGIN
   PROCESS (clk, reset_n)
   BEGIN
      IF reset_n = '0' THEN
         estado <= s0;
      ELSIF (clk'EVENT AND clk = '1') THEN -- falling edge
         CASE estado IS
           WHEN s0=>
               IF entrada = '0' THEN
                  estado <= s1;
               ELSE
                  estado <= s0;
               END IF;
           WHEN s1=>
               IF entrada = '0' THEN
                  estado <= s1;
               ELSE
                  estado <= s2;
               END IF;
			WHEN s2=>
               IF zero = '1' THEN
                  estado <= s0;
               ELSE
                  estado <= s1;
               END IF;
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (estado)
   BEGIN
      CASE estado IS
         WHEN s0 =>
            saida <= "00";
         WHEN s1 =>
            saida <= "01";
         WHEN s2 =>
            saida <= "10";
      END CASE;
   END PROCESS;
   
END funcionamento;