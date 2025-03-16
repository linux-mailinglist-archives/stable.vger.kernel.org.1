Return-Path: <stable+bounces-124516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1AAA6346F
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607787A41D0
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2D18859B;
	Sun, 16 Mar 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZwl2mdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4898BE5
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109474; cv=none; b=SgddC5Er0TyJJ3nUQu7ftJL74I+OBjJYmWPPD7KSqJz1dPy2QfksOSnSy1+YIKw4SFBV9lpJnEKmcqXfWfWpThAMRkG0qzomASTFAYCU6PHV56QRSvmOIEirxXI9XlxKPVkp7Gxg3XxqHjkonXaMVFJ9lZzAvECY+RoDL66pV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109474; c=relaxed/simple;
	bh=iO00qom/HSqk/xwUsr4p2DDLdxjTOFDOS8FHISOXod8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C7vErPZiX82zNzUTCy8BBFCwWRKYQ//vgYqYunMTJw2bslK94Y5VcWro7dsP423j1VtKRkaQEFUVtMHN/qJ06xDPWUyLpNTjiSuus+zUKlgjQHoibi4yhDfoE2GrQIA7bdgNgpdpx1VPgoJ3usVCr5CzVfg6P/gCMSgh3F9B1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZwl2mdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A44C4CEDD;
	Sun, 16 Mar 2025 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109474;
	bh=iO00qom/HSqk/xwUsr4p2DDLdxjTOFDOS8FHISOXod8=;
	h=Subject:To:Cc:From:Date:From;
	b=pZwl2mdK9dmVunQNTvQOuYVdMBDn1BbjGwl+fggh3dzS2q8bIwkM8sbkLaCRI+EMW
	 jEIFTlVmpvKAVBcLTHn74kFKJ0rCT5I5diRSG5CwykOSLyDV5Z7qw73fVLuQRdr7Jn
	 6++iYTmNeU8BLq/dDLMZAFjen6XyqD7sC+pKC9yQ=
Subject: FAILED: patch "[PATCH] rust: init: fix `Zeroable` implementation for" failed to apply to 6.6-stable tree
To: benno.lossin@proton.me,a.hindborg@kernel.org,aliceryhl@google.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:16:35 +0100
Message-ID: <2025031635-resent-sniff-676f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x df27cef153603b18a7d094b53cc3d5264ff32797
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031635-resent-sniff-676f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df27cef153603b18a7d094b53cc3d5264ff32797 Mon Sep 17 00:00:00 2001
From: Benno Lossin <benno.lossin@proton.me>
Date: Wed, 5 Mar 2025 13:29:01 +0000
Subject: [PATCH] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<KBox<T>>`

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

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 7fd1ea8265a5..8bbd5e3398fc 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1418,17 +1418,14 @@ macro_rules! impl_zeroable {
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


