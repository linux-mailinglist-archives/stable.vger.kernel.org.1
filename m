Return-Path: <stable+bounces-230333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNSQJwLfw2kgugQAu9opvQ
	(envelope-from <stable+bounces-230333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:11:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8D3257B9
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5CFF30D08AD
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECF3D88FB;
	Wed, 25 Mar 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwLjgs9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2D3D88E3;
	Wed, 25 Mar 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443489; cv=none; b=b3KLafnV6/P3uF8M0zXm2Oshb6k/n+FF5GtsVoCdFb2Fdy4lda6vcbR/G/f1rSMyDH+s436QZWEhCVPbyyZX7vTx4kV6FCySgf5toMrLg4k6O7Ynq1iYh3ds13+/0MPOTpniOaod2VvDxv81/sIdRpTPs+9tWsTA5TF5kKWKZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443489; c=relaxed/simple;
	bh=21C6Hj/OU4nRBmS/BsGazVmC9H/ZNKTeiUu2gzkfktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRzKCAcTUJaZ+5MRwAVT+cHc/YdqsHPqS0RD6Kvzy1k1MNhgyUnwwE4OldP5SV2WSle0Tc7I9/tYbOkEqNLHO32eJYwC01HvwrnTyUNSgOSLQgLF3n6DqK85OcQltH3bRMwu33q3Xrvc20hGUNcSuss8MoDyhlZ67eUi9knYjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwLjgs9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB39CC2BCB0;
	Wed, 25 Mar 2026 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774443488;
	bh=21C6Hj/OU4nRBmS/BsGazVmC9H/ZNKTeiUu2gzkfktw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwLjgs9G6kBPbh6WWkQD2zOnKHipJ0X43V8GaGfycdvxZgdPXLfSDa8Pm9J59hBJy
	 7fE9yKGkyLwMLnF5t8UmE0jGObXjlta74zGl2JnA80YCbYzLtdVVS01YzW4D9R/q+z
	 otIY+BoSeQJIPhVmAO8BWDyzyrtcPm/I3QZr9wjov9lkhHNhznGdUmMM1+5K4hLKNn
	 HJo59GljJ8fuFwFWUgii/9dLqcYZNgUJRv2Ad2eh23/COjgCS0ENZNxlLbDgujbEGx
	 H2AxIduYUOYpYgVtwlvv6VUL7IWanzL0rShvKiqHqWXoP4ThYFVzZ7JSFwMAfNbIvX
	 o/ZlaoQT5c5Gw==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: [PATCH 6.18.y 2/2] rust: pin-init: replace shadowed return token by `unsafe`-to-create token
Date: Wed, 25 Mar 2026 13:57:51 +0100
Message-ID: <20260325125753.944918-2-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325125753.944918-1-lossin@kernel.org>
References: <20260325125753.944918-1-lossin@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,garyguo.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33A8D3257B9
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
index fdf38b4fdbdc..7d903674033f 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1205,10 +1205,6 @@ macro_rules! __init_internal {
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
@@ -1221,47 +1217,44 @@ macro_rules! __init_internal {
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


