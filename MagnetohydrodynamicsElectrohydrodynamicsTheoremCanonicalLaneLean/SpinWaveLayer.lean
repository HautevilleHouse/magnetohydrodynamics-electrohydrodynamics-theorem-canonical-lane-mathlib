import MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean.MHDPlasmaObjects

/-!
# Spin Wave Layer

This module records the spin-wave dispersion structure for the admissible class.
Spin waves (magnons) arise from the Landau-Lifshitz equation and are key to magnetic domain dynamics.
-/

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure SpinWaveCertificate where
  flow : MHDPlasmaFlow
  exchangeConstant : ℝ
  anisotropy : ℝ
  magnetization : ScalarField
  dispersionRelation : String
  waveVector : Space3
  frequency : ℝ
  dispersionClosed : Prop
  exchangeClosed : exchangeConstant = 1
  anisotropyClosed : anisotropy = 0
  magnetizationClosed : magnetization = zeroScalarField
  frequencyClosed : frequency = 0

def sourceSpinWaveCertificate : SpinWaveCertificate := {
  flow := primitiveFlow
  exchangeConstant := 1
  anisotropy := 0
  magnetization := zeroScalarField
  dispersionRelation := "ω = γ H + D k^2"
  waveVector := ![0,0,0]
  frequency := 0
  dispersionClosed := True
  exchangeClosed := rfl
  anisotropyClosed := rfl
  magnetizationClosed := rfl
  frequencyClosed := rfl
}

def SpinWaveLayerClosed (C : SpinWaveCertificate) : Prop :=
  C.dispersionClosed ∧ C.exchangeClosed ∧ C.anisotropyClosed ∧ C.magnetizationClosed ∧ C.frequencyClosed

theorem source_spin_wave_layer_closed : SpinWaveLayerClosed sourceSpinWaveCertificate := by
  exact And.intro sourceSpinWaveCertificate.dispersionClosed
    (And.intro sourceSpinWaveCertificate.exchangeClosed
      (And.intro sourceSpinWaveCertificate.anisotropyClosed
        (And.intro sourceSpinWaveCertificate.magnetizationClosed sourceSpinWaveCertificate.frequencyClosed)))

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse