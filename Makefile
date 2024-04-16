R := \e[31m
G := \e[32m
B := \e[34m
D := \e[0m

NAME := scop

DIR_SRC := srcs
DIR_INC := includes
C_FILES  := main.c

SRCS := $(addprefix $(DIR_SRC)/, $(C_FILES))
OBJS := $(SRCS:%.c=%.o)

FLAGS     := -std=c99 -lglfw -lGLEW -lGL -lm -lX11 -lpthread -lXi -lXrandr -ldl -I$(DIR_INC)
FLAGS_DEV := -g3 -Wall -Werror -Wextra -pedantic
FLAGS_SAN := -fsanitize=address

.c.o:
	@printf "$(B)Building $(NAME) objects.$(D)\n"
	$(CC) $(FLAGS) -c $< -o $@
	@printf "$(G)$(NAME) objects created.$(D)\n"

all: $(OBJS)
	@printf "$(B)Building $(NAME) program.$(D)\n"
	$(CC) $(OBJS) $(FLAGS) -o $(NAME)
	@printf "$(G)$(NAME) program created.$(D)\n"

dev: fclean $(OBJS)
	@printf "$(B)Building $(NAME) program.$(D)\n"
	$(CC) $(SRCS) $(FLAGS) $(FLAGS_DEV) $(FLAGS_SAN) -o $(NAME)
	@printf "$(G)$(NAME) program created.$(D)\n"

clean:
	@printf "$(R)Remove all object files.$(D)\n"
	-rm $(OBJS)

fclean: clean
	@printf "$(R)Remove binaries and build.$(D)\n"
	-rm $(NAME)
	@printf "$(G)Full clean done.$(D)\n"

test: fclean
	$(CC) $(SRCS) $(FLAGS) -g3 -o $(NAME)
	valgrind --track-fds=yes --leak-check=full --show-leak-kinds=all ./$(NAME)

re: fclean all

.PHONE: all dev clean fclean re test
