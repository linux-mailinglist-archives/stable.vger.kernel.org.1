Return-Path: <stable+bounces-82731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979AC994E3A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4411C252CC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F91DF745;
	Tue,  8 Oct 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I97xxGkg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F781DF730;
	Tue,  8 Oct 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393234; cv=none; b=HQ4qg4fHqf1IbW+qTDEumZ8r1AgzVchwbUZkZUeQfJIWqVnM63bdxU0SuFZbaL/AIGL+SuLAt8b/hTy4MrjVgqHUNUFlgDnfQKJFh+q55EUQivmpJD+K6XySHN8aIUWNeOq0t2++Mm61CkyqmNFsURseCQKretX6ElJXY55KDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393234; c=relaxed/simple;
	bh=ttwwgoYWEhQ2PAhQHOOr/sCd4A7A7RY5WK0aai/CWrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR7w/oy4kk/z4anDqYqiPZQNV32ho2PgkkM6VMLvkkbELT3q19oIKr8TfgQSbvXRIBvSXHTEa7a1TkiC6ONLu+Ekv3R0tCvy96LiFzF3ZS8h9WEVc9A+UW95UbuMTmHiKK2c5+edLAuyg0OFaRrkeezCeigTNHRRg+uBQbB7QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I97xxGkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCB9C4CEC7;
	Tue,  8 Oct 2024 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393234;
	bh=ttwwgoYWEhQ2PAhQHOOr/sCd4A7A7RY5WK0aai/CWrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I97xxGkgAvXAMq2j6fsjB0lBRy0kQ/4KyuJc/c6QJaB0W3xMcHPKb7oBC4HsN4BSg
	 oiohZNdFD0ZHqxsUd1dFEPVcshXEYQw9iQEMFPLJllDYLX0Bl9B/D/8uJsuh5S+hb5
	 wplTO06Omrdc1UR6LiY/DzytTcbLEADp9kAmChGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/386] crypto: octeontx2 - Fix authenc setkey
Date: Tue,  8 Oct 2024 14:05:06 +0200
Message-ID: <20241008115631.869666179@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 7ccb750dcac8abbfc7743aab0db6a72c1c3703c7 ]

Use the generic crypto_authenc_extractkeys helper instead of custom
parsing code that is slightly broken.  Also fix a number of memory
leaks by moving memory allocation from setkey to init_tfm (setkey
can be called multiple times over the life of a tfm).

Finally accept all hash key lengths by running the digest over
extra-long keys.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/otx2_cptvf_algs.c       | 254 +++++++-----------
 1 file changed, 90 insertions(+), 164 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index e27ddd3c4e558..4385d3df52b4d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -11,7 +11,6 @@
 #include <crypto/xts.h>
 #include <crypto/gcm.h>
 #include <crypto/scatterwalk.h>
-#include <linux/rtnetlink.h>
 #include <linux/sort.h>
 #include <linux/module.h>
 #include "otx2_cptvf.h"
@@ -54,6 +53,8 @@ static struct cpt_device_table se_devices = {
 	.count = ATOMIC_INIT(0)
 };
 
