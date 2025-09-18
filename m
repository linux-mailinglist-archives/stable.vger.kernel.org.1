Return-Path: <stable+bounces-172247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED84B30C23
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294EA7AF63E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC02641FC;
	Fri, 22 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hahtEWkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D18223DE7
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831996; cv=none; b=JwwyA69lGmeEZ7e9x2uRXtQwK0dxaX+3IqsS3B4+gilaBSTZO7MdAUB7sffytaDlAHC0ojiRdRapSgh2rhfL45zorKbrGsGhS1HyDw35wjZZTMINhxxpvQNBY8NtFjzlzRCaE3g5m9zsE452LHW+/+obQ6ZeT12lWL9Zs8t8ftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831996; c=relaxed/simple;
	bh=JmBYctGxLuaX1AonmjmWNV9gHx8n1MfMqgkyGldAK6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5HbJy/xTU0vLkmGkAviZbES2IQrxnrutiBsc3EIG1wu6ZUhuIj/PCHZVJhY6FOV1fgJLVguDAADmunyYx8WY0Yh3AUapHmhPuhUIQIFWqh2okQR2NFtrNIEKHYRDC8sIwLsXWCRbXSJ6BByZXJ8HEYX6z1e4TP+9YSoBB5Q2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hahtEWkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43F6C113CF;
	Fri, 22 Aug 2025 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831995;
	bh=JmBYctGxLuaX1AonmjmWNV9gHx8n1MfMqgkyGldAK6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hahtEWkEddBBM/0Iqfjag/kIb720wgYoqRh7LuyGRGFCABb35/UPRp/HGroueFqnQ
	 TAy9LM2ZmZneXNhDQiOvS51uWxtOsa2KyZVQCtGTfVoTE8Be0M5IGe6lMVZQWjgfmR
	 93JGBegHk7f4XvjXwrIYmS0wcrPaZ58Nj9zXRLaVreMcQft8EV0cBrKiH+WZXgcn03
	 u03Pl58Fb92MrmKrGq9m+iGjTBVZrM8185AV6D6kq3xRSj661uEsGt+UZayMPvUIWo
	 BHHsJfEcrNQ5ySFgMIvL5KaNSRZ12hXasyoNOYvOFCF5Gd4bCFSQQTJ8f18/FZTCqJ
	 C97aNF5hJxKMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] crypto: x86/aegis128 - optimize length block preparation using SSE4.1
Date: Thu, 21 Aug 2025 23:06:29 -0400
Message-ID: <20250822030632.1053504-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822030632.1053504-1-sashal@kernel.org>
References: <2025082114-proofs-slideshow-5515@gregkh>
 <20250822030632.1053504-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit af2aff7caf8afb7abbe219a838d61b4c17d88a47 ]

Start using SSE4.1 instructions in the AES-NI AEGIS code, with the first
use case being preparing the length block in fewer instructions.

In practice this does not reduce the set of CPUs on which the code can
run, because all Intel and AMD CPUs with AES-NI also have SSE4.1.

Upgrade the existing SSE2 feature check to SSE4.1, though it seems this
check is not strictly necessary; the aesni-intel module has been getting
away with using SSE4.1 despite checking for AES-NI only.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 3d9eb180fbe8 ("crypto: x86/aegis - Add missing error checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/Kconfig               | 4 ++--
 arch/x86/crypto/aegis128-aesni-asm.S  | 6 ++----
 arch/x86/crypto/aegis128-aesni-glue.c | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 46b53ab06165..0cf89264db08 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -366,7 +366,7 @@ config CRYPTO_CHACHA20_X86_64
 	  - AVX-512VL (Advanced Vector Extensions-512VL)
 
 config CRYPTO_AEGIS128_AESNI_SSE2
-	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE2)"
+	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE4.1)"
 	depends on X86 && 64BIT
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
@@ -375,7 +375,7 @@ config CRYPTO_AEGIS128_AESNI_SSE2
 
 	  Architecture: x86_64 using:
 	  - AES-NI (AES New Instructions)
-	  - SSE2 (Streaming SIMD Extensions 2)
+	  - SSE4.1 (Streaming SIMD Extensions 4.1)
 
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "Hash functions: NHPoly1305 (SSE2)"
diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 1b57558548c7..639ba6f31a90 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * AES-NI + SSE2 implementation of AEGIS-128
+ * AES-NI + SSE4.1 implementation of AEGIS-128
  *
  * Copyright (c) 2017-2018 Ondrej Mosnacek <omosnacek@gmail.com>
  * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
@@ -716,9 +716,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_final)
 
 	/* prepare length block: */
 	movd %edx, MSG
-	movd %ecx, T0
-	pslldq $8, T0
-	pxor T0, MSG
+	pinsrd $2, %ecx, MSG
 	psllq $3, MSG /* multiply by 8 (to get bit count) */
 
 	pxor STATE3, MSG
diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 6c4c2cda2c2d..9b52451f6fee 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * The AEGIS-128 Authenticated-Encryption Algorithm
- *   Glue for AES-NI + SSE2 implementation
+ *   Glue for AES-NI + SSE4.1 implementation
  *
  * Copyright (c) 2017-2018 Ondrej Mosnacek <omosnacek@gmail.com>
  * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
@@ -265,7 +265,7 @@ static struct simd_aead_alg *simd_alg;
 
 static int __init crypto_aegis128_aesni_module_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
+	if (!boot_cpu_has(X86_FEATURE_XMM4_1) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
@@ -284,6 +284,6 @@ module_exit(crypto_aegis128_aesni_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ondrej Mosnacek <omosnacek@gmail.com>");
-MODULE_DESCRIPTION("AEGIS-128 AEAD algorithm -- AESNI+SSE2 implementation");
+MODULE_DESCRIPTION("AEGIS-128 AEAD algorithm -- AESNI+SSE4.1 implementation");
 MODULE_ALIAS_CRYPTO("aegis128");
 MODULE_ALIAS_CRYPTO("aegis128-aesni");
-- 
2.50.1


