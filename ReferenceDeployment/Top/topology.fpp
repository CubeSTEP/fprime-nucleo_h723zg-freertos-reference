module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

    enum Ports_RateGroups {
      rateGroup1
    }

  topology ReferenceDeployment {

    # ----------------------------------------------------------------------
    # Subtopology instances
    # ----------------------------------------------------------------------

    instance ComFprime.Subtopology

    # ----------------------------------------------------------------------
    # Instances used in the topology
    # ----------------------------------------------------------------------

    instance cmdDisp
    instance eventManager
    instance rateDriver
    instance rateGroup1
    instance rateGroupDriver
    instance textLogger
    instance timeHandler
    instance tlmSend
    instance comDriver

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    command connections instance cmdDisp

    event connections instance eventManager

    telemetry connections instance tlmSend

    text event connections instance textLogger

    time connections instance timeHandler

    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    connections RateGroups {
      # Block driver
      rateDriver.CycleOut -> rateGroupDriver.CycleIn

      # Rate group 1
      rateGroupDriver.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1.CycleIn
      rateGroup1.RateGroupMemberOut[0] -> tlmSend.Run
      rateGroup1.RateGroupMemberOut[1] -> comDriver.schedIn
      rateGroup1.RateGroupMemberOut[2] -> ComFprime.Subtopology.comQueueRun
    }
    
    connections Communications {
      # ComDriver buffer allocations
      comDriver.allocate   -> ComFprime.Subtopology.commsBufferGetCallee
      comDriver.deallocate -> ComFprime.Subtopology.commsBufferSendIn

      # ComDriver <-> ComStub
      comDriver.$recv                           -> ComFprime.Subtopology.drvReceiveIn
      ComFprime.Subtopology.drvReceiveReturnOut -> comDriver.recvReturnIn
      ComFprime.Subtopology.drvSendOut          -> comDriver.$send
      comDriver.ready                           -> ComFprime.Subtopology.drvConnected

      # Events and telemetry to ComQueue
      eventManager.PktSend -> ComFprime.Subtopology.comPacketQueueIn[ComFprime.Ports_ComPacketQueue.EVENTS]
      tlmSend.PktSend     -> ComFprime.Subtopology.comPacketQueueIn[ComFprime.Ports_ComPacketQueue.TELEMETRY]

      # Router <-> CmdDispatcher
      ComFprime.Subtopology.commandOut -> cmdDisp.seqCmdBuff
      cmdDisp.seqCmdStatus             -> ComFprime.Subtopology.cmdResponseIn
    }

    connections ReferenceDeployment {
      # Add here connections to user-defined components
    }

  }

}
