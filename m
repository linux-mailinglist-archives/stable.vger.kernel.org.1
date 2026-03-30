Return-Path: <stable+bounces-231051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH6WAfs8ymnD6gUAu9opvQ
	(envelope-from <stable+bounces-231051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A061357C45
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F9043017251
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8513AA4F0;
	Mon, 30 Mar 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zm9ac+xm"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3E37F749
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861159; cv=none; b=MnRwhcf/uqikGaSx8sqj/tl6a7MZ10pMLFK/M90ZqBeJd7vnZF+H83hGj48xiDKCiHYEf5qovamnKro5bCFpecd+sS2/sPCOBziEcYAqkEmTPbcOcU5hLJPcdlLmkY4jb3+M66oO1QYwQmhJPuOsCFkaxW+5jPnoqbIZyVHwB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861159; c=relaxed/simple;
	bh=BZWogKMI3ZPT5v6FZGRwHQrLxWLtOJOHCxsfhN/BkjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyV8r7WUaiBxkxxgmuzj3+BTe+jkFGdAzghDivxMGYzFE6gdPCXnSfZRpYyEJ2u/gYI728V4FpWUWz8EPeEWN1I5QLGMS5QmkXShFOcyj3usUHAip+iOZ/4wQRGnMNNAx78EyvAm0odbvCeRQ8yaP/FuokDb/0+O8nD+MXFJoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zm9ac+xm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E00FA4E42874
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A159A5FFA8
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F82110450DD4;
	Mon, 30 Mar 2026 10:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774861154; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=46DHvDZeUCklipun3q2ZDl6S8XWgkalPnMiRj56h3/c=;
	b=zm9ac+xmC7z5dWOt1DmMX6OkubeDRCp4PrAZ7EdeV56JaelHenAZ24HhyxxVM1u2meLGl3
	dOmjp3vGTJcbbaXCMFuToL9KxPUw82k52ViOmsutfTyNDLNldkZWjcXrpb/1i1knfPz/m6
	uCqq+ismp9FmRKYqh4SOo0SLLh/YHR1ehhzFD+OP2L7ZRIz4Pr2xTEdLm8tr7gfpO78S5W
	CZCaSjRIzmCJjKydzdKIepXLmWq0HYEy7EGXr3EUGevChhRLyNP2VrSA/WT3y7u3dUt0zc
	eqsdKIOg9iegfSaK+mcbugBprN3SvXZjm7k2I66z6Kr2CeqOJTC6zf1Gp1hz4Q==
From: Paul Louvel <paul.louvel@bootlin.com>
To: herve.codina@bootlin.com
Cc: thomas.petazzoni@bootlin.com,
	miquel.raynal@bootlin.com,
	Paul Louvel <paul.louvel@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] crypto: talitos - fix SEC1 32k ahash request limitation
