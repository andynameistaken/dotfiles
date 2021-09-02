# What is an Object
* Real-world objects share two characteristics: They all have state and behavior. Dogs have state
  (name, color, breed, hungry) and behavior (barking, fetching, wagging tail).
*  Software objects are conceptually similar to real-world objects:
   they too consist of state and related behavior.__ 
   An object stores its state in *fields* 
   (variables in some programming languages) and exposes its behavior through *methods 
   (functions in some programming languages).
   Methods operate on an object's internal state and
   serve as the primary mechanism for object-to-object communication.   


   **Object representation:**  
   ![image](https://user-images.githubusercontent.com/15692002/117999331-069d0080-b345-11eb-9d00-57232cf53c2d.png)

   ___
   ### Important!
   Hiding internal state and requiring all interaction to be performed through an object's methods is known as data encapsulation — a fundamental principle of object-oriented programming.
   
   ---
## Bicycle example

![picture 1](../../../../images/1cfcd17620f9a1c0e96495ded7b9da3b4c2d01bb146e663f02f5d846835be10a.png)  

## Benefits of Object Oriented Programming
* **Modularity**
  
   *  The source code for an object can be written and maintained independently of the source code for other objects. 
      Once created, an object can be easily passed around inside the system.
       
* **Information-hiding**
    * By interacting only with an object's methods, the details of its internal
      implementation remain hidden from the outside world.
        
* **Code re-use**
    * If an object already exists (perhaps written by another software developer), 
      you can use that object in your program. This allows specialists to implement/test/debug 
      complex, task-specific objects, which you can then trust to run in your own code.
      
* **Pluggability and debugging ease**
  * If a particular object turns out to be problematic, 
  you can simply remove it from your application and plug in a different
  object as its replacement. This is analogous to fixing mechanical problems in the real world. If a bolt breaks, you replace it, not the entire machine.
    