+static struct otx2_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg);
+
 static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
 {
 	int count;
@@ -580,40 +581,56 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
 
+	switch (ctx->mac_type) {
+	case OTX2_CPT_SHA1:
+		ctx->hashalg = crypto_alloc_shash("sha1", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA256:
+		ctx->hashalg = crypto_alloc_shash("sha256", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA384:
+		ctx->hashalg = crypto_alloc_shash("sha384", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA512:
+		ctx->hashalg = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	}
+
+	if (IS_ERR(ctx->hashalg))
+		return PTR_ERR(ctx->hashalg);
+
+	if (ctx->hashalg) {
+		ctx->sdesc = alloc_sdesc(ctx->hashalg);
+		if (!ctx->sdesc) {
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
+	}
+
 	/*
 	 * When selected cipher is NULL we use HMAC opcode instead of
 	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
 	 * for calculating ipad and opad
 	 */
-	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL) {
-		switch (ctx->mac_type) {
-		case OTX2_CPT_SHA1:
-			ctx->hashalg = crypto_alloc_shash("sha1", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
-
-		case OTX2_CPT_SHA256:
-			ctx->hashalg = crypto_alloc_shash("sha256", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL && ctx->hashalg) {
+		int ss = crypto_shash_statesize(ctx->hashalg);
 
-		case OTX2_CPT_SHA384:
-			ctx->hashalg = crypto_alloc_shash("sha384", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->ipad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->ipad) {
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
 
-		case OTX2_CPT_SHA512:
-			ctx->hashalg = crypto_alloc_shash("sha512", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->opad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->opad) {
+			kfree(ctx->ipad);
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
 		}
 	}
 	switch (ctx->cipher_type) {
@@ -686,8 +703,7 @@ static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
-	if (ctx->hashalg)
-		crypto_free_shash(ctx->hashalg);
+	crypto_free_shash(ctx->hashalg);
 	kfree(ctx->sdesc);
 
 	if (ctx->fbk_cipher) {
@@ -760,7 +776,7 @@ static inline void swap_data64(void *buf, u32 len)
 		cpu_to_be64s(src);
 }
 
-static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+static int swap_pad(u8 mac_type, u8 *pad)
 {
 	struct sha512_state *sha512;
 	struct sha256_state *sha256;
@@ -768,22 +784,19 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 	switch (mac_type) {
 	case OTX2_CPT_SHA1:
-		sha1 = (struct sha1_state *) in_pad;
+		sha1 = (struct sha1_state *)pad;
 		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
-		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA256:
-		sha256 = (struct sha256_state *) in_pad;
+		sha256 = (struct sha256_state *)pad;
 		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
-		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA384:
 	case OTX2_CPT_SHA512:
-		sha512 = (struct sha512_state *) in_pad;
+		sha512 = (struct sha512_state *)pad;
 		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
-		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
 		break;
 
 	default:
@@ -793,55 +806,54 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 	return 0;
 }
 
-static int aead_hmac_init(struct crypto_aead *cipher)
+static int aead_hmac_init(struct crypto_aead *cipher,
+			  struct crypto_authenc_keys *keys)
 {
 	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
-	int authkeylen = ctx->auth_key_len;
+	int authkeylen = keys->authkeylen;
 	u8 *ipad = NULL, *opad = NULL;
-	int ret = 0, icount = 0;
+	int icount = 0;
+	int ret;
 
-	ctx->sdesc = alloc_sdesc(ctx->hashalg);
-	if (!ctx->sdesc)
-		return -ENOMEM;
+	if (authkeylen > bs) {
+		ret = crypto_shash_digest(&ctx->sdesc->shash, keys->authkey,
+					  authkeylen, ctx->key);
+		if (ret)
+			goto calc_fail;
 
-	ctx->ipad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+		authkeylen = ds;
+	} else
+		memcpy(ctx->key, keys->authkey, authkeylen);
 
-	ctx->opad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	ctx->enc_key_len = keys->enckeylen;
+	ctx->auth_key_len = authkeylen;
 
-	ipad = kzalloc(state_size, GFP_KERNEL);
-	if (!ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	if (ctx->cipher_type == OTX2_CPT_CIPHER_NULL)
+		return keys->enckeylen ? -EINVAL : 0;
 
-	opad = kzalloc(state_size, GFP_KERNEL);
-	if (!opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX2_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX2_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX2_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		return -EINVAL;
 	}
 
-	if (authkeylen > bs) {
-		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
-					  authkeylen, ipad);
-		if (ret)
-			goto calc_fail;
+	memcpy(ctx->key + authkeylen, keys->enckey, keys->enckeylen);
 
-		authkeylen = ds;
-	} else {
-		memcpy(ipad, ctx->key, authkeylen);
-	}
+	ipad = ctx->ipad;
+	opad = ctx->opad;
 
+	memcpy(ipad, ctx->key, authkeylen);
 	memset(ipad + authkeylen, 0, bs - authkeylen);
 	memcpy(opad, ipad, bs);
 
@@ -859,7 +871,7 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, ipad);
-	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	ret = swap_pad(ctx->mac_type, ipad);
 	if (ret)
 		goto calc_fail;
 
@@ -867,25 +879,9 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, opad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, opad);
-	ret = copy_pad(ctx->mac_type, ctx->opad, opad);
-	if (ret)
-		goto calc_fail;
-
-	kfree(ipad);
-	kfree(opad);
-
-	return 0;
+	ret = swap_pad(ctx->mac_type, opad);
 
 calc_fail:
-	kfree(ctx->ipad);
-	ctx->ipad = NULL;
-	kfree(ctx->opad);
-	ctx->opad = NULL;
-	kfree(ipad);
-	kfree(opad);
-	kfree(ctx->sdesc);
-	ctx->sdesc = NULL;
-
 	return ret;
 }
 
@@ -893,87 +889,17 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	int enckeylen = 0, authkeylen = 0;
-	struct rtattr *rta = (void *)key;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
+	struct crypto_authenc_keys authenc_keys;
 
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (keylen < enckeylen)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	authkeylen = keylen - enckeylen;
-	memcpy(ctx->key, key, keylen);
-
-	switch (enckeylen) {
-	case AES_KEYSIZE_128:
-		ctx->key_type = OTX2_CPT_AES_128_BIT;
-		break;
-	case AES_KEYSIZE_192:
-		ctx->key_type = OTX2_CPT_AES_192_BIT;
-		break;
-	case AES_KEYSIZE_256:
-		ctx->key_type = OTX2_CPT_AES_256_BIT;
-		break;
-	default:
-		/* Invalid key length */
-		return -EINVAL;
-	}
-
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = authkeylen;
-
-	return aead_hmac_init(cipher);
+	return crypto_authenc_extractkeys(&authenc_keys, key, keylen) ?:
+	       aead_hmac_init(cipher, &authenc_keys);
 }
 
 static int otx2_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					     const unsigned char *key,
 					     unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	struct rtattr *rta = (void *)key;
-	int enckeylen = 0;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (enckeylen != 0)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	memcpy(ctx->key, key, keylen);
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = keylen;
-
-	return 0;
+	return otx2_cpt_aead_cbc_aes_sha_setkey(cipher, key, keylen);
 }
 
 static int otx2_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
-- 
2.43.0