Date: Mon, 30 Mar 2026 10:58:40 +0200
Message-ID: <20260330085841.17377-2-paul.louvel@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330085841.17377-1-paul.louvel@bootlin.com>
References: <20260330085841.17377-1-paul.louvel@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-231051-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A061357C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit c662b043cdca ("crypto: af_alg/hash: Support
MSG_SPLICE_PAGES"), the crypto core may pass large scatterlists spanning
multiple pages to drivers supporting ahash operations. As a result, a
driver can now receive large ahash requests.

The SEC1 engine has a limitation where a single descriptor cannot
process more than 32k of data. The current implementation attempts to
handle the entire request within a single descriptor, which leads to
failures raised by the driver:

  "length exceeds h/w max limit"

Address this limitation by splitting large ahash requests into multiple
descriptors, each respecting the 32k hardware limit. This allows
processing arbitrarily large requests.

Cc: stable@vger.kernel.org
Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 216 ++++++++++++++++++++++++++-------------
 1 file changed, 147 insertions(+), 69 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index e8c0db687c57..4c325fa0eac1 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -12,6 +12,7 @@
  * All rights reserved.
  */
 
+#include <linux/workqueue.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -870,10 +871,18 @@ struct talitos_ahash_req_ctx {
 	unsigned int swinit;
 	unsigned int first;
 	unsigned int last;
+	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 	struct scatterlist bufsl[2];
 	struct scatterlist *psrc;
+
+	struct scatterlist request_bufsl[2];
+	struct ahash_request *areq;
+	struct scatterlist *request_sl;
+	unsigned int remaining_ahash_request_bytes;
+	unsigned int current_ahash_request_bytes;
+	struct work_struct sec1_ahash_process_remaining;
 };
 
 struct talitos_export_state {
@@ -1759,7 +1768,20 @@ static void ahash_done(struct device *dev,
 
 	kfree(edesc);
 
-	ahash_request_complete(areq, err);
+	if (err) {
+		ahash_request_complete(areq, err);
+		return;
+	}
+
+	req_ctx->remaining_ahash_request_bytes -=
+		req_ctx->current_ahash_request_bytes;
+
+	if (!req_ctx->remaining_ahash_request_bytes) {
+		ahash_request_complete(areq, 0);
+		return;
+	}
+
+	schedule_work(&req_ctx->sec1_ahash_process_remaining);
 }
 
 /*
@@ -1925,60 +1947,7 @@ static struct talitos_edesc *ahash_edesc_alloc(struct ahash_request *areq,
 				   nbytes, 0, 0, 0, areq->base.flags, false);
 }
 
-static int ahash_init(struct ahash_request *areq)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct device *dev = ctx->dev;
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	unsigned int size;
-	dma_addr_t dma;
-
-	/* Initialize the context */
-	req_ctx->buf_idx = 0;
-	req_ctx->nbuf = 0;
-	req_ctx->first = 1; /* first indicates h/w must init its context */
-	req_ctx->swinit = 0; /* assume h/w init of context */
-	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
-			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
-			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
-	req_ctx->hw_context_size = size;
-
-	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
-			     DMA_TO_DEVICE);
-	dma_unmap_single(dev, dma, req_ctx->hw_context_size, DMA_TO_DEVICE);
-
-	return 0;
-}
-
-/*
- * on h/w without explicit sha224 support, we initialize h/w context
- * manually with sha224 constants, and tell it to run sha256.
- */
-static int ahash_init_sha224_swinit(struct ahash_request *areq)
-{
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-
-	req_ctx->hw_context[0] = SHA224_H0;
-	req_ctx->hw_context[1] = SHA224_H1;
-	req_ctx->hw_context[2] = SHA224_H2;
-	req_ctx->hw_context[3] = SHA224_H3;
-	req_ctx->hw_context[4] = SHA224_H4;
-	req_ctx->hw_context[5] = SHA224_H5;
-	req_ctx->hw_context[6] = SHA224_H6;
-	req_ctx->hw_context[7] = SHA224_H7;
-
-	/* init 64-bit count */
-	req_ctx->hw_context[8] = 0;
-	req_ctx->hw_context[9] = 0;
-
-	ahash_init(areq);
-	req_ctx->swinit = 1;/* prevent h/w initting context with sha256 values*/
-
-	return 0;
-}
-
-static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
+static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
@@ -1997,12 +1966,12 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 
 	if (!req_ctx->last && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
-		nents = sg_nents_for_len(areq->src, nbytes);
+		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
 			return nents;
 		}
