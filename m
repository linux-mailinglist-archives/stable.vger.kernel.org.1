Return-Path: <stable+bounces-121995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BEAA59D70
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D43A8E0A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7422D799;
	Mon, 10 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c66vLpH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54922154C;
	Mon, 10 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627228; cv=none; b=u1Upl/aA6I12XHRAev8EsRtlDTgDV86PJnDAFw2i1ZR7/DbFr9BNnY7oMOaQYXCWQdfkW6n5MM0ieKnyZG5+WlxwnzAXL87vE0PQ3/vW4kPXlTzD4pVQ81R97qVVnywxj1WETRrpuBa/T8C28kxtT9UUk2vlbM0Ld1OYGuDmtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627228; c=relaxed/simple;
	bh=29sRWbUM7fmq2OtaIrdYdTrxerRfJEHSRmHKUEXzoZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZllQJDiP7lGlUQysKyR+IZuLnj4JXC+UQPa4gHl+MqdYDnXEXj/tbn4z/FmmMdO9KPQG6deZW6mkHJDGhTPvPgDtTRkQXYorToh1k+Jz3v84xBxh0nfusYt+HhKa4IkO9gDPrAY+5rLAGLEclEN7Na3dBN53bP6Up8XaIfJbDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c66vLpH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E38C4CEE5;
	Mon, 10 Mar 2025 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627228;
	bh=29sRWbUM7fmq2OtaIrdYdTrxerRfJEHSRmHKUEXzoZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c66vLpH4cr7lJfUf7ceMY3lJrhls/Iy2RONPD249/2MrPIxjWaiJesTpFHnTzkHr2
	 Ce2nkpE+RRefkGse+l4PgfPn4zIJsxBYnmRUcdbNOinkebfmoKcbVl473fZyF+dSsg
	 Sp3FteObrtAWj+kPYCRG/loZYTHcltVB7h1eIG20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 058/269] kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
Date: Mon, 10 Mar 2025 18:03:31 +0100
Message-ID: <20250310170500.040479457@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

commit 392e34b6bc22077ef63abf62387ea3e9f39418c1 upstream.

Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
Rust's `alloc` crate and the `new_uninit` unstable feature.

Also remove `Kmalloc`'s `GlobalAlloc` implementation -- we can't remove
this in a separate patch, since the `alloc` crate requires a
`#[global_allocator]` to set, that implements `GlobalAlloc`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/20241004154149.93856-29-dakr@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/Makefile                     |   43 +++++--------------------
 rust/exports.c                    |    1 
 rust/kernel/alloc/allocator.rs    |   65 +-------------------------------------
 scripts/Makefile.build            |    4 +-
 scripts/generate_rust_analyzer.py |   11 +-----
 5 files changed, 16 insertions(+), 108 deletions(-)

--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,8 +15,8 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
-always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
+obj-$(CONFIG_RUST) += bindings.o kernel.o
+always-$(CONFIG_RUST) += exports_helpers_generated.h \
     exports_bindings_generated.h exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
@@ -53,11 +53,6 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
-alloc-cfgs = \
-    --cfg no_global_oom_handling \
-    --cfg no_rc \
-    --cfg no_sync
-
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -81,7 +76,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustd
 # command-like flags to solve the issue. Meanwhile, we use the non-custom case
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
-    rustdoc-alloc rustdoc-kernel
+    rustdoc-kernel
 	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
 	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
@@ -108,20 +103,11 @@ rustdoc-core: $(RUST_LIB_SRC)/core/src/l
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
-# We need to allow `rustdoc::broken_intra_doc_links` because some
-# `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
-# functions. Ideally `rustdoc` would have a way to distinguish broken links
-# due to things that are "configured out" vs. entirely non-existing ones.
-rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
-    -Arustdoc::broken_intra_doc_links
-rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
-	+$(call if_changed,rustdoc)
-
-rustdoc-kernel: private rustc_target_flags = --extern alloc \
+rustdoc-kernel: private rustc_target_flags = \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
-    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
+    rustdoc-compiler_builtins $(obj)/libmacros.so \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
@@ -165,7 +151,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_flags) \
-		-L$(objtree)/$(obj) --extern alloc --extern kernel \
+		-L$(objtree)/$(obj) --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
@@ -201,7 +187,7 @@ rusttest-macros: $(src)/macros/lib.rs FO
 	+$(call if_changed,rustc_test)
 	+$(call if_changed,rustdoc_test)
 
