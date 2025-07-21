Return-Path: <stable+bounces-163627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC5B0CB29
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 21:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FC1188DE43
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BB22F770;
	Mon, 21 Jul 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkcq7srz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E421BD035
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127350; cv=none; b=CgrLCozUN5XdtfRp6zhxH81mBSAM5F8riMhUBatqBbdiwXm1vBHnK8b+y1qS5RDiGSS3QhY5tz3sg9YgjcdrUg5DAnz+wlfu5BTvHkD2YagN9iAAJSQofS0JeTUqvdfumzcTsJJvgDfBW+6A7GdT21ygSmEuGdOiUbr08PyKIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127350; c=relaxed/simple;
	bh=fr+BMu28mMN9AZthAlbQJqBZowBJIPOZ7G+j5VCNDII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ql7qLmKyzZMblJq6wXlxnbFxdY1+z6P6hVYBTw8sI+48RgLSJBtfkLEYoaorIjG1hyN1nbXQTNnluQCaMGWVWgsDzrdu05vjzGvHOK88bkwWM5noIitrAQlrkCWSf3M5ISYVLl2ANcNG84bF/O8TWSq4XXuqxcaX6w1a8eUjasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkcq7srz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5471EC4CEED;
	Mon, 21 Jul 2025 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753127349;
	bh=fr+BMu28mMN9AZthAlbQJqBZowBJIPOZ7G+j5VCNDII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkcq7srzdJGcXYKb2T+hDo/BHsbixBT1ZY4dd2Gux3NVQlquaC1D3wzG2sZKr0Y2p
	 R3CpyQEb1zrkueCxDwbdBcxzVP73GLAyY3kDwzX2BTeM9amUfNzAXgSsRtis/5devT
	 akikwTiW+zYr3ekNB3GfLjB8Beu8wnXqVqH3dPopxkQuiDbLGgCZJv1RMZqyfpH6Pi
	 LrFXurhr6h6ZRrJOxAp7Uuc1ESonrd4XMet1otLj+Noc/3JQsTWctv43YIgOQAJRJ7
	 9IEJoboA4XSvYP321swSe2BZ7dcSIZouxC1zKv2J/Fe2GiudRAf5qid4y2velAT9nI
	 eKZmRwDbNayuA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	David Wood <david@davidtw.co>,
	Wesley Wiser <wwiser@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH 6.15.y] rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
Date: Mon, 21 Jul 2025 21:49:04 +0200
Message-ID: <20250721194904.1150898-1-ojeda@kernel.org>
In-Reply-To: <2025072101-perfume-vitalize-a08b@gregkh>
References: <2025072101-perfume-vitalize-a08b@gregkh>
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
 rust/Makefile           |  1 +
 rust/kernel/firmware.rs |  2 +-
 rust/kernel/kunit.rs    |  2 +-
 rust/kernel/lib.rs      |  2 ++
 rust/macros/module.rs   | 10 +++++-----
 scripts/Makefile.build  |  2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index d62b58d0a55c..913b31d25bc4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -194,6 +194,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 	RUST_MODFILE=test.rs \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_common_flags) \
+		-Zcrate-attr='feature(used_with_arg)' \
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		$(rustdoc_test_quiet) \
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 2494c96e105f..4fe621f35716 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -202,7 +202,7 @@ macro_rules! module_firmware {
             };
 
             #[link_section = ".modinfo"]
-            #[used]
+            #[used(compiler)]
             static __MODULE_FIRMWARE: [u8; $($builder)*::create(__MODULE_FIRMWARE_PREFIX)
                 .build_length()] = $($builder)*::create(__MODULE_FIRMWARE_PREFIX).build();
         };
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 1604fb6a5b1b..cf95700c8612 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -278,7 +278,7 @@ macro_rules! kunit_unsafe_test_suite {
                     is_init: false,
                 };
 
-            #[used]
+            #[used(compiler)]
             #[allow(unused_unsafe)]
             #[cfg_attr(not(target_os = "macos"), link_section = ".kunit_test_suites")]
             static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings::kunit_suite =
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..2bdf9d14ec43 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -26,6 +26,8 @@
 #![feature(const_mut_refs)]
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
+// To be determined.
+#![feature(used_with_arg)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 44e5cb108cea..b19ce62f6af1 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -57,7 +57,7 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
                 {cfg}
                 #[doc(hidden)]
                 #[cfg_attr(not(target_os = \"macos\"), link_section = \".modinfo\")]
-                #[used]
+                #[used(compiler)]
                 pub static __{module}_{counter}: [u8; {length}] = *{string};
             ",
             cfg = if builtin {
@@ -247,7 +247,7 @@ mod __module_init {{
                     // key or a new section. For the moment, keep it simple.
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     static __IS_RUST_MODULE: () = ();
 
                     static mut __MOD: core::mem::MaybeUninit<{type_}> =
@@ -271,7 +271,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".init.data\"]
                     static __UNIQUE_ID___addressable_init_module: unsafe extern \"C\" fn() -> i32 = init_module;
 
@@ -291,7 +291,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".exit.data\"]
                     static __UNIQUE_ID___addressable_cleanup_module: extern \"C\" fn() = cleanup_module;
 
@@ -301,7 +301,7 @@ mod __module_init {{
                     #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
-                    #[used]
+                    #[used(compiler)]
                     pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
 
                     #[cfg(not(MODULE))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 13dcd86e74ca..eb0d27812aec 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -222,7 +222,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op
+rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.50.1


