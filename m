Return-Path: <stable+bounces-143137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD6AB32A0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E983BEA97
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5725A34D;
	Mon, 12 May 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uramaB+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31525A32F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040534; cv=none; b=Tt7HK6ZmQVpgPjVWdrHYqBNLNVGaGbGWjaRzQ/C48DIizSwcqbX8QrtxlRDxYuXzQ/zKYAjAwo9HshYY3Qxr54uQr3S9hh1oH9Q4MRPklCUCGXHD+7O4RDq/y3AWgjxuwSrahpTpvc1Lj2vxPEKxXAjvJmeOtXiP0MaidCp4ODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040534; c=relaxed/simple;
	bh=U7517LeVtezkrM0pRT0MxNYXcetU86Nsh5KTsClQaqM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=szPpfiJr6TmwTbH8lpJzIXEk9lBMzi7fMI+kv/p/tHjiJa9nZ/CnKl667af4glw+fmD4mdrcYpH5gUbfGQHydnoSVCBAxLoXB9P/MV13ra2NVu8m56WVp4djbGWEECuaYnri4tugXhg1tnWTbAurOJhDGuBJTo1+TOsb8g+MdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uramaB+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A040C4CEE7;
	Mon, 12 May 2025 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040533;
	bh=U7517LeVtezkrM0pRT0MxNYXcetU86Nsh5KTsClQaqM=;
	h=Subject:To:Cc:From:Date:From;
	b=uramaB+K7pan6lNi3K5Fr4e7ig9H3feXE8sxb0A+gBTm+3SMsSnGbWPlGV4CL4ZyD
	 ezw7mZsi828D+uQqkPS/hTDeRZaNHpT+dsV/zXzHVlpvODqa855VNGn1+jpiSz6oK2
	 lk50lub3+5aHurRrP/UAjDgt/Ag7jsDQmdxOyqeM=
Subject: FAILED: patch "[PATCH] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint" failed to apply to 6.14-stable tree
To: ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:02:10 +0200
Message-ID: <2025051210-devourer-antarctic-1ed3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x a39f3087092716f2bd531d6fdc20403c3dc2a879
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051210-devourer-antarctic-1ed3@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


