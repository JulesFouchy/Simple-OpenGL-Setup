# Simple-OpenGL-Setup

Welcome to this barebone OpenGL project !

It is meant for you to copy-paste and use as a starting point for your own projects.

(NB : if you are not planning on learning how to make a computer graphics application from scratch, you should consider using a more fully-featured framework like [Cool](https://github.com/CoolLibs/Cool)).

## main.cpp

In here we initialize [*glfw*](https://www.glfw.org/docs/latest/) (the library that handles the window and user inputs), create a window and then start the app. You don't really need to modify this file, except to change your window name or initial size.

## App

This is the actual root of your project. This is where your drawing code should go, as well as handling inputs from the user.

## User inputs

To learn more about the parameters you receive in the callbacks, read [glfw's documentation](https://www.glfw.org/docs/latest/input_guide.html).