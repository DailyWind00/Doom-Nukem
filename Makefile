CLIENT_NAME := doom-nukem
CLIENT_SRCS := $(wildcard srcs/doom-nukem/*.c)
CLIENT_OBJS := $(CLIENT_SRCS:.c=.o)

EDITOR_NAME := doom-nukem-editor
EDITOR_SRCS := $(wildcard srcs/editor/*.c)
EDITOR_OBJS := $(EDITOR_SRCS:.c=.o)

MLX_LIB := -Ldependencies/MLX42/build -lmlx42

INCLUDES_PATH := -Iincludes/ -Iincludes/editor/ -Iincludes/doom-nukem/ -Idependencies/MLX42/include

CC := cc
CFLAGS := -Wall -Wextra # -Werror
MLX_FLAGS := -ldl -lglfw -pthread -lm
RM := rm -f

DEBUG := 0
ifeq ($(DEBUG), 1)
	CFLAGS += -g3 -fsanitize=address
else
	CFLAGS += -Ofast
endif

all: dependencies $(CLIENT_NAME) $(EDITOR_NAME)

debug: clean
	@$(MAKE) DEBUG=1 all

$(CLIENT_NAME): $(CLIENT_OBJS)
	$(CC) -o $@ $^ $(MLX_LIB) $(CFLAGS) $(MLX_FLAGS)

$(EDITOR_NAME): $(EDITOR_OBJS)
	$(CC) -o $@ $^ $(MLX_LIB) $(CFLAGS) $(MLX_FLAGS)

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDES_PATH)

dependencies:
	@if [ ! -d dependencies ]; then \
		mkdir dependencies && \
		cd dependencies && \
		git clone https://github.com/codam-coding-college/MLX42.git && \
		cd MLX42 && \
		cmake -B build && \
		cmake --build build -j4; \
	fi

clean:
	$(RM) $(CLIENT_OBJS) $(EDITOR_OBJS)

fclean: clean
	$(RM) $(CLIENT_NAME) $(EDITOR_NAME)
	$(RM) -r dependencies

re: fclean all

.PHONY: all debug dependencies clean fclean re