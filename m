Return-Path: <stable+bounces-158411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EDAE67AB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C2B3A8737
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CFD2D3228;
	Tue, 24 Jun 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efcQuvzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224792D3225
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773547; cv=none; b=IkiUB1UjwD80kT9D4Smw2wjE7FEy5OXuOMVYi1cerrnf+AbFZ2W+Jj15Inkv82ufyKMts1TosMrdHZa0rcP9uzNBvWn4ILi1oNqRmQ6vIZSHz8Zmwdt15UK3c+2TAx2j5B7wD4MN+OIg9vnEtgjq1ZSkkFHDPlUD7VjA+RzfJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773547; c=relaxed/simple;
	bh=hN3o+NiTDe+HV80f7W09L6nxWv4xaOlr64h0XU7TAKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTCrzohDBsRGYQcDKyomobj+1Td+iIU6WV38w/BYK5PIMgKEPZYSqaaGOts6oul8FtQRnceJ+oJsZVjFsy/3T6zTJoKqBUzccZwn82eK3oEAaO/092P1/fvxv/kX2EcBkEtEVuqYYLwZfqDbwXza/wYHzLxG/nD4U6mF0mvAaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efcQuvzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB9C4CEE3;
	Tue, 24 Jun 2025 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773547;
	bh=hN3o+NiTDe+HV80f7W09L6nxWv4xaOlr64h0XU7TAKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efcQuvzNDGVyM+BOl1SGpRwhFbltv7CbGK65z0CcD4H5qctAnHhBrpB0pR4PoUOEL
	 lbBQeAi9bZWogbYqMljr2zWIh5O1p7z6J+NnVzZm7xvvBBxnLIxdF8f4j838R7dzF5
	 SduUNjJOOHTRZDRrVWJlJGStg1YL3rjZL0I1RyLEJ8D/c/CPagAYH/LWynbCx6LNRe
	 +VJcOvFVmzHup9cDpE3rXg82B0w06WL+sVqwACzc4zIyVyIRtd6+vmes21d8+tPwqp
	 dOvS9mG0Jh9PWC07acctQeLjiRK2rfEYjN8m3jrMgKvLGj+Y9wOzYrxrGGFE31HV8P
	 C1wwOQIu65wWg==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	lossin@kernel.org,
	sashal@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 2/4] rust: revocable: indicate whether `data` has been revoked already
Date: Tue, 24 Jun 2025 15:58:33 +0200
Message-ID: <20250624135856.60250-3-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624135856.60250-1-dakr@kernel.org>
References: <20250624135856.60250-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 4b76fafb20dd4a2becb94949d78e86bc88006509 ]

Return a boolean from Revocable::revoke() and Revocable::revoke_nosync()
to indicate whether the data has been revoked already.

Return true if the data hasn't been revoked yet (i.e. this call revoked
the data), false otherwise.

This is required by Devres in order to synchronize the completion of the
revoke process.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20250612121817.1621-3-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/revocable.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 1e5a9d25c21b..3f0fbee4acb5 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -126,8 +126,10 @@ pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a
     /// # Safety
     ///
     /// Callers must ensure that there are no more concurrent users of the revocable object.
-    unsafe fn revoke_internal<const SYNC: bool>(&self) {
-        if self.is_available.swap(false, Ordering::Relaxed) {
+    unsafe fn revoke_internal<const SYNC: bool>(&self) -> bool {
+        let revoke = self.is_available.swap(false, Ordering::Relaxed);
+
+        if revoke {
             if SYNC {
                 // SAFETY: Just an FFI call, there are no further requirements.
                 unsafe { bindings::synchronize_rcu() };
@@ -137,6 +139,8 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) {
             // `compare_exchange` above that takes `is_available` from `true` to `false`.
             unsafe { drop_in_place(self.data.get()) };
         }
+
+        revoke
     }
 
     /// Revokes access to and drops the wrapped object.
@@ -144,10 +148,13 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) {
     /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`],
     /// expecting that there are no concurrent users of the object.
     ///
+    /// Returns `true` if `&self` has been revoked with this call, `false` if it was revoked
+    /// already.
+    ///
     /// # Safety
     ///
     /// Callers must ensure that there are no more concurrent users of the revocable object.
-    pub unsafe fn revoke_nosync(&self) {
+    pub unsafe fn revoke_nosync(&self) -> bool {
         // SAFETY: By the safety requirement of this function, the caller ensures that nobody is
         // accessing the data anymore and hence we don't have to wait for the grace period to
         // finish.
@@ -161,7 +168,10 @@ pub unsafe fn revoke_nosync(&self) {
     /// If there are concurrent users of the object (i.e., ones that called
     /// [`Revocable::try_access`] beforehand and still haven't dropped the returned guard), this
     /// function waits for the concurrent access to complete before dropping the wrapped object.
-    pub fn revoke(&self) {
+    ///
+    /// Returns `true` if `&self` has been revoked with this call, `false` if it was revoked
+    /// already.
+    pub fn revoke(&self) -> bool {
         // SAFETY: By passing `true` we ask `revoke_internal` to wait for the grace period to
         // finish.
         unsafe { self.revoke_internal::<true>() }
-- 
2.49.0


