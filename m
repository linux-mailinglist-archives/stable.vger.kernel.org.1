Return-Path: <stable+bounces-239964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPf8ETls5mkJwQEAu9opvQ
	(envelope-from <stable+bounces-239964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:11:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2B43289C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F9253074595
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B139F18A;
	Mon, 20 Apr 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmzgYtfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB837374E64;
	Mon, 20 Apr 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705795; cv=none; b=u7+8n4H5+rWT7SBaSc/2pMpIdD7R2CU/GFTM9SSt8sCfzR3FRWH552c+rYQ/Ou7ODUwiN1rsAPwe/k57ydzQVVWoNvJB2AUKtXh7qGO8Pr4679hDnoZMjP3vA4OoX3YfFQcOj0UKQBgc9ighsgM23CGFNL0qn6MF9epNWtGjJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705795; c=relaxed/simple;
	bh=RDw+2/yrSekeZqbdwCFumgPFmQPYUffjovp3DYsv3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBVLNOkHT+00++viQV6LJHxPR4kYisREccIHMGhV2CLxPfCD1XhoRiI+GxdIord3dDfYjEQXZHa0cSk39SRf+9CGqd9kfyZ++0gAckWT19g+bnnCZkrjrQpFYjyd47M72cTYPpW9f/bNRUrzpTC9zMQWRba3OS5sO80FObD5XlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmzgYtfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE3C19425;
	Mon, 20 Apr 2026 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705795;
	bh=RDw+2/yrSekeZqbdwCFumgPFmQPYUffjovp3DYsv3LA=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=mmzgYtfMfQWefte3Gx+pNWc6RTWzzxAbVPRmRXNPwGd8Sx+K4S67fwftWeAcWYAQR
	 9PERlPaKyLne2YYld69YVjagqD4jUJKXVNXJUgrGvsfkAjCkyKFAi99OJAzwAIc0tz
	 O2yY1p6y1EuSaRQPXGZE4U+NAsGT2Fh9vpBWSVnCAMQnk7zn4L9zhoA+10D4hobne5
	 V81eaIBKB33xnPldWVisID2++egQ1VLWQn3ka130345uWaxSd7hbNtYDhwboKFZqCk
	 6vPApVO33r8WZbkTl5kyvj6rN+LcD2zsqgghbclfzQBD9zeTJCKOawHvIF4FvDrLWz
	 LxC7bPQ4t+tTQ==
From: Gary Guo <gary@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: pin-init: fix incorrect accessor reference lifetime
Date: Mon, 20 Apr 2026 18:23:01 +0100
Message-ID: <20260420172302.1843752-1-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239964-lists,stable=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gary@garyguo.net];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[gary@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:replyto,garyguo.net:email]
X-Rspamd-Queue-Id: 51F2B43289C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gary Guo <gary@garyguo.net>

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`. Somewhat ironically, the safety
justification of creating the accessor is.. "SAFETY: TODO".

Fix it by adding `Deref`/`DerefMut` implementation to `DropGuard` and
derive the reference from dereferencing `DropGuard` instead. The lifetime
of `DropGuard` is exactly what we want for these accessors.

The old accessor creation code also has a purpose of preventing unaligned
fields. So a `let _ = &(*#slot).#ident` still needs to be present, but this
no longer has to care about pinning, so it is moved to just before the
guard generation.

Fixes: 42415d163e5d ("rust: pin-init: add references to previously initialized fields")
Cc: stable@vger.kernel.org
Signed-off-by: Gary Guo <gary@garyguo.net>
---
The patch is also available at https://github.com/Rust-for-Linux/pin-init/pull/132
which has regression tests added and runs through pin-init's test suite.
---
 rust/pin-init/internal/src/init.rs | 107 +++++++++++++----------------
 rust/pin-init/src/__internal.rs    |  27 +++++++-
 2 files changed, 73 insertions(+), 61 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index daa3f1c6466e..c5f848103c92 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -249,22 +249,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let accessor = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                    }
-                } else {
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { &mut (*#slot).#ident }
-                    }
-                };
                 quote! {
                     #(#attrs)*
                     {
@@ -272,51 +256,31 @@ fn init_fields(
                         // SAFETY: TODO
                         unsafe { #write(&raw mut (*#slot).#ident, #value_ident) };
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let (value_init, accessor) = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    (
-                        quote! {
-                            // SAFETY:
-                            // - `slot` is valid, because we are inside of an initializer closure, we
-                            //   return when an error/panic occurs.
-                            // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
-                            //   for `#ident`.
-                            unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                        },
-                    )
+                let value_init = if pinned {
+                    quote! {
+                        // SAFETY:
+                        // - `slot` is valid, because we are inside of an initializer closure, we
+                        //   return when an error/panic occurs.
+                        // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
+                        //   for `#ident`.
+                        unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
+                    }
                 } else {
-                    (
-                        quote! {
-                            // SAFETY: `slot` is valid, because we are inside of an initializer
-                            // closure, we return when an error/panic occurs.
-                            unsafe {
-                                ::pin_init::Init::__init(
-                                    #init,
-                                    &raw mut (*#slot).#ident,
-                                )?
-                            };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { &mut (*#slot).#ident }
-                        },
-                    )
+                    quote! {
+                        // SAFETY: `slot` is valid, because we are inside of an initializer
+                        // closure, we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                #init,
+                                &raw mut (*#slot).#ident,
+                            )?
+                        };
+                    }
                 };
                 quote! {
                     #(#attrs)*
@@ -324,9 +288,6 @@ fn init_fields(
                         let #init = #value;
                         #value_init
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Code { block: value, .. } => quote! {
@@ -339,18 +300,46 @@ fn init_fields(
         if let Some(ident) = kind.ident() {
             // `mixed_site` ensures that the guard is not accessible to the user-controlled code.
             let guard = format_ident!("__{ident}_guard", span = Span::mixed_site());
+
+            // NOTE: The reference is derived from the guard so that it only lives as long as the
+            // guard does and cannot escape the scope. If it's created via `&mut (*#slot).#ident`
+            // like the unaligned field guard, it will become effectively `'static`.
+            let accessor = if pinned {
+                let project_ident = format_ident!("__project_{ident}");
+                quote! {
+                    // SAFETY: the initialization is pinned.
+                    unsafe { #data.#project_ident(&mut *#guard) }
+                }
+            } else {
+                quote! {
+                    &mut *#guard
+                }
+            };
+
             res.extend(quote! {
+                // Take a reference of the field to ensure that the initialized field is
+                // properly aligned. Unaligned fields will cause the compiler to emit E0793. We
+                // do not support unaligned fields since `Init::__init` requires an aligned
+                // pointer; the call to `ptr::write` above has the same requirement.
+                // SAFETY: `slot` is valid.
+                #(#cfgs)*
+                let _ = unsafe { &(*#slot).#ident };
+
                 #(#cfgs)*
                 // Create the drop guard:
                 //
                 // We rely on macro hygiene to make it impossible for users to access this local
                 // variable.
                 // SAFETY: We forget the guard later when initialization has succeeded.
-                let #guard = unsafe {
+                let mut #guard = unsafe {
                     ::pin_init::__internal::DropGuard::new(
                         &raw mut (*slot).#ident
                     )
                 };
+
+                #(#cfgs)*
+                #[allow(unused_variables)]
+                let #ident = #accessor;
             });
             guards.push(guard);
             guard_attrs.push(cfgs);
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90adbdc1893b..d122ab840c44 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -5,6 +5,8 @@
 //! These items must not be used outside of this crate and the pin-init-internal crate located at
 //! `../internal`.
 
+use core::ops::{Deref, DerefMut};
+
 use super::*;
 
 /// See the [nomicon] for what subtyping is. See also [this table].
@@ -238,6 +240,10 @@ struct Foo {
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
+///
+/// # Invariants
+///
+/// `ptr` is convertible to a mutable reference and `*ptr` is owned by `DropGuard`.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
 }
@@ -259,11 +265,28 @@ pub unsafe fn new(ptr: *mut T) -> Self {
     }
 }
 
+impl<T: ?Sized> Deref for DropGuard<T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        // SAFETY: `ptr` is convertible to reference
+        unsafe { &*self.ptr }
+    }
+}
+
+impl<T: ?Sized> DerefMut for DropGuard<T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut T {
+        // SAFETY: `ptr` is convertible to a mutable reference
+        unsafe { &mut *self.ptr }
+    }
+}
+
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `DropGuard` owns the `*ptr`.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }

base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
-- 
2.51.2


