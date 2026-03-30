Return-Path: <stable+bounces-231052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOizKP08ymnG6wUAu9opvQ
	(envelope-from <stable+bounces-231052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55D357C43
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81F803017525
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7A3AEF34;
	Mon, 30 Mar 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nt3kVkxO"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02923ACA7A
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861159; cv=none; b=PAipEyZmbTZyzSvAlGRQjWJtilw/0oVGt/t/y0Qyd6yUr8E9BZLZefpihbB67sC6QA/ebcePGZ8IoeWp1mjs3cNWUUL9m1WpYPa43goFZy4O0c91r5zEboAxcb6cntGWNpNbiLXYJTHb8Wcv2v7bZZVepxQVVQgqdSiJVz18Tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861159; c=relaxed/simple;
	bh=2mLbEQ+ySKvpZdfGNy5NwvEALKxOXo7VUyAcLyPTo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvWHALixh7VwFM0UhxeUg1QA3AQknfeJBr3dXxGiqQZ4g/K2PObhkfdcEF4f1I0e3/HD1MAQMZTa2RAQAc1Vk9bZ/cejE/6LC15WH9qKwSOdMbCCWS71kbnBJD1kgSxICol6+odzqsPDNeOH5Q7F6sDqY54gLvOpsGQ0Z0wFEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nt3kVkxO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 62EDD4E42876
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33F625FFA8
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:59:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E45710450D88;
	Mon, 30 Mar 2026 10:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774861155; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yo9qTdZD+OYAUep2Pxyjh0pdrF7X7xlonXBoiSL+VEw=;
	b=nt3kVkxOY+WSnHnkyMStgHHR8GAHGKwYVyV4HMV/eJNlS+r9cyx6JM5I41m6lRKrwEF25P
	jlSLEWCOecMTaNCuTQbxoFOBls62lZKUr+N78fYK4bDekrEN3SmCd9NaGWTMvSjhvFwEQH
	L3+Aaq1CNvfqe+DhECyJQX26qQSqzREzPzqA1C30BZ744WafIytCPX+tWsx1OV4I3eosp6
	MVqNjghDtn2Xk7Kfzz13Cq2LJUCfk3PppU6QZiXgxi9yetENS/h/l0D26+tsk3e2WtVu7T
	1UxsqDAkAs5qVjrYfhezsK1Boxs+76Y1OyxQoRUIyZMO+lQjWhde+oi1NFsMAQ==
From: Paul Louvel <paul.louvel@bootlin.com>
To: herve.codina@bootlin.com
Cc: thomas.petazzoni@bootlin.com,
	miquel.raynal@bootlin.com,
	Paul Louvel <paul.louvel@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] crypto: talitos - rename first/last to first_desc/last_desc
