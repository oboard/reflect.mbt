///|
#my.Attribute1(a="1", b="2")
#my.Attribute2(haha)
pub struct MyStruct1 {
  #my.Attribute3
  field1 : Int
  field2 : String
  field3 : Double?
}

///|
#my.Attribute4
pub fn MyStruct1::new(
  field1 : Int,
  field2 : String,
  field3 : Double?,
) -> MyStruct1 {
  MyStruct1::{ field1, field2, field3 }
}

///|
test "struct" {
  let struct1 = MyStruct1::{ field1: 1, field2: "hello", field3: Some(3.14) }

  // Test type info
  let info = @reflect.type_of(struct1)
  assert_eq(info.name(), "MyStruct1")

  // Test field access
  let f1 = @reflect.get_field(struct1, "field1")
  // Check if f1 is Some(Any(Int))
  match f1 {
    Some(a) => {
      // We can try to coerce or check type name
      assert_eq(a.type_name(), "Int")
      assert_eq(a.unsafe_coerce(), 1) // unsafe_coerce requires type inference
    }
    None => fail("field1 not found")
  }

  // Test iteration
  assert_eq(struct1.fields().to_array().length(), 3)
}
