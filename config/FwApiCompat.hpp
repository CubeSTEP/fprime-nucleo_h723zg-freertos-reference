#ifndef CONFIG_FW_API_COMPAT_HPP
#define CONFIG_FW_API_COMPAT_HPP

namespace Fw {

class SerializeBufferBase;

enum class Endianness : U8 {
    BIG = 0,
    LITTLE = 1
};

using SerialBufferBase = SerializeBufferBase;
using LinearBufferBase = SerializeBufferBase;

}  // namespace Fw

// Compatibility shims for newer FPP-generated APIs when building
// against older F' serialization interfaces.
#ifndef serializeTo
#define serializeTo serialize
#endif

#ifndef deserializeFrom
#define deserializeFrom deserialize
#endif

#ifndef serializeFrom
#define serializeFrom(value, ...) serialize(value)
#endif

#ifndef deserializeTo
#define deserializeTo(value, ...) deserialize(value)
#endif

#ifndef getBuffCapacity
#define getBuffCapacity getCapacity
#endif

#endif
