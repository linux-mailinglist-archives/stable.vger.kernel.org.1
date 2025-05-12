Return-Path: <stable+bounces-143262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6382AB37A3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7315A17DFB2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E567258CFB;
	Mon, 12 May 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyMtKpT8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5567254AE1
	for <stable@vger.kernel.org>; Mon, 12 May 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054047; cv=none; b=lnVMMnQykPj83Zv3yRmVvGV5C9gVuzgU0CiwWe5AEAPor9kZyoBW9T+JEHkgQnZtQOxOBkJ0VwkkMVpMlbA55YdzDAYvC5JTiRBgtyg19AstJRdnsy4PqVtLfB7NUBCCuN6hM861IGEGTPm9Ssj5lp+1Xi3Fa14ElKSCqHX3fgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054047; c=relaxed/simple;
	bh=j6rnRGNg2eSatkE4P7DTupgMxGwaJY1/EsVmSEe+6JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atSogjRKIoNSjjJxtNdTIJ7o78eyg5xc7mRh3LjdKAde+w46s00QtanqNzv3GTwAubbbYNDXRBuu3jvWA5W0ssBs1+tU8J+rWtY++RtWTndeJ12iW2IcfihMnzVNHWRqWOhAw9glQsHVSFUj8yKlfbWSKwtWvVjdT6XZbnCgO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyMtKpT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE25C4CEE7;
	Mon, 12 May 2025 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054046;
	bh=j6rnRGNg2eSatkE4P7DTupgMxGwaJY1/EsVmSEe+6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyMtKpT8mlYtqUueddqGtOLSXLBDDKRohaVARln0DetmIxhDmMAzdbgipFRb9yXln
	 1Xl+5pzN0iCaeeQ5BqAqgK9MMwX6UvcNKAioTELPhw//LYvrcJNWq6b3r4Yy59Rgew
	 N6rYfdCoGC0EWjm/Q8bOE/RpbzRpKcGdNeQ1uFKr1w1Mw9W3hRR74ote7dL2FOq5ty
	 CQEIV0aSCykfT2MrNzWAFkAJYDgHLlOgDfKKc9PY4WzXqxIpT9N/B25TXdgd3Luxv/
	 sJOOO2i50nNWXe43xFEGVKjye3gG/N+JaHpRg7LWh3yyRLGQvYyAHBOHSmxzKs2DgQ
	 Vaod+y57p6Fsg==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.14.y] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
Date: Mon, 12 May 2025 14:47:18 +0200
Message-ID: <20250512124718.1403201-1-ojeda@kernel.org>
In-Reply-To: <2025051210-devourer-antarctic-1ed3@gregkh>
References: <2025051210-devourer-antarctic-1ed3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.87.0 (expected 2025-05-15) [1], Clippy may expand
the `ptr_eq` lint, e.g.:

    error: use `core::ptr::eq` when comparing raw pointers
       --> rust/kernel/list.rs:438:12
        |
    438 |         if self.first == item {
        |            ^^^^^^^^^^^^^^^^^^ help: try: `core::ptr::eq(self.first, item)`
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_eq
        = note: `-D clippy::ptr-eq` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::ptr_eq)]`

It is expected that a PR to relax the lint will be backported [2] by
the time Rust 1.87.0 releases, since the lint was considered too eager
(at least by default) [3].

Thus allow the lint temporarily just in case.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust-clippy/pull/14339 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/14526 [2]
Link: https://github.com/rust-lang/rust-clippy/issues/14525 [3]
Link: https://lore.kernel.org/r/20250502140237.1659624-3-ojeda@kernel.org
[ Converted to `allow`s since backport was confirmed. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit a39f3087092716f2bd531d6fdc20403c3dc2a879)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc/kvec.rs | 3 +++
 rust/kernel/list.rs       | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..87a71fd40c3c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -2,6 +2,9 @@
 
 //! Implementation of [`Vec`].
 
+// May not be needed in Rust 1.87.0 (pending beta backport).
+#![allow(clippy::ptr_eq)]
+
 use super::{
     allocator::{KVmalloc, Kmalloc, Vmalloc},
     layout::ArrayLayout,
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..3841ba02ef7a 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,6 +4,9 @@
 
 //! A linked list implementation.
 
+// May not be needed in Rust 1.87.0 (pending beta backport).
+#![allow(clippy::ptr_eq)]
+
 use crate::init::PinInit;
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
-- 
2.49.0


