Return-Path: <stable+bounces-267203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zQI7DqVJNGqsTwYAu9opvQ
	(envelope-from <stable+bounces-267203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:40:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476D6A2610
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:40:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=efiGhOff;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267203-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267203-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA28301D31E
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A7346FA1;
	Thu, 18 Jun 2026 19:40:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6E28D8DA;
	Thu, 18 Jun 2026 19:40:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811609; cv=none; b=ujRDc+JqMCGJ7rmYeRDvT9eR2NmU/9JGj0RA316ptCO9A2fRT7tps9pycfhOS/PoVu3TqkDMUeFxl5xBCLEyzoSuD4TstB5iYmV+fFzAhyNcGA9L6sGbHLlrTLgCK9YiKjzw8LFag3Fho3q5df38Nj5SarqdMbEGeGIIIfV+CFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811609; c=relaxed/simple;
	bh=FmoXqA5LOBKUgctaZXzL4RumfuwPXIN4XJyzEfsWuho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXFr7CYnGKSoWDX636ksaoOUhTXFnJl6kpjsVq44dRiyV2hNQvbXLTyKd07YN3muW/YjDqpq+ueTb+WhMTvdURI1OsOadve4wxA9y1CklLZ7JhputLyMK8tQ31zX8/CgECKYe48u00VTOU2yzCzoX1v95KD41HL5owvT+nr/dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efiGhOff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E31F000E9;
	Thu, 18 Jun 2026 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781811608;
	bh=UzLTD0LraVmy0o5iyS49odOxFiNfs8wnUQiTnlIyr2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efiGhOffLuRTIPipF3vRAqw+0L7VjFMvHCC/dgo/x50DMT+LBxOYfoZUkTSTednjt
	 xy/QGJJPGxEaOl6VZl215vd3kP31J60TqDW5/qF/fvCQ54Dh5AEiEyFEv0k46eOxRK
	 8C8jwt+gDTmG+Q8rTU4WWu91zNsJmx1n15ErvbJ+lmNXxE56UNBp24VwPdKih8fLIa
	 zuvVIOj1ZBl2BwfymaPOcnCJwKPzdtT0eiEmHW/SHQNJgoouZkifZ3QsZqQFKEgKhg
	 tUChKhOCOT3bZ3DfIAuO5OVxAW0X5GiLNcT8AiFWu/lpaglL6+jHtWpDhYWTU/gOMV
	 +0k5Gw9IJRmxA==
From: Danilo Krummrich <dakr@kernel.org>
To: lossin@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	boqun@kernel.org,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com,
	deborah.brouwer@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] rust: revocable: fix race between concurrent revokers
Date: Thu, 18 Jun 2026 21:32:59 +0200
Message-ID: <20260618193951.601239-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618193951.601239-1-dakr@kernel.org>
References: <20260618193951.601239-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lossin@kernel.org,m:gary@garyguo.net,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:deborah.brouwer@collabora.com,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:dakr@kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267203-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8476D6A2610

There is a potential race condition when two paths try to revoke a
Revocable concurrently.

It can happen with e.g. Devres, where the driver core's
devres_release_all() calls Revocable::revoke() via the devres callback,
while Devres::drop() calls revoke_nosync() on another CPU.

The revoker that does not claim the is_available swap returns
immediately, but the revoker that did may still be executing
drop_in_place() on the inner data. This can cause a use-after-free when
the other revoker's caller proceeds to drop adjacent resources that
drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
SGTable freeing the backing sg_table and pages).

Fix this by adding a Completion to Revocable. The revoker that claims
the swap signals the Completion after drop_in_place() finishes, and any
concurrent revoker waits for it before returning. This ensures the
wrapped object is fully torn down before either path continues.

If needed, a revoke_no_wait() variant that does not wait for concurrent
revocations to complete can be added in the future.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
Suggested-by: Gary Guo <gary@garyguo.net>
Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/revocable.rs | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 0f4ae673256d..6d9d6ecccba1 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -7,7 +7,15 @@
 
 use pin_init::Wrapper;
 
-use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
+use crate::{
+    bindings,
+    prelude::*,
+    sync::{
+        rcu,
+        Completion, //
+    },
+    types::Opaque,
+};
 use core::{
     marker::PhantomData,
     ops::Deref,
@@ -67,6 +75,8 @@
 pub struct Revocable<T> {
     is_available: AtomicBool,
     #[pin]
+    revocation: Completion,
+    #[pin]
     data: Opaque<T>,
 }
 
@@ -85,6 +95,7 @@ impl<T> Revocable<T> {
     pub fn new<E>(data: impl PinInit<T, E>) -> impl PinInit<Self, E> {
         try_pin_init!(Self {
             is_available: AtomicBool::new(true),
+            revocation <- Completion::new().map_err(|e| match e {}),
             data <- Opaque::pin_init(data),
         }? E)
     }
@@ -168,6 +179,10 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) -> bool {
             // SAFETY: We know `self.data` is valid because only one CPU can succeed the
             // `compare_exchange` above that takes `is_available` from `true` to `false`.
             unsafe { drop_in_place(self.data.get()) };
+
+            self.revocation.complete_all();
+        } else {
+            self.revocation.wait_for_completion();
         }
 
         revoke
@@ -179,7 +194,8 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) -> bool {
     /// expecting that there are no concurrent users of the object.
     ///
     /// Returns `true` if `&self` has been revoked with this call, `false` if it was revoked
-    /// already.
+    /// already. In the latter case, this function waits for the concurrent revocation to complete
+    /// before returning.
     ///
     /// # Safety
     ///
@@ -200,7 +216,8 @@ pub unsafe fn revoke_nosync(&self) -> bool {
     /// function waits for the concurrent access to complete before dropping the wrapped object.
     ///
     /// Returns `true` if `&self` has been revoked with this call, `false` if it was revoked
-    /// already.
+    /// already. In the latter case, this function waits for the concurrent revocation to complete
+    /// before returning, ensuring the wrapped object has been fully dropped.
     pub fn revoke(&self) -> bool {
         // SAFETY: By passing `true` we ask `revoke_internal` to wait for the grace period to
         // finish.
-- 
2.54.0


