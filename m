Return-Path: <stable+bounces-158413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C70AE67BD
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885201BC5794
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2792D3A70;
	Tue, 24 Jun 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCI7sCs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E12D3A69
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773552; cv=none; b=ZbVnPq/6Mvj5OBtUjkgE+ud6JNdDJTec6sNM44NxKoW4hAQS2fivsNw93g+aKk0Cu2KCXNQwLoOMifwbdA0Q5ypxqibxy4JxAItHo/LYqzYeEwF7Swat3xR3S+nfLvG0p7l+qu/BvsP4LK3SHui7wqXNKtWho2OYu6CR31Tvjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773552; c=relaxed/simple;
	bh=rwViq7C2aveGgZDK1pUhxPQYD8BRz3zZT2whsBdQw9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjG+Ipo9HVV7DQ6BzF7xR8elsXVlHDNyDTlnYA6Lw3Iikkcm10gS69MBqXoIcQpvQmTMn4Cyq+XMhVIDv870Li+69KS6+RoypG6OXqaMH1n58o30gn8knmmxIye3nchcCjSLfPywwmy9shJjw3tdMt6+lET5hL8rsAeJbKv+Glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCI7sCs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317E7C4CEF1;
	Tue, 24 Jun 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773550;
	bh=rwViq7C2aveGgZDK1pUhxPQYD8BRz3zZT2whsBdQw9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCI7sCs1WaERQ5X0BZZMcP8Yb7Vmb8PcPudI0Rem2Cq4EhpyD4oYnxpuNBUc2fUk1
	 FWXpzs6pkJCxrOVi3DClCriBuvZsb3E8SMC4zBYz1RMP4foT0HRH+oBdfoSJFesV6F
	 4nVNV64GW+Q4mhMjJ7eQQyfkF3rIRiUd2rWmf4VNdDtiW1Wz/K2SAjASXLnOkci7TA
	 Sl8eWqAQ/XAVanrUGNvfT/7NGS3lDncmnfM9w/hRqt2x+W+jcGne/3IxjiiD28zDZw
	 7bf4TOMGuV3g/6hAUiHOW2MefzhD4FmUDfqAkLtVKIoMFCI6kwIrajtpXH9YJ+Z34D
	 vy2fpNKCf6rtA==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	lossin@kernel.org,
	sashal@kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 4/4] rust: devres: do not dereference to the internal Revocable
Date: Tue, 24 Jun 2025 15:58:35 +0200
Message-ID: <20250624135856.60250-5-dakr@kernel.org>
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

[ Upstream commit 20c96ed278e362ae4e324ed7d8c69fb48c508d3c ]

We can't expose direct access to the internal Revocable, since this
allows users to directly revoke the internal Revocable without Devres
having the chance to synchronize with the devres callback -- we have to
guarantee that the internal Revocable has been fully revoked before
the device is fully unbound.

Hence, remove the corresponding Deref implementation and, instead,
provide indirect accessors for the internal Revocable.

Note that we can still support Devres::revoke() by implementing the
required synchronization (which would be almost identical to the
synchronization in Devres::drop()).

Fixes: 76c01ded724b ("rust: add devres abstraction")
Reviewed-by: Benno Lossin <lossin@kernel.org>
Link: https://lore.kernel.org/r/20250611174827.380555-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index f3a4e3383b8d..dc6ea014ee60 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -12,13 +12,11 @@
     error::{Error, Result},
     ffi::c_void,
     prelude::*,
-    revocable::Revocable,
-    sync::{Arc, Completion},
+    revocable::{Revocable, RevocableGuard},
+    sync::{rcu, Arc, Completion},
     types::ARef,
 };
 
-use core::ops::Deref;
-
 #[pin_data]
 struct DevresInner<T> {
     dev: ARef<Device>,
@@ -196,13 +194,15 @@ pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
 
         Ok(())
     }
-}
 
-impl<T> Deref for Devres<T> {
-    type Target = Revocable<T>;
+    /// [`Devres`] accessor for [`Revocable::try_access`].
+    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
+        self.0.data.try_access()
+    }
 
-    fn deref(&self) -> &Self::Target {
-        &self.0.data
+    /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
+    pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) -> Option<&'a T> {
+        self.0.data.try_access_with_guard(guard)
     }
 }
 
@@ -210,7 +210,7 @@ impl<T> Drop for Devres<T> {
     fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
-        if unsafe { self.revoke_nosync() } {
+        if unsafe { self.0.data.revoke_nosync() } {
             // We revoked `self.0.data` before the devres action did, hence try to remove it.
             if !DevresInner::remove_action(&self.0) {
                 // We could not remove the devres action, which means that it now runs concurrently,
-- 
2.49.0


