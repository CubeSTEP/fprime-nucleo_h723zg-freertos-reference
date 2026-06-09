// ======================================================================
// \title  Led.hpp
// \author thakkar
// \brief  hpp file for Led component implementation class
// ======================================================================

#ifndef ReferenceDeployment_Led_HPP
#define ReferenceDeployment_Led_HPP

#include "Components/Led/LedComponentAc.hpp"

namespace ReferenceDeployment {

class Led final : public LedComponentBase {
  public:
    // ----------------------------------------------------------------------
    // Component construction and destruction
    // ----------------------------------------------------------------------

    //! Construct Led object
    Led(const char* const compName  //!< The component name
    );

    //! Destroy Led object
    ~Led();

  private:
    // ----------------------------------------------------------------------
    // Handler implementations for commands
    // ----------------------------------------------------------------------

    //! Handler implementation for command TODO
    //!
    //! TODO
    void TODO_cmdHandler(FwOpcodeType opCode,  //!< The opcode
                         U32 cmdSeq            //!< The command sequence number
                         ) override;
};

}  // namespace ReferenceDeployment

#endif
