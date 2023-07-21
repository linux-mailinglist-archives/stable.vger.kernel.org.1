Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09E975D2A4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGUTCB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGUTCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456A30D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0420561D90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1536EC433C7;
        Fri, 21 Jul 2023 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966117;
        bh=YexaRF/olXnEIEVu9T+Gd6nt3KqBVAEXsnHW965ItiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dcpe5HJf/cbAI90rA8d99+7TeYmi9IlcRsoS6Fp22f6Vjt1En21gDElA+roSWfyBY
         6fSrHWHuLxbSSIkHShwotnBvVLy2i/6Z5kuGroBz4tF8qSnGTrBmHbibhAbHPn5/QP
         A+8tOAOvNxbxp+TJZ0q8OAZ27jKdWBMMMy+/kz8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 231/532] crypto: qat - honor CRYPTO_TFM_REQ_MAY_SLEEP flag
Date:   Fri, 21 Jul 2023 18:02:15 +0200
Message-ID: <20230721160626.907658717@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 8fb203c65a795b96faa1836b5086a5d6eb5c5e99 ]

If a request has the flag CRYPTO_TFM_REQ_MAY_SLEEP set, allocate memory
using the flag GFP_KERNEL otherwise use GFP_ATOMIC.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: eb7713f5ca97 ("crypto: qat - unmap buffer before free for DH")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/qat_algs.c      | 19 ++++++++++++-------
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 17 ++++++++++-------
 drivers/crypto/qat/qat_common/qat_crypto.h    |  5 +++++
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 906082fbdd67b..d36f90628603c 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -706,7 +706,8 @@ static void qat_alg_free_bufl(struct qat_crypto_instance *inst,
 static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 			       struct scatterlist *sgl,
 			       struct scatterlist *sglout,
-			       struct qat_crypto_request *qat_req)
+			       struct qat_crypto_request *qat_req,
+			       gfp_t flags)
 {
 	struct device *dev = &GET_DEV(inst->accel_dev);
 	int i, sg_nctr = 0;
@@ -727,7 +728,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	qat_req->buf.sgl_dst_valid = false;
 
 	if (n > QAT_MAX_BUFF_DESC) {
-		bufl = kzalloc_node(sz, GFP_ATOMIC, node);
+		bufl = kzalloc_node(sz, flags, node);
 		if (unlikely(!bufl))
 			return -ENOMEM;
 	} else {
@@ -771,7 +772,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		sg_nctr = 0;
 
 		if (n > QAT_MAX_BUFF_DESC) {
-			buflout = kzalloc_node(sz_out, GFP_ATOMIC, node);
+			buflout = kzalloc_node(sz_out, flags, node);
 			if (unlikely(!buflout))
 				goto err_in;
 		} else {
@@ -972,6 +973,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	struct icp_qat_fw_la_auth_req_params *auth_param;
 	struct icp_qat_fw_la_bulk_req *msg;
 	int digst_size = crypto_aead_authsize(aead_tfm);
+	gfp_t f = qat_algs_alloc_flags(&areq->base);
 	int ret;
 	u32 cipher_len;
 
@@ -979,7 +981,7 @@ static int qat_alg_aead_dec(struct aead_request *areq)
 	if (cipher_len % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1014,6 +1016,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	struct qat_crypto_request *qat_req = aead_request_ctx(areq);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
 	struct icp_qat_fw_la_auth_req_params *auth_param;
+	gfp_t f = qat_algs_alloc_flags(&areq->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	u8 *iv = areq->iv;
 	int ret;
@@ -1021,7 +1024,7 @@ static int qat_alg_aead_enc(struct aead_request *areq)
 	if (areq->cryptlen % AES_BLOCK_SIZE != 0)
 		return -EINVAL;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, areq->src, areq->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1199,13 +1202,14 @@ static int qat_alg_skcipher_encrypt(struct skcipher_request *req)
 	struct qat_alg_skcipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
+	gfp_t f = qat_algs_alloc_flags(&req->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -1264,13 +1268,14 @@ static int qat_alg_skcipher_decrypt(struct skcipher_request *req)
 	struct qat_alg_skcipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct qat_crypto_request *qat_req = skcipher_request_ctx(req);
 	struct icp_qat_fw_la_cipher_req_params *cipher_param;
+	gfp_t f = qat_algs_alloc_flags(&req->base);
 	struct icp_qat_fw_la_bulk_req *msg;
 	int ret;
 
 	if (req->cryptlen == 0)
 		return 0;
 
-	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req);
+	ret = qat_alg_sgl_to_bufl(ctx->inst, req->src, req->dst, qat_req, f);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 5f11929cf9bac..11c7f2b6e5975 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -224,9 +224,10 @@ static int qat_dh_compute_value(struct kpp_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(kpp_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
-	int ret;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	int n_input_params = 0;
 	u8 *vaddr;
+	int ret;
 
 	if (unlikely(!ctx->xa))
 		return -EINVAL;
@@ -291,7 +292,7 @@ static int qat_dh_compute_value(struct kpp_request *req)
 		} else {
 			int shift = ctx->p_size - req->src_len;
 
-			qat_req->src_align = kzalloc(ctx->p_size, GFP_KERNEL);
+			qat_req->src_align = kzalloc(ctx->p_size, flags);
 			if (unlikely(!qat_req->src_align))
 				return ret;
 
@@ -317,7 +318,7 @@ static int qat_dh_compute_value(struct kpp_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->p_size, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->p_size, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 
@@ -650,6 +651,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	u8 *vaddr;
 	int ret;
 
@@ -696,7 +698,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 	} else {
 		int shift = ctx->key_sz - req->src_len;
 
-		qat_req->src_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->src_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->src_align))
 			return ret;
 
@@ -714,7 +716,7 @@ static int qat_rsa_enc(struct akcipher_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 		vaddr = qat_req->dst_align;
@@ -783,6 +785,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	struct qat_asym_request *qat_req =
 			PTR_ALIGN(akcipher_request_ctx(req), 64);
 	struct icp_qat_fw_pke_request *msg = &qat_req->req;
+	gfp_t flags = qat_algs_alloc_flags(&req->base);
 	u8 *vaddr;
 	int ret;
 
@@ -839,7 +842,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 	} else {
 		int shift = ctx->key_sz - req->src_len;
 
-		qat_req->src_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->src_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->src_align))
 			return ret;
 
@@ -857,7 +860,7 @@ static int qat_rsa_dec(struct akcipher_request *req)
 		qat_req->dst_align = NULL;
 		vaddr = sg_virt(req->dst);
 	} else {
-		qat_req->dst_align = kzalloc(ctx->key_sz, GFP_KERNEL);
+		qat_req->dst_align = kzalloc(ctx->key_sz, flags);
 		if (unlikely(!qat_req->dst_align))
 			goto unmap_src;
 		vaddr = qat_req->dst_align;
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index 245b6d9a36507..df3c738ce323a 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -109,4 +109,9 @@ static inline bool adf_hw_dev_has_crypto(struct adf_accel_dev *accel_dev)
 	return true;
 }
 
+static inline gfp_t qat_algs_alloc_flags(struct crypto_async_request *req)
+{
+	return req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
+}
+
 #endif
-- 
2.39.2