-		sg_copy_to_buffer(areq->src, nents,
+		sg_copy_to_buffer(req_ctx->request_sl, nents,
 				  ctx_buf + req_ctx->nbuf, nbytes);
 		req_ctx->nbuf += nbytes;
 		return 0;
@@ -2029,7 +1998,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 		sg_init_table(req_ctx->bufsl, nsg);
 		sg_set_buf(req_ctx->bufsl, ctx_buf, req_ctx->nbuf);
 		if (nsg > 1)
-			sg_chain(req_ctx->bufsl, 2, areq->src);
+			sg_chain(req_ctx->bufsl, 2, req_ctx->request_sl);
 		req_ctx->psrc = req_ctx->bufsl;
 	} else if (is_sec1 && req_ctx->nbuf && req_ctx->nbuf < blocksize) {
 		int offset;
@@ -2038,26 +2007,26 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 			offset = blocksize - req_ctx->nbuf;
 		else
 			offset = nbytes_to_hash - req_ctx->nbuf;
-		nents = sg_nents_for_len(areq->src, offset);
+		nents = sg_nents_for_len(req_ctx->request_sl, offset);
 		if (nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
 			return nents;
 		}
-		sg_copy_to_buffer(areq->src, nents,
+		sg_copy_to_buffer(req_ctx->request_sl, nents,
 				  ctx_buf + req_ctx->nbuf, offset);
 		req_ctx->nbuf += offset;
-		req_ctx->psrc = scatterwalk_ffwd(req_ctx->bufsl, areq->src,
+		req_ctx->psrc = scatterwalk_ffwd(req_ctx->bufsl, req_ctx->request_sl,
 						 offset);
 	} else
-		req_ctx->psrc = areq->src;
+		req_ctx->psrc = req_ctx->request_sl;
 
 	if (to_hash_later) {
-		nents = sg_nents_for_len(areq->src, nbytes);
+		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
 			return nents;
 		}
-		sg_pcopy_to_buffer(areq->src, nents,
+		sg_pcopy_to_buffer(req_ctx->request_sl, nents,
 				   req_ctx->buf[(req_ctx->buf_idx + 1) & 1],
 				      to_hash_later,
 				      nbytes - to_hash_later);
@@ -2065,7 +2034,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 	req_ctx->to_hash_later = to_hash_later;
 
 	/* Allocate extended descriptor */
-	edesc = ahash_edesc_alloc(areq, nbytes_to_hash);
+	edesc = ahash_edesc_alloc(req_ctx->areq, nbytes_to_hash);
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
@@ -2087,14 +2056,123 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 	if (ctx->keylen && (req_ctx->first || req_ctx->last))
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
 
-	return common_nonsnoop_hash(edesc, areq, nbytes_to_hash, ahash_done);
+	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
 }
 
-static int ahash_update(struct ahash_request *areq)
+static void sec1_ahash_process_remaining(struct work_struct *work)
+{
+	struct talitos_ahash_req_ctx *req_ctx =
+		container_of(work, struct talitos_ahash_req_ctx,
+			     sec1_ahash_process_remaining);
+	int err = 0;
+
+	req_ctx->request_sl = scatterwalk_ffwd(req_ctx->request_bufsl,
+					       req_ctx->request_sl, TALITOS1_MAX_DATA_LEN);
+
+	if (req_ctx->remaining_ahash_request_bytes > TALITOS1_MAX_DATA_LEN)
+		req_ctx->current_ahash_request_bytes = TALITOS1_MAX_DATA_LEN;
+	else {
+		req_ctx->current_ahash_request_bytes =
+			req_ctx->remaining_ahash_request_bytes;
+
+		if (req_ctx->last_request)
+			req_ctx->last = 1;
+	}
+
+	err = ahash_process_req_one(req_ctx->areq,
+				    req_ctx->current_ahash_request_bytes);
+
+	if (err != -EINPROGRESS)
+		ahash_request_complete(req_ctx->areq, err);
+}
+
+static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct device *dev = ctx->dev;
+	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+	struct talitos_private *priv = dev_get_drvdata(dev);
+	bool is_sec1 = has_ftr_sec1(priv);
+
+	req_ctx->areq = areq;
+	req_ctx->request_sl = areq->src;
+	req_ctx->remaining_ahash_request_bytes = nbytes;
+
+	if (is_sec1) {
+		if (nbytes > TALITOS1_MAX_DATA_LEN)
+			nbytes = TALITOS1_MAX_DATA_LEN;
+		else if (req_ctx->last_request)
+			req_ctx->last = 1;
+	}
+
+	req_ctx->current_ahash_request_bytes = nbytes;
+
+	return ahash_process_req_one(req_ctx->areq,
+				     req_ctx->current_ahash_request_bytes);
+}
+
+static int ahash_init(struct ahash_request *areq)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct device *dev = ctx->dev;
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+	unsigned int size;
+	dma_addr_t dma;
 
+	/* Initialize the context */
+	req_ctx->buf_idx = 0;
+	req_ctx->nbuf = 0;
+	req_ctx->first = 1; /* first indicates h/w must init its context */
+	req_ctx->swinit = 0; /* assume h/w init of context */
+	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
+			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
+			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
+	req_ctx->hw_context_size = size;
+	req_ctx->last_request = 0;
 	req_ctx->last = 0;
+	INIT_WORK(&req_ctx->sec1_ahash_process_remaining, sec1_ahash_process_remaining);
+
+	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
+			     DMA_TO_DEVICE);
+	dma_unmap_single(dev, dma, req_ctx->hw_context_size, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+/*
+ * on h/w without explicit sha224 support, we initialize h/w context
+ * manually with sha224 constants, and tell it to run sha256.
+ */
+static int ahash_init_sha224_swinit(struct ahash_request *areq)
+{
+	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+
+	req_ctx->hw_context[0] = SHA224_H0;
+	req_ctx->hw_context[1] = SHA224_H1;
+	req_ctx->hw_context[2] = SHA224_H2;
+	req_ctx->hw_context[3] = SHA224_H3;
+	req_ctx->hw_context[4] = SHA224_H4;
+	req_ctx->hw_context[5] = SHA224_H5;
+	req_ctx->hw_context[6] = SHA224_H6;
+	req_ctx->hw_context[7] = SHA224_H7;
+
+	/* init 64-bit count */
+	req_ctx->hw_context[8] = 0;
+	req_ctx->hw_context[9] = 0;
+
+	ahash_init(areq);
+	req_ctx->swinit = 1;/* prevent h/w initting context with sha256 values*/
+
+	return 0;
+}
+
+static int ahash_update(struct ahash_request *areq)
+{
+	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+
+	req_ctx->last_request = 0;
 
 	return ahash_process_req(areq, areq->nbytes);
 }
@@ -2103,7 +2181,7 @@ static int ahash_final(struct ahash_request *areq)
 {
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	req_ctx->last = 1;
+	req_ctx->last_request = 1;
 
 	return ahash_process_req(areq, 0);
 }
@@ -2112,7 +2190,7 @@ static int ahash_finup(struct ahash_request *areq)
 {
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	req_ctx->last = 1;
+	req_ctx->last_request = 1;
 
 	return ahash_process_req(areq, areq->nbytes);
 }
-- 
2.53.0


