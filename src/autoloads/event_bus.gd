class_name EventBus
extends Node2D


# Add signals here for game-wide events. Access through the Events singleton

signal terminal_pile_updated
signal game_over(win: bool)


signal draw_card(card: Card)
signal draw_pile_empty(pile: DrawPile)

signal try_move_to_terminal(card: Card)
