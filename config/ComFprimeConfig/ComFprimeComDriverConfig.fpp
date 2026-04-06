module ComFprime {
    # Override default TCP comms driver for STM32H7 FreeRTOS deployments.
    instance comDriver: Arduino.StreamDriver base id ComFprimeConfig.BASE_ID + 0x0B00 \
    {
        phase Fpp.ToCpp.Phases.configComponents """
        ComFprime::comDriver.configure(&Serial);
        """
    }
}
