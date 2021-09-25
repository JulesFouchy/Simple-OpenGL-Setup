#include "App.hpp"
#include "GLFW/glfw3.h"

void App::render()
{
    glClearColor(1.f, 0.5f, 0.5f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT);
}