Return-Path: <stable+bounces-125090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F3A68FBB
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970F3169D34
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB31E8337;
	Wed, 19 Mar 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RUpKJBdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619E1DD0E1;
	Wed, 19 Mar 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394948; cv=none; b=pFjHIIKK7DWSUTYWj/OGxSUO/slrGfpeQZdU2xBBGeJWq9yCRDuiYvgDaBB4WqOmTXNYotBut7rgqjLf/Scb0MNp5XMxwx7irjvvj21OSEY6DNLCCRBoj9d3iWDzzwt4vscoBaBaAnVqYyZSeYZElT5l9houtMn2ClhLOLxMgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394948; c=relaxed/simple;
	bh=Ekp8cL1Qi6ci06cYaU1/+IiD3iH0m7pY8Fk/LcIKkPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddk6n2+a0VNd5JMsIDL8Dm8a+Sd/x8FYrBKAKDTtGXtjFp/HaFiJccYzUQah90ZiJduMQC3IHjUOhSOyqthByYBkkPt/j8FEKrHWayOfwRG41sq9N+XOoQDpIXfyS9f315SaOp5qY72Wf8IdwbrhtVkLwUtpujdzgbIbUL9s8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RUpKJBdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF6AC4CEE8;
	Wed, 19 Mar 2025 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394948;
	bh=Ekp8cL1Qi6ci06cYaU1/+IiD3iH0m7pY8Fk/LcIKkPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUpKJBdqu31o1YypuW6mTn7r20iIsSBeQexPGvDevYAP+0DFCQTXEqHFxdlpuAfnY
	 FMB0+/mFyNRoaC6i/Smceli3gGCzzaUOtxRqp6FOTPBo13jobK7yp/ywzpdowrxmp/
	 ZUmN7PTLQRKeLgVxwQ4/QBmAf3Un7DSyVhBUyphM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.13 171/241] rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`
Date: Wed, 19 Mar 2025 07:30:41 -0700
Message-ID: <20250319143031.959592613@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benno Lossin <benno.lossin@proton.me>

commit df27cef153603b18a7d094b53cc3d5264ff32797 upstream.

According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
such as our custom `KBox<T>` have the null pointer optimization only if
`T: Sized`. Thus remove the `Zeroable` implementation for the unsized
case.

Link: https://doc.rust-lang.org/stable/std/option/index.html#representation [1]
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/rust-for-linux/CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com/
Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.6.y)
Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/r/20250305132836.2145476-1-benno.lossin@proton.me
[ Added Closes tag and moved up the Reported-by one. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/init.rs |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1400,17 +1400,14 @@ impl_zeroable! {
     // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
     {<T: ?Sized + Zeroable>} UnsafeCell<T>,
 
-    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
+    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee:
+    // https://doc.rust-lang.org/stable/std/option/index.html#representation).
     Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,
     Option<NonZeroU128>, Option<NonZeroUsize>,
     Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZeroI64>,
     Option<NonZeroI128>, Option<NonZeroIsize>,
-
-    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
-    //
-    // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
-    {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<KBox<T>>,
+    {<T>} Option<NonNull<T>>,
+    {<T>} Option<KBox<T>>,
 
     // SAFETY: `null` pointer is valid.
     //



