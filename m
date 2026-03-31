Return-Path: <stable+bounces-231813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK0YGywBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6836E522
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD493212215
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B94279ED;
	Tue, 31 Mar 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpNF3stU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FB4279E6;
	Tue, 31 Mar 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975135; cv=none; b=RgQ2VpGlEJS0jzqau9Xd5bVqx8HPOf/FVdU/A9ZlEupe+7qK/7CDF3L+9vHXvNmJH1e5H47JteQTPZm44g1O2jC+FOSczQsvqFzvoXLnwP798tKU6O+TVouh/JbHZsipdsMAJSVH9/PrCr8AjwWlBG6KvTapkjAGlFEzUWjtX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975135; c=relaxed/simple;
	bh=6BvXbstGLYKWzFd2HnlJbkXtJZ4EAr7vchJJ7BnzMRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWsOpYd6CbV9QRNYAeNbupy+Azo8rIIeteg9eodLhwHs6rnFoGZV3GyrJ5z7MYP4mK9Gdv3j2W1BjYlVbi1iR0Te35Ihitl7Ahtg49//Jdb0Yi+9EleDTDCyRUQwjI0TNvsUen8JZ6cVAkqBsSJV6hsyVQsJQmfssUx/rCkxy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpNF3stU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B9DC2BCB1;
	Tue, 31 Mar 2026 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975135;
	bh=6BvXbstGLYKWzFd2HnlJbkXtJZ4EAr7vchJJ7BnzMRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpNF3stUb9Fn4NBk2u1wqtQylk4/X/Jl99EaTo104JtXMrune9esQxduNfU/XRLtQ
	 1tqHUIyxmgVojUO/k/+TNLW/twK6DTKxmL+q7QtQSUGXSL1+uoPwWDNvmFvCEtrqeM
	 FHT+c8bD6n24JHxntD9+00gf1ErjpoWdn/FCMX4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 178/342] rust: regulator: do not assume that regulator_get() returns non-null
Date: Tue, 31 Mar 2026 18:20:11 +0200
Message-ID: <20260331161805.555743890@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231813-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: C3A6836E522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

[ Upstream commit 8121353a4bf8e38afee26299419a78ec108e14a6 ]

The Rust `Regulator` abstraction uses `NonNull` to wrap the underlying
`struct regulator` pointer. When `CONFIG_REGULATOR` is disabled, the C
stub for `regulator_get` returns `NULL`. `from_err_ptr` does not treat
`NULL` as an error, so it was passed to `NonNull::new_unchecked`,
causing undefined behavior.

Fix this by using a raw pointer `*mut bindings::regulator` instead of
`NonNull`. This allows `inner` to be `NULL` when `CONFIG_REGULATOR` is
disabled, and leverages the C stubs which are designed to handle `NULL`
or are no-ops.

Fixes: 9b614ceada7c ("rust: regulator: add a bare minimum regulator abstraction")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/r/20260322193830.89324-1-ojeda@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Link: https://patch.msgid.link/20260324-regulator-fix-v1-1-a5244afa3c15@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/regulator.rs | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 2c44827ad0b7e..40c7f2209867d 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -23,7 +23,10 @@ use crate::{
     prelude::*,
 };
 
-use core::{marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop, //
+};
 
 mod private {
     pub trait Sealed {}
@@ -232,15 +235,17 @@ pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
 ///
 /// # Invariants
 ///
-/// - `inner` is a non-null wrapper over a pointer to a `struct
-///   regulator` obtained from [`regulator_get()`].
+/// - `inner` is a pointer obtained from a successful call to
+///   [`regulator_get()`]. It is treated as an opaque token that may only be
+///   accessed using C API methods (e.g., it may be `NULL` if the C API returns
+///   `NULL`).
 ///
 /// [`regulator_get()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_get
 pub struct Regulator<State>
 where
     State: RegulatorState,
 {
-    inner: NonNull<bindings::regulator>,
+    inner: *mut bindings::regulator,
     _phantom: PhantomData<State>,
 }
 
@@ -252,7 +257,7 @@ impl<T: RegulatorState> Regulator<T> {
         // SAFETY: Safe as per the type invariants of `Regulator`.
         to_result(unsafe {
             bindings::regulator_set_voltage(
-                self.inner.as_ptr(),
+                self.inner,
                 min_voltage.as_microvolts(),
                 max_voltage.as_microvolts(),
             )
@@ -262,7 +267,7 @@ impl<T: RegulatorState> Regulator<T> {
     /// Gets the current voltage of the regulator.
     pub fn get_voltage(&self) -> Result<Voltage> {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
+        let voltage = unsafe { bindings::regulator_get_voltage(self.inner) };
 
         to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
     }
@@ -273,10 +278,8 @@ impl<T: RegulatorState> Regulator<T> {
             // received from the C code.
             from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_char_ptr()) })?;
 
-        // SAFETY: We can safely trust `inner` to be a pointer to a valid
-        // regulator if `ERR_PTR` was not returned.
-        let inner = unsafe { NonNull::new_unchecked(inner) };
-
+        // INVARIANT: `inner` is a pointer obtained from `regulator_get()`, and
+        // the call was successful.
         Ok(Self {
             inner,
             _phantom: PhantomData,
@@ -285,12 +288,12 @@ impl<T: RegulatorState> Regulator<T> {
 
     fn enable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_enable(self.inner) })
     }
 
     fn disable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_disable(self.inner) })
     }
 }
 
@@ -352,7 +355,7 @@ impl<T: IsEnabled> Regulator<T> {
     /// Checks if the regulator is enabled.
     pub fn is_enabled(&self) -> bool {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        unsafe { bindings::regulator_is_enabled(self.inner.as_ptr()) != 0 }
+        unsafe { bindings::regulator_is_enabled(self.inner) != 0 }
     }
 }
 
@@ -362,11 +365,11 @@ impl<T: RegulatorState> Drop for Regulator<T> {
             // SAFETY: By the type invariants, we know that `self` owns a
             // reference on the enabled refcount, so it is safe to relinquish it
             // now.
-            unsafe { bindings::regulator_disable(self.inner.as_ptr()) };
+            unsafe { bindings::regulator_disable(self.inner) };
         }
         // SAFETY: By the type invariants, we know that `self` owns a reference,
         // so it is safe to relinquish it now.
-        unsafe { bindings::regulator_put(self.inner.as_ptr()) };
+        unsafe { bindings::regulator_put(self.inner) };
     }
 }
 
-- 
2.53.0




