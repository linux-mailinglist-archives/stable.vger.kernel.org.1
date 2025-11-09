Return-Path: <stable+bounces-192813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048FC437C8
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB25F4E23E4
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADA78F2B;
	Sun,  9 Nov 2025 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tom5+O62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196517483
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658080; cv=none; b=iyqFwC3S+FgkICarhk+D91iVVofwvcJZBzk2Ivn4KvkLS0fE0DxP2pRlfDAguxfPH6oAEL3185uziTGPw6lxf8XPJ4eD/Y5r0S99zsN9CbMqlVyKNGEKrugcxMr3XJvvIn2E1753ln16xuTiHGdDUfTIlkjGpaa3zXGUZJqt/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658080; c=relaxed/simple;
	bh=t5Zlxvd/8jIk2ydxdh0b6ylLHzC6aZxIpUa5YRu+IBo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DXZVzc5AcyxgbW/vexhK3UbpHqvdZWD5OYK9biSowvDId6FdC7chM4cEbnVYiqkvaEWlQ78r1GdJh+QM0b+kTVE75SJVWKkV/SvDix/lihjEa1/FncK00HwYuLoqt5ZGS8QyhIJz4vBSJoxuNotmDi+rN6odJ0uhjY5N8Cp1dBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tom5+O62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C87C19422;
	Sun,  9 Nov 2025 03:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762658079;
	bh=t5Zlxvd/8jIk2ydxdh0b6ylLHzC6aZxIpUa5YRu+IBo=;
	h=Subject:To:Cc:From:Date:From;
	b=tom5+O62KBaVD/mpVWQKVaiDydajjyy1IKjXwqvUwMeozTXXkn3Sq35TPJpn+REYG
	 rhvmOBglFHPJWmXNHy+YDnX9O6AcGOzhVOFXJiFl4SLPNy+HtZRnV+53l9LnXFgWiR
	 VGVXjVyQtsx3rp/+zXtWdfCELiD2vCOaEhA5elSs=
Subject: FAILED: patch "[PATCH] lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN" failed to apply to 5.10-stable tree
To: ebiggers@kernel.org,ardb@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:14:24 +0900
Message-ID: <2025110924-gravel-pantry-1eee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 44e8241c51f762aafa50ed116da68fd6ecdcc954
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110924-gravel-pantry-1eee@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44e8241c51f762aafa50ed116da68fd6ecdcc954 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 3 Nov 2025 21:49:06 -0800
Subject: [PATCH] lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

On big endian arm kernels, the arm optimized Curve25519 code produces
incorrect outputs and fails the Curve25519 test.  This has been true
ever since this code was added.

It seems that hardly anyone (or even no one?) actually uses big endian
arm kernels.  But as long as they're ostensibly supported, we should
disable this code on them so that it's not accidentally used.

Note: for future-proofing, use !CPU_BIG_ENDIAN instead of
CPU_LITTLE_ENDIAN.  Both of these are arch-specific options that could
get removed in the future if big endian support gets dropped.

Fixes: d8f1308a025f ("crypto: arm/curve25519 - wire up NEON implementation")
Cc: stable@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20251104054906.716914-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 8886055e938f..16859c6226dd 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -64,7 +64,7 @@ config CRYPTO_LIB_CURVE25519
 config CRYPTO_LIB_CURVE25519_ARCH
 	bool
 	depends on CRYPTO_LIB_CURVE25519 && !UML && !KMSAN
-	default y if ARM && KERNEL_MODE_NEON
+	default y if ARM && KERNEL_MODE_NEON && !CPU_BIG_ENDIAN
 	default y if PPC64 && CPU_LITTLE_ENDIAN
 	default y if X86_64
 


