# Original raw data file is the additional file 5: Original raw data. Excel file
# with raw fluorescence and cycle data exported from LightCycler.
# URL:
# https://static-content.springer.com/esm/art%3A10.1186%2F1471-2105-9-95/MediaObjects/12859_2007_2080_MOESM5_ESM.xls
# Publication: https://doi.org/10.1186/1471-2105-9-95.

library(tidyverse)
library(readxl)
library(here)

data_dir <- here::here("data-raw")
data_file_path <- file.path(data_dir, "12859_2007_2080_MOESM5_ESM.xls")
sheets <- readxl::excel_sheets(data_file_path)

# The mapping between targets (here provided in `sheets`) and the dye (Taqman
# probe or intercalating dye) choice was gathered from the documentation of the
# R package `{qpcR}` by Andrej-Nikolai Spiess.
dyes <- setNames(c("TaqMan", "TaqMan", "TaqMan", "SYBR", "SYBR"), sheets)

read_dataset <- function(file, sheet) {

  # Exception for sheet "SLC22A13h", that unlike the rest of the sheets whose
  # data start at B3, for "SLC22A13h" the start is C3.
  header_range <- if (sheet == "SLC22A13h") "C3:AF3" else "B3:AE3"

  header <-
    readxl::read_excel(
      path = file,
      sheet = sheet,
      range = header_range,
      col_names = as.character(1:30)
    )

  dilution <-
    na.omit(as.character(unlist(header[1,]))) %>%
    stringr::str_extract(r"{(\d+:\d+)}") %>%
    {.[is.na(.)] <- "1:1"; .} %>%
    stringr::str_extract(r"{\d+$}") %>%
    as.integer()

  replicates <- rep(1:3, each = 5)

  # Exception for sheet "SLC22A13h".
  data_range <- if (sheet == "SLC22A13h") "C5:AF49" else "B5:AE49"

  data <-
    readxl::read_excel(
      path = file,
      sheet = sheet,
      range = data_range,
      col_names = as.character(1:30)
    )

  dataset <-
    split(as.list(data), f = rep(seq_len(ncol(data) / 2), each = 2)) %>%
    purrr::map2(dilution,
                .f = ~ tibble::tibble(
                  dilution = .y,
                  cycle = .x[[1]],
                  fluor = .x[[2]]
                )) %>%
    purrr::map2(replicates,
                .f = ~ tibble::add_column(.x, replicate = .y, .before = 1L)) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(
      plate = factor(sheet),
      well = factor(NA_character_),
      replicate = replicate,
      dye = factor(dyes[sheet]),
      target = factor(sheet),
      sample_type = factor("std"),
      dilution = dilution,
      cycle = cycle,
      fluor = fluor,
      .before = 1L
      )

  dataset
}

sheets <- setNames(sheets, sheets)
datasets <-
  purrr::map(sheets, ~ read_dataset(file = data_file_path, sheet = .x))

with(datasets,
     {
       usethis::use_data(SLC6A14r, overwrite = TRUE)
       usethis::use_data(SLC22A13h, overwrite = TRUE)
       usethis::use_data(EMTp, overwrite = TRUE)
       usethis::use_data(ETTch, overwrite = TRUE)
       usethis::use_data(GAPDHh, overwrite = TRUE)
     })
