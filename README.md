
# with-struct

A little macro that lets you bind local variable aliases to structure slots,
like with-slots but for structures. It should be faster than the CLOS method
because under the hood with-slots is doing dynamic type lookups on the
objects to determine the setters and this uses the defstruct generated
accessors.

## How it works

Basically it builds a look up table of

> (alias . ({struct-name}-#{struct-arg} #{struct}))

entries and then does a deep substitution of macro body's input code block.

## Install

Unfortunatly its not in quicklisp, so

> git clone git@github.com:ivankocienski/with-struct.git ~/quicklisp/local-projects

## Caveats

This macro is probably not fast if your code is read heavy. But you'd use
a (let ...) block anyhow for that, right?

Not sure how well this will deal with nested structure access.

## Example

See demo/demo.lisp for an example.