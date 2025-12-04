///|
struct FieldSpec {
  label : String
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
struct MethodSpec {
  name : String
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
struct StructSpec {
  name : String
  fields : Array[FieldSpec]
  methods : Array[MethodSpec]
  attrs : Array[ReflectAttribute]
} derive(Show, ToJson)

///|
fn generate_impl(spec : StructSpec) -> String {
  let struct_name = spec.name
  let lines = StringBuilder::new()
  lines.write_string("///|\n")

  // type_info
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with type_info(self) {\n",
  )
  lines.write_string("  @any.Any::of(self).type_info()\n")
  lines.write_string("}\n\n")

  // kind
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with kind(_) {\n",
  )
  lines.write_string("  Struct\n")
  lines.write_string("}\n\n")

  // attrs
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with attrs(_) {\n",
  )
  lines.write_string("  \{spec.attrs}\n")
  lines.write_string("}\n\n")

  // field
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with field(self, name) {\n",
  )
  lines.write_string("  match name {\n")
  spec.fields.each(fn(field) {
    lines.write_string(
      "    \"\{field.label}\" => Some(@any.Any::of(self.\{field.label}))\n",
    )
  })
  lines.write_string("    _ => None\n")
  lines.write_string("  }\n")
  lines.write_string("}\n\n")

  // fields
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with fields(self) {\n",
  )
  lines.write_string("  Iter2::new(fn(yield_) {\n")
  spec.fields.each(fn(field) {
    lines.write_string(
      "    if yield_(\"\{field.label}\", @any.Any::of(self.\{field.label})) == IterEnd { return IterEnd }\n",
    )
  })
  lines.write_string("    IterContinue\n")
  lines.write_string("  })\n")
  lines.write_string("}\n\n")

  // variant
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with variant(_) {\n",
  )
  lines.write_string("  None\n")
  lines.write_string("}\n\n")

  // index
  lines.write_string(
    "pub impl @reflect.Reflect for \{struct_name} with index(_, _) {\n",
  )
  lines.write_string("  None\n")
  lines.write_string("}\n\n")
  lines.to_string()
}

///|
fn main {
  let argv = @sys.get_cli_args()
  let input_file = @ref.new("")
  let output_file = @ref.new("")
  let usage =
    #| MoonBit ORM CLI tool for generating database schema from Moonbit files
    #| usage: 
    #|      morm-gen <input_file> -o <output_file>
    #|
  @ArgParser.parse(
    [
      (
        "--output-file",
        "-o",
        String(file => output_file.val = file),
        "Output file",
      ),
    ],
    file => input_file.val = file,
    usage,
    argv,
  )
  try {
    println("Parsing file: \{input_file.val}")
    let (ast, _) = @parser.parse_file(input_file.val)
    println("Parsed file")
    let specs = parse_entities_from_ast(ast)
    println("Parsed entities")
    //
    let codes : Array[String] = []
    specs.each(spec => codes.push(generate_impl(spec)))
    println("Generated codes")
    let code = codes.join("\n\n")
    @fs.write_string_to_file(output_file.val, code, encoding="utf8")
    let entity_names = specs.map(spec => spec.name)
    if entity_names.length() > 0 {
      println("Generated \{output_file.val} for entities: \{entity_names}")
    }
  } catch {
    @fs.IOError(e) => println("IOError: \{e}")
  }
}
