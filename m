Return-Path: <stable+bounces-253953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnDHcnDEWpDpgYAu9opvQ
	(envelope-from <stable+bounces-253953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:12:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BA5BF94A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9579E300FB77
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFC2C3757;
	Sat, 23 May 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAm6LvM1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2A29DB6E
	for <stable@vger.kernel.org>; Sat, 23 May 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549114; cv=none; b=c9ca75x0dn9MI+kxgzJ7IEaHp9m41CyPziLH0CgT3fYxdxOsFkmCTzl4Iybz3ylkud94/SpAxpcUOKDvNYY0hWwxXufJHLBbbUdvY1wJy7svbPF15RPM19h/t1BdXI9as1W28GWCkDnFMtgXVC+fXB1tvdNNBVnb3AXGMQvOgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549114; c=relaxed/simple;
	bh=hGWlZAdSKJyrO4vnRYHgI0oT7ZubZ5JXgla6IQEgQvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE8N1tEzpOCHI5Kxdg3Cn8miOT1B6l6qNmMpcyW3n8U3lYKNdd//pbDnd4ymm5MUOlvKudadprOz+J2nm/SmycvgGxDeHrXTC8l2HE8AFfGejfCisgW+asRsBcfpqsZCf8SG+ZQk+/1BIOeoJLtAghOJCM8U6nTptQgTIv+rr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAm6LvM1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44a5174670eso4832261f8f.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549111; x=1780153911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHCpxEue7VXEZ9tnLbMHa9jIi5zBsJ5AQM9y2uBm52M=;
        b=GAm6LvM1UkA8A/aE5kLdkBwlTwMiGw49hMtuwBZdWwwr3Eoq8Uik8at5SQ3CJOOMaf
         mAh0lGqR7P+27rH9ToAXCt1hjL1smpqYwgpUYQI8JiaGHmCJM7Z1sE50u2lERPtsFva1
         810KePWYkwltEj5Z8QUmnCNEKm7mAx7oQaL07fMVpKJjSp9IRJNay0A/u1WVc877ImdJ
         wk5OkkrAi5tyVFhsCF1rKOwQLyTsHy/EcB08jo485bBkP48/uoHtK4eNAIbdVlcFVWnQ
         LJLxAJkWCPNboWqsZu3Od35pZ6XyzKiuo8SH4q8hXBv5fQ+GdlNdA1jYNm+Htl1s6AdM
         vTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549111; x=1780153911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHCpxEue7VXEZ9tnLbMHa9jIi5zBsJ5AQM9y2uBm52M=;
        b=gV4Erb367LjHy05C1El0SP7RWUaU1wVZjugfbQVY9Lv7Yub8lAS/jSuLsr93mwgsNd
         Z3ihKghWm6lY+/10REmGSevcQT7bKcGuJkY0VKZSXygzH2ECOq7MPo7FjVpsP1Imw8DV
         ZAzdSmR0FhtlGWOJ54ynrxfEhod+fIdVXBMxatc0+uLIvi3UDU06w10U3/lW2U3Xh5/J
         PdSTD76awCSDH3tYK9Opd9yqRQAbBvQdVhrvSiVSkf0Lw5V6ZkVFTKFyvKUHs11Q40JO
         B1rT0o0uksPNg4d3G/Bdgr7A3qgPwYTRjtNr/T5JU1vHIDc/EZy4nhw4SEfuVHOBq2hS
         BuNg==
X-Forwarded-Encrypted: i=1; AFNElJ9q2Y3U1NlRSo/cgF1UMlpMa0s0Qz8g0L5VfEJ7smGo+fZ6tpHv/if/CHSiwLXhLrppFmuqu9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOdYOF1WybKogh7ieOPd2hDx5A2s5vgt9NOmZh0D6k1aUElYf
	K5Bx0pWDN0MvsiD4xpXf01uGox/ml5Hy1UtwYpeVszjedHWpJ55xIVrA
X-Gm-Gg: Acq92OEM7CTZOszkS6XGmAuQ2VnU2Gin5sdqXQlYArR33Tph6YkojR+0yHXvhBYS0oH
	2TFiT3bEhleLLfy1FRriyOHSnnb6WwioCKx0PIIDGLzqXmDc1AlH+FXz8Pqo2kmki5cCPSqU+66
	QiTTZKHCsSHcUAu3tss4ss2yyxMBpYEGbiBR+tQh4MCxEKSwzsw/Int2a4FBDFcJA/M+l6J1RdT
	ewDDTt+Gj/815Ps4oBxoBaYnTKiG4/4kxeiA0kyFqYbNjdiOyxuWq4Np/6z3yE1L7mIlvDZMDlr
	C5BqMcj/D6H+xFD7KczdzcZ1Yf79DSAI1IhWdzfBzneQV0w784Bxsy8QpKWx+r3vI3l/Bi+gRvw
	QfBtgi81WW7nekovuw7aEinHFMNuEhsAP0Cpms7mmZsRRyr/IQW3MqKsBF/HwzjTlqc2/TOorBf
	M+HN6F70CljxNh0bNMyWXrmLbMDlrzE3YI
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr13035816f8f.17.1779549110601;
        Sat, 23 May 2026 08:11:50 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:36:c98d:902c:348d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm12629156f8f.35.2026.05.23.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:11:49 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 1/5] Revert "crypto: talitos - rename first/last to first_desc/last_desc"