Date: Mon, 30 Mar 2026 10:58:41 +0200
Message-ID: <20260330085841.17377-3-paul.louvel@bootlin.com>
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
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	TAGGED_FROM(0.00)[bounces-231052-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B55D357C43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previous commit introduces a new last_request variable in the context
structure.

Renaming the first/last existing member variable in the context
structure to improve readability.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4c325fa0eac1..bc61d0fe3514 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -869,8 +869,8 @@ struct talitos_ahash_req_ctx {
 	u8 buf[2][HASH_MAX_BLOCK_SIZE];
 	int buf_idx;
 	unsigned int swinit;
-	unsigned int first;
-	unsigned int last;
+	unsigned int first_desc;
+	unsigned int last_desc;
 	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
@@ -889,8 +889,8 @@ struct talitos_export_state {
 	u32 hw_context[TALITOS_MDEU_MAX_CONTEXT_SIZE / sizeof(u32)];
 	u8 buf[HASH_MAX_BLOCK_SIZE];
 	unsigned int swinit;
-	unsigned int first;
-	unsigned int last;
+	unsigned int first_desc;
+	unsigned int last_desc;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 };
@@ -1722,7 +1722,7 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	if (desc->next_desc &&
 	    desc->ptr[5].ptr != desc2->ptr[5].ptr)
 		unmap_single_talitos_ptr(dev, &desc2->ptr[5], DMA_FROM_DEVICE);
-	if (req_ctx->last)
+	if (req_ctx->last_desc)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
 
@@ -1759,7 +1759,7 @@ static void ahash_done(struct device *dev,
 		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	if (!req_ctx->last && req_ctx->to_hash_later) {
+	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
 		/* Position any partial block for next update/final/finup */
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
@@ -1825,7 +1825,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!req_ctx->first || req_ctx->swinit) {
+	if (!req_ctx->first_desc || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1833,7 +1833,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	}
 	/* Indicate next op is not the first. */
-	req_ctx->first = 0;
+	req_ctx->first_desc = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
@@ -1866,7 +1866,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* fifth DWORD empty */
 
 	/* hash/HMAC out -or- hash context out */
-	if (req_ctx->last)
+	if (req_ctx->last_desc)
 		map_single_talitos_ptr(dev, &desc->ptr[5],
 				       crypto_ahash_digestsize(tfm),
 				       req_ctx->hw_context, DMA_FROM_DEVICE);
@@ -1908,7 +1908,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		if (sg_count > 1)
 			sync_needed = true;
 		copy_talitos_ptr(&desc2->ptr[5], &desc->ptr[5], is_sec1);
-		if (req_ctx->last)
+		if (req_ctx->last_desc)
 			map_single_talitos_ptr_nosync(dev, &desc->ptr[5],
 						      req_ctx->hw_context_size,
 						      req_ctx->hw_context,
@@ -1964,7 +1964,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	bool is_sec1 = has_ftr_sec1(priv);
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
 
-	if (!req_ctx->last && (nbytes + req_ctx->nbuf <= blocksize)) {
+	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
 		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
@@ -1981,7 +1981,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	nbytes_to_hash = nbytes + req_ctx->nbuf;
 	to_hash_later = nbytes_to_hash & (blocksize - 1);
 
-	if (req_ctx->last)
+	if (req_ctx->last_desc)
 		to_hash_later = 0;
 	else if (to_hash_later)
 		/* There is a partial block. Hash the full block(s) now */
@@ -2041,19 +2041,19 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	edesc->desc.hdr = ctx->desc_hdr_template;
 
 	/* On last one, request SEC to pad; otherwise continue */
-	if (req_ctx->last)
+	if (req_ctx->last_desc)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
 	else
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
 
 	/* request SEC to INIT hash. */
-	if (req_ctx->first && !req_ctx->swinit)
+	if (req_ctx->first_desc && !req_ctx->swinit)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
 
 	/* When the tfm context has a keylen, it's an HMAC.
 	 * A first or last (ie. not middle) descriptor must request HMAC.
 	 */
-	if (ctx->keylen && (req_ctx->first || req_ctx->last))
+	if (ctx->keylen && (req_ctx->first_desc || req_ctx->last_desc))
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
 
 	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
@@ -2076,7 +2076,7 @@ static void sec1_ahash_process_remaining(struct work_struct *work)
 			req_ctx->remaining_ahash_request_bytes;
 
 		if (req_ctx->last_request)
-			req_ctx->last = 1;
+			req_ctx->last_desc = 1;
 	}
 
 	err = ahash_process_req_one(req_ctx->areq,
@@ -2103,7 +2103,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 		if (nbytes > TALITOS1_MAX_DATA_LEN)
 			nbytes = TALITOS1_MAX_DATA_LEN;
 		else if (req_ctx->last_request)
-			req_ctx->last = 1;
+			req_ctx->last_desc = 1;
 	}
 
 	req_ctx->current_ahash_request_bytes = nbytes;
@@ -2124,14 +2124,14 @@ static int ahash_init(struct ahash_request *areq)
 	/* Initialize the context */
 	req_ctx->buf_idx = 0;
 	req_ctx->nbuf = 0;
-	req_ctx->first = 1; /* first indicates h/w must init its context */
+	req_ctx->first_desc = 1; /* first_desc indicates h/w must init its context */
 	req_ctx->swinit = 0; /* assume h/w init of context */
 	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
 			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
 			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
 	req_ctx->hw_context_size = size;
 	req_ctx->last_request = 0;
-	req_ctx->last = 0;
+	req_ctx->last_desc = 0;
 	INIT_WORK(&req_ctx->sec1_ahash_process_remaining, sec1_ahash_process_remaining);
 
 	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
@@ -2224,8 +2224,8 @@ static int ahash_export(struct ahash_request *areq, void *out)
 	       req_ctx->hw_context_size);
 	memcpy(export->buf, req_ctx->buf[req_ctx->buf_idx], req_ctx->nbuf);
 	export->swinit = req_ctx->swinit;
-	export->first = req_ctx->first;
-	export->last = req_ctx->last;
+	export->first_desc = req_ctx->first_desc;
+	export->last_desc = req_ctx->last_desc;
 	export->to_hash_later = req_ctx->to_hash_later;
 	export->nbuf = req_ctx->nbuf;
 
@@ -2250,8 +2250,8 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	memcpy(req_ctx->hw_context, export->hw_context, size);
 	memcpy(req_ctx->buf[0], export->buf, export->nbuf);
 	req_ctx->swinit = export->swinit;
-	req_ctx->first = export->first;
-	req_ctx->last = export->last;
+	req_ctx->first_desc = export->first_desc;
+	req_ctx->last_desc = export->last_desc;
 	req_ctx->to_hash_later = export->to_hash_later;
 	req_ctx->nbuf = export->nbuf;
 
-- 
2.53.0


