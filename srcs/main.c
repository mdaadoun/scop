#include "scop.h"

int
main(int argc, char **argv)
{
	(void) argc;
	(void) argv;
	GLFWwindow* window;

	if (!glfwInit())
		return -1;

	window = glfwCreateWindow(WIDTH, HEIGHT, TITLE, NULL, NULL);
	if (!window)
	{
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	while (!glfwWindowShouldClose(window))
	{
		/* Render here */
		glClear(GL_COLOR_BUFFER_BIT);

		/* Swap front and back buffers */
		glfwSwapBuffers(window);

		/* Poll for and process events */
		glfwPollEvents();
	}

	glfwTerminate();
	return (0);
}
