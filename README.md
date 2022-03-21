# Nebula.jl #
An ambitious game engine leveraging rich Julia ecosystem, inspired by Gamezero.jl and Starlight.jl in its pre-pre-pre-alpha stage.

There are several challenges for games which are still unresolved.

1. The games, by design, cannot achieve most movements player may think of. Even simple actions such as opening a door need to be scripted by the developer. The player cannot climb a tree if the developer didn't script it in.
2. The game environment is static. Most things do not change. Rocks always stay in-place, and water waves don't actually do anything.
3. Entities normally don't respond and interact with environments well, and often lack even the basic intelligence.


The author believes that it is time for game developers to abandon the old scripted ways of game development and embrace the new paradigm of game development. 
* Game developers are spending more and more GPU compute power for diminishing improvement in graphics quality. This engine proposes to put a compromise on that idea, freeing up GPU for physics simulation, deep learning AI, and other features relevant to gameplay.
* Environments are simulated and objects follow their physics systems, except for occasional "events" triggered by player or environment, turning on or off some physics systems, or doing certain "actions" such as walking, lightning strike, etc.
* Game rules ARE the physics system. 
* The triangle-based rasterization was designed when GPUs were less general-purpose. This engine allows the developers to explore new rendering system, or even mix them up.


To achieve this ambition, this library leverages several libraries in the Julia ecosystem.
* Leveraging the Julia's ModelingToolkit ecosystem, game developers can make their own physics system easily!
* With help from Julia's GPU ecosystem, GPGPU compute rendering offers the flexibility of software rendering without sacrificing hardware power!
* Juliaaudio ecosystem for audio processing and more!
* To control entities, we feature OverSeer, a powerful ECS system!
* When it comes to AI, Flux and Alphazero.jl come to mind!
* Last, but not least, proudly in Julia language itself, this engine supports game modding!
### Planned Features #

* Efficient, scalable physics engine for real or cartoon physics system as you desire. 
* Powerful AI
* Entity information system, generating information "detected" by entity to be processed or rendered.
* Content manager utilities for managing game options and extensions.
* Customizable user interface
* Asset creation utilities, and good interface for writing asset creation GUI and algorithms (paint brush, blur, inpainting, upscaling brush)

### Roadmap

* Create appropriate files.
* Create a basic rendering system for rendering pure 2d maps.
* An entity system maintaining components for simple entities.
* Intelligent entities with their own "vision", such as RGB vision, night vision, X-ray, point-cloud.
* A game event system where player, entity, or environment triggers an event to happen.
* Asset maker, protocol for algorithms to communicate with GUIS.
* Game content manager
* World generation
* Multiplayer
* Servers auto-scaling.
* ???
* FUN!

### Contributions
There are many ways to contribute to this, including, but not limited to.

* Implementing logics.
* Refactoring codes to make them more general-purpose.
* Providing new test cases and/or benchmarks.
* Providing documentations and/or tutorials.
* Using the library and providing HONEST feedback.
* Making request for features.
* Making suggestions, advices, etc in one's domain of expertise.

However, there are a few guidelines.
* More general is better, even if it means more LOC or makes the code subjectively harder to read.
* More performant code is better. Simple equivalent pseudocode belongs in the documentation.
* Leverage existing ecosystem first. Don't repeat yourself.

### Diagram
![Diagram](/Diagram/Crude_plan.png)