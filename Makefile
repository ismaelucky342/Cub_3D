# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: danpalac <danpalac@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 14:34:27 by danpalac          #+#    #+#              #
#    Updated: 2024/09/25 10:39:04 by danpalac         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#==========COLOURS=============================================================#

# Basic Colors

BLACK       = \033[0;30m
RED         = \033[0;31m
GREEN       = \033[0;32m
YELLOW      = \033[0;33m
BLUE        = \033[0;34m
MAGENTA     = \033[0;35m
CYAN        = \033[0;36m
WHITE       = \033[0;37m

# Bright Colors

BOLD_BLACK  = \033[1;30m
BOLD_RED    = \033[1;31m
BOLD_GREEN  = \033[1;32m
BOLD_YELLOW = \033[1;33m
BOLD_BLUE   = \033[1;34m
BOLD_MAGENTA= \033[1;35m
BOLD_CYAN   = \033[1;36m
BOLD_WHITE  = \033[1;37m

# Extended Colors (256 colors)
ORANGE      = \033[38;5;208m
WINE        = \033[38;5;88m
LIME        = \033[38;5;190m
TURQUOISE   = \033[38;5;38m
LIGHT_PINK  = \033[38;5;13m
DARK_GRAY   = \033[38;5;235m
LIGHT_RED   = \033[38;5;203m
LIGHT_BLUE  = \033[38;5;75m


# Reseteo de color
NO_COLOR    = \033[0m
DEF_COLOR   = \033[0;39m
CLEAR_LINE  = \033[2K
MOVE_UP     = \033[1A

#==========NAMES===============================================================#

NAME		:= cub3D
LIBFT		:= $(LIBFT_DIR)libft.a
MLX			:= $(MLX_DIR)libmlx.a
MLX_LINUX	:= $(MLX_DIR)libmlx_Linux.a

#==========COMMANDS============================================================#

CC			:= gcc
CFLAGS		:= -Wall -Wextra -Werror -g3
RM			:= rm -rf
AR			:= ar rcs
LIB			:= ranlib
MKDIR 		:= mkdir -p
IFLAGS	= -I$(INCLUDES) -I$(LIBFT_DIR)$(INCLUDES) -I$(MLX_DIR)
LDFLAGS	= -L$(LIBFT_DIR) -lft -L$(MLX_DIR)$(MLX) -L$(MLX_DIR)$(MLX_LINUX) -lX11 -lXext -lm -lbsd


##==========DIRECTORIES=======================================================#

MLX_DIR		:= minilibx-linux/
LIBFT_DIR	:= libft/
INCLUDES	:= inc/
SRC_DIR		:= src/
OBJ_DIR		:= obj/

# src dir
GRAFICS_DIR	:= grafics/
PARSE_DIR	:= parse/
GAME_DIR	:= game/

#==========SOURCES============================================================#


GRAFICS_FILES	:= 
PARSE_FILES		:= 
GAME_FILES		:= cub_3d
			
#==========FILES###===========================================================#

SRC_FILES+=$(addprefix $(GRAFICS_DIR), $(GRAFICS_FILES))
SRC_FILES+=$(addprefix $(PARSE_DIR), $(PARSE_FILES))
SRC_FILES+=$(addprefix $(GAME_DIR), $(GAME_FILES))

SRCS := $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJS := $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))
DEPS := $(addprefix $(OBJ_DIR), $(addsuffix .d, $(SRC_FILES)))

#==========RULES==============================================================#

all: $(NAME)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c Makefile
	@mkdir -p $(dir $@)
	@printf "%b" "$(BOLD_CYAN)[Cub_3D]:\t$(DEF_COLOR)$(BOLD_GREEN)$<$(DEF_COLOR)\r"
	@$(CC) $(CFLAGS) $(IFLAGS) -MMD -MP -c $< -o $@
	@printf "%b" "$(BOLD_BLUE)$(DEF_COLOR)\r"

$(NAME) : $(MLX) $(LIBFT) $(OBJS)
	@$(CC) $(CFLAGS) $(IFLAGS) $(OBJS) $(LDFLAGS) -o $(NAME)
	@printf "%b" "$(BOLD_BLUE)$(DEF_COLOR)"
	@printf "%b" "$(CLEAR_LINE)$(BOLD_CYAN)Compilation complete!$(DEF_COLOR)\n"

clean: 
	@$(RM) -rf $(OBJ_DIR) a.out
	@printf "%b" "$(BLUE)[Cub_3D]:\tobject files$(DEF_COLOR)$(GREEN)  => Cleaned!$(DEF_COLOR)\n"

fclean: clean
	@$(RM) $(NAME)
	@make fclean -sC $(LIBFT_DIR)
	@printf "%b" "$(CYAN)[Cub_3D]:\texec. files$(DEF_COLOR)$(GREEN)  => Cleaned!$(DEF_COLOR)\n"

$(LIBFT):
	@make -sC $(LIBFT_DIR)

$(MLX):
	@make -sC $(MLX_DIR)

re: fclean all

norm:
	@norminette $(SRC) $(INCLUDE) | grep -v Norme -B1 || true

-include $(DEPS)

.PHONY: all clean fclean re norm
