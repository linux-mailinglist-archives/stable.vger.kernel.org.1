Return-Path: <stable+bounces-244244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LdFLt0u+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE824D25D7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D840301C8AD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D224ADDB7;
	Tue,  5 May 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j76ZclqC"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4034A341D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003645; cv=none; b=qVtPZmrDYtuYXdFPTJ53kACDRltMciOg+kyLS6njqw9fkehmS1OVHRbZ5sxXu+YIODDN5c4eTlhBMhpicTfwEl0b4LT8oqze6MmTCnm1Poo6qS15fO/ibpb0Lm3Rt9V8oZhoiew3Owl34SYtI5n9EWor54VqP3pS2xY79ONnui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003645; c=relaxed/simple;
	bh=OMYxZs9XE8R8nLGQ/7IlFs0u83h+dEbGq7xq0kUbR1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FC73A4EEv4cKTnVcgSB1aDL2e/DUi+urB7rP26lc4pyrtV+KpX7WsOYzbhUGJw7CdiDEbsx8NZj4i7EjeAPND5uxR5SWAdYstT6jWo50oPz64bcYn7o+JC6wus+WoJC7dRP++9kV7Rvfs9z5Cn21fdk8Cxio5Y8dk1NTH6JbqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j76ZclqC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9647BC5CD52;
	Tue,  5 May 2026 17:54:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC1CB6053C;
	Tue,  5 May 2026 17:53:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AF6811AD0412;
	Tue,  5 May 2026 19:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778003638; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ym+CkLUj3hotoqhZyVQhRlReEdrG4pvxZ0e/b3zAjT4=;
	b=j76ZclqCHnWp5MqM2Qk/xiGEENlhLETTRDcQM286hmk6EneuyykdCsn0ecJ7bLmtz/+3NA
	5lCG0m2JvoA2ttRUaFlDvrfuPQ+0IihYkEgnA8ExhviOGxrCEcTXXKLbKzSv566czpHNtk
	93bomXQNZOckPH1f9/FqV9Af1UxcY9Zh7WoHo2DssYAZbKttLvPiod/p/kYqdHotZ+eRga
	C5iE96BOAhgTP/N233QndR7ihH0M8y5K+B/xVZxWcjdM9hS/jXf+PxrOTIIPm7YyFfbwjr
	UNB6aPu7vUfryzBAEN4Tw0X0ZQToXPH6c1Zsh1pNQB32PjYDxK7O4NsV5HTFiQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 05 May 2026 19:53:08 +0200
Subject: [PATCH v2 07/12] crypto: talitos/hash - use descriptor chaining
 for SEC1 instead of workqueue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-7-5818064bd190@bootlin.com>
References: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
In-Reply-To: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778003630; l=13626;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=OMYxZs9XE8R8nLGQ/7IlFs0u83h+dEbGq7xq0kUbR1U=;
 b=+92BFWnEu90v3lJrA1TLFVuzhsMx+HRYTPhVMUuCnyS7wY0YlsgqWyuEpwnKCsS2P2Q35TxhJ
 EE8PMA4XCQpACRN2k+ql551nxUoRGWr7jQz6mKGMt+YRyWfe5bMTRvj
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: ACE824D25D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244244-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Rework the SEC1 ahash implementation to build a chain of hardware
descriptors, replacing the previous approach of submitting one
descriptor at a time via a workqueue, introduced by commit 655ef638a2bc
("crypto: talitos - fix SEC1 32k ahash request limitation").

Introduce ahash_process_req_prepare() which iterates over the request
data, allocating enough descriptors to cover the entire ahash request.
The new fields (bufsl, src, first, last) are added to talitos_edesc for
this purpose.

common_nonsnoop_hash() no longer calls talitos_submit(); it only
maps and sets up the descriptor.  Submission is now done by the caller
after the chain is built.

ahash_free_desc_list_from() takes over calling
common_nonsnoop_hash_unmap() for each descriptor during cleanup.

Compared to the workqueue based solution, request are slightly faster
since there is no more scheduling latency induced by the workqueue, and
only one interrupt is generated by the device at the end of a chain.

