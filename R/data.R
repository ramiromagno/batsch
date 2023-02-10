#' qPCR data sets by Batsch et al. (2008)
#'
#' @description
#' Each data set comprises a five-point, four-fold dilution series. For each
#' concentration there are three replicates. Each amplification curve is 45
#' cycles long.
#'
#' A single reaction (total volume 10 µl) contained 1 µl master mix (LightCycler
#' TaqMan Master; Roche 04735536001), 1 µmol/l each of forward and reverse
#' primer, SYBR Green I at 1:30 dilution (Invitrogen S7563) or 50 nmol/l probe,
#' and various amounts of cDNA or plasmid DNA. Contamination controls contained
#' water instead of DNA. After enzyme activation (10 min, 95°C), thermocycling
#' consisted of 45 cycles of 10 s at 95°C, 30 s at 55°C, and 1 s at 72°C;
#' velocity of temperature change was 1.1°C/s.
#' Please read the Methods section of Batsch et al. (2008) for more details.
#'
#' @format Each data set is provided as a [tibble][tibble::tibble-package] with
#'   675 rows and 9 variables:
#' \describe{
#' \item{`plate`}{Plate identifier. Because one plate was used per target, the
#' name of the plate is the same as the values in `target`.}
#' \item{`well`}{Well identifier. Values are always `NA` (not available) for
#' these data sets. This variable is kept nevertheless to be coherent with other
#' data sets from other similar R data packages.}
#' \item{`dye`}{Either SYBR Green I master mix (Roche) (`"SYBR"`) or TaqMan
#' probe (`"TaqMan"`).}
#' \item{`target`}{Target identifier: rat SLC6A14 (`"SLC6A14r"`), human SLC22A13
#' (`"SLC22A13h"`), pig EMT (`"EMTp"`), chicken ETT (`"ETTch"`) or human GAPDH
#' (`"GAPDHh"`).}
#' \item{`sample_type`}{Sample type (all curves are standards, i.e. `"std"`).}
#' \item{`replicate`}{Replicate identifier: 1 thru 3.}
#' \item{`dilution`}{Dilution factor. Higher number means greater dilution.}
#' \item{`cycle`}{PCR cycle.}
#' \item{`fluor`}{Raw fluorescence values.}
#' }
#'
#' @examples
#' SLC6A14r
#'
#' SLC22A13h
#'
#' EMTp
#'
#' ETTch
#'
#' GAPDHh
#'
#' @source \doi{10.1186/1471-2105-9-95}
#' @name batsch
#' @keywords datasets
NULL

#' @format NULL
#' @rdname batsch
"SLC6A14r"

#' @format NULL
#' @rdname batsch
"SLC22A13h"

#' @format NULL
#' @rdname batsch
"EMTp"

#' @format NULL
#' @rdname batsch
"ETTch"

#' @format NULL
#' @rdname batsch
"GAPDHh"
