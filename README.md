This is an example procedural fish in 2D for Godot 4.4.2

It uses a custom implementation of inverse kinematics (Doesn't use SkeletonModifications) to control a skeleton that deforms a polygon2D (The polygon2D has the texture of a fish)
The fish is controlled by holding left click on the screen, making it move towards the mouse position.
It includes a basic implementation of inversekinematics with angle constraints, and a somewhat properly made fish polygon, with weights assigned more or less well. 

Fish Container is what controls the movement fish, containing every segment. Segments are Sprite2Ds that are in order, from head to tail.
The position and rotation of each segment is then put every physics frame into the bones of the skeleton (Defined as Owned Bone in each segment)

![Example Fish](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeXZ6ZzJpZ2JhdnA5cnBkczY2b3FtcHI4NTE2aThsZzhxaTE1eGJ6MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hJQuG4CaMebOmqWmMj/giphy.gif)
