import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean

structure MHDAnalyticCertificate where
  operatorsClosed : Prop
  asymptoticLayerClosed : Prop
  spectralLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  asymptoticLayerClosedProof : asymptoticLayerClosed
  spectralLayerClosedProof : spectralLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceMHDAnalyticCertificate : MHDAnalyticCertificate := {
  operatorsClosed := MHDEquationsClosed primitivePlasmaState
  asymptoticLayerClosed := MHDAsymptoticClosed sourceMHDAsymptoticCertificate
  spectralLayerClosed := MHDSpectralClosed sourceMHDSpectralCertificate
  endpointLayerClosed := MHDRegularityEndpointClosed sourceMHDRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  operatorsClosedProof := primitive_mhd_equations_closed_checked
  asymptoticLayerClosedProof := source_mhd_asymptotic_closed
  spectralLayerClosedProof := source_mhd_spectral_closed
  endpointLayerClosedProof := source_mhd_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def MHDAnalyticCertificateClosed (C : MHDAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.asymptoticLayerClosed ∧
  C.spectralLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_mhd_analytic_certificate_closed : MHDAnalyticCertificateClosed sourceMHDAnalyticCertificate := by
  exact And.intro sourceMHDAnalyticCertificate.operatorsClosedProof
    (And.intro sourceMHDAnalyticCertificate.asymptoticLayerClosedProof
      (And.intro sourceMHDAnalyticCertificate.spectralLayerClosedProof
        (And.intro sourceMHDAnalyticCertificate.endpointLayerClosedProof
          sourceMHDAnalyticCertificate.canonicalCarriageImportedProof)))

end MagnetohydrodynamicsElectrohydrodynamicsTheoremCanonicalLaneLean
end HautevilleHouse