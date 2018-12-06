variable "listy" {
  type = list(string)
}

resource "test_instance" "other" {
  count = 2
}

resource "test_instance" "bad1" {
  security_groups = test_instance.other.*.id
}

resource "test_instance" "bad2" {
  security_groups = var.listy
}

resource "test_instance" "bad1" {
  security_groups = concat(test_instance.other.*.id, var.listy)
}

resource "test_instance" "bad1" {
  security_groups = ["a", "b", "c"]
}

# The rest of these should keep the same amount of list-ness

resource "test_instance" "ok1" {
  security_groups = []
}

resource "test_instance" "ok2" {
  security_groups = ["notalist"]
}

resource "test_instance" "ok3" {
  security_groups = [path.module]
}

resource "test_instance" "ok4" {
  security_groups = [["foo"], ["bar"]]
}

resource "test_instance" "ok5" {
  security_groups = test_instance.other.*.id
}

resource "test_instance" "ok6" {
  security_groups = [
    test_instance.other1.*.id,
    test_instance.other2.*.id,
  ]
}
