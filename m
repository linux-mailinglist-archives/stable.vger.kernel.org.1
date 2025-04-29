Return-Path: <stable+bounces-138181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869CFAA16E1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCCA16F904
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE562517AF;
	Tue, 29 Apr 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ukj81DER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31A24A07D;
	Tue, 29 Apr 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948425; cv=none; b=YYRrcPhixKYtFE28Y2cr6JaWn9mOinbEDYlBiUuiICufa5lvnA1OoIa9v/5NUUAs8Ld34tPSUSFiu2xgkPC8y4zKhyXoUXznTfjvW2ZhVjtUMvpV/iq9S2Phy1nh27DFfknLGom9x+Fe+aERlwTXaEV+N0u/nOjMMVQl4mVhOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948425; c=relaxed/simple;
	bh=A9lJkmEm3KbdpTXDqQMj4ihzpJ8p+ncigcM3OZ+WF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP7ol4FCYW1ScjqKiWudYt+cD642Mf66C5I8C8E8tS4EbDP+W+nu4BEPkzxMRsyoukWG4FU9KosbAsxP3AWIGk/4b71pVGKGnrN1O+RtH3pCnO5cDtJgG2lgBLf/stS+Rm+vnj6ruyycPlvCl9n+Jh5omc6QzxJcYLsj9WJFOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ukj81DER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBBDC4CEE3;
	Tue, 29 Apr 2025 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948425;
	bh=A9lJkmEm3KbdpTXDqQMj4ihzpJ8p+ncigcM3OZ+WF6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukj81DERLCJXyFAeZtHX9Y/Af5nT/pCcL4tr1Orl2R6Ad9MFXrupZUMgQ9BAru6wG
	 mEH1SjIzVSq4n1kHejvAiOO1rM/ue63KJ6AjZVL4HPzAn2t+H5QRk4Ne5fRMIcPkjS
	 wMy8EfNsxEVyzIm5xvk2e1SsLrrZktnAvAy2bK7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.12 270/280] crypto: lib/Kconfig - Hide arch options from user
Date: Tue, 29 Apr 2025 18:43:31 +0200
Message-ID: <20250429161126.184321833@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 17ec3e71ba797cdb62164fea9532c81b60f47167 upstream.

The ARCH_MAY_HAVE patch missed arm64, mips and s390.  But it may
also lead to arch options being enabled but ineffective because
of modular/built-in conflicts.

As the primary user of all these options wireguard is selecting
the arch options anyway, make the same selections at the lib/crypto
option level and hide the arch options from the user.

Instead of selecting them centrally from lib/crypto, simply set
the default of each arch option as suggested by Eric Biggers.

Change the Crypto API generic algorithms to select the top-level
lib/crypto options instead of the generic one as otherwise there
is no way to enable the arch options (Eric Biggers).  Introduce a
set of INTERNAL options to work around dependency cycles on the
CONFIG_CRYPTO symbol.

Fixes: 1047e21aecdf ("crypto: lib/Kconfig - Fix lib built-in failure when arch is modular")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202502232152.JC84YDLp-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/crypto/Kconfig     |   16 ++++++++++------
 arch/arm64/crypto/Kconfig   |    6 ++++--
 arch/mips/crypto/Kconfig    |    7 +++++--
 arch/powerpc/crypto/Kconfig |   11 +++++++----
 arch/riscv/crypto/Kconfig   |    1 -
 arch/s390/crypto/Kconfig    |    3 ++-
 arch/x86/crypto/Kconfig     |   17 +++++++++++------
 crypto/Kconfig              |    6 +++---
 lib/crypto/Kconfig          |   41 +++++++++++++++++++++--------------------
 9 files changed, 63 insertions(+), 45 deletions(-)

--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
 config CRYPTO_CURVE25519_NEON
-	tristate "Public key crypto: Curve25519 (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -45,9 +47,10 @@ config CRYPTO_NHPOLY1305_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_ARM
-	tristate "Hash functions: Poly1305 (NEON)"
+	tristate
 	select CRYPTO_HASH
-	select CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -212,9 +215,10 @@ config CRYPTO_AES_ARM_CE
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (NEON)"
+	tristate
 	select CRYPTO_SKCIPHER
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -26,10 +26,11 @@ config CRYPTO_NHPOLY1305_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_NEON
-	tristate "Hash functions: Poly1305 (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -186,11 +187,12 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "Ciphers: ChaCha (NEON)"
+	tristate
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -12,9 +12,11 @@ config CRYPTO_CRC32_MIPS
 	  Architecture: mips
 
 config CRYPTO_POLY1305_MIPS
-	tristate "Hash functions: Poly1305"
+	tristate
 	depends on MIPS
+	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
@@ -61,10 +63,11 @@ config CRYPTO_SHA512_OCTEON
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_CHACHA_MIPS
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (MIPS32r2)"
+	tristate
 	depends on CPU_MIPS32_R2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (powerpc)"
 
 config CRYPTO_CURVE25519_PPC64
