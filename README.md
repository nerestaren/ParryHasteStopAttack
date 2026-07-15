# ParryHasteStopAttack
Scans macros and (un)comments commands that end with `#phsa`.

## Use case
When tanking dragons, I add a `/stopattack` command to my actions' macros to prevent _parryhaste_. E.g.:

```
#showtooltip
/cast [mod:alt]Dark Command;Icy Touch
/stopattack
/cancelaura Divine Intervention
/cancelaura Hand of Protection
```

This may be a good idea, but I should remove that to tank other bosses, as this is a threat loss.

One way to remove it and make it easier for the following time tanking a dragon may be to comment it, e.g.: `#/stopattack`.

This addon provides an automatic way of doing this, by tagging the commands that need to be processed with `#phsa` at the end of the line.

This way, the previous macro looks like this:

```
#showtooltip
/cast [mod:alt]Dark Command;Icy Touch
#/stopattack #phsa
/cancelaura Divine Intervention
/cancelaura Hand of Protection
```

This addon would work with any other command. Supporting other tags is not supported, but would be quite easy to do.

## Description
This addon listens to the following slash commands: `/ph`, `/phsa`, `/parryhaste`, `/parryhastestopattack`.
An argument may be passed to specify the action to perform:
* `on` or `enable`
* `off` or `disable`
* `toggle` or leave it empty

Then all macros are processed and, if a line is found that ends with `#phsa`, it checks if it is already commented or not.
- If it was already commented and the action is not to disable it, it enables it by uncommenting.
- If it was not commented and the action is not to enable it, it disables it by commenting it with `#`.

Disclaimer: this cannot be done in combat.
