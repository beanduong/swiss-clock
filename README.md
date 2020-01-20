# swiss-clock

> swiss-clock is a clock, calendar and weather display written with Flutter. It is an entry for the [Flutter Clock challenge](https://flutter.dev/clock).

light             |  dark
:-------------------------:|:-------------------------:
![image of swiss clock](https://github.com/beanduong/swiss-clock/blob/master/images/light.png) | ![image of swiss clock](https://github.com/beanduong/swiss-clock/blob/master/images/dark.png)

## Design Thoughts

### Layout

The clock consists of 3 subcontainer: a clock filling the left side, a weather display in the upper right side and a monthly calendar right below. Even though there are two containers on the right side and one in the left, the design still manages to achieve a well-balanced look.

### Functionalism

swiss-clock combines the aesthetic of a minimalist version of the famous Mondaine Swiss watch face and the trending use of Neumorphism.

The design tries to be functional. Every element that is shown has a purpose to be there. By the usage of whitespace and letting every subcontainer breathe, the lock creates a balanced and calming lock, while being full of information.

### Neumorphism

By using neumorphism as the main design language, this clock face appears to break its two dimensions, stepping out of the display and into the room. By doing that, it morphes into an analog entity with its extruded and tangible widgets. 

Another thing that one might notice, is that watch hand doesn't move linearly. Instead, it moves with a tick rate of 8 beats per seconds (or 28.800 beats per hour). This accomplishes two things: it imitates the behaviour of classic Swiss watches, which were a huge inspiration for this watch face, to appear even more analog and less digital. Almost every high-end Swiss watch runs with a tick rate of 28.800 bph. This non-linear movement also embodies the core character of Neumorphism. Neumorphism is not about containers that look extruded. It's more about imitating a real-life appearance in a digital manner blurring the lines between the analog and digital environment.

### Icons

The clock also comes with a set of icons that try to match the minimalist and simple nature of the clock.

light             |  dark
:-------------------------:|:-------------------------:
![image of light icon set](https://github.com/beanduong/swiss-clock/blob/master/images/icons_light.png) | ![image of dark icon set](https://github.com/beanduong/swiss-clock/blob/master/images/icons_dark.png)

## Epilogue

Looking back, I feel like most people lose themselves in exotic and extravagant designs and forget about the purpose of a clock.
It shouldn't be visually loud. It's never the main attraction of a room. It has to walk the fine line between being visually pleasing or pleasing to look at and being an object of the background. It should also be in a form that allows for environmental insertion. The clock never determines the look of a room, but it does complete the look.
