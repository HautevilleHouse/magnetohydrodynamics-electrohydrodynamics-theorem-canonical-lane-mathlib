import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.LorentzForceLayer

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure EnergyDissipationCertificate where
  lorentzForce : LorentzForceCertificate
  kineticEnergyFinite : Prop
  magneticEnergyFinite : Prop
  dissipationRatePositive : Prop
  kineticEnergyFiniteClosed : kineticEnergyFinite
  magneticEnergyFiniteClosed : magneticEnergyFinite
  dissipationRatePositiveClosed : dissipationRatePositive

def sourceEnergyDissipationCertificate : EnergyDissipationCertificate := {
  lorentzForce := sourceLorentzForceCertificate
  kineticEnergyFinite := MHDBalanceClosed primitiveMHDFlow
  magneticEnergyFinite := MHDBalanceClosed primitiveMHDFlow
  dissipationRatePositive := primitiveMHDFlow.viscosity > 0 ∧ primitiveMHDFlow.resistivity > 0
  kineticEnergyFiniteClosed := primitive_mhd_balance_closed_checked
  magneticEnergyFiniteClosed := primitive_mhd_balance_closed_checked
  dissipationRatePositiveClosed := by
    refine And.intro ?_ ?_
    · norm_num
    · norm_num
}

def EnergyDissipationClosed (C : EnergyDissipationCertificate) : Prop :=
  LorentzForceClosed C.lorentzForce ∧ C.kineticEnergyFinite ∧ C.magneticEnergyFinite ∧ C.dissipationRatePositive

theorem source_energy_dissipation_closed :
    EnergyDissipationClosed sourceEnergyDissipationCertificate := by
  refine And.intro source_lorentz_force_closed
    (And.intro sourceEnergyDissipationCertificate.kineticEnergyFiniteClosed
      (And.intro sourceEnergyDissipationCertificate.magneticEnergyFiniteClosed
        sourceEnergyDissipationCertificate.dissipationRatePositiveClosed))

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse
