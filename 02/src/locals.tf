locals {
  lplatform = "netology-develop-platform"
  ldevelop = "develop"
  ldevelop2 = "develop2"
  
  vm_develop_lname = "${ local.lplatform }-${ local.ldevelop }"
  vm_develop2_lname = "${ local.lplatform }-${ local.ldevelop2 }"
}
