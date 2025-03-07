Return-Path: <stable+bounces-121481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EAA57544
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ABB3B07F2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FA258CCE;
	Fri,  7 Mar 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBBwLbIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134E18BC36;
	Fri,  7 Mar 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387907; cv=none; b=G9uiskkUKpJwgnnyiK+G6mtLzv5auwfVd/pP3kmrcgjjboRvhq/ouMiEbIYKxeby89GtXywso09nQPNz0XmriU0Tghth3k8dtLbFqAKX4uqgIsKtDePl/Zu/ON3mXUZ/1HsBm/ZLgFyAsg8P1YSZLBssQSZp+pwAKbiXDNTNByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387907; c=relaxed/simple;
	bh=vNmXjLHauCLUhD0zmXfUrAi6uW5sFMKIenUjQ+BaNGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/ec/rzA4UdJjPu/sAty6L2h39XHNGcPKHA8bbv8OU0jM8xnxPj6mWGc/lHhmvAVtDTIHG0ayW7MZQ8L9kpPKMaPoVZG7y7O22FrrW1MRsMxBHj7R9vkX66ds6wB3NOUIX5dXwXN8NezD9+zX5yZgk8uSBvhmdR2UjsVpCQRCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBBwLbIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A5C4CEE3;
	Fri,  7 Mar 2025 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387907;
	bh=vNmXjLHauCLUhD0zmXfUrAi6uW5sFMKIenUjQ+BaNGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBBwLbIY2nqeoBYWkTYJui8SzUEHPGc3XqSt7ghF5e+QLEJNVa0oYKUWwjQ5PqN6A
	 bFEtP/0BJ4dpKZCtc3DcbrFW65YLmsE5EI8dGN9SgWibIVun51F5C8sfrIxM5y8e9Z
	 JnirRW4fm63Ipx2yZ+aAYN0DILiScg0tuYwvwCA2e+7pnp8ISBwRAT9HuGiSpSH2DK
	 v2J4Xw+jRFQSJMoOrfNTBIWnZirMAkebHlfXJv1P9ZpJaz557gvZ0PgZRNl7ir83Pv
	 TyOUUfiTIgHiL2NmHr2yTCxICwwgv3piRc0yIHp4iXXJkR/R7cuqIuhvJ3LxGyVIv+
	 88fuaGU0xsdbw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alyssa Ross <hi@alyssa.is>,
	NoisyCoil <noisycoil@disroot.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y 26/60] rust: alloc: add module `allocator_test`
Date: Fri,  7 Mar 2025 23:49:33 +0100
Message-ID: <20250307225008.779961-27-ojeda@kernel.org>
In-Reply-To: <20250307225008.779961-1-ojeda@kernel.org>
References: <20250307225008.779961-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

commit 5a888c28e3b4ff6f54a53fca33951537d135e7f1 upstream.

`Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
subsequent patches, and hence this dependency propagates throughout the
whole kernel.

Add the `allocator_test` module that provides an empty implementation
for all `Allocator`s in the kernel, such that we don't break the
`rusttest` make target in subsequent patches.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/20241004154149.93856-8-dakr@kernel.org
[ Added missing `_old_layout` parameter as discussed. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 2203852c3712..b5605aab182d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -2,12 +2,17 @@
 
 //! Extensions to the [`alloc`] crate.
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
+#[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
+#[cfg(any(test, testlib))]
+pub mod allocator_test;
+
+#[cfg(any(test, testlib))]
+pub use self::allocator_test as allocator;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
new file mode 100644
index 000000000000..c5d325506f0c
--- /dev/null
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#![allow(missing_docs)]
+
+use super::{AllocError, Allocator, Flags};
+use core::alloc::Layout;
+use core::ptr::NonNull;
+
+pub struct Kmalloc;
+
+unsafe impl Allocator for Kmalloc {
+    unsafe fn realloc(
+        _ptr: Option<NonNull<u8>>,
+        _layout: Layout,
+        _old_layout: Layout,
+        _flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        panic!();
+    }
+}
-- 
2.48.1


