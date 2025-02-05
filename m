Return-Path: <stable+bounces-113349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3AA291CF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579693AB335
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C97186E56;
	Wed,  5 Feb 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDgvXyh8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5C1DB153;
	Wed,  5 Feb 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766659; cv=none; b=h9siW6qOIgzaaizQ+50Ah6NMferpjc06bk9pMyVQD54sJcyMUc1BE0jV5sT9wZb6pH9HLhIIcn7Cw6n5a5C2VkZzxrb1mzSrrkVvKNpAuQZblwcuNuflyE69jiIGkwjzY8My1qIXPn2JydJZgdz4tmN9je8J5zdSFzdwsjS44VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766659; c=relaxed/simple;
	bh=Cs6QK/6H3yMWPw8rqiEtDgeyp6/GxDlB8Za7py+69CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB5PtAkSshLoaCQVE+Vr0yP3Ychg72qygV0xgUvZirv93rMwDbO7paBkRct0ZSADEmPo8f6KnUvqg9v1NK1lmLQQH0fgmXTq/Kczc8vz1LWfUsIIrGksCSFYf3i9LLzBaAMzT44ScXa3Nzvmdpp/Fh5GGz2o/EMb/8KSttpAi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDgvXyh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A0C4CEDD;
	Wed,  5 Feb 2025 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766658;
	bh=Cs6QK/6H3yMWPw8rqiEtDgeyp6/GxDlB8Za7py+69CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDgvXyh8F/d+r+yTElOPzmCldzAAAcIhFAWkoWAbZCUer6R6wo0gm3rCLVGVtPe6V
	 bO1rzP3cd0ErsdXUBFETaoAXWGrC7wjVKrK/7bF+oR+FejWb159M8AW8VYW7vygxVM
	 LMpsHogx6hvZMMUIjey/QdxTO9kzUx8D7/1VR9lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 277/623] crypto: hisilicon/sec2 - fix for aead icv error
Date: Wed,  5 Feb 2025 14:40:19 +0100
Message-ID: <20250205134506.828074500@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

From: Wenkai Lin <linwenkai6@hisilicon.com>

[ Upstream commit fd337f852b2677b53d0859a47b58e6e6bd189f30 ]

When the AEAD algorithm is used for encryption or decryption,
the input authentication length varies, the hardware needs to
obtain the input length to pass the integrity check verification.
Currently, the driver uses a fixed authentication length,which
causes decryption failure, so the length configuration is modified.
In addition, the step of setting the auth length is unnecessary,
so it was deleted from the setkey function.

Fixes: 2f072d75d1ab ("crypto: hisilicon - Add aead support on SEC2")
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec2/sec.h        |   1 -
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 101 +++++++++------------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  11 ---
 3 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 356188bee6fbc..70c3bdedb6baf 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -90,7 +90,6 @@ struct sec_auth_ctx {
 	dma_addr_t a_key_dma;
 	u8 *a_key;
 	u8 a_key_len;
-	u8 mac_len;
 	u8 a_alg;
 	bool fallback;
 	struct crypto_shash *hash_tfm;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index ae9ebbb4103d4..8db995279545c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -948,15 +948,14 @@ static int sec_aead_mac_init(struct sec_aead_req *req)
 	struct aead_request *aead_req = req->aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
 	size_t authsize = crypto_aead_authsize(tfm);
-	u8 *mac_out = req->out_mac;
 	struct scatterlist *sgl = aead_req->src;
+	u8 *mac_out = req->out_mac;
 	size_t copy_size;
 	off_t skip_size;
 
 	/* Copy input mac */
 	skip_size = aead_req->assoclen + aead_req->cryptlen - authsize;
-	copy_size = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac_out,
-				       authsize, skip_size);
+	copy_size = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac_out, authsize, skip_size);
 	if (unlikely(copy_size != authsize))
 		return -EINVAL;
 
@@ -1139,7 +1138,6 @@ static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
 static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 			   const u32 keylen, const enum sec_hash_alg a_alg,
 			   const enum sec_calg c_alg,
-			   const enum sec_mac_len mac_len,
 			   const enum sec_cmode c_mode)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
@@ -1151,7 +1149,6 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	ctx->a_ctx.a_alg = a_alg;
 	ctx->c_ctx.c_alg = c_alg;
