Return-Path: <stable+bounces-41637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87E8B5666
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A898CB21FCE
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C13D961;
	Mon, 29 Apr 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ID4ih4SS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF511EB2F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389711; cv=none; b=O40DE7boIP1H0GMCo8zZTQXUxGb7mrh8GhJ6adqNJDtC7ffyfKumXYGj7mV/sKy9kzbMgRgrjeIbeEHH1LJ/DDg5LS1Dm53VMAvUHbxK2IXaD6D9FV8tS26PdudK63Kwa9zDs9mF0WANd+zQuvy29sy92rvMRnRPrr2k9ijD9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389711; c=relaxed/simple;
	bh=gA/wJrKyqv3nZc0FNnOtYsRje+3gALP2s5TjQE0hJdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U/pglue7PC4DPMzg8Q3bBb2liLSIoYdGF5Rudx5wC8KUQ6ebkwso8ne/k+0QkmWRVKSptQ4n94pYJqbaP6iiMbQxedakZp4Dphts0/Q3pDDdHfpc6Gm+2K3ArL9VRY798mb9tFk3XnxI5m2gvk0VBjfD4R+B3i2oBQxLvK/j1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ID4ih4SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81CC113CD;
	Mon, 29 Apr 2024 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389710;
	bh=gA/wJrKyqv3nZc0FNnOtYsRje+3gALP2s5TjQE0hJdM=;
	h=Subject:To:Cc:From:Date:From;
	b=ID4ih4SS21uMxvjhGgiwHw5gSJDyJzvDEU84L7eIPgmuVrGvD26kBE0CPHsy5IOKm
	 rmK9WU2c93UfnYKp4U7mrU7ICrM0u0Q1Mzg46/+RJFOJUjjtN5tB4tvzh8ncoRxL+T
	 wE+gALoHCWkcekEt6NvWdAvD/SRkDRjepnYcQUck=
Subject: FAILED: patch "[PATCH] rust: macros: fix soundness issue in `module!` macro" failed to apply to 6.6-stable tree
To: benno.lossin@proton.me,bjorn3_gh@protonmail.com,ojeda@kernel.org,walmeida@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:21:39 +0200
Message-ID: <2024042939-ended-heavily-2e5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7044dcff8301b29269016ebd17df27c4736140d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042939-ended-heavily-2e5c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