Date: Sat, 23 May 2026 17:10:44 +0200
Message-ID: <20260523151048.14914-2-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523151048.14914-1-ggoerisch@gmail.com>
References: <2026052212-aged-amply-7bd8@gregkh>
 <20260523151048.14914-1-ggoerisch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253953-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E70BA5BF94A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit a866e2b1c65edaee2e1bb1024ee2c761ced335f8.
---
 drivers/crypto/talitos.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 347483f6fc5d..f78a44f99101 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -869,8 +869,8 @@ struct talitos_ahash_req_ctx {
 	u8 buf[2][HASH_MAX_BLOCK_SIZE];
 	int buf_idx;
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first;
+	unsigned int last;
 	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
@@ -889,8 +889,8 @@ struct talitos_export_state {
 	u32 hw_context[TALITOS_MDEU_MAX_CONTEXT_SIZE / sizeof(u32)];
 	u8 buf[HASH_MAX_BLOCK_SIZE];
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first;
+	unsigned int last;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 };
@@ -1722,7 +1722,7 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	if (desc->next_desc &&
 	    desc->ptr[5].ptr != desc2->ptr[5].ptr)
 		unmap_single_talitos_ptr(dev, &desc2->ptr[5], DMA_FROM_DEVICE);
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
 
@@ -1759,7 +1759,7 @@ static void ahash_done(struct device *dev,
 		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
+	if (!req_ctx->last && req_ctx->to_hash_later) {
 		/* Position any partial block for next update/final/finup */
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
@@ -1825,7 +1825,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!req_ctx->first_desc || req_ctx->swinit) {
+	if (!req_ctx->first || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1833,7 +1833,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	}
 	/* Indicate next op is not the first. */
-	req_ctx->first_desc = 0;
+	req_ctx->first = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
@@ -1866,7 +1866,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* fifth DWORD empty */
 
 	/* hash/HMAC out -or- hash context out */
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		map_single_talitos_ptr(dev, &desc->ptr[5],
 				       crypto_ahash_digestsize(tfm),
 				       req_ctx->hw_context, DMA_FROM_DEVICE);
@@ -1908,7 +1908,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		if (sg_count > 1)
 			sync_needed = true;
 		copy_talitos_ptr(&desc2->ptr[5], &desc->ptr[5], is_sec1);
-		if (req_ctx->last_desc)
+		if (req_ctx->last)
 			map_single_talitos_ptr_nosync(dev, &desc->ptr[5],
 						      req_ctx->hw_context_size,
 						      req_ctx->hw_context,
@@ -1964,7 +1964,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	bool is_sec1 = has_ftr_sec1(priv);
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
 
-	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
+	if (!req_ctx->last && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
 		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
@@ -1981,7 +1981,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	nbytes_to_hash = nbytes + req_ctx->nbuf;
 	to_hash_later = nbytes_to_hash & (blocksize - 1);
 
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		to_hash_later = 0;
 	else if (to_hash_later)
 		/* There is a partial block. Hash the full block(s) now */
@@ -2041,19 +2041,19 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	edesc->desc.hdr = ctx->desc_hdr_template;
 
 	/* On last one, request SEC to pad; otherwise continue */
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
 	else
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
 
 	/* request SEC to INIT hash. */
-	if (req_ctx->first_desc && !req_ctx->swinit)
+	if (req_ctx->first && !req_ctx->swinit)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
 
 	/* When the tfm context has a keylen, it's an HMAC.
 	 * A first or last (ie. not middle) descriptor must request HMAC.
 	 */
-	if (ctx->keylen && (req_ctx->first_desc || req_ctx->last_desc))
+	if (ctx->keylen && (req_ctx->first || req_ctx->last))
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
 
 	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
@@ -2076,7 +2076,7 @@ static void sec1_ahash_process_remaining(struct work_struct *work)
 			req_ctx->remaining_ahash_request_bytes;
 
 		if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
+			req_ctx->last = 1;
 	}
 
 	err = ahash_process_req_one(req_ctx->areq,
@@ -2103,7 +2103,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 		if (nbytes > TALITOS1_MAX_DATA_LEN)
 			nbytes = TALITOS1_MAX_DATA_LEN;
 		else if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
+			req_ctx->last = 1;
 	}
 
 	req_ctx->current_ahash_request_bytes = nbytes;
@@ -2124,14 +2124,14 @@ static int ahash_init(struct ahash_request *areq)
 	/* Initialize the context */
 	req_ctx->buf_idx = 0;
 	req_ctx->nbuf = 0;
-	req_ctx->first_desc = 1; /* first_desc indicates h/w must init its context */
+	req_ctx->first = 1; /* first indicates h/w must init its context */
 	req_ctx->swinit = 0; /* assume h/w init of context */
 	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
 			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
 			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
 	req_ctx->hw_context_size = size;
 	req_ctx->last_request = 0;
-	req_ctx->last_desc = 0;
+	req_ctx->last = 0;
 	INIT_WORK(&req_ctx->sec1_ahash_process_remaining, sec1_ahash_process_remaining);
 
 	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
@@ -2223,8 +2223,8 @@ static int ahash_export(struct ahash_request *areq, void *out)
 	       req_ctx->hw_context_size);
 	memcpy(export->buf, req_ctx->buf[req_ctx->buf_idx], req_ctx->nbuf);
 	export->swinit = req_ctx->swinit;
-	export->first_desc = req_ctx->first_desc;
-	export->last_desc = req_ctx->last_desc;
+	export->first = req_ctx->first;
+	export->last = req_ctx->last;
 	export->to_hash_later = req_ctx->to_hash_later;
 	export->nbuf = req_ctx->nbuf;
 
@@ -2249,8 +2249,8 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	memcpy(req_ctx->hw_context, export->hw_context, size);
 	memcpy(req_ctx->buf[0], export->buf, export->nbuf);
 	req_ctx->swinit = export->swinit;
-	req_ctx->first_desc = export->first_desc;
-	req_ctx->last_desc = export->last_desc;
+	req_ctx->first = export->first;
+	req_ctx->last = export->last;
 	req_ctx->to_hash_later = export->to_hash_later;
 	req_ctx->nbuf = export->nbuf;
 
-- 
2.54.0


