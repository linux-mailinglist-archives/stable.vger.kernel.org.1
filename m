Return-Path: <stable+bounces-41636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0808B5664
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D4A282CE2
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2583D961;
	Mon, 29 Apr 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eJ9SVdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA691EB2F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389701; cv=none; b=aCxO1dHcSIwAxdPiN6nOiDGIdbu+/HtifZGjK5zJF4xa8fh6To/nAo9T6pphkgJKCCswMxHAmtGvf6kiz2MxhFb2U5PoT9pbZa4WaK6agJhxMwb5AVqh39XZRu82CkfqRYS4Gh0etDljmpuXxjBPjvO5+cIfHyEFdu3MJRDbsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389701; c=relaxed/simple;
	bh=7zf+Rz9oFLio1nOW+R/MnGbBQgiZRyTVYZshdha0sDs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CT/i2scie8rE6BdTURllT30QdjJGn/Yaxb+nekSgT+xEXs/zChxvX48OQGjahawuNJ6u/k9NI7BTpbOj3learrjAYQw+2cjCUzVdClFtW2LVLxD4QmKW8aK2gm+k498GhCi076q+ZUQTohu7D9Rb2JAdXKJuw6uf6Gr+gRp6Bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eJ9SVdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305C6C4AF17;
	Mon, 29 Apr 2024 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389701;
	bh=7zf+Rz9oFLio1nOW+R/MnGbBQgiZRyTVYZshdha0sDs=;
	h=Subject:To:Cc:From:Date:From;
	b=2eJ9SVdIuBySj40g2uQJ+moQvRChuu+mtf2MzZaLb9EQlNkFdqAySb8V7DHEEMfPn
	 +QtnUjhXxOCcXRzGLKFt1wErn2pAlscFyU5cz57VgeAsDTS3QfeV1gzF/YTtdNXh2v
	 r6Wnbw+Qj2ppkeSQOOn5+bSTTGFr7b8rozauBiRQ=
Subject: FAILED: patch "[PATCH] rust: macros: fix soundness issue in `module!` macro" failed to apply to 6.8-stable tree
To: benno.lossin@proton.me,bjorn3_gh@protonmail.com,ojeda@kernel.org,walmeida@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:21:38 +0200
Message-ID: <2024042938-computing-synthetic-f9fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 7044dcff8301b29269016ebd17df27c4736140d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042938-computing-synthetic-f9fe@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
1b6170ff7a20 ("rust: module: place generated init_module() function in .init.text")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7044dcff8301b29269016ebd17df27c4736140d2 Mon Sep 17 00:00:00 2001
From: Benno Lossin <benno.lossin@proton.me>
Date: Mon, 1 Apr 2024 18:52:50 +0000
Subject: [PATCH] rust: macros: fix soundness issue in `module!` macro
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `module!` macro creates glue code that are called by C to initialize
the Rust modules using the `Module::init` function. Part of this glue
code are the local functions `__init` and `__exit` that are used to
initialize/destroy the Rust module.

These functions are safe and also visible to the Rust mod in which the
`module!` macro is invoked. This means that they can be called by other
safe Rust code. But since they contain `unsafe` blocks that rely on only
being called at the right time, this is a soundness issue.

Wrap these generated functions inside of two private modules, this
guarantees that the public functions cannot be called from the outside.
Make the safe functions `unsafe` and add SAFETY comments.

Cc: stable@vger.kernel.org
Reported-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/629
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Wedson Almeida Filho <walmeida@microsoft.com>
Link: https://lore.kernel.org/r/20240401185222.12015-1-benno.lossin@proton.me
[ Moved `THIS_MODULE` out of the private-in-private modules since it
  should remain public, as Dirk Behme noticed [1]. Capitalized comments,
  avoided newline in non-list SAFETY comments and reworded to add
  Reported-by and newline. ]
Link: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/topic/x/near/433512583 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27979e582e4b..acd0393b5095 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -199,17 +199,6 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
 
-            /// The \"Rust loadable module\" mark.
-            //
-            // This may be best done another way later on, e.g. as a new modinfo
-            // key or a new section. For the moment, keep it simple.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[used]
-            static __IS_RUST_MODULE: () = ();
-
-            static mut __MOD: Option<{type_}> = None;
-
             // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
             // freed until the module is unloaded.
             #[cfg(MODULE)]
@@ -221,81 +210,132 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 kernel::ThisModule::from_ptr(core::ptr::null_mut())
             }};
 
