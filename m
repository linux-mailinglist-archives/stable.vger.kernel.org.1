Return-Path: <stable+bounces-169828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E81B2882D
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6010AC32B7
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D16212B31;
	Fri, 15 Aug 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji9oOLeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743142153C7
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295654; cv=none; b=ZMfyUpycMFI610Rr7zEtdpCsyOc5UfDlm44kgNcGMsh6C8Gr9dkL6gwLn14mmiWeQBLocU7kxYVThZIzxA/lByQowmptJHOosPWHuMev6Zv49mN/XdimvXV1hTlBocJ5Yw8fWWmaDWWjeWYLR1du25ovmrWcXgnlC5hIXUmBrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295654; c=relaxed/simple;
	bh=3kOkmm93Jb9t7jUfHGsq6IRdZFWw/X5L9p0ZbYkfytg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrLbDdvCOPqttMyxyA9sAGIyUn+Qi9Zc5hnK3dexpwh5MCACXOjaUwu71Xt/nhT68EmFBZyyPe+Ue9sGJB55WbpWeWUDF+sajzlanlZTrmFYEY084ksEJDfF/m89j2x6FfKJgLPTY7AX5560BTyMJwPEDGS+7NzeZ+w/rMf0FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji9oOLeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A021C4CEEB;
	Fri, 15 Aug 2025 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295654;
	bh=3kOkmm93Jb9t7jUfHGsq6IRdZFWw/X5L9p0ZbYkfytg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ji9oOLeD1Zo5gXRak9uzzPfIhliJYJwpkFDIjzXeDCrAtsndWjnw9YukpE6SnIziW
	 ivw6dafLHeiYlvnftdpmN28SeT/m+YETQIbOsRKDczKkON6ZhctmJFcctU5JBf96e+
	 k1g9qV/rvlMuOfw0sCov22ZGbeE+iSQFTF5RtRTTqi04fugsA2PSuGK3qBm7LXOaAI
	 2yWW99yr14rQNeXZ8D2a+DBRkgTY3Kj129yV1nqRVhiQIqSEOm/xRDUsm00ErmEijy
	 nAehe6yuEKlj9yiil6OYU/jxtra9L7rX0FzuWV1e+8LFWC3yO1QbnyBstXvAzdD5uO
	 +/u/V1pywrGYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fscrypt: Don't use problematic non-inline crypto engines
Date: Fri, 15 Aug 2025 18:07:29 -0400
Message-ID: <20250815220729.247859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081514-salad-crumpet-f125@gregkh>
References: <2025081514-salad-crumpet-f125@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit b41c1d8d07906786c60893980d52688f31d114a6 ]

Make fscrypt no longer use Crypto API drivers for non-inline crypto
engines, even when the Crypto API prioritizes them over CPU-based code
(which unfortunately it often does).  These drivers tend to be really
problematic, especially for fscrypt's workload.  This commit has no
effect on inline crypto engines, which are different and do work well.

Specifically, exclude drivers that have CRYPTO_ALG_KERN_DRIVER_ONLY or
CRYPTO_ALG_ALLOCATES_MEMORY set.  (Later, CRYPTO_ALG_ASYNC should be
excluded too.  That's omitted for now to keep this commit backportable,
since until recently some CPU-based code had CRYPTO_ALG_ASYNC set.)

There are two major issues with these drivers: bugs and performance.

First, these drivers tend to be buggy.  They're fundamentally much more
error-prone and harder to test than the CPU-based code.  They often
don't get tested before kernel releases, and even if they do, the crypto
self-tests don't properly test these drivers.  Released drivers have
en/decrypted or hashed data incorrectly.  These bugs cause issues for
fscrypt users who often didn't even want to use these drivers, e.g.:

- https://github.com/google/fscryptctl/issues/32
- https://github.com/google/fscryptctl/issues/9
- https://lore.kernel.org/r/PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com

These drivers have also similarly caused issues for dm-crypt users,
including data corruption and deadlocks.  Since Linux v5.10, dm-crypt
has disabled most of them by excluding CRYPTO_ALG_ALLOCATES_MEMORY.

