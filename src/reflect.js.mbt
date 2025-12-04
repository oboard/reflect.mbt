///|
pub extern "js" fn set_field(
  obj : &Reflect,
  field : String,
  value : Any,
) -> Unit =
  #|(obj, field, value) => obj.self[field] = value._1.val;
