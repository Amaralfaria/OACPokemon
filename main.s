.eqv T_OBJ 4 #tamanho de cada objeto
.data
.include "data_files/dialog_box_battle.data"
.include "data_files/battle_pokemon_stats.data"
.include "data_files/options_battle.data"
.include "data_files/pokemon_attacks_menu_bg.data"
.include "objetos.s"
.include "mapas/mapa.s"

# BAG (Armazena os itens do jogador)
player_bag: .word I_POTION, 5

CURRENT_MAP: .word MAPA

LAB_OBJ: .word LAB
         .byte 10, 9

PKCTR_OBJ: .word PKCTR
           .byte 9, 10 

MAPA_OBJ: .word MAPA 
          .byte 23, 21

MALL_OBJ: .word LOJA
          .byte 9, 9

GYM_OBJ: .word GYM
         .byte 10, 8

WILL_BATTLE: .byte 0

# STRINGS
barra:  .string "/"
seta:   .string ">"
traco:  .string "-"
x:		.string "x"
# DI�?LOGOS DA BATALHA
dead_battle:        .string "O pokemon inimigo morreu!"
xp_battle1:         .string "O seu pokemon adquiriu"
xp_battle2:         .string "pontos de xp."
lvl_up_battle:      .string "O seu pokemon evoluiu para o level"
attack_battle:      .string "atacou com"
atk_down_battle:    .string "teve o ataque diminuido!"
use_potion_dial:	.string "O jogador utilizou uma potion."
defeat:				.string "Todos os seus pokemons foram derrotados em batalha!"
revive_poke:		.string "Visite a curandeira para reviver seus pokemons."
dead:				.string "morreu!"
str_run:			.string "Voce fugiu com sucesso!"
covarde:			.string "Covarde kkkkkk"			
# POKEMON INIMIGO
P_INIMIGO: .word 0, 0, 0

# POKÉMON INICIAL DO JOGADOR
P_PLAYER: .word 0, 0, 0

.text
.include "MACROSv21.s"

#iniciando mapa
SETUP:	
  	li s0, 0 # frame
	li s1,23 #linha
	li s2,21 #coluna
	li s3, 1 #direçao (0 = cima, 1 = baixo, 2 = direita, 3 = esquerda)
  	jal INIT_POKEMON_INICIAL

GAME_LOOP:
	xori s0, s0, 1

	li a0,0
	jal KEY2

	beqz a0,GAME_PRINT

  li t0, 'z'
  beq a0, t0, INTERACTION

	mv a3,a0 #a3 = tecla
	mv a0,s1 #linha
	mv a1,s2 #coluna
	jal MOVE

GAME_PRINT:
 	mv a0,s1
	mv a1,s2
	jal ra, CARREGA_MAPA

  	jal PRINT_PLAYER

  j GAME_LOOP.END

INTERACTION:
  mv a0, s1
  mv a1, s2
  mv a2, s3
  jal CHECK_DIALOG

GAME_LOOP.END:
  jal CHECK_BATTLE

	li t0, 0xFF200604 # troca o frame exibido para o frame qeu acabou de ser pintado 
	sb s0, 0(t0)

	li a0, 70
	li a7, 32
	ecall       # espera 70ms entre cada frame

	j GAME_LOOP

.include "SYSTEMv21.s"
.include "print.s"
.include "check_interaction.s"
.include "battle.s"
.include "pokemons.s"
.include "ataques.s"
.include "draw_battle_screen.s"
.include "init_pokemon_inicial.s"
.include "create_pokemon.s"
.include "draw_pokemon.s"
.include "draw_enemy_pokemon.s"
.include "draw_player_pokemon.s"
.include "sleep.s"
.include "print_save.s"
.include "dialog.s"
.include "move.s"
.include "print_player.s"
.include "draw.s"
.include "print_text_box.s"
.include "random_save.s"
.include "check_battle.s"
.include "items.s"
