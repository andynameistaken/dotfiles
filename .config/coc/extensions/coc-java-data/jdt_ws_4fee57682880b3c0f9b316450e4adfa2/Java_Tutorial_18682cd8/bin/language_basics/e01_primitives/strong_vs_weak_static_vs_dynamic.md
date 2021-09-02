Source: https://stackoverflow.com/a/2690593  

This is often misunderstood so let me clear it up.

## Static/Dynamic Typing

**Static typing** is where the type is bound to the *variable*.  Types are checked at compile time.

**Dynamic typing** is where the type is bound to the *value*.  Types are checked at run time.

So in Java for example:

    String s = "abcd";

`s` will "forever" be a `String`. During its life it may point to different `String`s (since `s` is a reference in Java). It may have a `null` value but it will never refer to an `Integer` or a `List`. That's static typing.

In PHP:

    $s = "abcd";          // $s is a string
    $s = 123;             // $s is now an integer
    $s = array(1, 2, 3);  // $s is now an array
    $s = new DOMDocument; // $s is an instance of the DOMDocument class

That's dynamic typing.

## Strong/Weak Typing


**Strong typing** is a phrase with no widely agreed upon meaning.  Most programmers who use this term to mean something other than static typing use it to imply that there is a type discipline that is enforced by the compiler.  For example, CLU has a strong type system that does not allow client code to create a value of abstract type except by using the constructors provided by the type.  C has a somewhat strong type system, but it can be "subverted" to a degree because a program can always cast a value of one pointer type to a value of another pointer type.  So for example, in C you can take a value returned by `malloc()` and cheerfully cast it to `FILE*`, and the compiler won't try to stop you&mdash;or even warn you that you are doing anything dodgy.

(The original answer said something about a value "not changing type at run time".  I have known many language designers and compiler writers and have not known one that talked about values changing type at run time, except possibly some very advanced research in type systems, where this is known as the "strong update problem".)

**Weak typing** implies that the compiler does not enforce a typing discpline, or perhaps that enforcement can easily be subverted.

The original of this answer conflated weak typing with **implicit conversion** (sometimes also called "implicit promotion"). For example, in Java:

    String s = "abc" + 123; // "abc123";

This is code is an example of implicit promotion: 123 is implicitly converted to a string before being concatenated with `"abc"`. It can be argued the Java compiler rewrites that code as:

    String s = "abc" + new Integer(123).toString();

Consider a classic PHP "starts with" problem:

    if (strpos('abcdef', 'abc') == false) {
      // not found  
    }

The error here is that `strpos()` returns the index of the match, being 0. 0 is coerced into boolean `false` and thus the condition is actually true. The solution is to use `===` instead of `==` to avoid implicit conversion.

This example illustrates how a combination of implicit conversion and dynamic typing can lead programmers astray.

Compare that to Ruby:

    val = "abc" + 123

which is a runtime error because in Ruby the *object* 123 is *not* implicitly converted just because it happens to be passed to a `+` method. In Ruby the programmer must make the conversion explicit:

    val = "abc" + 123.to_s

Comparing PHP and Ruby is a good illustration here. Both are dynamically typed languages but PHP has lots of implicit conversions and Ruby (perhaps surprisingly if you're unfamiliar with it) doesn't.

## Static/Dynamic vs Strong/Weak

The point here is that the static/dynamic axis is independent of the strong/weak axis. People confuse them probably in part because strong vs weak typing is not only less clearly defined, there is no real consensus on exactly what is meant by strong and weak. For this reason strong/weak typing is far more of a shade of grey rather than black or white.

So to answer your question: another way to look at this that's *mostly* correct is to say that static typing is compile-time type safety and strong typing is runtime type safety.

The reason for this is that variables in a statically typed language have a type that must be declared and can be checked at compile time. A strongly-typed language has values that have a type at run time, and it's difficult for the programmer to subvert the type system without a dynamic check.

But it's important to understand that a language can be Static/Strong, Static/Weak, Dynamic/Strong or Dynamic/Weak.

______
# Java is Strongly-Typed  
source: https://www.cs.usfca.edu/~wolber/courses/110/lectures/java_is_strongly.htm  
All variables must be declared.

    You cannot say assign to a variable before it is declared.

    Declaration specifies the type of the variable

        <type> <variable>;

    You can define a variable as a scalar:

        int x;
        float f;

    or programmer-defined type (some class)

        Person p;
        ArrayList list;
        ProgramStatement statement;

    When you define a class, you create a new programmer-defined type.

After a variable is declared, you can assign to it.

        int x;
        x = 4;

You can also declare and assign with one fell swoop:

        int x=4;  // equivalent to above two lines.

We call a variable which has a class for a type an object.

Once an object is declared, you can 1) assign to it, often with a creation statement. 2) access its data members, and 3) call its methods.

    Person p;
    p = new Person("Wolber",25); // note constructor with parameters
    p.age=27; // assigning to data member
    p.older(jones) ;   // call a method

    With objects as well, you can declare and assign with one fell swoop:

        Person p = new Person();

    Question: why does the sentence above say 'often' with a creation statement. How else do we assign to an object?

Now let's convert a Python program to Java step by step. Here's the program.

The key changes are:

1. use of { ...} instead of indenting
2. Declaring the types of all data members, local variables, parameters, and return values.
3. Create objects using 'new'
4. Input data using Scanner class.
5. Use ArrayList instead of python built-in lists.

We'll also need some Math functions, so we'll import java.lang.Math.* and take a look at the API docs for it.
And we'll need to convert some integers to Strings, so we'll use the valueof function from the String class