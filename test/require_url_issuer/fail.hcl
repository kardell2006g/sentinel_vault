#------------------------------------------------------------------------------
# Sentinel Modules (function imports)
#------------------------------------------------------------------------------
mock "tfplan-functions" {
  module {
    source = "../../functions/tfplan-functions.sentinel"
  }
}


#------------------------------------------------------------------------------
# Sentinel Mocks
#------------------------------------------------------------------------------
mock "tfplan/v2" {
  module {
    source = "mock-tfplan-fail.sentinel"
  }
}


#------------------------------------------------------------------------------
# Result
#------------------------------------------------------------------------------
test {
  rules = {
    main = false
  }
}