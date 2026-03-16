Return-Path: <stable+bounces-225560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBWEESwVuGl/YwEAu9opvQ
	(envelope-from <stable+bounces-225560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:35:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B029B799
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CFD303CEBB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B71285041;
	Mon, 16 Mar 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOOZA33k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFF1E511
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671654; cv=none; b=YfRI3BzkHIUL5v+tosM2VEUP+6ANfnoLaGRBG4aVmYTlUoOyqDHWrmxzKmCWBBwGpZtS1l/D0HO3DvZmqzG4LB+iiNHTyCLTo7Ulv0CHjMlZlCHBqGbxhhVx8opcAvkaP++4hNeAeNcuSbRZLa+pWFWo7XbgRXcXl4BOf4qJP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671654; c=relaxed/simple;
	bh=yzVkz8h+UeYqUbXYKpLhjo4Omqel5Wb/hAojfc1PcOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sEYJXqsZ/eZlmKpES+2xxMt0hjIcIw/5/G9061lVmjdRHv5AO0y0QAchISzV9hTRkDVAGO9kPSxB1CAonXw5tOkhsZjLCqH3/0S2oE9F7B43CZQ55oKmbHwh5/l/uEhKCqRvnK7oAoG/comDZjeXdB6gBaNR3McwB6p+zW7zK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOOZA33k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81449C19421;
	Mon, 16 Mar 2026 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773671654;
	bh=yzVkz8h+UeYqUbXYKpLhjo4Omqel5Wb/hAojfc1PcOg=;
	h=Subject:To:Cc:From:Date:From;
	b=FOOZA33kAT5RPyePsDW1uFvKtewooPJr+0zYkauVZlZ6YcCoAPzAFw3Bd7sMUBFDU
	 gN3MElIV+e3w8uvWbwcdLiDmqBHXMwqPhVDpWrUPhtGpc+cfOFAnh3WSh4JFAQSr/P
	 kt7PIEdUQsm4Fh1jhAYf43f4Gic1+pxfyxfex4V4=
Subject: FAILED: patch "[PATCH] rust: pin-init: replace shadowed return token by" failed to apply to 6.18-stable tree
To: lossin@kernel.org,aliceryhl@google.com,gary@garyguo.net,ojeda@kernel.org,theemathas@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 15:34:02 +0100
Message-ID: <2026031602-badly-slackness-b379@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225560-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,garyguo.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,garyguo.net:email]
X-Rspamd-Queue-Id: 9A7B029B799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031602-badly-slackness-b379@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 Mon Sep 17 00:00:00 2001
From: Benno Lossin <lossin@kernel.org>
Date: Wed, 11 Mar 2026 11:50:49 +0100
Subject: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token

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

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 738f62c8105c..2fe918f4d82a 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -148,11 +148,6 @@ fn assert_zeroable<T: ?::core::marker::Sized>(_: *mut T)
     let init_fields = init_fields(&fields, pinned, &data, &slot);
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
@@ -162,18 +157,15 @@ fn assert_zeroable<T: ?::core::marker::Sized>(_: *mut T)
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