Commit 655ef638a2bc ("crypto: talitos - fix SEC1 32k ahash request
limitation") :

$ /usr/libexec/libkcapi/sha256sum ./test_5M.bin
013c5609d63c...  ./test_5M.bin
real 0m 0.41s
user 0m 0.01s
sys  0m 0.07s

Now :

$ /usr/libexec/libkcapi/sha256sum ./test_5M.bin
013c5609d63c...  ./test_5M.bin
real 0m 0.37s
user 0m 0.00s
sys  0m 0.20s

Tested on a system with an MPC885 SoC featuring the SEC1 Lite.

The increase in sys time is due to the fact that commit 37b5e8897eb5
("crypto: talitos - chain in buffered data for ahash on SEC1") can no
longer be applied.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 168 ++++++++++++++++++++++++++++++-----------------
 drivers/crypto/talitos.h |  10 +++
 2 files changed, 118 insertions(+), 60 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 1f47424b93c7..450f81fc0137 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1803,12 +1803,13 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 
 	unmap_single_talitos_ptr(dev, &desc->ptr[5], DMA_FROM_DEVICE);
 
-	if (req_ctx->last_desc)
+	if (edesc->last && req_ctx->last_request)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
 
-	if (req_ctx->psrc)
-		talitos_sg_unmap(dev, edesc, req_ctx->psrc, NULL, 0, 0);
+	if (edesc->src)
+		talitos_sg_unmap(dev, edesc, edesc->src, NULL, 0, 0);
+
 
 	/* When using hashctx-in, must unmap it. */
 	if (from_talitos_ptr_len(&desc->ptr[1], is_sec1))
@@ -1823,11 +1824,13 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 static void ahash_free_desc_list_from(struct ahash_request *areq,
 				      struct talitos_edesc *edesc)
 {
+	struct talitos_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 	struct talitos_edesc *tmp;
 
 	list_for_each_entry_safe_from(edesc, tmp, &req_ctx->desc_list, node) {
 		list_del(&edesc->node);
+		common_nonsnoop_hash_unmap(ctx->dev, edesc, areq);
 		kfree(edesc);
 	}
 }
@@ -1837,8 +1840,6 @@ static void ahash_done(struct device *dev,
 		       int err)
 {
 	struct ahash_request *areq = context;
-	struct talitos_edesc *edesc =
-		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
 	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
@@ -1846,16 +1847,14 @@ static void ahash_done(struct device *dev,
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
 	}
-	common_nonsnoop_hash_unmap(dev, edesc, areq);
 
 	ahash_free_desc_list_from(areq,
 				  list_first_entry(&req_ctx->desc_list,
 						   struct talitos_edesc, node));
 
-	if (err) {
-		ahash_request_complete(areq, err);
-		return;
-	}
+	ahash_request_complete(areq, err);
+
+	return;
 
 	req_ctx->remaining_ahash_request_bytes -=
 		req_ctx->current_ahash_request_bytes;
@@ -1889,18 +1888,15 @@ static void talitos_handle_buggy_hash(struct talitos_ctx *ctx,
 			       (char *)padded_hash, DMA_TO_DEVICE);
 }
 
-static int common_nonsnoop_hash(struct talitos_edesc *edesc,
-				struct ahash_request *areq, unsigned int length,
-				void (*callback) (struct device *dev,
-						  struct talitos_desc *desc,
-						  void *context, int error))
+static void common_nonsnoop_hash(struct talitos_edesc *edesc,
+				 struct ahash_request *areq,
+				 unsigned int length)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 	struct device *dev = ctx->dev;
 	struct talitos_desc *desc = &edesc->desc;
-	int ret;
 	bool sync_needed = false;
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -1909,7 +1905,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!req_ctx->first_desc || req_ctx->swinit) {
+	if (!edesc->first || !req_ctx->first_desc || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1926,22 +1922,22 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 
 	sg_count = edesc->src_nents ?: 1;
 	if (is_sec1 && sg_count > 1)
-		sg_copy_to_buffer(req_ctx->psrc, sg_count, edesc->buf, length);
+		sg_copy_to_buffer(edesc->src, sg_count, edesc->buf, length);
 	else if (length)
-		sg_count = dma_map_sg(dev, req_ctx->psrc, sg_count,
-				      DMA_TO_DEVICE);
+		sg_count = dma_map_sg(dev, edesc->src, sg_count, DMA_TO_DEVICE);
+
 	/*
 	 * data in
 	 */
-	sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
-					&desc->ptr[3], sg_count, 0, 0);
+	sg_count = talitos_sg_map(dev, edesc->src, length, edesc, &desc->ptr[3],
+				  sg_count, 0, 0);
 	if (sg_count > 1)
 		sync_needed = true;
 
 	/* fifth DWORD empty */
 
 	/* hash/HMAC out -or- hash context out */
-	if (req_ctx->last_desc)
+	if (edesc->last && req_ctx->last_request)
 		map_single_talitos_ptr(dev, &desc->ptr[5],
 				       crypto_ahash_digestsize(tfm),
 				       req_ctx->hw_context, DMA_FROM_DEVICE);
@@ -1959,26 +1955,91 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	if (sync_needed)
 		dma_sync_single_for_device(dev, edesc->dma_link_tbl,
 					   edesc->dma_len, DMA_BIDIRECTIONAL);
-
-	ret = talitos_submit(dev, ctx->ch, desc, callback, areq);
-	if (ret != -EINPROGRESS) {
-		common_nonsnoop_hash_unmap(dev, edesc, areq);
-		kfree(edesc);
-	}
-	return ret;
 }
 
 static struct talitos_edesc *ahash_edesc_alloc(struct ahash_request *areq,
+					       struct scatterlist *src,
 					       unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	return talitos_edesc_alloc(ctx->dev, req_ctx->psrc, NULL, NULL, 0,
+	return talitos_edesc_alloc(ctx->dev, src, NULL, NULL, 0,
 				   nbytes, 0, 0, 0, areq->base.flags, false);
 }
 
+static int ahash_process_req_prepare(struct ahash_request *areq,
+				     unsigned int nbytes,
+				     unsigned int blocksize, bool is_sec1)
+{
+	struct talitos_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
+	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+	size_t desc_max = is_sec1 ? TALITOS1_MAX_DATA_LEN : SIZE_MAX;
+	struct talitos_edesc *edesc;
+	struct scatterlist tmp[2];
+	size_t to_hash_this_desc;
+	struct scatterlist *src;
+	size_t offset = 0;
+
+	INIT_LIST_HEAD(&req_ctx->desc_list);
+	do {
+		src = scatterwalk_ffwd(tmp, req_ctx->psrc, offset);
+
+		to_hash_this_desc =
+			min(nbytes, ALIGN_DOWN(desc_max, blocksize));
+
+		/* Allocate extended descriptor */
+		edesc = ahash_edesc_alloc(areq, src, to_hash_this_desc);
+		if (IS_ERR(edesc)) {
+			if (!list_empty(&req_ctx->desc_list)) {
+				edesc = list_first_entry(&req_ctx->desc_list,
+							 struct talitos_edesc,
+							 node);
+				ahash_free_desc_list_from(areq, edesc);
+			}
+
+			return PTR_ERR(edesc);
+		}
+
+		edesc->src =
+			scatterwalk_ffwd(edesc->bufsl, req_ctx->psrc, offset);
+		edesc->desc.hdr = ctx->desc_hdr_template;
+		edesc->first = offset == 0;
+		edesc->last = nbytes - to_hash_this_desc == 0;
+
+		/* On last one, request SEC to pad; otherwise continue */
+		if (req_ctx->last_request && edesc->last)
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
+		else
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
+
+		/* request SEC to INIT hash. */
+		if (req_ctx->first_desc && edesc->first && !req_ctx->swinit)
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
+
+		/*
+		 * When the tfm context has a keylen, it's an HMAC.
+		 * A first or last (ie. not middle) descriptor must request HMAC.
+		 */
+		if (ctx->keylen && ((req_ctx->first_desc && edesc->first) ||
+				    (req_ctx->last_request && edesc->last)))
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
+
+		/* clear the DN bit  */
+		if (is_sec1 && !edesc->last)
+			edesc->desc.hdr &= ~DESC_HDR_DONE_NOTIFY;
+
+		list_add_tail(&edesc->node, &req_ctx->desc_list);
+
+		common_nonsnoop_hash(edesc, areq, to_hash_this_desc);
+
+		offset += to_hash_this_desc;
+		nbytes -= to_hash_this_desc;
+	} while (nbytes);
+
+	return 0;
+}
+
 static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
@@ -1987,14 +2048,16 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	struct talitos_edesc *edesc;
 	unsigned int blocksize =
 			crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	bool is_sec1 = has_ftr_sec1(dev_get_drvdata(ctx->dev));
 	unsigned int nbytes_to_hash;
 	unsigned int to_hash_later;
 	unsigned int nsg;
 	int nents;
 	struct device *dev = ctx->dev;
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
+	int ret;
 
-	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
+	if (!req_ctx->last_request && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
 		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
@@ -2011,7 +2074,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	nbytes_to_hash = nbytes + req_ctx->nbuf;
 	to_hash_later = nbytes_to_hash & (blocksize - 1);
 
-	if (req_ctx->last_desc)
+	if (req_ctx->last_request)
 		to_hash_later = 0;
 	else if (to_hash_later)
 		/* There is a partial block. Hash the full block(s) now */
@@ -2046,33 +2109,19 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	}
 	req_ctx->to_hash_later = to_hash_later;
 
-	/* Allocate extended descriptor */
-	edesc = ahash_edesc_alloc(req_ctx->areq, nbytes_to_hash);
-	if (IS_ERR(edesc))
-		return PTR_ERR(edesc);
-
-	INIT_LIST_HEAD(&req_ctx->desc_list);
-	list_add_tail(&edesc->node, &req_ctx->desc_list);
-
-	edesc->desc.hdr = ctx->desc_hdr_template;
-
-	/* On last one, request SEC to pad; otherwise continue */
-	if (req_ctx->last_desc)
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
-	else
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
+	ret = ahash_process_req_prepare(areq, nbytes_to_hash, blocksize,
+					is_sec1);
+	if (ret)
+		return ret;
 
-	/* request SEC to INIT hash. */
-	if (req_ctx->first_desc && !req_ctx->swinit)
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
+	edesc = list_first_entry(&req_ctx->desc_list, struct talitos_edesc,
+				 node);
 
-	/* When the tfm context has a keylen, it's an HMAC.
-	 * A first or last (ie. not middle) descriptor must request HMAC.
-	 */
-	if (ctx->keylen && (req_ctx->first_desc || req_ctx->last_desc))
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
+	ret = talitos_submit(dev, ctx->ch, &edesc->desc, ahash_done, areq);
+	if (ret != -EINPROGRESS)
+		ahash_free_desc_list_from(areq, edesc);
 
-	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
+	return ret;
 }
 
 static void sec1_ahash_process_remaining(struct work_struct *work)
@@ -2124,8 +2173,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 
 	req_ctx->current_ahash_request_bytes = nbytes;
 
-	return ahash_process_req_one(req_ctx->areq,
-				     req_ctx->current_ahash_request_bytes);
+	return ahash_process_req_one(req_ctx->areq, areq->nbytes);
 }
 
 static int ahash_init(struct ahash_request *areq)
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index ac75c2ddecb9..efba34458b12 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -44,6 +44,11 @@ struct talitos_desc {
 
 /*
  * talitos_edesc - s/w-extended descriptor
+ * @bufsl: scatterlist buffer
+ * @src: pointer to input scatterlist
+ * @first: first descriptor of a chain
+ * @last: last descriptor of a chain
+ *
  * @src_nents: number of segments in input scatterlist
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
@@ -59,6 +64,11 @@ struct talitos_desc {
  * of link_tbl data
  */
 struct talitos_edesc {
+	struct scatterlist bufsl[2];
+	struct scatterlist *src;
+	int first;
+	int last;
+
 	int src_nents;
 	int dst_nents;
 	dma_addr_t iv_dma;

-- 
2.53.0


