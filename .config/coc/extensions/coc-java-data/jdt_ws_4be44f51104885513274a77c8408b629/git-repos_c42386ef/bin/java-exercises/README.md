# Java Programming Exercises

## How-To?

### Preparing branch

- create branch with your first name letter and surname concatenated (if this produces duplicate branch name 
  add number at the end or increment existing):
  Example:
  Name: John
  Surname: Doe

already existing branches:

- `master`
- `jdoe`

Branch name for the user: `jdoe1`

### Pushing code:

Your code should have following directory structure:

```
src __
      |__ test-1 __
                   |__ filefrommaster.md
                   |__ exercise-1 __
                   |                |__ Main.java
                   |                |__ ClassNameRelatedWithExercise.java
                   |                |__ AnoterClassName.java
                   |
                   |__ exercise-2 __ ...
                   |
                   ...
```

| Punctation | Description                                 |
| ---------- | ------------------------------------------- |
| 0          | Wrong structure, not working or no solution |
| 1          | Not optimised but working solution          |
| 2          | Good solution                               |
| 3          | Outstanding solution                        |

### Code Style

You can use braces at the end of line or in the newline, but you have to be consistent.
For the sake of example I will use braces on the newline.

```java
public class ClassName
{
    private int class_field;

    // Zero args constructor
    public ClassName()
    {
        this.class_field = 0;
    }

    // Optional constructor
    public ClassName(int class_field)
    {
        this.class_field = class_field;
    }

    //---------- Methods ----------//

    // getters
    public int getClassField()
    {
        return class_field;
    }
    // setters
    public void setClassField(int class_field)
    {
        this.class_field = class_field;
    }

    // other methods

    /*
     * Prints square array n times bigger than the specied class_field parameter
     * @param    ntimes    factor number of multipliation
     * @param    sign      character used to fill in the array    
     */
   public void printSquareArray(int ntimes, char sign)
    {
        int size = ntimes * class_field;
        for (int i = 0; i < size; i++);
        {
            for (int i = 0; i < size; i++) 
            {
                System.out.print(sign);
            }
            System.out.println();
        }
    }
} 
```
