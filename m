Return-Path: <stable+bounces-130096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF69A80308
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059AE422FD4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E6268C79;
	Tue,  8 Apr 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U4H6Mfmo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BB1AAA0F;
	Tue,  8 Apr 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112806; cv=none; b=RgQ3oz8uvgvXfaLI0D/pHak36u8NaLMgP1E/EMSTaFUMNbbSVmotgL59je6f/lRoxbqwvIls2ojyiTWY3M+SbaottRj3ptAXz11Gx1qiTjk+FKmEyHfNQvrvPaSd4gy3yJwGsuSPCXJT4xH4u6InMjcebobJrakq4hjiD5OChGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112806; c=relaxed/simple;
	bh=yv70Qbqp/JMBSzXVAkuBkftVd72BD2awjQelNfroh2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h95SLizEL3XvsUEOh1OLDPGrNNPCJd8AbuvifobDpI1zEI3RkdAvzrVARceBybCd480PjZ+3d8sbcA+TMH0LJnUqX0tFVXiq1Bxdr0/XSuMLpgXb2x0IkaMfqWgNirsHNkvr4EwbLOTeIvQMVNYVNX5UPTJ+sMamlqfDTxcoC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U4H6Mfmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0292DC4CEE5;
	Tue,  8 Apr 2025 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112806;
	bh=yv70Qbqp/JMBSzXVAkuBkftVd72BD2awjQelNfroh2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4H6Mfmou+UOolObWVOxYqcZ0g69ad5oaQ1xtq5/CCzS04CqVFZkec0pf0GuVtL4q
	 Ocpyu9WIAeZdluP/raf3bu/FSZgjJWIthGThJfmlyoBm5QBWQHVfoas8HSnIiLxNUj
	 SSAgpuK7ntYqRdIgnM/hQqV0SKJJZVoLrntqljgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 167/279] crypto: hisilicon/sec2 - fix for aead authsize alignment
Date: Tue,  8 Apr 2025 12:49:10 +0200
Message-ID: <20250408104830.837614981@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenkai Lin <linwenkai6@hisilicon.com>

[ Upstream commit a49cc71e219040d771a8c1254879984f98192811 ]

The hardware only supports authentication sizes
that are 4-byte aligned. Therefore, the driver
switches to software computation in this case.

Fixes: 2f072d75d1ab ("crypto: hisilicon - Add aead support on SEC2")
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 32150e05a2795..6de3ccd0fa9b7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -55,7 +55,6 @@
 #define SEC_TYPE_MASK		0x0F
 #define SEC_DONE_MASK		0x0001
 #define SEC_ICV_MASK		0x000E
-#define SEC_SQE_LEN_RATE_MASK	0x3
 
 #define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
 #define SEC_SGL_SGE_NR		128
@@ -77,16 +76,16 @@
 #define SEC_TOTAL_PBUF_SZ	(PAGE_SIZE * SEC_PBUF_PAGE_NUM +	\
 			SEC_PBUF_LEFT_SZ)
 
-#define SEC_SQE_LEN_RATE	4
 #define SEC_SQE_CFLAG		2
 #define SEC_SQE_AEAD_FLAG	3
 #define SEC_SQE_DONE		0x1
 #define SEC_ICV_ERR		0x2
-#define MIN_MAC_LEN		4
 #define MAC_LEN_MASK		0x1U
 #define MAX_INPUT_DATA_LEN	0xFFFE00
 #define BITS_MASK		0xFF
+#define WORD_MASK		0x3
 #define BYTE_BITS		0x8
+#define BYTES_TO_WORDS(bcount)	((bcount) >> 2)
 #define SEC_XTS_NAME_SZ		0x3
 #define IV_CM_CAL_NUM		2
 #define IV_CL_MASK		0x7
@@ -1133,7 +1132,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
-	if (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK) {
+	if (ctx->a_ctx.a_key_len & WORD_MASK) {
 		ret = -EINVAL;
 		dev_err(dev, "AUTH key length error!\n");
 		goto bad_key;
@@ -1538,11 +1537,10 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
 
 	sec_sqe->type2.a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
-	sec_sqe->type2.mac_key_alg = cpu_to_le32(authsize / SEC_SQE_LEN_RATE);
+	sec_sqe->type2.mac_key_alg = cpu_to_le32(BYTES_TO_WORDS(authsize));
 
 	sec_sqe->type2.mac_key_alg |=
-			cpu_to_le32((u32)((ctx->a_key_len) /
-			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET);
+			cpu_to_le32((u32)BYTES_TO_WORDS(ctx->a_key_len) << SEC_AKEY_OFFSET);
 
 	sec_sqe->type2.mac_key_alg |=
 			cpu_to_le32((u32)(ctx->a_alg) << SEC_AEAD_ALG_OFFSET);
@@ -1594,12 +1592,10 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
 	sqe3->a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(authsize /
-			SEC_SQE_LEN_RATE) << SEC_MAC_OFFSET_V3);
+			cpu_to_le32(BYTES_TO_WORDS(authsize) << SEC_MAC_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(ctx->a_key_len /
-			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET_V3);
+			cpu_to_le32((u32)BYTES_TO_WORDS(ctx->a_key_len) << SEC_AKEY_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
 			cpu_to_le32((u32)(ctx->a_alg) << SEC_AUTH_ALG_OFFSET_V3);
@@ -2205,8 +2201,8 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	struct device *dev = ctx->dev;
 	int ret;
 
-	/* Hardware does not handle cases where authsize is less than 4 bytes */
-	if (unlikely(sz < MIN_MAC_LEN)) {
+	/* Hardware does not handle cases where authsize is not 4 bytes aligned */
+	if (c_mode == SEC_CMODE_CBC && (sz & WORD_MASK)) {
 		sreq->aead_req.fallback = true;
 		return -EINVAL;
 	}
-- 
2.39.5