-rusttest-kernel: private rustc_target_flags = --extern alloc \
+rusttest-kernel: private rustc_target_flags = \
     --extern build_error --extern macros --extern bindings --extern uapi
 rusttest-kernel: $(src)/kernel/lib.rs \
     rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
@@ -328,9 +314,6 @@ quiet_cmd_exports = EXPORTS $@
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
 
-$(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
-	$(call if_changed,exports)
-
 # Even though Rust kernel modules should never use the bindings directly,
 # symbols from the `bindings` crate and the C helpers need to be exported
 # because Rust generics and inlined functions may not get their code generated
@@ -377,7 +360,7 @@ quiet_cmd_rustc_library = $(if $(skip_cl
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
+		--cfgs='core=$(core-cfgs)' \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -415,12 +398,6 @@ $(obj)/compiler_builtins.o: private rust
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/alloc.o: private skip_clippy = 1
-$(obj)/alloc.o: private skip_flags = -Wunreachable_pub
-$(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
-$(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
-	+$(call if_changed_rule,rustc_library)
-
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
@@ -435,9 +412,9 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/kernel.o: private rustc_target_flags = --extern alloc \
+$(obj)/kernel.o: private rustc_target_flags = \
     --extern build_error --extern macros --extern bindings --extern uapi
-$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
+$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -16,7 +16,6 @@
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
 
 #include "exports_core_generated.h"
-#include "exports_alloc_generated.h"
 #include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -8,8 +8,8 @@
 //!
 //! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>
 
-use super::{flags::*, Flags};
-use core::alloc::{GlobalAlloc, Layout};
+use super::Flags;
+use core::alloc::Layout;
 use core::ptr;
 use core::ptr::NonNull;
 
@@ -54,23 +54,6 @@ fn aligned_size(new_layout: Layout) -> u
     layout.size()
 }
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
-    let size = aligned_size(new_layout);
-
-    // SAFETY:
-    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-    //   function safety requirement.
-    // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
-    //   to the function safety requirement)
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
-}
-
 /// # Invariants
 ///
 /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
@@ -156,43 +139,6 @@ unsafe impl Allocator for Kmalloc {
     }
 }
 
-// SAFETY: TODO.
-unsafe impl GlobalAlloc for Kmalloc {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
-    }
-
-    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-        // SAFETY: TODO.
-        unsafe {
-            bindings::kfree(ptr as *const core::ffi::c_void);
-        }
-    }
-
-    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
-        // SAFETY:
-        // - `new_size`, when rounded up to the nearest multiple of `layout.align()`, will not
-        //   overflow `isize` by the function safety requirement.
-        // - `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
-        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
-
-        // SAFETY:
-        // - `ptr` is either null or a pointer allocated by this allocator by the function safety
-        //   requirement.
-        // - the size of `layout` is not zero because `new_size` is not zero by the function safety
-        //   requirement.
-        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
-    }
-
-    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | __GFP_ZERO) }
-    }
-}
-
 // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
 // - memory remains valid until it is explicitly freed,
 // - passing a pointer to a valid memory allocation is OK,
@@ -240,10 +186,3 @@ unsafe impl Allocator for KVmalloc {
         unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
-
-#[global_allocator]
-static ALLOCATOR: Kmalloc = Kmalloc;
-
-// See <https://github.com/rust-lang/rust/pull/86844>.
-#[no_mangle]
-static __rust_no_alloc_shim_is_unstable: u8 = 0;
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,7 +248,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := arbitrary_self_types,lint_reasons,new_uninit
+rust_allowed_features := arbitrary_self_types,lint_reasons
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
@@ -258,7 +258,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	-Zunstable-options --extern force:alloc --extern kernel \
+	-Zunstable-options --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -65,13 +65,6 @@ def generate_crates(srctree, objtree, sy
     )
 
     append_crate(
-        "alloc",
-        sysroot_src / "alloc" / "src" / "lib.rs",
-        ["core", "compiler_builtins"],
-        cfg=crates_cfgs.get("alloc", []),
-    )
-
-    append_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
         [],
@@ -96,7 +89,7 @@ def generate_crates(srctree, objtree, sy
     append_crate(
         "kernel",
         srctree / "rust" / "kernel" / "lib.rs",
-        ["core", "alloc", "macros", "build_error", "bindings"],
+        ["core", "macros", "build_error", "bindings"],
         cfg=cfg,
     )
     crates[-1]["source"] = {
@@ -133,7 +126,7 @@ def generate_crates(srctree, objtree, sy
             append_crate(
                 name,
                 path,
-                ["core", "alloc", "kernel"],
+                ["core", "kernel"],
                 cfg=cfg,
             )
 



