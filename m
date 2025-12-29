Return-Path: <stable+bounces-203661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D35CE7448
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 433EB3015A88
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3432BF48;
	Mon, 29 Dec 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AFM7INZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BD32BF24
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023751; cv=none; b=s0l/X7cFJatkffB8Y6yJ+buT5e/v7H7TEE72eZg/IpGEo57hGCIUGPgxkUrBZpwwG1z09Kchy9Mq4yg9vmLLWaIPKSuwg5gsxeUFqURGKSZ3DjBrOSQRGCzOX1hoCYr25hcEs4sjCvyUIij1JaB0EpZr292dsL5y1vDUi3iFtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023751; c=relaxed/simple;
	bh=OTbKRRHBHOZrhAU8Laoe1gDFEBXNskYaXqJGYAVMnz8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=faCIiaI/y8YA3KO8BW2K/XRx966xUimIF55F13E6SSWtg48MQ6Nm9JSd31gpElnWqLsESubz3lvYdAc9pREA+u6ymgjtyIzHQXVgAyhkrzJpKUtZrry3O1ybRgaUjuWSiDnoiXyZPZSIZHjHBl4pYjOuRDU4+YJMsjiFPUmsG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AFM7INZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B7BC4CEF7;
	Mon, 29 Dec 2025 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023751;
	bh=OTbKRRHBHOZrhAU8Laoe1gDFEBXNskYaXqJGYAVMnz8=;
	h=Subject:To:Cc:From:Date:From;
	b=AFM7INZTFn7JglVlEjy9EhgLp6L1GKB8FE+EC30t9pZBXVtzm81RUZAyEN2zIKS+y
	 LivvDjdatXhq3wNNIIti8mYMWyC/YeD+8PZDPce30SJWSW4rdAHokHPSg12oxcFmLR
	 tAj24oIw1T+F09BvL8Ul9Dm0/9wUrNYIhCYxPCC0=
Subject: FAILED: patch "[PATCH] lib/crypto: riscv: Depend on" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,jerry.shih@sifive.com,wangruikang@iscas.ac.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:55:48 +0100
Message-ID: <2025122948-abide-broken-c7d3@gregkh>
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
git cherry-pick -x 1cd5bb6e9e027bab33aafd58fe8340124869ba62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122948-abide-broken-c7d3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cd5bb6e9e027bab33aafd58fe8340124869ba62 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 6 Dec 2025 13:37:50 -0800
Subject: [PATCH] lib/crypto: riscv: Depend on
 RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS

Replace the RISCV_ISA_V dependency of the RISC-V crypto code with
RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS, which implies RISCV_ISA_V as
well as vector unaligned accesses being efficient.

This is necessary because this code assumes that vector unaligned
accesses are supported and are efficient.  (It does so to avoid having
to use lots of extra vsetvli instructions to switch the element width
back and forth between 8 and either 32 or 64.)

This was omitted from the code originally just because the RISC-V kernel
support for detecting this feature didn't exist yet.  Support has now
been added, but it's fragmented into per-CPU runtime detection, a
command-line parameter, and a kconfig option.  The kconfig option is the
only reasonable way to do it, though, so let's just rely on that.

Fixes: eb24af5d7a05 ("crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}")
Fixes: bb54668837a0 ("crypto: riscv - add vector crypto accelerated ChaCha20")
Fixes: 600a3853dfa0 ("crypto: riscv - add vector crypto accelerated GHASH")
Fixes: 8c8e40470ffe ("crypto: riscv - add vector crypto accelerated SHA-{256,224}")
Fixes: b3415925a08b ("crypto: riscv - add vector crypto accelerated SHA-{512,384}")
Fixes: 563a5255afa2 ("crypto: riscv - add vector crypto accelerated SM3")
Fixes: b8d06352bbf3 ("crypto: riscv - add vector crypto accelerated SM4")
Cc: stable@vger.kernel.org
Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
Closes: https://lore.kernel.org/r/b3cfcdac-0337-4db0-a611-258f2868855f@iscas.ac.cn/
Reviewed-by: Jerry Shih <jerry.shih@sifive.com>
Link: https://lore.kernel.org/r/20251206213750.81474-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index a75d6325607b..14c5acb935e9 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -4,7 +4,8 @@ menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
 config CRYPTO_AES_RISCV64
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTS"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		   RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	select CRYPTO_SKCIPHER
@@ -20,7 +21,8 @@ config CRYPTO_AES_RISCV64
 
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		   RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	select CRYPTO_GCM
 	help
 	  GCM GHASH function (NIST SP 800-38D)
@@ -30,7 +32,8 @@ config CRYPTO_GHASH_RISCV64
 
 config CRYPTO_SM3_RISCV64
 	tristate "Hash functions: SM3 (ShangMi 3)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		   RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
@@ -42,7 +45,8 @@ config CRYPTO_SM3_RISCV64
 
 config CRYPTO_SM4_RISCV64
 	tristate "Ciphers: SM4 (ShangMi 4)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		   RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index a3647352bff6..6871a41e5069 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -61,7 +61,8 @@ config CRYPTO_LIB_CHACHA_ARCH
 	default y if ARM64 && KERNEL_MODE_NEON
 	default y if MIPS && CPU_MIPS32_R2
 	default y if PPC64 && CPU_LITTLE_ENDIAN && VSX
-	default y if RISCV && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	default y if S390
 	default y if X86_64
 
@@ -184,7 +185,8 @@ config CRYPTO_LIB_SHA256_ARCH
 	default y if ARM64
 	default y if MIPS && CPU_CAVIUM_OCTEON
 	default y if PPC && SPE
-	default y if RISCV && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	default y if S390
 	default y if SPARC64
 	default y if X86_64
@@ -202,7 +204,8 @@ config CRYPTO_LIB_SHA512_ARCH
 	default y if ARM && !CPU_V7M
 	default y if ARM64
 	default y if MIPS && CPU_CAVIUM_OCTEON
-	default y if RISCV && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default y if RISCV && 64BIT && TOOLCHAIN_HAS_VECTOR_CRYPTO && \
+		     RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
 	default y if S390
 	default y if SPARC64
 	default y if X86_64


