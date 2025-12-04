///|
pub(all) struct ReflectAttribute {
  id : StringView
  name : StringView
  params : Map[StringView, StringView]
} derive(Show, Eq, ToJson)

///|
/// 解析阶段：使用中间结构 EntitySpec（调用者负责提供 AST）
// 说明：避免在此函数中调用可能带错误类型的 API，保持纯解析逻辑。
fn parse_entities_from_ast(
  ast : @moonbitlang/core/list.List[@moonbitlang/parser/syntax.Impl],
) -> Array[StructSpec] {
  let specs : Map[StringView, StructSpec] = {}
  ast.each(item => if item
    is @syntax.Impl::TopTypeDef(
      { tycon: name, components: Record(params), attrs, .. }
    ) {
    let fields : Array[FieldSpec] = []
    params.each(param => if param is { name: { label, .. }, attrs, .. } {
      fields.push({ label, attrs: collect_attributes(attrs) })
    })
    specs.set(name, {
      name,
      fields,
      methods: [],
      attrs: collect_attributes(attrs),
    })
  })
  ast.each(item => if item
    is @syntax.Impl::TopFuncDef(
      fun_decl={
        type_name: Some({ name: Ident(name=ty) | Dot(id=ty, ..), .. }),
        name: { name, .. },
        attrs,
        ..,
      },
      ..
    ) {
    specs[ty].methods.push({ name, attrs: collect_attributes(attrs) })
  })
  specs.values().to_array()
}

///|
/// 收集并解析所有 #morm.* attributes 为结构化 ORMAttribute
fn collect_attributes(
  attrs : @moonbitlang/core/list.List[@moonbitlang/parser/attribute.Attribute],
) -> Array[ReflectAttribute] {
  let results : Array[ReflectAttribute] = []
  attrs.each(attr => if attr.raw.strip_prefix("#") is Some(attr) {
    if attr lexmatch? (id, "\.", rest) {
      if rest lexmatch? (name, "\(", rest) {
        if rest lexmatch? (params, "\)") {
          if params.contains(",") {
            results.push({
              id,
              name,
              params: Map::from_iter(
                params
                .split(",")
                .map(x => x.split("=").map(y => y.trim_space()).to_array())
                .map(items => (items[0], items[1])),
              ),
            })
          } else {
            results.push({ id, name, params: { "_": params.trim_space() } })
          }
        }
      } else {
        results.push({ id, name: rest, params: {} })
      }
    }
  })
  results
}