-	tristate "Public key crypto: Curve25519 (PowerPC64)"
+	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -124,11 +126,12 @@ config CRYPTO_AES_GCM_P10
 	  later CPU. This module supports stitched acceleration for AES/GCM.
 
 config CRYPTO_CHACHA20_P10
-	tristate "Ciphers: ChaCha20, XChacha20, XChacha12 (P10 or later)"
+	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -22,7 +22,6 @@ config CRYPTO_CHACHA_RISCV64
 	tristate "Ciphers: ChaCha"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
 	help
 	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
 
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -120,11 +120,12 @@ config CRYPTO_DES_S390
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_CHACHA_S390
-	tristate "Ciphers: ChaCha20"
+	tristate
 	depends on S390
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving cipher: ChaCha20 stream cipher (RFC 7539)
 
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -3,10 +3,12 @@
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
 config CRYPTO_CURVE25519_X86
-	tristate "Public key crypto: Curve25519 (ADX)"
+	tristate
 	depends on X86 && 64BIT
+	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 algorithm
 
@@ -348,11 +350,12 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	  Processes 64 blocks in parallel.
 
 config CRYPTO_CHACHA20_X86_64
-	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
+	tristate
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	default CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
 	  stream cipher algorithms
@@ -417,10 +420,12 @@ config CRYPTO_POLYVAL_CLMUL_NI
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_POLY1305_X86_64
-	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
+	tristate
 	depends on X86 && 64BIT
+	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
-	select CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	default CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -316,7 +316,7 @@ config CRYPTO_ECRDSA
 config CRYPTO_CURVE25519
 	tristate "Curve25519"
 	select CRYPTO_KPP
-	select CRYPTO_LIB_CURVE25519_GENERIC
+	select CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Curve25519 elliptic curve (RFC7748)
 
@@ -614,7 +614,7 @@ config CRYPTO_ARC4
 
 config CRYPTO_CHACHA20
 	tristate "ChaCha"
-	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_LIB_CHACHA_INTERNAL
 	select CRYPTO_SKCIPHER
 	help
 	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
@@ -943,7 +943,7 @@ config CRYPTO_POLYVAL
 config CRYPTO_POLY1305
 	tristate "Poly1305"
 	select CRYPTO_HASH
-	select CRYPTO_LIB_POLY1305_GENERIC
+	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -48,11 +48,6 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 	  accelerated implementation of the ChaCha library interface,
 	  either builtin or as a module.
 
-config CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA if CRYPTO_LIB_CHACHA=m
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA if CRYPTO_ARCH_MAY_HAVE_LIB_CHACHA=y
-
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
 	select CRYPTO_LIB_UTILS
@@ -63,9 +58,14 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_CHACHA.
 
+config CRYPTO_LIB_CHACHA_INTERNAL
+	tristate
+	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
-	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+	select CRYPTO
+	select CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
@@ -78,13 +78,9 @@ config CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	  accelerated implementation of the Curve25519 library interface,
 	  either builtin or as a module.
 
-config CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519 if CRYPTO_LIB_CURVE25519=m
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519 if CRYPTO_ARCH_MAY_HAVE_LIB_CURVE25519=y
-
 config CRYPTO_LIB_CURVE25519_GENERIC
 	tristate
+	select CRYPTO_LIB_UTILS
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  Curve25519 library interface that require the generic code as a
@@ -92,10 +88,14 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_CURVE25519.
 
+config CRYPTO_LIB_CURVE25519_INTERNAL
+	tristate
+	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
+
 config CRYPTO_LIB_CURVE25519
 	tristate "Curve25519 scalar multiplication library"
-	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
-	select CRYPTO_LIB_UTILS
+	select CRYPTO
+	select CRYPTO_LIB_CURVE25519_INTERNAL
 	help
 	  Enable the Curve25519 library interface. This interface may be
 	  fulfilled by either the generic implementation or an arch-specific
@@ -118,11 +118,6 @@ config CRYPTO_ARCH_HAVE_LIB_POLY1305
 	  accelerated implementation of the Poly1305 library interface,
 	  either builtin or as a module.
 
-config CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305 if CRYPTO_LIB_POLY1305=m
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305 if CRYPTO_ARCH_MAY_HAVE_LIB_POLY1305=y
-
 config CRYPTO_LIB_POLY1305_GENERIC
 	tristate
 	help
@@ -132,9 +127,14 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  implementation is enabled, this implementation serves the users
 	  of CRYPTO_LIB_POLY1305.
 
+config CRYPTO_LIB_POLY1305_INTERNAL
+	tristate
+	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+
 config CRYPTO_LIB_POLY1305
 	tristate "Poly1305 library interface"
-	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+	select CRYPTO
+	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Enable the Poly1305 library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
@@ -142,9 +142,10 @@ config CRYPTO_LIB_POLY1305
 
 config CRYPTO_LIB_CHACHA20POLY1305
 	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
-	depends on CRYPTO
+	select CRYPTO
 	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_POLY1305
+	select CRYPTO_LIB_UTILS
 	select CRYPTO_ALGAPI
 
 config CRYPTO_LIB_SHA1



