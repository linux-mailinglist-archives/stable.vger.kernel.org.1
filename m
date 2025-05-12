Return-Path: <stable+bounces-143138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D8AB32AB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97783189C7EB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5911EB3D;
	Mon, 12 May 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OytvwFzR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E08433A0
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040541; cv=none; b=YvQGXlW4/st6EJ8qZvw7RQxX+JsxUnZMRpu05T97NR3X29U7iphp9gkssBzUodqDyOwwXI7+0VzIblJ0OGOGHXdSFx0eOnSYYbEFAxwzfqX7zComPxCdz4UyTUdcgJ5Rkng9RRQ+NV0uBH3iBg/EvbZm4nTrfMok0GCra75/gE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040541; c=relaxed/simple;
	bh=tF9aTFbbhaZb7+m0zepS/k5sO3cAce8QkqXn2Jv35AM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CB+SpL47IeZ/n2WM1pKzkwE9ubdlk1VqW9vCKV3Pge0ryfODgLQOdF4TlD1J8yq9anm5DPNWmxSyd7oAxBf9Q4bGWRh/8XEnJbK0Okd0Er82jShupjDrmQ9BQS/bKYvDJVJrteIWKeg5c5tzavy+lT/DZAuynR15NQ9/yOLAZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OytvwFzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666A3C4CEE7;
	Mon, 12 May 2025 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040540;
	bh=tF9aTFbbhaZb7+m0zepS/k5sO3cAce8QkqXn2Jv35AM=;
	h=Subject:To:Cc:From:Date:From;
	b=OytvwFzRWSWNFimdiESfxVkxFJr1XCjZWKEzCk8F5dofJjSNjzIoTxAj6HeL3pVRa
	 6nziF1yd32YQkhnEEwFrqgZbG4twhxqDFHhM7lTyIe80SfV9VS1B7v0gCWUBfYjLbV
	 GRJvwTo+/OJLR0jW1xyBe5QcpM1GubK5KVJYRLCg=
Subject: FAILED: patch "[PATCH] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint" failed to apply to 6.12-stable tree
To: ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:02:11 +0200
Message-ID: <2025051211-unclothed-common-f6cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a39f3087092716f2bd531d6fdc20403c3dc2a879
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051211-unclothed-common-f6cf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a39f3087092716f2bd531d6fdc20403c3dc2a879 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Fri, 2 May 2025 16:02:34 +0200
Subject: [PATCH] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint

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
index a335c3b1ff5e..2054682c5724 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,6 +4,9 @@
 
 //! A linked list implementation.
 
+// May not be needed in Rust 1.87.0 (pending beta backport).
+#![allow(clippy::ptr_eq)]
+
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
 use core::iter::{DoubleEndedIterator, FusedIterator};


