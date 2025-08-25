#include "editor.h"

int main(int argc, char **argv) {
	(void)argc;
	(void)argv;

	mlx_t *mlx = mlx_init(1920 / 2, 1080 / 2, "Doom Nukem Editor", NULL);
	mlx_loop(mlx);
	mlx_terminate(mlx);

	return 0;
}