Return-Path: <stable+bounces-82431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DDD994CC9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F911F23D47
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAD1DF25A;
	Tue,  8 Oct 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcMvQ24p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E41DE4DB;
	Tue,  8 Oct 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392238; cv=none; b=nW3dLAAsQe1vss97jsfdVqFf/oynNCbcr7llMF1gfRT7y6E3puOORGFJlrJ8jcsnr6rgXSXtuiI/7IrEw42OciN3VafhPwI9LS0pYL2tCMqjtZ37yVBcVyOrLMaO6lQHDK9sIEDffnefIgRh6RCraHvW1thtPMt3N0aFX5Dj3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392238; c=relaxed/simple;
	bh=+o1dQPGwTo7SyUj25/R7iTkSqgeuYXd3Wrf1dVoeDQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drjOG+7NYqvaRQ94t6rQR7GXV1J6Kt8W20eYv9UDAKEli5CfQ70vB010h8Tzk31pTP6MmR4hRXVr6osqfuy679wjAbmaeI/VGQFzHXOgw1FMAKvOlOyrJoG6cp9PqzQJ+J0BUYrMO4YFGwaZuRLJ0vZ0M2j8/T2VSO8MvtrvdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcMvQ24p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0432AC4CEC7;
	Tue,  8 Oct 2024 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392238;
	bh=+o1dQPGwTo7SyUj25/R7iTkSqgeuYXd3Wrf1dVoeDQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcMvQ24pqiYImkjip7GppHjVKc0yvrys/6SeKjkR0Ihc07qbdTaldCC2wzgU/gXJT
	 iuGW5Y14Tpcg757pYhg1uIl/3+jZXXrb6S2q2V/zaT2jwhAeiXOwu6u0gf4Mt4Gl+E
	 akyI3QgPACGA3S6kUhT62yYP+zNWfq8WSNMS1ZXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.11 357/558] rust: sync: require `T: Sync` for `LockedBy::access`
Date: Tue,  8 Oct 2024 14:06:27 +0200
Message-ID: <20241008115716.349427303@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

commit a8ee30f45d5d57467ddb7877ed6914d0eba0af7f upstream.

The `LockedBy::access` method only requires a shared reference to the
owner, so if we have shared access to the `LockedBy` from several
threads at once, then two threads could call `access` in parallel and
both obtain a shared reference to the inner value. Thus, require that
`T: Sync` when calling the `access` method.

An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
This patch does not choose that approach as it gives up the ability to
use `LockedBy` with `!Sync` types, which is okay as long as you only use
`access_mut`.

Cc: stable@vger.kernel.org
Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/sync/locked_by.rs |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -83,8 +83,12 @@ pub struct LockedBy<T: ?Sized, U: ?Sized
 // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
 
-// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
-// data it protects is `Send`.
+// SAFETY: If `T` is not `Sync`, then parallel shared access to this `LockedBy` allows you to use
+// `access_mut` to hand out `&mut T` on one thread at the time. The requirement that `T: Send` is
+// sufficient to allow that.
+//
+// If `T` is `Sync`, then the `access` method also becomes available, which allows you to obtain
+// several `&T` from several threads at once. However, this is okay as `T` is `Sync`.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
 
 impl<T, U> LockedBy<T, U> {
@@ -118,7 +122,10 @@ impl<T: ?Sized, U> LockedBy<T, U> {
     ///
     /// Panics if `owner` is different from the data protected by the lock used in
     /// [`new`](LockedBy::new).
-    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
+    where
+        T: Sync,
+    {
         build_assert!(
             size_of::<U>() > 0,
             "`U` cannot be a ZST because `owner` wouldn't be unique"
@@ -127,7 +134,10 @@ impl<T: ?Sized, U> LockedBy<T, U> {
             panic!("mismatched owners");
         }
 
-        // SAFETY: `owner` is evidence that the owner is locked.
+        // SAFETY: `owner` is evidence that there are only shared references to the owner for the
+        // duration of 'a, so it's not possible to use `Self::access_mut` to obtain a mutable
+        // reference to the inner value that aliases with this shared reference. The type is `Sync`
+        // so there are no other requirements.
         unsafe { &*self.data.get() }
     }
 



