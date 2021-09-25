#include <GLFW/glfw3.h>
#include "App.hpp"

static App& get_app(GLFWwindow* window)
{
    return *reinterpret_cast<App*>(glfwGetWindowUserPointer(window));
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    get_app(window).key_callback(key, scancode, action, mods);
}

int main()
{
    /* Initialize the library */
    if (!glfwInit()) {
        return -1;
    }

    /* Create a windowed mode window and its OpenGL context */
    GLFWwindow* window = glfwCreateWindow(1280, 720, "Hello World", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }

    /* Make the window's context current */
    glfwMakeContextCurrent(window);

    /* Create the App */
    App app{};

    /* Hook user inputs to the App */
    // clang-format off
    glfwSetKeyCallback        (window, &key_callback);
    // glfwSetMouseButtonCallback(window, App::mouse_button_callback);
    // glfwSetScrollCallback     (window, App::scroll_callback);
    // glfwSetCursorPosCallback  (window, App::cursor_position_callback);
    // glfwSetWindowSizeCallback (window, window_size_callback);
    // clang-format on

    /* Loop until the user closes the window */
    while (!glfwWindowShouldClose(window)) {
        app.render();

        /* Swap front and back buffers */
        glfwSwapBuffers(window);

        /* Poll for and process events */
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}