Second, these drivers tend to be *much* slower than the CPU-based code.
This may seem counterintuitive, but benchmarks clearly show it.  There's
a *lot* of overhead associated with going to a hardware driver, off the
CPU, and back again.  To prove this, I gathered as many systems with
this type of crypto engine as I could, and I measured synchronous
encryption of 4096-byte messages (which matches fscrypt's workload):

Intel Emerald Rapids server:
   AES-256-XTS:
      xts-aes-vaes-avx512   16171 MB/s  [CPU-based, Vector AES]
      qat_aes_xts             289 MB/s  [Offload, Intel QuickAssist]

Qualcomm SM8650 HDK:
   AES-256-XTS:
      xts-aes-ce             4301 MB/s  [CPU-based, ARMv8 Crypto Extensions]
      xts-aes-qce              73 MB/s  [Offload, Qualcomm Crypto Engine]

i.MX 8M Nano LPDDR4 EVK:
   AES-256-XTS:
      xts-aes-ce              647 MB/s   [CPU-based, ARMv8 Crypto Extensions]
      xts(ecb-aes-caam)        20 MB/s   [Offload, CAAM]
   AES-128-CBC-ESSIV:
      essiv(cbc-aes-caam,sha256-lib) 23 MB/s   [Offload, CAAM]

STM32MP157F-DK2:
   AES-256-XTS:
      xts-aes-neonbs         13.2 MB/s   [CPU-based, ARM NEON]
      xts(stm32-ecb-aes)     3.1 MB/s    [Offload, STM32 crypto engine]
   AES-128-CBC-ESSIV:
      essiv(cbc-aes-neonbs,sha256-lib)
                             14.7 MB/s   [CPU-based, ARM NEON]
      essiv(stm32-cbc-aes,sha256-lib)
                             3.2 MB/s    [Offload, STM32 crypto engine]
   Adiantum:
      adiantum(xchacha12-arm,aes-arm,nhpoly1305-neon)
                             52.8 MB/s   [CPU-based, ARM scalar + NEON]

So, there was no case in which the crypto engine was even *close* to
being faster.  On the first three, which have AES instructions in the
CPU, the CPU was 30 to 55 times faster (!).  Even on STM32MP157F-DK2
which has a Cortex-A7 CPU that doesn't have AES instructions, AES was
over 4 times faster on the CPU.  And Adiantum encryption, which is what
actually should be used on CPUs like that, was over 17 times faster.

Other justifications that have been given for these non-inline crypto
engines (almost always coming from the hardware vendors, not actual
users) don't seem very plausible either:

  - The crypto engine throughput could be improved by processing
    multiple requests concurrently.  Currently irrelevant to fscrypt,
    since it doesn't do that.  This would also be complex, and unhelpful
    in many cases.  2 of the 4 engines I tested even had only one queue.

  - Some of the engines, e.g. STM32, support hardware keys.  Also
    currently irrelevant to fscrypt, since it doesn't support these.
    Interestingly, the STM32 driver itself doesn't support this either.

  - Free up CPU for other tasks and/or reduce energy usage.  Not very
    plausible considering the "short" message length, driver overhead,
    and scheduling overhead.  There's just very little time for the CPU
    to do something else like run another task or enter low-power state,
    before the message finishes and it's time to process the next one.

  - Some of these engines resist power analysis and electromagnetic
    attacks, while the CPU-based crypto generally does not.  In theory,
    this sounds great.  In practice, if this benefit requires the use of
    an off-CPU offload that massively regresses performance and has a
    low-quality, buggy driver, the price for this hardening (which is
    not relevant to most fscrypt users, and tends to be incomplete) is
    just too high.  Inline crypto engines are much more promising here,
    as are on-CPU solutions like RISC-V High Assurance Cryptography.

Fixes: b30ab0e03407 ("ext4 crypto: add ext4 encryption facilities")
Cc: stable@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250704070322.20692-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
[ Drop some documentation changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/crypto/fscrypt_private.h | 17 +++++++++++++++++
 fs/crypto/hkdf.c            |  2 +-
 fs/crypto/keysetup.c        |  3 ++-
 fs/crypto/keysetup_v1.c     |  3 ++-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index d5f68a0c5d15..88414cbd97ae 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -27,6 +27,23 @@
  */
 #define FSCRYPT_MIN_KEY_SIZE	16
 
+/*
+ * This mask is passed as the third argument to the crypto_alloc_*() functions
+ * to prevent fscrypt from using the Crypto API drivers for non-inline crypto
+ * engines.  Those drivers have been problematic for fscrypt.  fscrypt users
+ * have reported hangs and even incorrect en/decryption with these drivers.
+ * Since going to the driver, off CPU, and back again is really slow, such
+ * drivers can be over 50 times slower than the CPU-based code for fscrypt's
+ * workload.  Even on platforms that lack AES instructions on the CPU, using the
+ * offloads has been shown to be slower, even staying with AES.  (Of course,
+ * Adiantum is faster still, and is the recommended option on such platforms...)
+ *
+ * Note that fscrypt also supports inline crypto engines.  Those don't use the
+ * Crypto API and work much better than the old-style (non-inline) engines.
+ */
+#define FSCRYPT_CRYPTOAPI_MASK \
+	(CRYPTO_ALG_ALLOCATES_MEMORY | CRYPTO_ALG_KERN_DRIVER_ONLY)
+
 #define FSCRYPT_CONTEXT_V1	1
 #define FSCRYPT_CONTEXT_V2	2
 
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 7607d18b35fc..8cc611896c32 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -72,7 +72,7 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 	u8 prk[HKDF_HASHLEN];
 	int err;
 
-	hmac_tfm = crypto_alloc_shash(HKDF_HMAC_ALG, 0, 0);
+	hmac_tfm = crypto_alloc_shash(HKDF_HMAC_ALG, 0, FSCRYPT_CRYPTOAPI_MASK);
 	if (IS_ERR(hmac_tfm)) {
 		fscrypt_err(NULL, "Error allocating " HKDF_HMAC_ALG ": %ld",
 			    PTR_ERR(hmac_tfm));
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f7407071a952..94ad0024c529 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -88,7 +88,8 @@ fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 	struct crypto_skcipher *tfm;
 	int err;
 
-	tfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
+	tfm = crypto_alloc_skcipher(mode->cipher_str, 0,
+				    FSCRYPT_CRYPTOAPI_MASK);
 	if (IS_ERR(tfm)) {
 		if (PTR_ERR(tfm) == -ENOENT) {
 			fscrypt_warn(inode,
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9..159dd0288349 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -52,7 +52,8 @@ static int derive_key_aes(const u8 *master_key,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
-	struct crypto_skcipher *tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
+	struct crypto_skcipher *tfm =
+		crypto_alloc_skcipher("ecb(aes)", 0, FSCRYPT_CRYPTOAPI_MASK);
 
 	if (IS_ERR(tfm)) {
 		res = PTR_ERR(tfm);
-- 
2.50.1


