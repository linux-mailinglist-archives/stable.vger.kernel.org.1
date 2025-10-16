Return-Path: <stable+bounces-186150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED6BE3B92
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578854084E0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9992FF65D;
	Thu, 16 Oct 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezDFTnhI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB123741;
	Thu, 16 Oct 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621609; cv=none; b=fwmPET1RxBmhDQQh74PTtTyAv4tL3mcq55ta5UiYe8CpACX0ROCqGGVbkApeAJoN081Nf91r+vJB9y1U0FjQ2GfS6y7b9b2qTopOnwl9z30MBi4J4eCGsMO3vjiNfd/GO+Gvtm93zL7GYd/cqU0pTtfXgkGxcatBlL7U5raneBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621609; c=relaxed/simple;
	bh=wA9mQjxPS+NhEiTEmHO4o/e94KReITMocNzUF2d7mNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuHMoL1lrKvbo7IsowJ+1WAAqrDeSpeTgO3cLZfea1edDCYqYHtmGG7Z4qmd99F/4Tr1IX0EwZaEmxN5KhUEWtrSsKAZYoIC8Z4SmJSIjTFH7gdjthYeCeJSCdY15rsi8peFlXaXH75QpHjQFWydgC/dEtOilF/YDjZYFd8+4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezDFTnhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9088C4CEF1;
	Thu, 16 Oct 2025 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621608;
	bh=wA9mQjxPS+NhEiTEmHO4o/e94KReITMocNzUF2d7mNA=;
	h=From:To:Cc:Subject:Date:From;
	b=ezDFTnhIYVd0PhXaejrIrJQ/O2l1q1RdVjZVynSgQ2jPk7ww5DEgNeufhjx4t0GT1
	 6S6Ed6tj6L9P6DdWy8Ve0rIp7zdl/bcMwwbNCyuu0Q8Bl4awpAgzLlinVNzBEFr9Pa
	 WFKB4bPbX874Cj/YHj3IpH2Drdt7r6bv+Z9DzcfVujv91QNWnZmxZJvdeSkpTq/yZV
	 Kgo8mOcFvoWdGZ9nwj852bSi07H40hU+dzPBMG2633w9xSphVwHbkQORJIYoHMiqLr
	 lJDKsXOSEgMDNxGEkbJfBVCAGHsdedl5Nb665ZJNp0XiAHO5ggWiWArhuDxFBARrt2
	 4lCohuSRnlctw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] rust: device: fix device context of Device::parent()
Date: Thu, 16 Oct 2025 15:31:44 +0200
Message-ID: <20251016133251.31018-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regardless of the DeviceContext of a device, we can't give any
guarantees about the DeviceContext of its parent device.

This is very subtle, since it's only caused by a simple typo, i.e.

	 Self::from_raw(parent)

which preserves the DeviceContext in this case, vs.

	 Device::from_raw(parent)

which discards the DeviceContext.

(I should have noticed it doing the correct thing in auxiliary::Device
subsequently, but somehow missed it.)

Hence, fix both Device::parent() and auxiliary::Device::parent().

Cc: stable@vger.kernel.org
Fixes: a4c9f71e3440 ("rust: device: implement Device::parent()")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 8 +-------
 rust/kernel/device.rs    | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4163129b4103..e12f78734606 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -217,13 +217,7 @@ pub fn id(&self) -> u32 {
 
     /// Returns a reference to the parent [`device::Device`], if any.
     pub fn parent(&self) -> Option<&device::Device> {
-        let ptr: *const Self = self;
-        // CAST: `Device<Ctx: DeviceContext>` types are transparent to each other.
-        let ptr: *const Device = ptr.cast();
-        // SAFETY: `ptr` was derived from `&self`.
-        let this = unsafe { &*ptr };
-
-        this.as_ref().parent()
+        self.as_ref().parent()
     }
 }
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 23a95324cb0f..343996027c89 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -256,7 +256,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
 
     /// Returns a reference to the parent device, if any.
     #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
-    pub(crate) fn parent(&self) -> Option<&Self> {
+    pub(crate) fn parent(&self) -> Option<&Device> {
         // SAFETY:
         // - By the type invariant `self.as_raw()` is always valid.
         // - The parent device is only ever set at device creation.
@@ -269,7 +269,7 @@ pub(crate) fn parent(&self) -> Option<&Self> {
             // - Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
             // - `parent` is valid for the lifetime of `self`, since a `struct device` holds a
             //   reference count of its parent.
-            Some(unsafe { Self::from_raw(parent) })
+            Some(unsafe { Device::from_raw(parent) })
         }
     }
 
-- 
2.51.0


