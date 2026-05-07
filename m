Return-Path: <stable+bounces-244588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAWGKX6m/GmwSQAAu9opvQ
	(envelope-from <stable+bounces-244588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:49:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDB4EA887
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D8630C2617
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F242EEAA;
	Thu,  7 May 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="USM5dhI4"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC140758A
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164944; cv=none; b=YFXT7yS6UkYiEDW0m3IEmFogrr1TE8uLpt/hdZ/ptQa7RxHAngO/I5IUDBvMw3DAoEk8h7Gni6RDgqDGqbECYbJ8ZyoMhQXYDRBIUGd6lx0cWuD05XzAr4FgAg/ABOOo1M1G+IXLpsbni+GDsXH94NV37rIWHETLjEKQOdlBwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164944; c=relaxed/simple;
	bh=Pj/omQS8/bnTGU/YHn5DhQ94ALBQvuhcRU0l5aTvIWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYxTDWJxHiu2ABOmAhTGBiAeBS3P+Ylh+wj0xNiyAfxOIeK/p3cHOcjIz+ChoN9DTGOiSRya2Bk3SY6pDeKy1xhCCR8D7UDEnLt6ThY0/r6VwIAgeysd+eiaEWpYQEeCt3nBnKnLQG+9K6TDVehFz+ZUgHY7aJQSBc2Vm0LiCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=USM5dhI4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B4CC5C5DC5F;
	Thu,  7 May 2026 14:43:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 014FF60495;
	Thu,  7 May 2026 14:42:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7B83108194E7;
	Thu,  7 May 2026 16:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SUFudVvJ9y35/3htDCJOCx8HpvSqlyO19b81VfH+tro=;
	b=USM5dhI4B5VL2AwCb2vDkRAchNWRO0BSbpqxN0jz0tqD/vgtnuUMS6FTqsc1M3hh1pmEbZ
	+dQdYH6UDfEigm0K5+DyBEVlDrNB8yTTpG/SVikYcNghXOlRFB8eC7rgypGfbUObiAm/2x
	pSn/gwnCMwq1yGTppwLjn7jbZULuh2iw1rZwJPNTUSD9IeJrqTRl3zNZzRVFPDOs2AVDCg
	aPvrjhcckzBKRn890XfMauAmiZxHZ9YB07H77b/+htR6HOULZEc35VqHvJwdNUSeI/V+ms
	SOEVMkqTH+a1gyy9WWJTz8dyaOjE4OydLSn5iP0EUCHMrTD4zEUdb3JQPxJKjw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 07 May 2026 16:41:52 +0200
Subject: [PATCH v3 06/11] crypto: talitos/hash - prepare SEC1 descriptor
 chaining, remove additional descriptor
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-bootlin_test-7-1-rc1_sec_bugfix-v3-6-c98d7589b942@bootlin.com>
References: <20260507-bootlin_test-7-1-rc1_sec_bugfix-v3-0-c98d7589b942@bootlin.com>
In-Reply-To: <20260507-bootlin_test-7-1-rc1_sec_bugfix-v3-0-c98d7589b942@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164923; l=6752;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=Pj/omQS8/bnTGU/YHn5DhQ94ALBQvuhcRU0l5aTvIWk=;
 b=TZ1UadA+3UJb9EiayuVvPQqP0NnSvjT8hU1y9cQeOx14DrzbZtDYl/RrSoL7uTw8pZIRZcOP2
 Tue1TZDzH6hAhPuoTsGQjYBoA/HS+ieLERbixmU84RvToP6wnbZ+yNQ
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1CEDB4EA887
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244588-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Currently, when SEC1 has buffered data (nbuf != 0), the ahash code
creates an additional descriptor on the fly inside
common_nonsnoop_hash() to handle the remainder of the data. This
approach is incompatible with the arbitrary-length descriptor chaining
that follows.

Remove the "additional descriptor" logic from common_nonsnoop_hash()
and common_nonsnoop_hash_unmap().

Also remove the nbytes adjustment for SEC1 in ahash_edesc_alloc()
that subtracted nbuf.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 101 +++--------------------------------------------
 1 file changed, 6 insertions(+), 95 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index b808833d18ef..0184982cb39b 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1788,15 +1788,9 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 	struct talitos_desc *desc = &edesc->desc;
-	struct talitos_desc *desc2;
-
-	if (desc->next_desc)
-		desc2 = &edesc->next_desc->desc;
 
 	unmap_single_talitos_ptr(dev, &desc->ptr[5], DMA_FROM_DEVICE);
-	if (desc->next_desc &&
-	    desc->ptr[5].ptr != desc2->ptr[5].ptr)
-		unmap_single_talitos_ptr(dev, &desc2->ptr[5], DMA_FROM_DEVICE);
+
 	if (req_ctx->last_desc)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
@@ -1808,13 +1802,6 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	if (from_talitos_ptr_len(&desc->ptr[1], is_sec1))
 		unmap_single_talitos_ptr(dev, &desc->ptr[1],
 					 DMA_TO_DEVICE);
-	else if (desc->next_desc)
-		unmap_single_talitos_ptr(dev, &desc2->ptr[1],
-					 DMA_TO_DEVICE);
-
-	if (is_sec1 && req_ctx->nbuf)
-		unmap_single_talitos_ptr(dev, &desc->ptr[3],
-					 DMA_TO_DEVICE);
 
 	if (edesc->dma_len)
 		dma_unmap_single(dev, edesc->dma_link_tbl, edesc->dma_len,
@@ -1922,9 +1909,6 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		to_talitos_ptr(&desc->ptr[2], ctx->dma_key, ctx->keylen,
 			       is_sec1);
 
-	if (is_sec1 && req_ctx->nbuf)
-		length -= req_ctx->nbuf;
-
 	sg_count = edesc->src_nents ?: 1;
 	if (is_sec1 && sg_count > 1)
 		sg_copy_to_buffer(req_ctx->psrc, sg_count, edesc->buf, length);
@@ -1934,16 +1918,10 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/*
 	 * data in
 	 */
-	if (is_sec1 && req_ctx->nbuf) {
-		map_single_talitos_ptr(dev, &desc->ptr[3], req_ctx->nbuf,
-				       req_ctx->buf[req_ctx->buf_idx],
-				       DMA_TO_DEVICE);
-	} else {
-		sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
-					  &desc->ptr[3], sg_count, 0, 0);
-		if (sg_count > 1)
-			sync_needed = true;
-	}
+	sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
+					&desc->ptr[3], sg_count, 0, 0);
+	if (sg_count > 1)
+		sync_needed = true;
 
 	/* fifth DWORD empty */
 
