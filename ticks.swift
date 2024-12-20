import HAL
import ATmega328P

// This is a simple library to simulate ticks for fairly crude time measurement.
// It is only expected to work on an ATmega328P or very closely related chip as
// it hard codes a specific interrupt vector, plus it assumes timings running at
// 16MHz. Given that, the fidelity of ticks as milliseconds should be reasonable.
// And with a 32 bit counter you should get about 49 days of continuous running before
// the tick counter overflows and wraps back to 0.
// Uses Timer 0 so that timer can't be used for PWM or other uses while this library is
// active.

public var ticks: UInt32 = 0

@interruptHandler
@_silgen_name("__vector_16")
func timer0Overflow() {
    ticks &+= 1
}

public func safeReadTicks() -> UInt32 {
    ATmega328P.globalInterruptsEnabled = false
    let currentTicks = ticks
    ATmega328P.globalInterruptsEnabled = true
    return currentTicks
}

public func enableTicks() {
    ATmega328P.Tc0.tcnt0.registerValue = 0
    ATmega328P.Tc0.tccr0a.registerValue = 0
    ATmega328P.Tc0.tccr0b.registerValue = 4
    ATmega328P.Tc0.timsk0.registerValue = 1
    ATmega328P.globalInterruptsEnabled = true
}

public func disableTicks() {
    ATmega328P.Tc0.tcnt0.registerValue = 0
    ATmega328P.Tc0.tccr0a.registerValue = 0
    ATmega328P.Tc0.tccr0b.registerValue = 0
    ATmega328P.Tc0.timsk0.registerValue = 0
    ATmega328P.globalInterruptsEnabled = false
}
