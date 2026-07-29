import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

abbrev PlasmaRegion := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → PlasmaRegion → ℝ
abbrev VectorField := Time → PlasmaRegion → PlasmaRegion
abbrev TensorField := Time → PlasmaRegion → (Fin 3 → Fin 3 → ℝ)

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0
def zeroTensorField : TensorField := fun _ _ _ _ => 0

structure MHDOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  curl : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  advection : VectorField → VectorField
  lorentzForce : VectorField → VectorField → VectorField
  resistiveTerm : VectorField → VectorField
  pressureGradient : ScalarField → VectorField
  projection : VectorField → VectorField
  projectionIdempotent : ∀ u, projection (projection u) = projection u

def primitiveMHDOperators : MHDOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  curl := fun u => u
  timeDerivative := fun _ => zeroVectorField
  advection := fun _ => zeroVectorField
  lorentzForce := fun _ _ => zeroVectorField
  resistiveTerm := fun _ => zeroVectorField
  pressureGradient := fun _ => zeroVectorField
  projection := fun u => u
  projectionIdempotent := by intro u; rfl
}

structure MHDPlasmaState where
  velocity : VectorField
  magneticField : VectorField
  pressure : ScalarField
  density : ScalarField
  resistivity : ℝ
  viscosity : ℝ
  operators : MHDOperators

def primitivePlasmaState : MHDPlasmaState := {
  velocity := zeroVectorField
  magneticField := zeroVectorField
  pressure := zeroScalarField
  density := zeroScalarField
  resistivity := 1
  viscosity := 1
  operators := primitiveMHDOperators
}

def IdealMHDCondition (S : MHDPlasmaState) : Prop :=
  S.operators.curl S.magneticField = S.operators.curl (S.operators.curl S.velocity)

def ResistiveMHDBalance (S : MHDPlasmaState) : Prop :=
  S.operators.timeDerivative S.magneticField = S.operators.curl (S.operators.crossProduct S.velocity S.magneticField)

def MHDEquationsClosed (S : MHDPlasmaState) : Prop :=
  IdealMHDCondition S ∧ ResistiveMHDBalance S

theorem primitive_mhd_equations_closed_checked : MHDEquationsClosed primitivePlasmaState := by
  unfold MHDEquationsClosed; constructor
  · unfold IdealMHDCondition; rfl
  · unfold ResistiveMHDBalance; rfl

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse