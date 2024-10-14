Return-Path: <stable+bounces-83668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2A99BE76
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D791F2267F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B614A4D4;
	Mon, 14 Oct 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgdyskja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B814A0AE;
	Mon, 14 Oct 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878266; cv=none; b=g7/8hpH6BfEtJEnE0AKbEVbgU2je0Tr7cL+NHEJx04dRhXJTa5Lq9MjqX2eHe1w7VF9p8F7hs/p2H7PLhiFp8ZK8ot9R2MJ8o23f0e8kOSQ6MMV72AomOLIlbHssHst5fW4cujCekKxLZLRwmfd9SeEF5h49BTcK2OTwhkM9ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878266; c=relaxed/simple;
	bh=z+NVXuqAmi8G4+8tRnlxkymWrkRCchQSLAOTmFj4l1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9Djv8wWzUIhQwblXk/FyqxzpN3J7X4URc/ZLTrg6JJpQENmt9ifzu/xRUNtAKmqzXgheF9ZN+/8LUQOQy9Z9GRKso4n5+2G28rfng4cxnbir0QJtQc0pr5LHeHb+tIPAeECeHbJOXwczvtzYbJY21qBc1CcXPASQUKQzuEZ+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgdyskja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148D4C4CEC3;
	Mon, 14 Oct 2024 03:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878266;
	bh=z+NVXuqAmi8G4+8tRnlxkymWrkRCchQSLAOTmFj4l1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kgdyskja1pvA42Hl74ZuxGKTjSjFLR+1tpBfqhRH9VkF5tPow9Z/2g+dqo2LgN7C3
	 jihb+gA4gAPzIKypXBkr3qTMLqPLtoEzH/1nuejFQvq3AUEQMt59eSFCutMFbqGuRG
	 YDLVD5q9IGCiF4ZSBvR7MJFnUnDE+aD6RkAqpOOgAC30NHkKuInrLiXD18BOCePM3k
	 4GmSUKv5vb8L5h5yitqJZ1Z00xRmfTdFzalryK9O8lf9WiWntzNUFYfU+ECneLlPgA
	 R1jig934Z6VT+ob07/1MRIvAA2/08GmFDK1ji44j9fbuI/m4xK7a/8N+Wp/kXRsWDE
	 b403wPp+/gLXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 10/20] rust: device: change the from_raw() function
Date: Sun, 13 Oct 2024 23:57:12 -0400
Message-ID: <20241014035731.2246632-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

[ Upstream commit cc4332afb5631b0e9d2ce5699b7f4b7caf743526 ]

The function Device::from_raw() increments a refcount by a call to
bindings::get_device(ptr). This can be confused because usually
from_raw() functions don't increment a refcount.
Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
semantics.

The new name of function should be "get_device" to be consistent with
the function get_device() already exist in .c files.

This function body also changed, because the `into()` will convert the
`&'a Device` into `ARef<Device>` and also call `inc_ref` from the
`AlwaysRefCounted` trait implemented for Device.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1088
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241001205603.106278-1-trintaeoitogc@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/device.rs   | 15 +++------------
 rust/kernel/firmware.rs |  2 +-
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885e..c8199ee079eff 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -51,18 +51,9 @@ impl Device {
     ///
     /// It must also be ensured that `bindings::device::release` can be called from any thread.
     /// While not officially documented, this should be the case for any `struct device`.
-    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
-        // SAFETY: By the safety requirements, ptr is valid.
-        // Initially increase the reference count by one to compensate for the final decrement once
-        // this newly created `ARef<Device>` instance is dropped.
-        unsafe { bindings::get_device(ptr) };
-
-        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
-        let ptr = ptr.cast::<Self>();
-
-        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
-        // `bindings::get_device` we also own a reference to the underlying `struct device`.
-        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
+    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
+        // SAFETY: By the safety requirements ptr is valid
+        unsafe { Self::as_ref(ptr) }.into()
     }
 
     /// Obtain the raw `struct device *`.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec4..13a374a5cdb74 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
-/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
 /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
-- 
2.43.0


