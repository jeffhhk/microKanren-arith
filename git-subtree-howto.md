# Synopsis

This repository demonstrates how to create a repository with upstream repositories connected via git subtree.

This repository currently only demonstrates creation of subtrees.

# Subtree vs submodules

Same:

- Both subtree and submodules are built into git.  They were introduced in roughly the same time period of git evolution.

Different:

- git submodule represents an upstream repo as a metadata link, whereas git subtree copies contents of upstream repo
- git submodule requires special commands for both producers and consumers of the parent repository.  git subtree requires special commands only for producers.
- git subtree provides an (optional) way for history between both parent and upstream repository to be seen in one log.
- With some additional care, git subtree provides a mechanism for committing first in the parent repository and subsequently to the upstream repository.

# How to

## Create repo
    git init
    git commit --allow-empty -m "create repository"

## Add subtree

    git remote add subtree-microKanren https://github.com/jasonhemann/microKanren
    git fetch subtree-microKanren
    git subtree add --prefix microKanren subtree-microKanren master

result:

    git log --graph --name-status | cat
        *   commit b1229dd18b03566d242f87dc784c665b45dfd933
        |\  Merge: 70e05bf 0f4505d
        | | Author: Jeff Henrikson <79888432+jeffhhk@users.noreply.github.com>
        | | Date:   Sat May 28 10:36:52 2022 -0700
        | |
        | |     Add 'microKanren/' from commit '0f4505db0d2525fc3d567c5183e45f28992cfe72'
        | |
        | |     git-subtree-dir: microKanren
        | |     git-subtree-mainline: 70e05bfb12813c9fcde7cf521c8e3e1a89a77c5d
        | |     git-subtree-split: 0f4505db0d2525fc3d567c5183e45f28992cfe72
        | |
        | * commit 0f4505db0d2525fc3d567c5183e45f28992cfe72
        | | Author: Jason Hemann <jason.hemann@gmail.com>
        | | Date:   Thu Jun 12 09:15:42 2014 -0400
        | |
        | |     changing state to s/c
        | |
        | | M	miniKanren-wrappers.scm
        | |
        | . . .
        |
        * commit 70e05bfb12813c9fcde7cf521c8e3e1a89a77c5d
          Author: Jeff Henrikson <79888432+jeffhhk@users.noreply.github.com>
          Date:   Sat May 28 10:32:01 2022 -0700

              create repository

## Add a second subtree

    git remote add subtree-faster-miniKanren https://github.com/michaelballantyne/faster-miniKanren
    git fetch subtree-faster-miniKanren
    git subtree add --prefix faster-miniKanren subtree-faster-miniKanren master

result:

        *   commit 2d10413beab92244fdf3c0de9eba8c93779458b3
        |\  Merge: 7393d90 910fbea
        | | Author: Jeff Henrikson <79888432+jeffhhk@users.noreply.github.com>
        | | Date:   Sat May 28 10:57:58 2022 -0700
        | | 
        | |     Add 'faster-miniKanren/' from commit '910fbea468d57c811b85e3e365e27f5e2d9dc2ba'
        | |     
        | |     git-subtree-dir: faster-miniKanren
        | |     git-subtree-mainline: 7393d9035ccd7f5afc4bff27c45663d46524abd1
        | |     git-subtree-split: 910fbea468d57c811b85e3e365e27f5e2d9dc2ba
        | | 
        | * commit 910fbea468d57c811b85e3e365e27f5e2d9dc2ba
        | | Author: Michael Ballantyne <michael.ballantyne@gmail.com>
        | | Date:   Sun Feb 27 13:38:33 2022 -0500
        | | 
        | |     full-interp fixes for booleans from Will Byrde
        | | 
        | | M	full-interp.scm
        | | 
        | * commit 1db40194cee7cc5821e0804055c92188e397f564
        | | Author: Michael Ballantyne <michael.ballantyne@gmail.com>
        | | Date:   Fri Feb 11 15:04:43 2022 -0500
        | | 
        | |     revise racket module wrappers to expose internals in private-unstable.rkt

## Change contents of a subtree

Just commit as if the subtree were in the parent repository.  Here is one commit on the parent repository followed by one commit on a subtree:

    * commit d0c6767c4dbb08fa735a92212aff1160eb372606
    | Author: Jeff Henrikson <79888432+jeffhhk@users.noreply.github.com>
    | Date:   Sat May 28 17:40:51 2022 -0700
    | 
    |     refactor: extract file miniKanren-wrappers-test.scm
    | 
    | A	microKanren/miniKanren-wrappers-test.scm
    | M	microKanren/miniKanren-wrappers.scm
    | 
    * commit fd7cc52401b73f0d710681764ae70928e4f868ae
    | Author: Jeff Henrikson <79888432+jeffhhk@users.noreply.github.com>
    | Date:   Sat May 28 11:05:51 2022 -0700
    | 
    |     add: test_pythag, long and short
    | 
    | A	more-wrappers.scm
    | A	test_pythag_long.scm
    | A	test_pythag_short.scm

If your intention is to eventually push a subtree commit upstream, it is best to take care not to mix files from the subtree and files elsewhere in the same commit.

## Integrate a subtree with truncated change history

If pre-integration history of the upstream repository is not interesting, passing the flag --squash to git subtree add will present the subtree history as a single commit instead of its entire history.

# End demonstration

This repository currently only demonstrates creation of subtrees.  For a general tutorial on subtrees, see the following repository:

> https://www.atlassian.com/git/tutorials/git-subtree