# ticks

This is a sort of demo package, although some may like to use it.

Unlike most of the Hal packages, it is NOT agnostic and designed to work
across the whole atmega/attiny ranges... this package is *specifically tied* to
just the ATmega328P chip. It may work on other chips but mostly by accident.

This is probably not what you need for bullet proof industrial timing, it's rather
more an easy prototyping tool.

The intention of the package is to start a tick timer, controlled by overflow
interrupts on Timer 0, to keep a ticks timer, available in the global
variable `ticks`.

`public func enableTicks()`
Activate Timer0 and an overflow interrupt to count ticks.
Has the side effect of activating global interrupts.

`public func disableTicks()`
simple integer number print

`public var ticks: UInt32`
variable containing the current tick count, note you can reset this if you choose,
just don't make assumptions if you do... the interrupt handler simply increments
it every millisecond (acutally every 1.024 milliseconds)

Note: there is a risk of "tearing" while you read this value, i.e. that the interrupt
handler updates the value in the middle of you reading it, because it is a 4-byte value.

The likely effect of that is probably trivial in most cases, except when overflowing from
one byte up to the next, when a somewhat inconsistent value could appear transiently.

To avoid this, use...

`public func safeReadTicks() -> UInt32`

...which temporarily disables interrupts while copying the ticks value, then returns
the results after resuming interrupts. That might possibly result in one overflow being missed
and an off by one on the tick count or similar small error but is probably less risky than a "torn"
value being read.


Here's a rather inefficient blink example...

```
import ticks

var lastTicks: UInt32 = 0
var toggle = false

ATmega328P.Portb.ddrb = 0xFF

enableTicks()

while mainLoopRunning {
    if (ticks - lastTicks) >= 1000 {
        toggle = !toggle
        lastTicks = ticks
        
        if toggle {
              ATmega328P.Portb.portb = 0xFF
        } else {
            ATmega328P.Portb.portb = 0
        }
    }
}
```
