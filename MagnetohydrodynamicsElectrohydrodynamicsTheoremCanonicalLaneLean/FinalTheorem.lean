import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.BridgeLemmas
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

def ConstrainedMHDClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_mhd_endgame (A : AdmissibleClass) :
    ConstrainedMHDClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse
