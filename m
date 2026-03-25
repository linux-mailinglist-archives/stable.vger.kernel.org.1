Return-Path: <stable+bounces-230331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KIGKqblw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:39:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9C325F49
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6CD32C521E
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DB3D7D8E;
	Wed, 25 Mar 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ixRyub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015653D1CC1;
	Wed, 25 Mar 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443465; cv=none; b=gP6OOYnTWarRW70n0o38GI5dOB934SJN9fbUbGfyqILlPaaRm+m1kbZyIuKimi9Bw0ukeypKrqSF+qvq4WSA3fyOk6fFjSWP7z0/7hmirLCD0vXEglEiJOS3u2x06GaosjRP2KyF5hUZZ+nTvhvSIXhqG/dG66/so1pQo9pWEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443465; c=relaxed/simple;
	bh=NL6wOM6nDr9o5bO+8yoHrTHR+22GdgJCIWkZhBJ1Eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJMAPvuI/qIGq0Fo+Kg4gNa7qrThVWKAqS8/JiSA22aGMUrnDXo4oNhkgqV+ZfxLye0OwPpuIkVPdEnCIO+cmIvEaxVUemDhGyKvBcJCXNrz8i9y/7UEbo0P5dvzmOBIzeWAizvW3wSCZp8ZkV2CoCpYq4DrmimbcCXKf0uOIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ixRyub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F17CC4CEF7;
	Wed, 25 Mar 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774443464;
	bh=NL6wOM6nDr9o5bO+8yoHrTHR+22GdgJCIWkZhBJ1Eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2ixRyubyAkYkPlL9ic4NmEuOgQnNT524BqJc+wOcmRsKS4UvaOwNqdam98aBd8+7
	 XbFFGZYeaaJ4IImXjc92dceRV9ZdmK+lBgFdM6lxgRf+KjjG/DlKU197eY0CcfXwhl
	 DxXAL3Uhc5Mf9ojcCn9K/la4urrXXPzM7aPidpk5lPg1wBDgCH8k4rVTeb8GaPhOVM
	 WU4A3SxZq+LB1nuFH7XtyZwMUGGRSPSNCKODGtHRS/em9ANxIxisuoM0fFhoOQNZSJ
	 8R/m8ZoC8sbCl/ZnXKAmamrt5zmEYgLipjRv0GPTGPHKWLrxKdwgH9m3OEN2OXnZQ2
	 mWsuH/RgC4Aeg==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Tim Chirananthavat <theemathas@gmail.com>,
	stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.19.y 2/2] rust: pin-init: replace shadowed return token by `unsafe`-to-create token
Date: Wed, 25 Mar 2026 13:57:32 +0100
Message-ID: <20260325125734.944247-2-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325125734.944247-1-lossin@kernel.org>
References: <20260325125734.944247-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E4B9C325F49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 ]

We use a unit struct `__InitOk` in the closure generated by the
initializer macros as the return value. We shadow it by creating a
struct with the same name again inside of the closure, preventing early
returns of `Ok` in the initializer (before all fields have been
initialized).

In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
this solution no longer works [1]. The shadowed struct can be named
through type inference. In addition, there is an RFC proposing to add
the feature of path inference to Rust, which would similarly allow [2].

Thus remove the shadowed token and replace it with an `unsafe` to create
token.

The reason we initially used the shadowing solution was because an
alternative solution used a builder pattern. Gary writes [3]:

    In the early builder-pattern based InitOk, having a single InitOk
    type for token is unsound because one can launder an InitOk token
    used for one place to another initializer. I used a branded lifetime
    solution, and then you figured out that using a shadowed type would
    work better because nobody could construct it at all.

The laundering issue does not apply to the approach we ended up with
today.

With this change, the example by Tim Chirananthavat in [1] no longer
compiles and results in this error:

    error: cannot construct `pin_init::__internal::InitOk` with struct literal syntax due to private fields
      --> src/main.rs:26:17
       |
    26 |                 InferredType {}
       |                 ^^^^^^^^^^^^
       |
       = note: private field `0` that was not provided
    help: you might have meant to use the `new` associated function
       |
    26 -                 InferredType {}
    26 +                 InferredType::new()
       |

Applying the suggestion of using the `::new()` function, results in
another expected error:

    error[E0133]: call to unsafe function `pin_init::__internal::InitOk::new` is unsafe and requires unsafe block
      --> src/main.rs:26:17
       |
    26 |                 InferredType::new()
       |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
       |
       = note: consult the function's documentation for information on how to avoid undefined behavior

Reported-by: Tim Chirananthavat <theemathas@gmail.com>
Link: https://github.com/rust-lang/rust/issues/153535 [1]
Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373 [2]
Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-4017620804 [3]
Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
Cc: stable@vger.kernel.org
Signed-off-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260311105056.1425041-1-lossin@kernel.org
[ Added period as mentioned. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Moved to declarative macro, because 6.19.y and earlier do not have
  `syn`. - Benno ]
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/__internal.rs | 28 +++++++++++--
 rust/pin-init/src/macros.rs     | 73 +++++++++++++++------------------
 2 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90f18e9a2912..068a336ed458 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -46,6 +46,24 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
     }
 }
 
