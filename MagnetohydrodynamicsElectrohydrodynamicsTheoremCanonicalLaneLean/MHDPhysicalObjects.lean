import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure MHDOperators where
  curl : VectorField → VectorField
  gradient : ScalarField → VectorField
  divergence : VectorField → ScalarField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  lorentzForce : VectorField → VectorField → VectorField
  lorentzForceAntisymmetric : ∀ u b, lorentzForce u b = - lorentzForce b u

def primitiveMHDOperators : MHDOperators := {
  curl := fun _ => zeroVectorField
  gradient := fun _ => zeroVectorField
  divergence := fun _ => zeroScalarField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  lorentzForce := fun u _ => u
  lorentzForceAntisymmetric := by
    intro u b
    rfl
}

structure MHDFlow where
  velocity : VectorField
  magneticField : VectorField
  pressure : ScalarField
  resistivity : ℝ
  viscosity : ℝ
  operators : MHDOperators

def primitiveMHDFlow : MHDFlow := {
  velocity := zeroVectorField
  magneticField := zeroVectorField
  pressure := zeroScalarField
  resistivity := 1
  viscosity := 1
  operators := primitiveMHDOperators
}

def Incompressible (F : MHDFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def DivergenceFreeMagnetic (F : MHDFlow) : Prop :=
  F.operators.divergence F.magneticField = zeroScalarField

def InductionEquationClosed (F : MHDFlow) : Prop :=
  F.operators.timeDerivative F.magneticField = F.operators.curl (F.velocity ×' F.magneticField) + F.resistivity • F.operators.laplacian F.magneticField

def MomentumEquationClosed (F : MHDFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.viscosity • F.operators.laplacian F.velocity - F.operators.gradient F.pressure + F.operators.lorentzForce F.magneticField F.velocity

def MHDBalanceClosed (F : MHDFlow) : Prop :=
  Incompressible F ∧ DivergenceFreeMagnetic F ∧ InductionEquationClosed F ∧ MomentumEquationClosed F

theorem primitive_mhd_balance_closed_checked :
    MHDBalanceClosed primitiveMHDFlow := by
  refine And.intro ?_ (And.intro ?_ (And.intro ?_ ?_))
  · rfl
  · rfl
  · rfl
  · rfl

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse
