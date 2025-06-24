Return-Path: <stable+bounces-158412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D8AE67AD
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BB95A5AFE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D02D29AC;
	Tue, 24 Jun 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbky54NZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D972777F1
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773549; cv=none; b=Yr5UUnvxTyQXoxGtfhSz/z9/B0H4vwPBEHbtd1/7BXp1wYm2KJhhai562d+bKm5P4H2gON13fbDqXRvkI00bOhgVwTKoIkAq6RL4FlTM52eHvmXdmbl8ushwDPafQxe40iKxn6a8qF+gB/qpM35OUW4V9Gu8n7oNgqF94Hh3ZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773549; c=relaxed/simple;
	bh=Wt3vUQeFmQGsPcN2Iw4s93OgCE9wTl28/9hsyxtEGq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsxUs7Y6xfUPLQKeKwivfT2UtaljwY41CPM5P3SpbAYh7IYXWdat/3CFHrHrIjyX2Xgk5RB9Qj8/1UXd9CTHg7VrHHzvH1mEWNTN5Ig/cMy0BWLKXAlHiYK4wiEG2mIasrkD4iNGgbsD45oG6PDnW5ZDA+1lBBzzT2QJ5zcgl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbky54NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B31C4CEE3;
	Tue, 24 Jun 2025 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773548;
	bh=Wt3vUQeFmQGsPcN2Iw4s93OgCE9wTl28/9hsyxtEGq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rbky54NZwTB7RBvh8ROi7aIAo/6sJ+P2u2TlJtO9G5Rp6L2U9LFm0JNgv9PUtdHmY
	 8y5JjnQ6kkTHqR7fkaLWC/+Xlc2igmAFYJS5yipXpcpVVLhw7+M6HrXlEaO5HdgU6L
	 pvo3/kZmWXqrwV39Ukx0SrAnO1tGaNmpzPAcqmbneIMREKTC/+OBxdcBPWjRXBXfOg
	 CS/y4S+6bm9LcOECHDgryYsKUiqz4zpKG7JWCbsf8pd3a6GgOR8Xowh/5ge1OHSpnJ
	 rYvIE8FtrZ4oRTzos7NKbKFylX5drOr0i54dpwgZumuKF5IesJmOHLU38q1fWZ3Skn
	 5rouyt4aSSi7g==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	lossin@kernel.org,
	sashal@kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/4] rust: devres: fix race in Devres::drop()
Date: Tue, 24 Jun 2025 15:58:34 +0200
Message-ID: <20250624135856.60250-4-dakr@kernel.org>
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

[ Upstream commit f744201c6159fc7323c40936fd079525f7063598 ]

In Devres::drop() we first remove the devres action and then drop the
wrapped device resource.

The design goal is to give the owner of a Devres object control over when
the device resource is dropped, but limit the overall scope to the
corresponding device being bound to a driver.

However, there's a race that was introduced with commit 8ff656643d30
("rust: devres: remove action in `Devres::drop`"), but also has been
(partially) present from the initial version on.

In Devres::drop(), the devres action is removed successfully and
subsequently the destructor of the wrapped device resource runs.
However, there is no guarantee that the destructor of the wrapped device
resource completes before the driver core is done unbinding the
corresponding device.

If in Devres::drop(), the devres action can't be removed, it means that
the devres callback has been executed already, or is still running
concurrently. In case of the latter, either Devres::drop() wins revoking
the Revocable or the devres callback wins revoking the Revocable. If
Devres::drop() wins, we (again) have no guarantee that the destructor of
the wrapped device resource completes before the driver core is done
unbinding the corresponding device.

CPU0					CPU1
------------------------------------------------------------------------
Devres::drop() {			Devres::devres_callback() {
   self.data.revoke() {			   this.data.revoke() {
      is_available.swap() == true
					      is_available.swap == false
					   }
					}

					// [...]
					// device fully unbound
      drop_in_place() {
         // release device resource
      }
   }
}

Depending on the specific device resource, this can potentially lead to
user-after-free bugs.

In order to fix this, implement the following logic.

In the devres callback, we're always good when we get to revoke the
device resource ourselves, i.e. Revocable::revoke() returns true.

If Revocable::revoke() returns false, it means that Devres::drop(),
concurrently, already drops the device resource and we have to wait for
Devres::drop() to signal that it finished dropping the device resource.

Note that if we hit the case where we need to wait for the completion of
Devres::drop() in the devres callback, it means that we're actually
racing with a concurrent Devres::drop() call, which already started
revoking the device resource for us. This is rather unlikely and means
that the concurrent Devres::drop() already started doing our work and we
just need to wait for it to complete it for us. Hence, there should not
be any additional overhead from that.

(Actually, for now it's even better if Devres::drop() does the work for
us, since it can bypass the synchronize_rcu() call implied by
Revocable::revoke(), but this goes away anyways once I get to implement
the split devres callback approach, which allows us to first flip the
atomics of all registered Devres objects of a certain device, execute a
single synchronize_rcu() and then drop all revocable objects.)

In Devres::drop() we try to revoke the device resource. If that is *not*
successful, it means that the devres callback already did and we're good.

Otherwise, we try to remove the devres action, which, if successful,
means that we're good, since the device resource has just been revoked
by us *before* we removed the devres action successfully.

If the devres action could not be removed, it means that the devres
callback must be running concurrently, hence we signal that the device
resource has been revoked by us, using the completion.

This makes it safe to drop a Devres object from any task and at any point
of time, which is one of the design goals.

Fixes: 76c01ded724b ("rust: add devres abstraction")
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/lkml/aD64YNuqbPPZHAa5@google.com/
Reviewed-by: Benno Lossin <lossin@kernel.org>
Link: https://lore.kernel.org/r/20250612121817.1621-4-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ddb1ce4a78d9..f3a4e3383b8d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,7 +13,7 @@
     ffi::c_void,
     prelude::*,
     revocable::Revocable,
-    sync::Arc,
+    sync::{Arc, Completion},
     types::ARef,
 };
 
@@ -25,13 +25,17 @@ struct DevresInner<T> {
     callback: unsafe extern "C" fn(*mut c_void),
     #[pin]
     data: Revocable<T>,
+    #[pin]
+    revoke: Completion,
 }
 
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
 /// manage their lifetime.
 ///
 /// [`Device`] bound resources should be freed when either the resource goes out of scope or the
-/// [`Device`] is unbound respectively, depending on what happens first.
+/// [`Device`] is unbound respectively, depending on what happens first. In any case, it is always
+/// guaranteed that revoking the device resource is completed before the corresponding [`Device`]
+/// is unbound.
 ///
 /// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
 /// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
@@ -105,6 +109,7 @@ fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
                 dev: dev.into(),
                 callback: Self::devres_callback,
                 data <- Revocable::new(data),
+                revoke <- Completion::new(),
             }),
             flags,
         )?;
@@ -133,26 +138,28 @@ fn as_ptr(&self) -> *const Self {
         self as _
     }
 
-    fn remove_action(this: &Arc<Self>) {
+    fn remove_action(this: &Arc<Self>) -> bool {
         // SAFETY:
         // - `self.inner.dev` is a valid `Device`,
         // - the `action` and `data` pointers are the exact same ones as given to devm_add_action()
         //   previously,
         // - `self` is always valid, even if the action has been released already.
-        let ret = unsafe {
+        let success = unsafe {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
                 this.as_ptr() as _,
             )
-        };
+        } == 0;
 
-        if ret == 0 {
+        if success {
             // SAFETY: We leaked an `Arc` reference to devm_add_action() in `DevresInner::new`; if
             // devm_remove_action_nowarn() was successful we can (and have to) claim back ownership
             // of this reference.
             let _ = unsafe { Arc::from_raw(this.as_ptr()) };
         }
+
+        success
     }
 
     #[allow(clippy::missing_safety_doc)]
@@ -164,7 +171,12 @@ fn remove_action(this: &Arc<Self>) {
         //         `DevresInner::new`.
         let inner = unsafe { Arc::from_raw(ptr) };
 
-        inner.data.revoke();
+        if !inner.data.revoke() {
+            // If `revoke()` returns false, it means that `Devres::drop` already started revoking
+            // `inner.data` for us. Hence we have to wait until `Devres::drop()` signals that it
+            // completed revoking `inner.data`.
+            inner.revoke.wait_for_completion();
+        }
     }
 }
 
@@ -196,6 +208,15 @@ fn deref(&self) -> &Self::Target {
 
 impl<T> Drop for Devres<T> {
     fn drop(&mut self) {
-        DevresInner::remove_action(&self.0);
+        // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
+        // anymore, hence it is safe not to wait for the grace period to finish.
+        if unsafe { self.revoke_nosync() } {
+            // We revoked `self.0.data` before the devres action did, hence try to remove it.
+            if !DevresInner::remove_action(&self.0) {
+                // We could not remove the devres action, which means that it now runs concurrently,
+                // hence signal that `self.0.data` has been revoked successfully.
+                self.0.revoke.complete_all();
+            }
+        }
     }
 }
-- 
2.49.0