@@ -1963,49 +1941,6 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) == 0)
 		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
 
-	if (is_sec1 && req_ctx->nbuf && length) {
-		struct talitos_edesc *edesc2;
-		struct talitos_desc *desc2;
-
-		edesc2 = kzalloc(sizeof(*edesc2),
-				 areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
-					 GFP_KERNEL :
-					 GFP_ATOMIC);
-		if (!edesc2) {
-			ret = -ENOMEM;
-			goto err;
-		}
-		edesc->next_desc = edesc2;
-
-		desc2 = &edesc2->desc;
-
-		desc2->hdr = desc->hdr;
-		desc2->hdr &= ~DESC_HDR_MODE0_MDEU_INIT;
-		desc->hdr &= ~DESC_HDR_MODE0_MDEU_PAD;
-		desc->hdr |= DESC_HDR_MODE0_MDEU_CONT;
-		desc->hdr &= ~DESC_HDR_DONE_NOTIFY;
-
-		if (desc->ptr[1].ptr)
-			copy_talitos_ptr(&desc2->ptr[1], &desc->ptr[1],
-					 is_sec1);
-		else
-			map_single_talitos_ptr_nosync(dev, &desc2->ptr[1],
-						      req_ctx->hw_context_size,
-						      req_ctx->hw_context,
-						      DMA_TO_DEVICE);
-		copy_talitos_ptr(&desc2->ptr[2], &desc->ptr[2], is_sec1);
-		sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
-					  &desc2->ptr[3], sg_count, 0, 0);
-		if (sg_count > 1)
-			sync_needed = true;
-		copy_talitos_ptr(&desc2->ptr[5], &desc->ptr[5], is_sec1);
-		if (req_ctx->last_desc)
-			map_single_talitos_ptr_nosync(dev, &desc->ptr[5],
-						      req_ctx->hw_context_size,
-						      req_ctx->hw_context,
-						      DMA_FROM_DEVICE);
-	}
-
 	if (sync_needed)
 		dma_sync_single_for_device(dev, edesc->dma_link_tbl,
 					   edesc->dma_len, DMA_BIDIRECTIONAL);
@@ -2028,11 +1963,6 @@ static struct talitos_edesc *ahash_edesc_alloc(struct ahash_request *areq,
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	struct talitos_private *priv = dev_get_drvdata(ctx->dev);
-	bool is_sec1 = has_ftr_sec1(priv);
-
-	if (is_sec1)
-		nbytes -= req_ctx->nbuf;
 
 	return talitos_edesc_alloc(ctx->dev, req_ctx->psrc, NULL, NULL, 0,
 				   nbytes, 0, 0, 0, areq->base.flags, false);
@@ -2051,8 +1981,6 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	unsigned int nsg;
 	int nents;
 	struct device *dev = ctx->dev;
-	struct talitos_private *priv = dev_get_drvdata(dev);
-	bool is_sec1 = has_ftr_sec1(priv);
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
 
 	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
@@ -2084,30 +2012,13 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	}
 
 	/* Chain in any previously buffered data */
-	if (!is_sec1 && req_ctx->nbuf) {
+	if (req_ctx->nbuf) {
 		nsg = (req_ctx->nbuf < nbytes_to_hash) ? 2 : 1;
 		sg_init_table(req_ctx->bufsl, nsg);
 		sg_set_buf(req_ctx->bufsl, ctx_buf, req_ctx->nbuf);
 		if (nsg > 1)
 			sg_chain(req_ctx->bufsl, 2, req_ctx->request_sl);
 		req_ctx->psrc = req_ctx->bufsl;
-	} else if (is_sec1 && req_ctx->nbuf && req_ctx->nbuf < blocksize) {
-		int offset;
-
-		if (nbytes_to_hash > blocksize)
-			offset = blocksize - req_ctx->nbuf;
-		else
-			offset = nbytes_to_hash - req_ctx->nbuf;
-		nents = sg_nents_for_len(req_ctx->request_sl, offset);
-		if (nents < 0) {
-			dev_err(dev, "Invalid number of src SG.\n");
-			return nents;
-		}
-		sg_copy_to_buffer(req_ctx->request_sl, nents,
-				  ctx_buf + req_ctx->nbuf, offset);
-		req_ctx->nbuf += offset;
-		req_ctx->psrc = scatterwalk_ffwd(req_ctx->bufsl, req_ctx->request_sl,
-						 offset);
 	} else
 		req_ctx->psrc = req_ctx->request_sl;
 

-- 
2.54.0


