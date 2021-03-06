context("PLS (old objects)")

library(testthat)
library(recipes)
library(dplyr)
library(modeldata)

## -----------------------------------------------------------------------------

data(biomass, package = "modeldata")

biom_tr <- biomass %>% dplyr::filter(dataset == "Training") %>% dplyr::select(-dataset, -sample)
biom_te <- biomass %>% dplyr::filter(dataset == "Testing")  %>% dplyr::select(-dataset, -sample, -HHV)

load(test_path("test_pls_old.RData"))

## -----------------------------------------------------------------------------

test_that('check old PLS scores from recipes version <= 0.1.12', {
  new_values_tr <- juice(old_pls, all_predictors())
  expect_equal(new_values_tr, old_pls_tr)

  new_values_te <- bake(old_pls, biom_te)
  expect_equal(new_values_te, old_pls_te)
})
