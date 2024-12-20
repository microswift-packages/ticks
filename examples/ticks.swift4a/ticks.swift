import HAL
import ATmega328P

var ticks: UInt32 = 0

@interruptHandler
@_silgen_name("__vector_16")
func timer0Overflow() {
    // comment modified
    ticks &+= 20
}

func enableTicks() {
    ATmega328P.Tc0.tcnt0.registerValue = 0
    ATmega328P.Tc0.tccr0a.registerValue = 0
    ATmega328P.Tc0.tccr0b.registerValue = 1
    ATmega328P.Tc0.timsk0.registerValue = 1
    ATmega328P.globalInterruptsEnabled = true
}
