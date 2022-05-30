# Synopsis

This repository integrates:

- Jason Hemann et al microKanren
- Whole numbers "oleg numbers" as implemented by faster-miniKanren
- A routine trace-var-list for printing values in microKanren programs
- Instrumentation of goal constructors so that in a debugger, goals appear tagged with their constructor instead of their procedure alone

## Implementation

For various reasons, code in the miniKanren idiom is difficult to reuse.  This repository makes use of git subtree to track microKanren and faster-miniKanren as upstream repositories.

The following document describes the commands which were used to create the git subtrees:

[git-subtree-howto.md](./git-subtree-howto.md)

## Running

Code is tested with Chez Scheme 9.5.

    scheme --script test_pythag_fast.scm
        (((1 1) (0 0 1) (1 0 1))
        ((0 1 1) (0 0 0 1) (0 1 0 1))
        ((1 0 1) (0 0 1 1) (1 0 1 1)))
        (time (pretty-print (run 3 ...)))
            137 collections
            3.253089148s elapsed cpu time, including 0.187553180s collecting
            3.257983635s elapsed real time, including 0.188727954s collecting
            1151308960 bytes allocated, including 1144203920 bytes reclaimed

The numbers above are pythagorean triples (lengths of sides of right triangles), e.g. (3,4,5)==(((1 1) (0 0 1) (1 0 1)).

Other tests:

    scheme --script test_pythag_slow_traced.scm

    (cd microKanren && scheme --script ./lambdag-test.scm)

