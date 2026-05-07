Return-Path: <stable+bounces-244589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OjMHKGm/GmwSQAAu9opvQ
	(envelope-from <stable+bounces-244589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6534EA8AC
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 240E5304ABD0
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9942EEBC;
	Thu,  7 May 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K9REKb0N"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF142883B;
	Thu,  7 May 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164945; cv=none; b=byLNDEo3TS84/QwTOxy3GNhrF35iI+vWncW7NC8y4Np1FBC2VwtmHCoA12fy55shzYuPoauPJlOUfz1oyR5DXakp6CQy190XsVv+QAzNHt/hvN+u8UsUdSALTZG01lQh2mZcbbQaRyYAjf0OA7iWtrqb4emG1Fi7SE+OiwDE6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164945; c=relaxed/simple;
	bh=hSkB/ToOSucAybkXhmloG2Iy73IAWltint0+kMWv33M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0+19pQMSXpm8f3qwYnnbM8gKktkDvEda1/c5nkf4RazwqpDgtm1bMjqFMkMk2LTxgwuEdhKFy+fRhYT5PEZZQ1F5PGcS1Qatp3apb9XQ/UkM55gw5iJr1npZe195L15EQopVEk9u6ThTPCF2XUn0EFtXV3cjpoR+x/czZFYlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K9REKb0N; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B25C91A3568;
	Thu,  7 May 2026 14:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 873C660646;
	Thu,  7 May 2026 14:42:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89833108194EC;
	Thu,  7 May 2026 16:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164940; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uGyL4NeIjSoNBGK/yQ5ULcrXkbDaktVYoKhNYCw/tzs=;
	b=K9REKb0NCFbqeAuaBmO+Q3RGW/7+tbgpqSb39+dVVT9+gQVFByet5DcfvdyDXsFxG0iB9v
	Dyizg+mmogJQvZ+kE5UgcGLUi+dMUfrHQ7DLJX/fXfNj59hsgJy1Ye/zpKsXkGRiGLruEU
	xe30mLVcl1fW34ctMXk56Qojp1Rqo1XwRqvvmD2o2b/LKjlM6TbKyAYZX69ivJ2+kMpfOw
	c37xZM1K8DIXnD0HLK/AdEyesqkefSlEgeiDbJrG1pvcKggJpRztgZQthhEhQCzGHWbKyL
	Pwb825zfjrUD6Mzlbi8qT0EO+Qo1l7ybWNv7/PNY98pxNAW+qKTBc7bNpgFmpg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 07 May 2026 16:41:55 +0200
Subject: [PATCH v3 09/11] crypto: talitos/hash - rename
 first_desc/last_desc to first_request/last_request
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-bootlin_test-7-1-rc1_sec_bugfix-v3-9-c98d7589b942@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164923; l=4902;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=hSkB/ToOSucAybkXhmloG2Iy73IAWltint0+kMWv33M=;
 b=xHTyZu7Ps6N9uU+Deb4Rf7dXYFRZEgs2on+Ulii1Hem62k/P4Dxlo5LDbEhXUexu6RQvYUDbm
 gvsemm51tHJBNE/u5DpNUPPc/Nbqypl/VNB+kc7TSg0uqHzcBxzKoSG
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 6E6534EA8AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244589-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

In talitos_ahash_req_ctx and talitos_export_state, the fields
first_desc and last_desc describe request-level (not descriptor-level)
state.  Rename them to first_request and last_request for clarity.
last_desc is also removed from talitos_ahash_req_ctx as it is no
longer used.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 1f497930800b..6be42935068a 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -944,8 +944,7 @@ struct talitos_ahash_req_ctx {
 	u8 buf[2][HASH_MAX_BLOCK_SIZE];
 	int buf_idx;
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first_request;
 	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
@@ -957,8 +956,8 @@ struct talitos_export_state {
 	u32 hw_context[TALITOS_MDEU_MAX_CONTEXT_SIZE / sizeof(u32)];
 	u8 buf[HASH_MAX_BLOCK_SIZE];
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first_request;
+	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 };
@@ -1822,8 +1821,7 @@ static void ahash_done(struct device *dev,
 		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-
-	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
+	if (!req_ctx->last_request && req_ctx->to_hash_later) {
 		/* Position any partial block for next update/final/finup */
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
@@ -1872,7 +1870,7 @@ static void common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!edesc->first || !req_ctx->first_desc || req_ctx->swinit) {
+	if (!edesc->first || !req_ctx->first_request || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1880,7 +1878,7 @@ static void common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	}
 	/* Indicate next op is not the first. */
-	req_ctx->first_desc = 0;
+	req_ctx->first_request = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
@@ -1975,14 +1973,14 @@ ahash_process_req_prepare(struct ahash_request *areq, unsigned int nbytes,
 			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
 
 		/* request SEC to INIT hash. */
-		if (req_ctx->first_desc && edesc->first && !req_ctx->swinit)
+		if (req_ctx->first_request && edesc->first && !req_ctx->swinit)
 			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
 
 		/*
 		 * When the tfm context has a keylen, it's an HMAC.
 		 * A first or last (ie. not middle) descriptor must request HMAC.
 		 */
-		if (ctx->keylen && ((req_ctx->first_desc && edesc->first) ||
+		if (ctx->keylen && ((req_ctx->first_request && edesc->first) ||
 				    (req_ctx->last_request && edesc->last)))
 			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
 
@@ -2103,14 +2101,13 @@ static int ahash_init(struct ahash_request *areq)
 	/* Initialize the context */
 	req_ctx->buf_idx = 0;
 	req_ctx->nbuf = 0;
-	req_ctx->first_desc = 1; /* first_desc indicates h/w must init its context */
+	req_ctx->first_request = 1;
 	req_ctx->swinit = 0; /* assume h/w init of context */
 	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
 			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
 			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
 	req_ctx->hw_context_size = size;
 	req_ctx->last_request = 0;
-	req_ctx->last_desc = 0;
 
 	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
 			     DMA_TO_DEVICE);
@@ -2202,8 +2199,8 @@ static int ahash_export(struct ahash_request *areq, void *out)
 	       req_ctx->hw_context_size);
 	memcpy(export->buf, req_ctx->buf[req_ctx->buf_idx], req_ctx->nbuf);
 	export->swinit = req_ctx->swinit;
-	export->first_desc = req_ctx->first_desc;
-	export->last_desc = req_ctx->last_desc;
+	export->first_request = req_ctx->first_request;
+	export->last_request = req_ctx->last_request;
 	export->to_hash_later = req_ctx->to_hash_later;
 	export->nbuf = req_ctx->nbuf;
 
@@ -2228,8 +2225,8 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	memcpy(req_ctx->hw_context, export->hw_context, size);
 	memcpy(req_ctx->buf[0], export->buf, export->nbuf);
 	req_ctx->swinit = export->swinit;
-	req_ctx->first_desc = export->first_desc;
-	req_ctx->last_desc = export->last_desc;
+	req_ctx->first_request = export->first_request;
+	req_ctx->last_request = export->last_request;
 	req_ctx->to_hash_later = export->to_hash_later;
 	req_ctx->nbuf = export->nbuf;
 

-- 
2.54.0


