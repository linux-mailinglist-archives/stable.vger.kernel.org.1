Return-Path: <stable+bounces-128168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF9A7B2ED
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5FF7A7C37
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E42B156678;
	Fri,  4 Apr 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQeedIY2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D6155C82;
	Fri,  4 Apr 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725060; cv=none; b=fCNkdfUNHnZ+KlTjI24AAHx9CivyC1L90lnfr7Ekg+ePKY2Mo4uahnHLVuMfydGd3Z0atB3c8NQ8BRkhcubJ9b/vc3ttOMLmB9ojI+Q6XuJgXslSutSL86Do94sC69w2dHjM0J5fYfla2ufLaQi9fE5phBEwmFa+cCdKhFceVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725060; c=relaxed/simple;
	bh=+U852PWkX9HpJ8w3HK774CIjyZa5t/VrC96/GO5bNBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRaO7e3B0S8jUowzG7md5UWmv/zZrWWZcg7/B7qaHOBAgtvdRZPXFMaGy/7ip3C+P0U8q4BapEP5VUAJRNtwHRuiufqoFwo+6rrVLjL1lzefW0mL4kpjEdCpSWHPNHiXymsjc7FwgKr3XNANb2lfZmiU05vcW/TPX/dS3eUATA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQeedIY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D366C4CEF3;
	Fri,  4 Apr 2025 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725060;
	bh=+U852PWkX9HpJ8w3HK774CIjyZa5t/VrC96/GO5bNBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQeedIY2meXJRHLon5gxOJAM/jg72VmbqHwCFFb+sveLhKKts8gGQFfK2ndoez8vO
	 3EMuBJixAGmlURwTnDJQO4vrlbq0KxuBRzYbmIg/miCTs5GsqPW4EqiMuXrYRhnkdY
	 g6MYT8lxOek2EAq9tOvQ/l48b1VaLKsrg5nty2uzuu+UPRqcJ/g6R1JjJfxc+K+V/l
	 4aidBm6BDWHGVHwwmOtAcWDHD+fYgtaKbu5XMsCPwnoNZiJa5m72r8bZLCI9C7X7cG
	 MkLYJJHKartQ5xoASeoCV3glB64o63X89s1nzEai4yuugtQVvLXPrXBc++T0lTFiWn
	 PJQNVgeRS6Bgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	leitao@debian.org,
	nayna@linux.ibm.com,
	pfsmorigo@gmail.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.14 07/23] crypto: lib/Kconfig - Fix lib built-in failure when arch is modular
Date: Thu,  3 Apr 2025 20:03:44 -0400
Message-Id: <20250404000402.2688049-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 1047e21aecdf17c8a9ab9fd4bd24c6647453f93d ]

The HAVE_ARCH Kconfig options in lib/crypto try to solve the
modular versus built-in problem, but it still fails when the
the LIB option (e.g., CRYPTO_LIB_CURVE25519) is selected externally.

Fix this by introducing a level of indirection with ARCH_MAY_HAVE
Kconfig options, these then go on to select the ARCH_HAVE options
if the ARCH Kconfig options matches that of the LIB option.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501230223.ikroNDr1-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/Kconfig     |  6 +++---
 arch/powerpc/crypto/Kconfig |  4 ++--
 arch/x86/crypto/Kconfig     |  6 +++---
 lib/crypto/Kconfig          | 26 ++++++++++++++++++--------
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 32650c8431d98..47d9cc59f254c 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -6,7 +6,7 @@ config CRYPTO_CURVE25519_NEON
 	tristate "Public key crypto: Curve25519 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
 	help
 	  Curve25519 algorithm
 
@@ -47,7 +47,7 @@ config CRYPTO_NHPOLY1305_NEON
 config CRYPTO_POLY1305_ARM
 	tristate "Hash functions: Poly1305 (NEON)"
 	select CRYPTO_HASH
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -214,7 +214,7 @@ config CRYPTO_AES_ARM_CE
 config CRYPTO_CHACHA20_NEON
 	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (NEON)"
 	select CRYPTO_SKCIPHER
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 5b315e9756b3f..e453cb0c82d2a 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -6,7 +6,7 @@ config CRYPTO_CURVE25519_PPC64
 	tristate "Public key crypto: Curve25519 (PowerPC64)"
 	depends on PPC64 && CPU_LITTLE_ENDIAN
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
 	help
 	  Curve25519 algorithm
 
@@ -95,7 +95,7 @@ config CRYPTO_CHACHA20_P10
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 4757bf922075b..c189dad0969ba 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -6,7 +6,7 @@ config CRYPTO_CURVE25519_X86
 	tristate "Public key crypto: Curve25519 (ADX)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
 	help
 	  Curve25519 algorithm
 
@@ -352,7 +352,7 @@ config CRYPTO_CHACHA20_X86_64
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
@@ -420,7 +420,7 @@ config CRYPTO_POLY1305_X86_64
 	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_POLY1305_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index b01253cac70a7..c542ef1d64d03 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -42,12 +42,17 @@ config CRYPTO_LIB_BLAKE2S_GENERIC
 	  of CRYPTO_LIB_BLAKE2S.
 
 config CRYPTO_ARCH_HAVE_LIB_CHACHA
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the ChaCha library interface,
 	  either builtin or as a module.
 
+config CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
+	tristate
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA if CRYPTO_LIB_CHACHA=m
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA if CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA=y
+
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
 	select CRYPTO_LIB_UTILS
@@ -60,7 +65,6 @@ config CRYPTO_LIB_CHACHA_GENERIC
 
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
-	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
@@ -68,12 +72,17 @@ config CRYPTO_LIB_CHACHA
 	  is available and enabled.
 
 config CRYPTO_ARCH_HAVE_LIB_CURVE25519
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the Curve25519 library interface,
 	  either builtin or as a module.
 
+config CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
+	tristate
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519 if CRYPTO_LIB_CURVE25519=m
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519 if CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519=y
+
 config CRYPTO_LIB_CURVE25519_GENERIC
 	tristate
 	help
@@ -85,7 +94,6 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 
 config CRYPTO_LIB_CURVE25519
 	tristate "Curve25519 scalar multiplication library"
-	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
 	select CRYPTO_LIB_UTILS
 	help
@@ -104,12 +112,17 @@ config CRYPTO_LIB_POLY1305_RSIZE
 	default 1
 
 config CRYPTO_ARCH_HAVE_LIB_POLY1305
-	tristate
+	bool
 	help
 	  Declares whether the architecture provides an arch-specific
 	  accelerated implementation of the Poly1305 library interface,
 	  either builtin or as a module.
 
+config CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
+	tristate
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305 if CRYPTO_LIB_POLY1305=m
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305 if CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305=y
+
 config CRYPTO_LIB_POLY1305_GENERIC
 	tristate
 	help
@@ -121,7 +134,6 @@ config CRYPTO_LIB_POLY1305_GENERIC
 
 config CRYPTO_LIB_POLY1305
 	tristate "Poly1305 library interface"
-	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
 	help
 	  Enable the Poly1305 library interface. This interface may be fulfilled
@@ -130,8 +142,6 @@ config CRYPTO_LIB_POLY1305
 
 config CRYPTO_LIB_CHACHA20POLY1305
 	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
-	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
-	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	depends on CRYPTO
 	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_POLY1305
-- 
2.39.5


