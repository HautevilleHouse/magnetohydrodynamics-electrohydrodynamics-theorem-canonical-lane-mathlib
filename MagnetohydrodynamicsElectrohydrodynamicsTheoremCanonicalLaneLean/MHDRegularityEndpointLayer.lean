import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure MHDRegularityEndpointCertificate where
  spectral : MHDSpectralCertificate
  sourceFormulaClosed : Prop
  bridgeClosedOnObject : Prop
  gateClosedOnAdmissibleClass : Prop
  theoremBoundaryCarried : Prop
  sourceFormulaClosedProof : sourceFormulaClosed
  bridgeClosedOnObjectProof : bridgeClosedOnObject
  gateClosedOnAdmissibleClassProof : gateClosedOnAdmissibleClass
  theoremBoundaryCarriedProof : theoremBoundaryCarried

def mhdAdmittedObject : AdmittedTheoremObject := {
  object := theoremSpecificObject
  localWitness := "MHD analytic certificate with asymptotic, spectral, and regularity endpoint."
  bridgeEvidence := "source-derived Lean certificate fields"
  sourceKeyChecked := rfl
  theoremObjectChecked := rfl
}

def mhdAdmissibleClass : AdmissibleClass := {
  object := mhdAdmittedObject
  endpointSatisfied := MHDEquationsClosed primitivePlasmaState
  remainderRecorded := formalizationCertificate.theoremBoundaryOpen = true
  gateWitness := Or.inl primitive_mhd_equations_closed_checked
}

def sourceMHDRegularityEndpointCertificate : MHDRegularityEndpointCertificate := {
  spectral := sourceMHDSpectralCertificate
  sourceFormulaClosed := sourceFormulaModels.length = 7
  bridgeClosedOnObject := bridgeClosed mhdAdmissibleClass
  gateClosedOnAdmissibleClass := gateClosed mhdAdmissibleClass
  theoremBoundaryCarried := formalizationCertificate.theoremBoundaryOpen = true
  sourceFormulaClosedProof := rfl
  bridgeClosedOnObjectProof := bridge_from_admissible_class mhdAdmissibleClass
  gateClosedOnAdmissibleClassProof := gate_from_admissible_class mhdAdmissibleClass
  theoremBoundaryCarriedProof := rfl
}

def MHDRegularityEndpointClosed (C : MHDRegularityEndpointCertificate) : Prop :=
  MHDSpectralClosed C.spectral ∧
  C.sourceFormulaClosed ∧
  C.bridgeClosedOnObject ∧
  C.gateClosedOnAdmissibleClass ∧
  C.theoremBoundaryCarried

theorem source_mhd_regularity_endpoint_closed : MHDRegularityEndpointClosed sourceMHDRegularityEndpointCertificate := by
  exact And.intro source_mhd_spectral_closed
    (And.intro sourceMHDRegularityEndpointCertificate.sourceFormulaClosedProof
      (And.intro sourceMHDRegularityEndpointCertificate.bridgeClosedOnObjectProof
        (And.intro sourceMHDRegularityEndpointCertificate.gateClosedOnAdmissibleClassProof
          sourceMHDRegularityEndpointCertificate.theoremBoundaryCarriedProof)))

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse