Return-Path: <stable+bounces-224670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDrJMB1JsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:51:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBE26290C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4ACC30065FC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42583D3CE6;
	Wed, 11 Mar 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9n9FCHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F33D3001;
	Wed, 11 Mar 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226265; cv=none; b=hIQzU8sc+5f3DsBS1H0ZbcFfyJglUaGt/l3JH7RdSk3bF984fCudd/nAZu7w5pUedCW7H9flF8uu1H5ndtOeyXCZX0CgC9SXk6tDfSlSRnK3oueSLFOOs3KMJxRjr6N9YS1lhbweJ+E6DTS2faGaSSbfFJr8jZbhAfVPBTYrdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226265; c=relaxed/simple;
	bh=MZON6RTe0+POhLMBN9IYZdEsh0baC1W9++LN5GUpjGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJn9U+G7c0fEnZqPFmLvOuUscyMybZ79X1mnes0IriaSYf+v21p+i7cevoz1KaSu6Vc9T5dIWVznnYzaoLAe93yTU1xhXJ3z+HyiUaZd1HSJUQQdOE/2QxDUpFJ37Wz9QZfLRNYwWVjc/RPvqDVVqoGobFlY3V3cW/WlfTujMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9n9FCHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB295C4CEF7;
	Wed, 11 Mar 2026 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226264;
	bh=MZON6RTe0+POhLMBN9IYZdEsh0baC1W9++LN5GUpjGA=;
	h=From:To:Cc:Subject:Date:From;
	b=j9n9FCHMQCvtIGC2zj8VDkMnwbTYi+9rWZuqFXhYe+mgKLqk/f9AGJMQCqDezzzkD
	 RZi7krplRUhzviV/8VI5A+pZGeJlyMAExGi3hzwT5pQ+xrBpGTFjdfc4NhVxF4rzEc
	 VrNW6D2bCPVRkVa2Zbq0jvxuJbjCx1D0B8DKznONhyOB+Mk8B2D78epdQifupBrd1F
	 dRonWG/0EnONefKB2+yIuNJ9YGpHdau9+iAeSjJ4F3Yr1cpoi55pJgwB09/xEfdt08
	 XflO0qxo3VWrzPy9rxZlrdlPNfeu5l3e1G/D3ZsEujzSQKKt22xXjCz3GPUdZ+0DIS
	 n67P7jTug1+cw==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Fiona Behrens <me@kloenk.dev>
Cc: Tim Chirananthavat <theemathas@gmail.com>,
	stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: pin-init: replace shadowed return token by `unsafe`-to-create token
Date: Wed, 11 Mar 2026 11:50:49 +0100
Message-ID: <20260311105056.1425041-1-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CFBE26290C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,kloenk.dev];
	TAGGED_FROM(0.00)[bounces-224670-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

We use a unit struct `__InitOk` in the closure generated by the
initializer macros as the return value. We shadow it by creating a
struct with the same name again inside of the closure, preventing early
returns of `Ok` in the initializer (before all fields have been
initialized).

In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
this solution no longer works [1]. The shadowed struct can be named
through type inference. In addition, there is an RFC proposing to add
the feature of path inference to Rust, which would similarly allow [2]

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
---
This is not yet a soundness issue, but could become one in the future
when TAIT gets stabilized in a form that allows the problem described.
---
 rust/pin-init/internal/src/init.rs | 22 +++++++---------------
 rust/pin-init/src/__internal.rs    | 28 ++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 42936f915a07..cfae789d55ba 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -156,11 +156,6 @@ fn assert_zeroable<T: ?::core::marker::Sized>(_: *mut T)
     );
     let field_check = make_field_check(&fields, init_kind, &path);
     Ok(quote! {{
-        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
-        // type and shadow it later when we insert the arbitrary user code. That way there will be
-        // no possibility of returning without `unsafe`.
-        struct __InitOk;
-
         // Get the data about fields from the supplied type.
         // SAFETY: TODO
         let #data = unsafe {
@@ -170,18 +165,15 @@ fn assert_zeroable<T: ?::core::marker::Sized>(_: *mut T)
             #path::#get_data()
         };
         // Ensure that `#data` really is of type `#data` and help with type inference:
-        let init = ::pin_init::__internal::#data_trait::make_closure::<_, __InitOk, #error>(
+        let init = ::pin_init::__internal::#data_trait::make_closure::<_, #error>(
             #data,
             move |slot| {
-                {
-                    // Shadow the structure so it cannot be used to return early.
-                    struct __InitOk;
-                    #zeroable_check
-                    #this
-                    #init_fields
-                    #field_check
-                }
-                Ok(__InitOk)
+                #zeroable_check
+                #this
+                #init_fields
+                #field_check
+                // SAFETY: we are the `init!` macro that is allowed to call this.
+                Ok(unsafe { ::pin_init::__internal::InitOk::new() })
             }
         );
         let init = move |slot| -> ::core::result::Result<(), #error> {
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90f18e9a2912..90adbdc1893b 100644
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
+    /// This function may only be called from the `init!` macro in `../internal/src/init.rs`.
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

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.53.0