-            // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
-            /// # Safety
-            ///
-            /// This function must not be called after module initialization, because it may be
-            /// freed after that completes.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            #[link_section = \".init.text\"]
-            pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
-                __init()
-            }}
+            // Double nested modules, since then nobody can access the public items inside.
+            mod __module_init {{
+                mod __module_init {{
+                    use super::super::{type_};
 
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn cleanup_module() {{
-                __exit()
-            }}
+                    /// The \"Rust loadable module\" mark.
+                    //
+                    // This may be best done another way later on, e.g. as a new modinfo
+                    // key or a new section. For the moment, keep it simple.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[used]
+                    static __IS_RUST_MODULE: () = ();
 
-            // Built-in modules are initialized through an initcall pointer
-            // and the identifiers need to be unique.
-            #[cfg(not(MODULE))]
-            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-            #[doc(hidden)]
-            #[link_section = \"{initcall_section}\"]
-            #[used]
-            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+                    static mut __MOD: Option<{type_}> = None;
 
-            #[cfg(not(MODULE))]
-            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-            core::arch::global_asm!(
-                r#\".section \"{initcall_section}\", \"a\"
-                __{name}_initcall:
-                    .long   __{name}_init - .
-                    .previous
-                \"#
-            );
+                    // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
+                    /// # Safety
+                    ///
+                    /// This function must not be called after module initialization, because it may be
+                    /// freed after that completes.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    #[link_section = \".init.text\"]
+                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
+                        // SAFETY: This function is inaccessible to the outside due to the double
+                        // module wrapping it. It is called exactly once by the C side via its
+                        // unique name.
+                        unsafe {{ __init() }}
+                    }}
 
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
-                __init()
-            }}
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn cleanup_module() {{
+                        // SAFETY:
+                        // - This function is inaccessible to the outside due to the double
+                        //   module wrapping it. It is called exactly once by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `init_module` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
 
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_exit() {{
-                __exit()
-            }}
+                    // Built-in modules are initialized through an initcall pointer
+                    // and the identifiers need to be unique.
+                    #[cfg(not(MODULE))]
+                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+                    #[doc(hidden)]
+                    #[link_section = \"{initcall_section}\"]
+                    #[used]
+                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
 
-            fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) => {{
-                        unsafe {{
-                            __MOD = Some(m);
+                    #[cfg(not(MODULE))]
+                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+                    core::arch::global_asm!(
+                        r#\".section \"{initcall_section}\", \"a\"
+                        __{name}_initcall:
+                            .long   __{name}_init - .
+                            .previous
+                        \"#
+                    );
+
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                        // SAFETY: This function is inaccessible to the outside due to the double
+                        // module wrapping it. It is called exactly once by the C side via its
+                        // placement above in the initcall section.
+                        unsafe {{ __init() }}
+                    }}
+
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_exit() {{
+                        // SAFETY:
+                        // - This function is inaccessible to the outside due to the double
+                        //   module wrapping it. It is called exactly once by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `__{name}_init` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
+
+                    /// # Safety
+                    ///
+                    /// This function must only be called once.
+                    unsafe fn __init() -> core::ffi::c_int {{
+                        match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
+                            Ok(m) => {{
+                                // SAFETY: No data race, since `__MOD` can only be accessed by this
+                                // module and there only `__init` and `__exit` access it. These
+                                // functions are only called once and `__exit` cannot be called
+                                // before or during `__init`.
+                                unsafe {{
+                                    __MOD = Some(m);
+                                }}
+                                return 0;
+                            }}
+                            Err(e) => {{
+                                return e.to_errno();
+                            }}
                         }}
-                        return 0;
                     }}
-                    Err(e) => {{
-                        return e.to_errno();
+
+                    /// # Safety
+                    ///
+                    /// This function must
+                    /// - only be called once,
+                    /// - be called after `__init` has been called and returned `0`.
+                    unsafe fn __exit() {{
+                        // SAFETY: No data race, since `__MOD` can only be accessed by this module
+                        // and there only `__init` and `__exit` access it. These functions are only
+                        // called once and `__init` was already called.
+                        unsafe {{
+                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
+                            __MOD = None;
+                        }}
                     }}
+
+                    {modinfo}
                 }}
             }}
-
-            fn __exit() {{
-                unsafe {{
-                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
-                    __MOD = None;
-                }}
-            }}
-
-            {modinfo}
         ",
         type_ = info.type_,
         name = info.name,