+/// Token type to signify successful initialization.
+///
+/// Can only be constructed via the unsafe [`Self::new`] function. The initializer macros use this
+/// token type to prevent returning `Ok` from an initializer without initializing all fields.
+pub struct InitOk(());
+
+impl InitOk {
+    /// Creates a new token.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called from the `__init_internal!` macro in `./macros.rs`.
+    #[inline(always)]
+    pub unsafe fn new() -> Self {
+        Self(())
+    }
+}
+
 /// This trait is only implemented via the `#[pin_data]` proc-macro. It is used to facilitate
 /// the pin projections within the initializers.
 ///
@@ -68,9 +86,10 @@ pub unsafe trait PinData: Copy {
     type Datee: ?Sized + HasPinData;
 
     /// Type inference helper function.
-    fn make_closure<F, O, E>(self, f: F) -> F
+    #[inline(always)]
+    fn make_closure<F, E>(self, f: F) -> F
     where
-        F: FnOnce(*mut Self::Datee) -> Result<O, E>,
+        F: FnOnce(*mut Self::Datee) -> Result<InitOk, E>,
     {
         f
     }
@@ -98,9 +117,10 @@ pub unsafe trait InitData: Copy {
     type Datee: ?Sized + HasInitData;
 
     /// Type inference helper function.
-    fn make_closure<F, O, E>(self, f: F) -> F
+    #[inline(always)]
+    fn make_closure<F, E>(self, f: F) -> F
     where
-        F: FnOnce(*mut Self::Datee) -> Result<O, E>,
+        F: FnOnce(*mut Self::Datee) -> Result<InitOk, E>,
     {
         f
     }
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 1980584c442a..45b68f539784 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1207,10 +1207,6 @@ macro_rules! __init_internal {
         @construct_closure($construct_closure:ident),
         @init_zeroed($($init_zeroed:expr)?),
     ) => {{
-        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
-        // type and shadow it later when we insert the arbitrary user code. That way there will be
-        // no possibility of returning without `unsafe`.
-        struct __InitOk;
         // Get the data about fields from the supplied type.
         //
         // SAFETY: TODO.
@@ -1223,47 +1219,44 @@ macro_rules! __init_internal {
             $crate::macros::paste!($t::$get_data())
         };
         // Ensure that `data` really is of type `$data` and help with type inference:
-        let init = $crate::__internal::$data::make_closure::<_, __InitOk, $err>(
+        let init = $crate::__internal::$data::make_closure::<_, $err>(
             data,
             move |slot| {
-                {
-                    // Shadow the structure so it cannot be used to return early.
-                    struct __InitOk;
-                    // If `$init_zeroed` is present we should zero the slot now and not emit an
-                    // error when fields are missing (since they will be zeroed). We also have to
-                    // check that the type actually implements `Zeroable`.
-                    $({
-                        fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
-                        // Ensure that the struct is indeed `Zeroable`.
-                        assert_zeroable(slot);
-                        // SAFETY: The type implements `Zeroable` by the check above.
-                        unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
-                        $init_zeroed // This will be `()` if set.
-                    })?
-                    // Create the `this` so it can be referenced by the user inside of the
-                    // expressions creating the individual fields.
-                    $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
-                    // Initialize every field.
-                    $crate::__init_internal!(init_slot($($use_data)?):
-                        @data(data),
+                // If `$init_zeroed` is present we should zero the slot now and not emit an
+                // error when fields are missing (since they will be zeroed). We also have to
+                // check that the type actually implements `Zeroable`.
+                $({
+                    fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
+                    // Ensure that the struct is indeed `Zeroable`.
+                    assert_zeroable(slot);
+                    // SAFETY: The type implements `Zeroable` by the check above.
+                    unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
+                    $init_zeroed // This will be `()` if set.
+                })?
+                // Create the `this` so it can be referenced by the user inside of the
+                // expressions creating the individual fields.
+                $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
+                // Initialize every field.
+                $crate::__init_internal!(init_slot($($use_data)?):
+                    @data(data),
+                    @slot(slot),
+                    @guards(),
+                    @munch_fields($($fields)*,),
+                );
+                // We use unreachable code to ensure that all fields have been mentioned exactly
+                // once, this struct initializer will still be type-checked and complain with a
+                // very natural error message if a field is forgotten/mentioned more than once.
+                #[allow(unreachable_code, clippy::diverging_sub_expression)]
+                let _ = || {
+                    $crate::__init_internal!(make_initializer:
                         @slot(slot),
-                        @guards(),
+                        @type_name($t),
                         @munch_fields($($fields)*,),
+                        @acc(),
                     );
-                    // We use unreachable code to ensure that all fields have been mentioned exactly
-                    // once, this struct initializer will still be type-checked and complain with a
-                    // very natural error message if a field is forgotten/mentioned more than once.
-                    #[allow(unreachable_code, clippy::diverging_sub_expression)]
-                    let _ = || {
-                        $crate::__init_internal!(make_initializer:
-                            @slot(slot),
-                            @type_name($t),
-                            @munch_fields($($fields)*,),
-                            @acc(),
-                        );
-                    };
-                }
-                Ok(__InitOk)
+                };
+                // SAFETY: we are the `__init_internal!` macro that is allowed to call this.
+                Ok(unsafe { $crate::init::__internal::InitOk::new() })
             }
         );
         let init = move |slot| -> ::core::result::Result<(), $err> {
-- 
2.53.0


