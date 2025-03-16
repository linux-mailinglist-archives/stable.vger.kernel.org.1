Return-Path: <stable+bounces-124547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5BA6365B
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 17:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D8616B65C
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EE19D886;
	Sun, 16 Mar 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II5TVEBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1D2E3377
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742141386; cv=none; b=g2Vp5cn0Iut4bF6YVxcS5eqAhf0vY3LIrIVMRWcrMWy5ls7YyvEU9R9iRNiRLYzP7DszEtC4Wwz/R+p7vknPKxkQwi60aVC7u6f4vhkvKNpeXpqg0VqOegGCaHMwRlMQHpNus1Bcl7HcIY5UimQFFqEIfDGP1VEIgodo/+xXMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742141386; c=relaxed/simple;
	bh=Soe4YKf0OzgENLDUxzM+V4kuMu4g39U6VrerB4BS8uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPLhzbWChIGsju7vZo+01YpUM7YLqPWDpH50N67E1Dszed9LhDhMHJOxczMqlJ9Q/iBoPmXthDRhc1k/wyeWGQb7tjL0YLBzvDu48vSrPUvohfNp0zJ9tMHBLmzbWTMmHjSrcqt3XUKrIT680risjhVRtlCgJqoz88xojR2twxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II5TVEBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2DC4CEDD;
	Sun, 16 Mar 2025 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742141385;
	bh=Soe4YKf0OzgENLDUxzM+V4kuMu4g39U6VrerB4BS8uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=II5TVEBilTXysZtB2+ykpcyw3TAHRvfhLRxPU9F5FMFoNbF7GbjgeO24lSixu2y/1
	 YFOXhmLlNMrjEEZCN41+nEqV4Gyyg7V7/ntsV52M45GEMD9xOW7cz+37a5VKrG2SK0
	 /VY9PRk8rkMK6zoN7MC78SFOfYqffiG7ZWfpIVTIqh9fUG4jRM+KSCK0VI4tgxw+dl
	 UVREd6gA2/Y+ckYbj/fSKkrZNIR1vVfpFxQJfiJVgowh6bOqU6Le6dvM2zrARXfgx0
	 fZ8eM52GAxxPI10OjYUpiJiwyYOt4thnglgJMTr3GHNfZXgFwKlgGFlxUIA0FRi4Yq
	 IjhuMXunPyn+A==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<Box<T>>`
Date: Sun, 16 Mar 2025 17:09:35 +0100
Message-ID: <20250316160935.2407908-1-ojeda@kernel.org>
In-Reply-To: <2025031635-resent-sniff-676f@gregkh>
References: <2025031635-resent-sniff-676f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <benno.lossin@proton.me>

commit df27cef153603b18a7d094b53cc3d5264ff32797 upstream.

According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
such as `Box<T>` have the null pointer optimization only if `T: Sized`.
Thus remove the `Zeroable` implementation for the unsized case.

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
---
 rust/kernel/init.rs | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 2d4b19b86857..6ef9f6182018 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1310,17 +1310,14 @@ macro_rules! impl_zeroable {
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
-    {<T: ?Sized>} Option<Box<T>>,
+    {<T>} Option<NonNull<T>>,
+    {<T>} Option<Box<T>>,
 
     // SAFETY: `null` pointer is valid.
     //
-- 
2.49.0


