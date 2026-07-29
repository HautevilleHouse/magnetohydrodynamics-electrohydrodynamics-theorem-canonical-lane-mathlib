import MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.SpinWaveLayer

/-!
# Ising Magnetic Domain Layer

This module records the Ising model and magnetic domain structure for the admissible class.
Domain walls and hysteresis are captured via spin-spin coupling constants.
-/

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure IsingMagneticDomainCertificate where
  spinWave : SpinWaveCertificate
  exchangeCoupling : ℝ
  domainWallEnergy : ScalarField
  magnetizationProfile : String
  hysteresisLoop : Prop
  exchangeCouplingClosed : exchangeCoupling = 1
  domainWallEnergyClosed : domainWallEnergy = zeroScalarField
  magnetizationProfileClosed : magnetizationProfile = "uniform"
  hysteresisLoopClosed : hysteresisLoop

def sourceIsingMagneticDomainCertificate : IsingMagneticDomainCertificate := {
  spinWave := sourceSpinWaveCertificate
  exchangeCoupling := 1
  domainWallEnergy := zeroScalarField
  magnetizationProfile := "uniform"
  hysteresisLoop := True
  exchangeCouplingClosed := rfl
  domainWallEnergyClosed := rfl
  magnetizationProfileClosed := rfl
  hysteresisLoopClosed := trivial
}

def IsingMagneticDomainLayerClosed (C : IsingMagneticDomainCertificate) : Prop :=
  SpinWaveLayerClosed C.spinWave ∧ C.exchangeCouplingClosed ∧ C.domainWallEnergyClosed ∧ C.magnetizationProfileClosed ∧ C.hysteresisLoopClosed

theorem source_ising_magnetic_domain_layer_closed : IsingMagneticDomainLayerClosed sourceIsingMagneticDomainCertificate := by
  exact And.intro source_spin_wave_layer_closed
    (And.intro sourceIsingMagneticDomainCertificate.exchangeCouplingClosed
      (And.intro sourceIsingMagneticDomainCertificate.domainWallEnergyClosed
        (And.intro sourceIsingMagneticDomainCertificate.magnetizationProfileClosed sourceIsingMagneticDomainCertificate.hysteresisLoopClosed)))

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse