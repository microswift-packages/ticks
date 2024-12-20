import ATmega328P
import serial
import ticks

enableTicks()

ATmega328P.Usart0.setupSerial()
ATmega328P.Usart0.write("Hello; World")

var lastTicks: UInt32 = 0
var toggle = false

ATmega328P.Portb.ddrb = 0xFF

while mainLoopRunning {
    if (ticks - lastTicks) >= 10 {
        toggle = !toggle
        lastTicks = ticks
        
        if toggle {
              ATmega328P.Portb.portb = 0xFF
        } else {
            ATmega328P.Portb.portb = 0
        }
    }
}