-	ctx->a_ctx.mac_len = mac_len;
 	c_ctx->c_mode = c_mode;
 
 	if (c_mode == SEC_CMODE_CCM || c_mode == SEC_CMODE_GCM) {
@@ -1187,10 +1184,9 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
-	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
-	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
+	if (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK) {
 		ret = -EINVAL;
-		dev_err(dev, "MAC or AUTH key length error!\n");
+		dev_err(dev, "AUTH key length error!\n");
 		goto bad_key;
 	}
 
@@ -1202,27 +1198,19 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 }
 
 
-#define GEN_SEC_AEAD_SETKEY_FUNC(name, aalg, calg, maclen, cmode)	\
-static int sec_setkey_##name(struct crypto_aead *tfm, const u8 *key,	\
-	u32 keylen)							\
-{									\
-	return sec_aead_setkey(tfm, key, keylen, aalg, calg, maclen, cmode);\
-}
-
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha1, SEC_A_HMAC_SHA1,
-			 SEC_CALG_AES, SEC_HMAC_SHA1_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256,
-			 SEC_CALG_AES, SEC_HMAC_SHA256_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512,
-			 SEC_CALG_AES, SEC_HMAC_SHA512_MAC, SEC_CMODE_CBC)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_ccm, 0, SEC_CALG_AES,
-			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
-GEN_SEC_AEAD_SETKEY_FUNC(aes_gcm, 0, SEC_CALG_AES,
-			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
-GEN_SEC_AEAD_SETKEY_FUNC(sm4_ccm, 0, SEC_CALG_SM4,
-			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
-GEN_SEC_AEAD_SETKEY_FUNC(sm4_gcm, 0, SEC_CALG_SM4,
-			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
+#define GEN_SEC_AEAD_SETKEY_FUNC(name, aalg, calg, cmode)				\
+static int sec_setkey_##name(struct crypto_aead *tfm, const u8 *key, u32 keylen)	\
+{											\
+	return sec_aead_setkey(tfm, key, keylen, aalg, calg, cmode);			\
+}
+
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha1, SEC_A_HMAC_SHA1, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512, SEC_CALG_AES, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_ccm, 0, SEC_CALG_AES, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_gcm, 0, SEC_CALG_AES, SEC_CMODE_GCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_ccm, 0, SEC_CALG_SM4, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_gcm, 0, SEC_CALG_SM4, SEC_CMODE_GCM)
 
 static int sec_aead_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
 {
@@ -1470,9 +1458,10 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct sec_cipher_req *c_req = &req->c_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_aead_req *a_req = &req->aead_req;
-	size_t authsize = ctx->a_ctx.mac_len;
+	struct sec_cipher_req *c_req = &req->c_req;
 	u32 data_size = aead_req->cryptlen;
 	u8 flage = 0;
 	u8 cm, cl;
@@ -1513,10 +1502,8 @@ static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
-	size_t authsize = crypto_aead_authsize(tfm);
-	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_aead_req *a_req = &req->aead_req;
+	struct sec_cipher_req *c_req = &req->c_req;
 
 	memcpy(c_req->c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
 
@@ -1524,15 +1511,11 @@ static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
 		/*
 		 * CCM 16Byte Cipher_IV: {1B_Flage,13B_IV,2B_counter},
 		 * the  counter must set to 0x01
+		 * CCM 16Byte Auth_IV: {1B_AFlage,13B_IV,2B_Ptext_length}
 		 */
-		ctx->a_ctx.mac_len = authsize;
-		/* CCM 16Byte Auth_IV: {1B_AFlage,13B_IV,2B_Ptext_length} */
 		set_aead_auth_iv(ctx, req);
-	}
-
-	/* GCM 12Byte Cipher_IV == Auth_IV */
-	if (ctx->c_ctx.c_mode == SEC_CMODE_GCM) {
-		ctx->a_ctx.mac_len = authsize;
+	} else if (ctx->c_ctx.c_mode == SEC_CMODE_GCM) {
+		/* GCM 12Byte Cipher_IV == Auth_IV */
 		memcpy(a_req->a_ivin, c_req->c_ivin, SEC_AIV_SIZE);
 	}
 }
@@ -1542,9 +1525,11 @@ static void sec_auth_bd_fill_xcm(struct sec_auth_ctx *ctx, int dir,
 {
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
-	sec_sqe->type2.icvw_kmode |= cpu_to_le16((u16)ctx->mac_len);
+	sec_sqe->type2.icvw_kmode |= cpu_to_le16((u16)authsize);
 
 	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
 	sec_sqe->type2.a_key_addr = sec_sqe->type2.c_key_addr;
@@ -1568,9 +1553,11 @@ static void sec_auth_bd_fill_xcm_v3(struct sec_auth_ctx *ctx, int dir,
 {
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
-	sqe3->c_icv_key |= cpu_to_le16((u16)ctx->mac_len << SEC_MAC_OFFSET_V3);
+	sqe3->c_icv_key |= cpu_to_le16((u16)authsize << SEC_MAC_OFFSET_V3);
 
 	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
 	sqe3->a_key_addr = sqe3->c_key_addr;
@@ -1594,11 +1581,12 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	sec_sqe->type2.a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
-	sec_sqe->type2.mac_key_alg =
-			cpu_to_le32(ctx->mac_len / SEC_SQE_LEN_RATE);
+	sec_sqe->type2.mac_key_alg = cpu_to_le32(authsize / SEC_SQE_LEN_RATE);
 
 	sec_sqe->type2.mac_key_alg |=
 			cpu_to_le32((u32)((ctx->a_key_len) /
@@ -1648,11 +1636,13 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct aead_request *aq = a_req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aq);
+	size_t authsize = crypto_aead_authsize(tfm);
 
 	sqe3->a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(ctx->mac_len /
+			cpu_to_le32((u32)(authsize /
 			SEC_SQE_LEN_RATE) << SEC_MAC_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
@@ -1703,9 +1693,9 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 {
 	struct aead_request *a_req = req->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
+	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_aead_req *aead_req = &req->aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
-	size_t authsize = crypto_aead_authsize(tfm);
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
 	struct aead_request *backlog_aead_req;
 	struct sec_req *backlog_req;
@@ -1718,10 +1708,8 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 	if (!err && c_req->encrypt) {
 		struct scatterlist *sgl = a_req->dst;
 
-		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl),
-					  aead_req->out_mac,
-					  authsize, a_req->cryptlen +
-					  a_req->assoclen);
+		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl), aead_req->out_mac,
+					  authsize, a_req->cryptlen + a_req->assoclen);
 		if (unlikely(sz != authsize)) {
 			dev_err(c->dev, "copy out mac err!\n");
 			err = -EINVAL;
@@ -2233,7 +2221,7 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	struct aead_request *req = sreq->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	size_t authsize = crypto_aead_authsize(tfm);
+	size_t sz = crypto_aead_authsize(tfm);
 	u8 c_mode = ctx->c_ctx.c_mode;
 	struct device *dev = ctx->dev;
 	int ret;
@@ -2244,9 +2232,8 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		return -EINVAL;
 	}
 
-	if (unlikely((c_mode == SEC_CMODE_GCM && authsize < DES_BLOCK_SIZE) ||
-	   (c_mode == SEC_CMODE_CCM && (authsize < MIN_MAC_LEN ||
-		authsize & MAC_LEN_MASK)))) {
+	if (unlikely((c_mode == SEC_CMODE_GCM && sz < DES_BLOCK_SIZE) ||
+		     (c_mode == SEC_CMODE_CCM && (sz < MIN_MAC_LEN || sz & MAC_LEN_MASK)))) {
 		dev_err(dev, "aead input mac length error!\n");
 		return -EINVAL;
 	}
@@ -2266,7 +2253,7 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (sreq->c_req.encrypt)
 		sreq->c_req.c_len = req->cryptlen;
 	else
-		sreq->c_req.c_len = req->cryptlen - authsize;
+		sreq->c_req.c_len = req->cryptlen - sz;
 	if (c_mode == SEC_CMODE_CBC) {
 		if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
 			dev_err(dev, "aead crypto length error!\n");
@@ -2292,7 +2279,7 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
-		    req->cryptlen <= authsize))) {
+			     req->cryptlen <= authsize))) {
 			ctx->a_ctx.fallback = true;
 			return -EINVAL;
 		}
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 27a0ee5ad9131..04725b514382f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -23,17 +23,6 @@ enum sec_hash_alg {
 	SEC_A_HMAC_SHA512 = 0x15,
 };
 
-enum sec_mac_len {
-	SEC_HMAC_CCM_MAC   = 16,
-	SEC_HMAC_GCM_MAC   = 16,
-	SEC_SM3_MAC        = 32,
-	SEC_HMAC_SM3_MAC   = 32,
-	SEC_HMAC_MD5_MAC   = 16,
-	SEC_HMAC_SHA1_MAC   = 20,
-	SEC_HMAC_SHA256_MAC = 32,
-	SEC_HMAC_SHA512_MAC = 64,
-};
-
 enum sec_cmode {
 	SEC_CMODE_ECB    = 0x0,
 	SEC_CMODE_CBC    = 0x1,
-- 
2.39.5




