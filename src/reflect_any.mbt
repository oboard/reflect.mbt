///|
pub impl Reflect for @any.Any with type_info(self) {
  self.type_info()
}

///|
pub impl Reflect for @any.Any with kind(_) {
  Primitive
}

///|
pub impl Reflect for @any.Any with attrs(_) {
  []
}

///|
pub impl Reflect for @any.Any with field(_, _) {
  None
}

///|
pub impl Reflect for @any.Any with fields(_) {
  Iter2::new(_ => IterEnd)
}

///|
pub impl Reflect for @any.Any with variant(_) {
  None
}

///|
pub impl Reflect for @any.Any with index(_, _) {
  None
}

///|
pub impl Reflect for @any.Any with as_any(self) {
  self
}
