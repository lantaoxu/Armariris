; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=+avx | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx | FileCheck %s --check-prefix=X64

define <4 x i64> @A(i64* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: A:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl (%eax), %ecx
; X32-NEXT:    movl 4(%eax), %eax
; X32-NEXT:    vmovd %ecx, %xmm0
; X32-NEXT:    vpinsrd $1, %eax, %xmm0, %xmm0
; X32-NEXT:    vpinsrd $2, %ecx, %xmm0, %xmm0
; X32-NEXT:    vpinsrd $3, %eax, %xmm0, %xmm0
; X32-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: A:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd (%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %q = load i64, i64* %ptr, align 8
  %vecinit.i = insertelement <4 x i64> undef, i64 %q, i32 0
  %vecinit2.i = insertelement <4 x i64> %vecinit.i, i64 %q, i32 1
  %vecinit4.i = insertelement <4 x i64> %vecinit2.i, i64 %q, i32 2
  %vecinit6.i = insertelement <4 x i64> %vecinit4.i, i64 %q, i32 3
  ret <4 x i64> %vecinit6.i
}

define <8 x i32> @B(i32* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: B:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: B:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %q = load i32, i32* %ptr, align 4
  %vecinit.i = insertelement <8 x i32> undef, i32 %q, i32 0
  %vecinit2.i = insertelement <8 x i32> %vecinit.i, i32 %q, i32 1
  %vecinit4.i = insertelement <8 x i32> %vecinit2.i, i32 %q, i32 2
  %vecinit6.i = insertelement <8 x i32> %vecinit4.i, i32 %q, i32 3
  ret <8 x i32> %vecinit6.i
}

define <4 x double> @C(double* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: C:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: C:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd (%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %q = load double, double* %ptr, align 8
  %vecinit.i = insertelement <4 x double> undef, double %q, i32 0
  %vecinit2.i = insertelement <4 x double> %vecinit.i, double %q, i32 1
  %vecinit4.i = insertelement <4 x double> %vecinit2.i, double %q, i32 2
  %vecinit6.i = insertelement <4 x double> %vecinit4.i, double %q, i32 3
  ret <4 x double> %vecinit6.i
}

define <8 x float> @D(float* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: D:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: D:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %q = load float, float* %ptr, align 4
  %vecinit.i = insertelement <8 x float> undef, float %q, i32 0
  %vecinit2.i = insertelement <8 x float> %vecinit.i, float %q, i32 1
  %vecinit4.i = insertelement <8 x float> %vecinit2.i, float %q, i32 2
  %vecinit6.i = insertelement <8 x float> %vecinit4.i, float %q, i32 3
  ret <8 x float> %vecinit6.i
}

;;;; 128-bit versions

define <4 x float> @e(float* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: e:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: e:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %xmm0
; X64-NEXT:    retq
entry:
  %q = load float, float* %ptr, align 4
  %vecinit.i = insertelement <4 x float> undef, float %q, i32 0
  %vecinit2.i = insertelement <4 x float> %vecinit.i, float %q, i32 1
  %vecinit4.i = insertelement <4 x float> %vecinit2.i, float %q, i32 2
  %vecinit6.i = insertelement <4 x float> %vecinit4.i, float %q, i32 3
  ret <4 x float> %vecinit6.i
}

; Don't broadcast constants on pre-AVX2 hardware.
define <4 x float> @_e2(float* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: _e2:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    vmovaps {{.*#+}} xmm0 = [-7.812500e-03,-7.812500e-03,-7.812500e-03,-7.812500e-03]
; X32-NEXT:    retl
;
; X64-LABEL: _e2:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vmovaps {{.*#+}} xmm0 = [-7.812500e-03,-7.812500e-03,-7.812500e-03,-7.812500e-03]
; X64-NEXT:    retq
entry:
   %vecinit.i = insertelement <4 x float> undef, float       0xbf80000000000000, i32 0
  %vecinit2.i = insertelement <4 x float> %vecinit.i, float  0xbf80000000000000, i32 1
  %vecinit4.i = insertelement <4 x float> %vecinit2.i, float 0xbf80000000000000, i32 2
  %vecinit6.i = insertelement <4 x float> %vecinit4.i, float 0xbf80000000000000, i32 3
  ret <4 x float> %vecinit6.i
}


define <4 x i32> @F(i32* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: F:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: F:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %xmm0
; X64-NEXT:    retq
entry:
  %q = load i32, i32* %ptr, align 4
  %vecinit.i = insertelement <4 x i32> undef, i32 %q, i32 0
  %vecinit2.i = insertelement <4 x i32> %vecinit.i, i32 %q, i32 1
  %vecinit4.i = insertelement <4 x i32> %vecinit2.i, i32 %q, i32 2
  %vecinit6.i = insertelement <4 x i32> %vecinit4.i, i32 %q, i32 3
  ret <4 x i32> %vecinit6.i
}

; FIXME: Pointer adjusted broadcasts

define <4 x i32> @load_splat_4i32_4i32_1111(<4 x i32>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4i32_4i32_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vpshufd {{.*#+}} xmm0 = mem[1,1,1,1]
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4i32_4i32_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = mem[1,1,1,1]
; X64-NEXT:    retq
entry:
  %ld = load <4 x i32>, <4 x i32>* %ptr
  %ret = shufflevector <4 x i32> %ld, <4 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %ret
}

define <8 x i32> @load_splat_8i32_4i32_33333333(<4 x i32>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_8i32_4i32_33333333:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss 12(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_8i32_4i32_33333333:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss 12(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <4 x i32>, <4 x i32>* %ptr
  %ret = shufflevector <4 x i32> %ld, <4 x i32> undef, <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>
  ret <8 x i32> %ret
}

define <8 x i32> @load_splat_8i32_8i32_55555555(<8 x i32>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_8i32_8i32_55555555:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss 20(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_8i32_8i32_55555555:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss 20(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <8 x i32>, <8 x i32>* %ptr
  %ret = shufflevector <8 x i32> %ld, <8 x i32> undef, <8 x i32> <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <8 x i32> %ret
}

define <4 x float> @load_splat_4f32_4f32_1111(<4 x float>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4f32_4f32_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss 4(%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4f32_4f32_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss 4(%rdi), %xmm0
; X64-NEXT:    retq
entry:
  %ld = load <4 x float>, <4 x float>* %ptr
  %ret = shufflevector <4 x float> %ld, <4 x float> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  ret <4 x float> %ret
}

define <8 x float> @load_splat_8f32_4f32_33333333(<4 x float>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_8f32_4f32_33333333:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss 12(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_8f32_4f32_33333333:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss 12(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <4 x float>, <4 x float>* %ptr
  %ret = shufflevector <4 x float> %ld, <4 x float> undef, <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>
  ret <8 x float> %ret
}

define <8 x float> @load_splat_8f32_8f32_55555555(<8 x float>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_8f32_8f32_55555555:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss 20(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_8f32_8f32_55555555:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss 20(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <8 x float>, <8 x float>* %ptr
  %ret = shufflevector <8 x float> %ld, <8 x float> undef, <8 x i32> <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <8 x float> %ret
}

define <2 x i64> @load_splat_2i64_2i64_1111(<2 x i64>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_2i64_2i64_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vpshufd {{.*#+}} xmm0 = mem[2,3,2,3]
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_2i64_2i64_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = mem[2,3,2,3]
; X64-NEXT:    retq
entry:
  %ld = load <2 x i64>, <2 x i64>* %ptr
  %ret = shufflevector <2 x i64> %ld, <2 x i64> undef, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %ret
}

define <4 x i64> @load_splat_4i64_2i64_1111(<2 x i64>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4i64_2i64_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd 8(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4i64_2i64_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd 8(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <2 x i64>, <2 x i64>* %ptr
  %ret = shufflevector <2 x i64> %ld, <2 x i64> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i64> %ret
}

define <4 x i64> @load_splat_4i64_4i64_2222(<4 x i64>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4i64_4i64_2222:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd 16(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4i64_4i64_2222:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd 16(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <4 x i64>, <4 x i64>* %ptr
  %ret = shufflevector <4 x i64> %ld, <4 x i64> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i64> %ret
}

define <2 x double> @load_splat_2f64_2f64_1111(<2 x double>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_2f64_2f64_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_2f64_2f64_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; X64-NEXT:    retq
entry:
  %ld = load <2 x double>, <2 x double>* %ptr
  %ret = shufflevector <2 x double> %ld, <2 x double> undef, <2 x i32> <i32 1, i32 1>
  ret <2 x double> %ret
}

define <4 x double> @load_splat_4f64_2f64_1111(<2 x double>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4f64_2f64_1111:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd 8(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4f64_2f64_1111:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd 8(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <2 x double>, <2 x double>* %ptr
  %ret = shufflevector <2 x double> %ld, <2 x double> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  ret <4 x double> %ret
}

define <4 x double> @load_splat_4f64_4f64_2222(<4 x double>* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: load_splat_4f64_4f64_2222:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd 16(%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: load_splat_4f64_4f64_2222:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastsd 16(%rdi), %ymm0
; X64-NEXT:    retq
entry:
  %ld = load <4 x double>, <4 x double>* %ptr
  %ret = shufflevector <4 x double> %ld, <4 x double> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  ret <4 x double> %ret
}

; Unsupported vbroadcasts

define <2 x i64> @G(i64* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: G:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl (%eax), %ecx
; X32-NEXT:    movl 4(%eax), %eax
; X32-NEXT:    vmovd %ecx, %xmm0
; X32-NEXT:    vpinsrd $1, %eax, %xmm0, %xmm0
; X32-NEXT:    vpinsrd $2, %ecx, %xmm0, %xmm0
; X32-NEXT:    vpinsrd $3, %eax, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: G:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; X64-NEXT:    retq
entry:
  %q = load i64, i64* %ptr, align 8
  %vecinit.i = insertelement <2 x i64> undef, i64 %q, i32 0
  %vecinit2.i = insertelement <2 x i64> %vecinit.i, i64 %q, i32 1
  ret <2 x i64> %vecinit2.i
}

define <4 x i32> @H(<4 x i32> %a) {
; X32-LABEL: H:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X32-NEXT:    retl
;
; X64-LABEL: H:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X64-NEXT:    retq
entry:
  %x = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  ret <4 x i32> %x
}

define <2 x double> @I(double* %ptr) nounwind uwtable readnone ssp {
; X32-LABEL: I:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; X32-NEXT:    retl
;
; X64-LABEL: I:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; X64-NEXT:    retq
entry:
  %q = load double, double* %ptr, align 4
  %vecinit.i = insertelement <2 x double> undef, double %q, i32 0
  %vecinit2.i = insertelement <2 x double> %vecinit.i, double %q, i32 1
  ret <2 x double> %vecinit2.i
}

define <4 x float> @_RR(float* %ptr, i32* %k) nounwind uwtable readnone ssp {
; X32-LABEL: _RR:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    vbroadcastss (%ecx), %xmm0
; X32-NEXT:    movl (%eax), %eax
; X32-NEXT:    movl %eax, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: _RR:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %xmm0
; X64-NEXT:    movl (%rsi), %eax
; X64-NEXT:    movl %eax, (%rax)
; X64-NEXT:    retq
entry:
  %q = load float, float* %ptr, align 4
  %vecinit.i = insertelement <4 x float> undef, float %q, i32 0
  %vecinit2.i = insertelement <4 x float> %vecinit.i, float %q, i32 1
  %vecinit4.i = insertelement <4 x float> %vecinit2.i, float %q, i32 2
  %vecinit6.i = insertelement <4 x float> %vecinit4.i, float %q, i32 3
  ; force a chain
  %j = load i32, i32* %k, align 4
  store i32 %j, i32* undef
  ret <4 x float> %vecinit6.i
}

define <4 x float> @_RR2(float* %ptr, i32* %k) nounwind uwtable readnone ssp {
; X32-LABEL: _RR2:
; X32:       ## BB#0: ## %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: _RR2:
; X64:       ## BB#0: ## %entry
; X64-NEXT:    vbroadcastss (%rdi), %xmm0
; X64-NEXT:    retq
entry:
  %q = load float, float* %ptr, align 4
  %v = insertelement <4 x float> undef, float %q, i32 0
  %t = shufflevector <4 x float> %v, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %t
}

; These tests check that a vbroadcast instruction is used when we have a splat
; formed from a concat_vectors (via the shufflevector) of two BUILD_VECTORs
; (via the insertelements).

define <8 x float> @splat_concat1(float* %p) {
; X32-LABEL: splat_concat1:
; X32:       ## BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: splat_concat1:
; X64:       ## BB#0:
; X64-NEXT:    vbroadcastss (%rdi), %ymm0
; X64-NEXT:    retq
  %1 = load float, float* %p, align 4
  %2 = insertelement <4 x float> undef, float %1, i32 0
  %3 = insertelement <4 x float> %2, float %1, i32 1
  %4 = insertelement <4 x float> %3, float %1, i32 2
  %5 = insertelement <4 x float> %4, float %1, i32 3
  %6 = shufflevector <4 x float> %5, <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <8 x float> %6
}

define <8 x float> @splat_concat2(float* %p) {
; X32-LABEL: splat_concat2:
; X32:       ## BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastss (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: splat_concat2:
; X64:       ## BB#0:
; X64-NEXT:    vbroadcastss (%rdi), %ymm0
; X64-NEXT:    retq
  %1 = load float, float* %p, align 4
  %2 = insertelement <4 x float> undef, float %1, i32 0
  %3 = insertelement <4 x float> %2, float %1, i32 1
  %4 = insertelement <4 x float> %3, float %1, i32 2
  %5 = insertelement <4 x float> %4, float %1, i32 3
  %6 = insertelement <4 x float> undef, float %1, i32 0
  %7 = insertelement <4 x float> %6, float %1, i32 1
  %8 = insertelement <4 x float> %7, float %1, i32 2
  %9 = insertelement <4 x float> %8, float %1, i32 3
  %10 = shufflevector <4 x float> %5, <4 x float> %9, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x float> %10
}

define <4 x double> @splat_concat3(double* %p) {
; X32-LABEL: splat_concat3:
; X32:       ## BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: splat_concat3:
; X64:       ## BB#0:
; X64-NEXT:    vbroadcastsd (%rdi), %ymm0
; X64-NEXT:    retq
  %1 = load double, double* %p, align 8
  %2 = insertelement <2 x double> undef, double %1, i32 0
  %3 = insertelement <2 x double> %2, double %1, i32 1
  %4 = shufflevector <2 x double> %3, <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x double> %4
}

define <4 x double> @splat_concat4(double* %p) {
; X32-LABEL: splat_concat4:
; X32:       ## BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vbroadcastsd (%eax), %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: splat_concat4:
; X64:       ## BB#0:
; X64-NEXT:    vbroadcastsd (%rdi), %ymm0
; X64-NEXT:    retq
  %1 = load double, double* %p, align 8
  %2 = insertelement <2 x double> undef, double %1, i32 0
  %3 = insertelement <2 x double> %2, double %1, i32 1
  %4 = insertelement <2 x double> undef, double %1, i32 0
  %5 = insertelement <2 x double> %2, double %1, i32 1
  %6 = shufflevector <2 x double> %3, <2 x double> %5, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x double> %6
}

;
; When VBROADCAST replaces an existing load, ensure it still respects lifetime dependencies.
;
define float @broadcast_lifetime() nounwind {
; X32-LABEL: broadcast_lifetime:
; X32:       ## BB#0:
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $56, %esp
; X32-NEXT:    leal {{[0-9]+}}(%esp), %esi
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _gfunc
; X32-NEXT:    vbroadcastss {{[0-9]+}}(%esp), %xmm0
; X32-NEXT:    vmovaps %xmm0, {{[0-9]+}}(%esp) ## 16-byte Spill
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _gfunc
; X32-NEXT:    vbroadcastss {{[0-9]+}}(%esp), %xmm0
; X32-NEXT:    vsubss {{[0-9]+}}(%esp), %xmm0, %xmm0 ## 16-byte Folded Reload
; X32-NEXT:    vmovss %xmm0, {{[0-9]+}}(%esp)
; X32-NEXT:    flds {{[0-9]+}}(%esp)
; X32-NEXT:    addl $56, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
;
; X64-LABEL: broadcast_lifetime:
; X64:       ## BB#0:
; X64-NEXT:    subq $40, %rsp
; X64-NEXT:    leaq (%rsp), %rdi
; X64-NEXT:    callq _gfunc
; X64-NEXT:    vbroadcastss {{[0-9]+}}(%rsp), %xmm0
; X64-NEXT:    vmovaps %xmm0, {{[0-9]+}}(%rsp) ## 16-byte Spill
; X64-NEXT:    leaq (%rsp), %rdi
; X64-NEXT:    callq _gfunc
; X64-NEXT:    vbroadcastss {{[0-9]+}}(%rsp), %xmm0
; X64-NEXT:    vsubss {{[0-9]+}}(%rsp), %xmm0, %xmm0 ## 16-byte Folded Reload
; X64-NEXT:    addq $40, %rsp
; X64-NEXT:    retq
  %1 = alloca <4 x float>, align 16
  %2 = alloca <4 x float>, align 16
  %3 = bitcast <4 x float>* %1 to i8*
  %4 = bitcast <4 x float>* %2 to i8*

  call void @llvm.lifetime.start(i64 16, i8* %3)
  call void @gfunc(<4 x float>* %1)
  %5 = load <4 x float>, <4 x float>* %1, align 16
  call void @llvm.lifetime.end(i64 16, i8* %3)

  call void @llvm.lifetime.start(i64 16, i8* %4)
  call void @gfunc(<4 x float>* %2)
  %6 = load <4 x float>, <4 x float>* %2, align 16
  call void @llvm.lifetime.end(i64 16, i8* %4)

  %7 = extractelement <4 x float> %5, i32 1
  %8 = extractelement <4 x float> %6, i32 1
  %9 = fsub float %8, %7
  ret float %9
}

declare void @gfunc(<4 x float>*)
declare void @llvm.lifetime.start(i64, i8*)
declare void @llvm.lifetime.end(i64, i8*)
