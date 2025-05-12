Return-Path: <stable+bounces-143261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F268AB378F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9E31B60073
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD2293B63;
	Mon, 12 May 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHg6duNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF63263C7F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053792; cv=none; b=gKmFH4sTFho9+IErzDkWFmS319H5jPH0Na1LrxWaude0J510Q5Jxj2qypNiz1L7NluSdAEOHmBTSTR+HqauMjfPVxN0/Gv+hVKI1rpMdn/3BIwCtDc2pogSXtns4mv76w1UyR84bVhNvbegruquXpyOEecGqJw84Mb9yyXxPLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053792; c=relaxed/simple;
	bh=j6rnRGNg2eSatkE4P7DTupgMxGwaJY1/EsVmSEe+6JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4r7kjg7pZmN6N16vw+SPPyO2HT5debsAuSg7r7SBQf+p3vaFphv5yQXJMjd70K9pI8/oEx1xKC+WTKx//DMn2Y/ld9mZ6ihO1vbdDxpPSOV7ChQvkmB2J+tahPwM4h5hlLAmO/YHPLEx2hGnu1we35YzV+MJpgZakHSVdf1zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHg6duNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D45C4CEE7;
	Mon, 12 May 2025 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053792;
	bh=j6rnRGNg2eSatkE4P7DTupgMxGwaJY1/EsVmSEe+6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHg6duNi4MIJ1irDkJn3MaLP7vKNB8SOEblA7p/ypE0oSbMedR2BoPf67fx0TpAX0
	 eHzdfzq7GggV/ZhNr4DohqwLNo4ZG8+4vBDbYwaV7m0b3wma6Icv7k4KarCZvfV7eh
	 f3XdSVwsmYyczakzFrXNahsGvIl/fhhfaSxusmx8qh5zD5WMSNaJFvQJ9kWPW9nCUa
	 NxiQ0ViMZzLz2A0u8FrGBIfNenZSRE6whLW/ebaZ58dk6tNzdcvui+J7bRlFuD7Dtt
	 AxwYRJWsfIQjopXRkbmBqt6chr1AWhI80Xe5nUxjOXGVExVjyCQ2wtxv65y9GV45vx
	 15EBhlI9NfxYQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
Date: Mon, 12 May 2025 14:42:47 +0200
Message-ID: <20250512124247.1401815-1-ojeda@kernel.org>
In-Reply-To: <2025051211-unclothed-common-f6cf@gregkh>
References: <2025051211-unclothed-common-f6cf@gregkh>
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


