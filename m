Return-Path: <stable+bounces-163626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466BB0CB27
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F57AF3B5
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325B1FFC46;
	Mon, 21 Jul 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chWrVSU9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA22B9A8
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127264; cv=none; b=rVd1ke5iRhqoU61T2x0JnTBSqi2UdSoytdFISOncpN3Zb/xULafTIwAgUYIjxQSPk+FaQkjTT4YD34464m5ui1UWCcDkyAQ3ByWmCdV/wGeLWPjx/eAxSXqT+k698MuLDxuL6gdLjekzwtGLvoimUr5W3XO9ZUUxPJji+2TxRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127264; c=relaxed/simple;
	bh=jsC+vssQI/D0U6Q8QFrSBZmJtIf9sH60jyj7RWXe1nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijaJhGlaf8sFeueztGYLYARNbYBT0PY1Tirnux9IUl8aAWTvavZmFEn/Po6hjicDyta/6//6MDgskhS89/kMZsK24r1F8I3GgryH3MGTaY47aJEqizLT8c3DVxnGfvfdu7nKw5CeFI66+H1xjCz4iLxW99MCIlZmPkAfx6SAI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chWrVSU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F019C4CEED;
	Mon, 21 Jul 2025 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753127263;
	bh=jsC+vssQI/D0U6Q8QFrSBZmJtIf9sH60jyj7RWXe1nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chWrVSU9qm+QY+DooK7qHbpYD+CkRc6AzGu6BHoFpOVUV0YOUYU5McTGzo3bU5Lmm
	 fRmOUbs0XzfZT+IUSQZQsm0biGXCf2TOZ4t0/qlvH4/ab191o+2KAwXYx3ZOCKXTeA
	 oCBAEgwDlkmthK/LM1jO+T2gscFbM41MdUmnN4Wykor3G07JcRtSdi2LefoGfJ1Z3t
	 eFq0dx3qyFgTVaN6rH++WfLkMHc4hqnMjzbXtMcRG4BdUijU5mJ6qGcunybAn4Gbso
	 gLt46MvIglna3366e3J2svOw6waHMAT6yGepXr72WCC5qz9DEKR7Z9e274nKkGVBPJ
	 npVItqfummvHQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	David Wood <david@davidtw.co>,
	Wesley Wiser <wwiser@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH 6.12.y] rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
Date: Mon, 21 Jul 2025 21:47:36 +0200
Message-ID: <20250721194736.1150349-1-ojeda@kernel.org>
In-Reply-To: <2025072102-theorize-single-3700@gregkh>
References: <2025072102-theorize-single-3700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Starting with Rust 1.89.0 (expected 2025-08-07), the Rust compiler fails
to build the `rusttest` target due to undefined references such as:

    kernel...-cgu.0:(.text....+0x116): undefined reference to
    `rust_helper_kunit_get_current_test'

Moreover, tooling like `modpost` gets confused:

    WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/nova/nova.o
    ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/nova-core/nova_core.o

The reason behind both issues is that the Rust compiler will now [1]
treat `#[used]` as `#[used(linker)]` instead of `#[used(compiler)]`
for our targets. This means that the retain section flag (`R`,
`SHF_GNU_RETAIN`) will be used and that they will be marked as `unique`
too, with different IDs. In turn, that means we end up with undefined
references that did not get discarded in `rusttest` and that multiple
`.modinfo` sections are generated, which confuse tooling like `modpost`
because they only expect one.

Thus start using `#[used(compiler)]` to keep the previous behavior
and to be explicit about what we want. Sadly, it is an unstable feature
(`used_with_arg`) [2] -- we will talk to upstream Rust about it. The good
news is that it has been available for a long time (Rust >= 1.60) [3].

The changes should also be fine for previous Rust versions, since they
behave the same way as before [4].

Alternatively, we could use `#[no_mangle]` or `#[export_name = ...]`
since those still behave like `#[used(compiler)]`, but of course it is
not really what we want to express, and it requires other changes to
avoid symbol conflicts.

Cc: David Wood <david@davidtw.co>
Cc: Wesley Wiser <wwiser@gmail.com>
Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/140872 [1]
Link: https://github.com/rust-lang/rust/issues/93798 [2]
Link: https://github.com/rust-lang/rust/pull/91504 [3]
Link: https://godbolt.org/z/sxzWTMfzW [4]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Link: https://lore.kernel.org/r/20250712160103.1244945-3-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 7498159226772d66f150dd406be462d75964a366)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile          |  1 +
 rust/kernel/lib.rs     |  1 +
 rust/macros/module.rs  | 10 +++++-----
 scripts/Makefile.build |  2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b8b7f817c48e..17491d8229a4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -157,6 +157,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
       cmd_rustdoc_test = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_common_flags) \
+		-Zcrate-attr='feature(used_with_arg)' \
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		$(rustdoc_test_quiet) \
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 904d241604db..889ddcb1a2dd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 #![feature(unsize)]
+#![feature(used_with_arg)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a5ea5850e307..edb23b28f446 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -57,7 +57,7 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
                 {cfg}
                 #[doc(hidden)]
                 #[link_section = \".modinfo\"]
-                #[used]
+                #[used(compiler)]
                 pub static __{module}_{counter}: [u8; {length}] = *{string};
             ",
             cfg = if builtin {
@@ -230,7 +230,7 @@ mod __module_init {{
                     // key or a new section. For the moment, keep it simple.
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     static __IS_RUST_MODULE: () = ();
 
                     static mut __MOD: Option<{type_}> = None;
@@ -253,7 +253,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".init.data\"]
                     static __UNIQUE_ID___addressable_init_module: unsafe extern \"C\" fn() -> i32 = init_module;
 
@@ -273,7 +273,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".exit.data\"]
                     static __UNIQUE_ID___addressable_cleanup_module: extern \"C\" fn() = cleanup_module;
 
@@ -283,7 +283,7 @@ mod __module_init {{
                     #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
-                    #[used]
+                    #[used(compiler)]
                     pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
 
                     #[cfg(not(MODULE))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2bba59e790b8..2c5c1a214f3b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,7 +248,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := arbitrary_self_types,lint_reasons
+rust_allowed_features := arbitrary_self_types,lint_reasons,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.50.1


