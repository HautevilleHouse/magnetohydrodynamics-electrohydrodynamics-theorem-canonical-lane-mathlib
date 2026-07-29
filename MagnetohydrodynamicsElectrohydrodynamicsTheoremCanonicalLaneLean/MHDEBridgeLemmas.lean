import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.MHDEOperators

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

def bridgeClosed (A : AdmissibleClass) : Prop :=
  NativeBridgeClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact And.intro A.object.sourceKeyChecked A.object.theoremObjectChecked

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse
