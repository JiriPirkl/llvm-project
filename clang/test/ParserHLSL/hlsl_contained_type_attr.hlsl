// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-compute -std=hlsl202x -x hlsl -ast-dump -o - %s | FileCheck %s

typedef vector<float, 4> float4;

// CHECK: -TypeAliasDecl 0x{{[0-9a-f]+}} <line:[[# @LINE + 4]]:1, col:83>
// CHECK: -HLSLAttributedResourceType 0x{{[0-9a-f]+}} '__hlsl_resource_t
// CHECK-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-SAME{LITERAL}: [[hlsl::contained_type(int)]]
using ResourceIntAliasT = __hlsl_resource_t [[hlsl::resource_class(UAV)]] [[hlsl::contained_type(int)]];
ResourceIntAliasT h1;

// CHECK: -VarDecl 0x{{[0-9a-f]+}} <line:[[# @LINE + 3]]:1, col:82> col:82 h2 '__hlsl_resource_t 
// CHECK-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-SAME{LITERAL}: [[hlsl::contained_type(float4)]]
__hlsl_resource_t [[hlsl::resource_class(UAV)]] [[hlsl::contained_type(float4)]] h2;

// CHECK: ClassTemplateDecl 0x{{[0-9a-f]+}} <line:[[# @LINE + 6]]:1, line:[[# @LINE + 8]]:1> line:[[# @LINE + 6]]:30 S
// CHECK: TemplateTypeParmDecl 0x{{[0-9a-f]+}} <col:11, col:20> col:20 referenced typename depth 0 index 0 T
// CHECK: CXXRecordDecl 0x{{[0-9a-f]+}} <col:23, line:[[# @LINE + 6]]:1> line:[[# @LINE + 4]]:30 struct S definition
// CHECK: FieldDecl 0x{{[0-9a-f]+}} <line:[[# @LINE + 4]]:3, col:79> col:79 h '__hlsl_resource_t
// CHECK-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-SAME{LITERAL}: [[hlsl::contained_type(T)]]
template <typename T> struct S {
  __hlsl_resource_t [[hlsl::resource_class(UAV)]] [[hlsl::contained_type(T)]] h;
};
