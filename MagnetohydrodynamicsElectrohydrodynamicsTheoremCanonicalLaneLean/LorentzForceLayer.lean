import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.MHDPhysicalObjects

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure LorentzForceCertificate where
  flow : MHDFlow
  lorentzForceAntisymmetry : Prop
  lorentzForceBounded : Prop
  lorentzForceAntisymmetryClosed : lorentzForceAntisymmetry
  lorentzForceBoundedClosed : lorentzForceBounded

def sourceLorentzForceCertificate : LorentzForceCertificate := {
  flow := primitiveMHDFlow
  lorentzForceAntisymmetry := primitiveMHDOperators.lorentzForceAntisymmetric primitiveMHDFlow.velocity primitiveMHDFlow.magneticField
  lorentzForceBounded := MHDBalanceClosed primitiveMHDFlow
  lorentzForceAntisymmetryClosed := rfl
  lorentzForceBoundedClosed := primitive_mhd_balance_closed_checked
}

def LorentzForceClosed (C : LorentzForceCertificate) : Prop :=
  C.lorentzForceAntisymmetry ∧ C.lorentzForceBounded

theorem source_lorentz_force_closed :
    LorentzForceClosed sourceLorentzForceCertificate := by
  exact And.intro sourceLorentzForceCertificate.lorentzForceAntisymmetryClosed
    sourceLorentzForceCertificate.lorentzForceBoundedClosed

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse
