Return-Path: <stable+bounces-244582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGjXAN2l/Gm5SQAAu9opvQ
	(envelope-from <stable+bounces-244582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:46:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1654EA74D
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D223075C59
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC540627F;
	Thu,  7 May 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vuAWxa2f"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A9406282
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164934; cv=none; b=k1zCwGdjOjxN2wlfoz3QgdBNqO0DzJpj/afK2SHdWTMOAdU6N21gKyNPGeojzBgf9NuDHe5YNgGkf1Pa17Tb/Kaq9QeP4X6geswN2hsIsIGr5TSYQ7i7ynGfZO6q7mcVwtqZZaFEoZnH9DodXeF+eAAHp5ASEp8NECgEakLvt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164934; c=relaxed/simple;
	bh=tgmSAC1yYrk9dsR4lgtNRiHwRKbEITfm7NYGKudZCXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuMWpGEiaL1xB9MpeBQlHPVf0DuRVhn9XUhPkBFciVedpRPpKlHmQF2JC36p1k91GvPw/igqxoi7Z8NZtm1t/7EHadxXCYoUGyBn1ArrV8pH8HYReypHKgyNSzIHL67EAMGmjWNxqJwQysFuLJDVWrP9Fm11e1iR3Y3+oYd6q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vuAWxa2f; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 22FDC4E42C18;
	Thu,  7 May 2026 14:42:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBB1960495;
	Thu,  7 May 2026 14:42:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79D45108194E8;
	Thu,  7 May 2026 16:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jkYIjWyWUk1nzGdUkssHblSGwBhJnrnDMZzy6dHJu+U=;
	b=vuAWxa2f4vESND0eRl6nvXKdbcdRVvefu0hXn3o07fpLUy4ENyb466S/bSBzFyN+I7d0WL
	EwUSjZweA7F2CeSvQq1RT9dIUGnnO33LfZtV75l66Vu/Rl823U0/RLKR70dzMD7daNsl14
	CMMliMlbE4vr4eCOMMtgIiRCxnNpCyWQgtaevsoekIs1EJqm8pTovUOfA6B1bJ6SYyd+oc
	kpUpIEda7tv1r7W33eWVyn+Wx0tmxjFMmUx/jkcQWOe4DjbQUiCDEP+zRdwxSNqJ8qeXNr
	B671Mu9S8ugNcYZelKKEsaPDK2xIUpMR8sld4ShhWPxZelWRx8F1anAuER/V5Q==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 07 May 2026 16:41:48 +0200
Subject: [PATCH v3 02/11] crypto: talitos - add chaining of arbitrary
 number of descriptor for the SEC1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-bootlin_test-7-1-rc1_sec_bugfix-v3-2-c98d7589b942@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164923; l=11196;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=tgmSAC1yYrk9dsR4lgtNRiHwRKbEITfm7NYGKudZCXo=;
 b=YoMe0enSv4jbBT1YPnZjByuC7a8np3dAq4SXpf1w4fCwBRQbMd0FMpCRPGQnzlsJgV7hnN0v8
 rLTadHrlGFsCD21t3Ccz/HUo+6FrmTGB/Ajt4dvgEMwobl3L5PVKYiX
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5B1654EA74D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244582-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

The SEC1 hardware can process a chain of descriptors without host
intervention. Only the hash implementation currently use this feature,
but with a chain of at most 2 descriptors added in commit 37b5e8897eb5
("crypto: talitos - chain in buffered data for ahash on SEC1").

Add supports for chaining an arbitrary number of descriptors in a chain.

Adapt the ahash implementation to make it compatible.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 180 ++++++++++++++++++++++++++++++++---------------
 drivers/crypto/talitos.h |   2 +
 2 files changed, 124 insertions(+), 58 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 440e19dc8de6..b0ebf99b94f5 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -273,7 +273,10 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 					   void *context, int error),
 			  void *context)
 {
+	struct talitos_edesc *edesc = container_of(desc, struct talitos_edesc, desc);
 	struct talitos_private *priv = dev_get_drvdata(dev);
+	dma_addr_t dma_desc, prev_dma_desc;
+	struct talitos_edesc *prev_edesc = NULL;
 	struct talitos_request *request;
 	unsigned long flags;
 	int head;
@@ -292,10 +295,31 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 
 	/* map descriptor and save caller data */
 	if (is_sec1) {
-		desc->hdr1 = desc->hdr;
-		request->dma_desc = dma_map_single(dev, &desc->hdr1,
+		while (edesc) {
+			edesc->desc.hdr1 = edesc->desc.hdr;
+
+			dma_desc = dma_map_single(dev, &edesc->desc.hdr1,
+						  TALITOS_DESC_SIZE,
+						  DMA_BIDIRECTIONAL);
+
+			if (!prev_edesc) {
+				request->dma_desc = dma_desc;
+				goto next;
+			}
+
+			/* Chain in any previous descriptors. */
+
+			prev_edesc->desc.next_desc = cpu_to_be32(dma_desc);
+
+			dma_sync_single_for_device(dev, prev_dma_desc,
 						   TALITOS_DESC_SIZE,
-						   DMA_BIDIRECTIONAL);
+						   DMA_TO_DEVICE);
+
+next:
+			prev_edesc = edesc;
+			prev_dma_desc = dma_desc;
+			edesc = edesc->next_desc;
+		}
 	} else {
 		request->dma_desc = dma_map_single(dev, desc,
 						   TALITOS_DESC_SIZE,
@@ -326,6 +350,7 @@ static __be32 get_request_hdr(struct device *dev,
 			      struct talitos_request *request, bool is_sec1)
 {
 	struct talitos_edesc *edesc;
+	dma_addr_t dma_desc;
 
 	if (!is_sec1) {
 		dma_sync_single_for_cpu(dev, request->dma_desc,
@@ -334,19 +359,17 @@ static __be32 get_request_hdr(struct device *dev,
 		return request->desc->hdr;
 	}
 
-	if (!request->desc->next_desc) {
-		dma_sync_single_for_cpu(dev, request->dma_desc,
-					TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
-		return request->desc->hdr1;
-	} else {
-		dma_sync_single_for_cpu(dev,
-					be32_to_cpu(request->desc->next_desc),
-					TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
-		edesc = container_of(request->desc, struct talitos_edesc, desc);
-
-		return ((struct talitos_desc *)(edesc->buf + edesc->dma_len))
-			->hdr1;
+	edesc = container_of(request->desc, struct talitos_edesc, desc);
+	dma_desc = request->dma_desc;
+	while (edesc->next_desc) {
+		dma_desc = be32_to_cpu(edesc->desc.next_desc);
+		edesc = edesc->next_desc;
 	}
+
+	dma_sync_single_for_cpu(dev, dma_desc, TALITOS_DESC_SIZE,
+				DMA_BIDIRECTIONAL);
+
+	return edesc->desc.hdr1;
 }
 
 /*
@@ -356,6 +379,7 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	struct talitos_request *request, saved_req;
+	struct talitos_edesc *edesc;
 	unsigned long flags;
 	int tail, status;
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -380,9 +404,22 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 			else
 				status = error;
 
-		dma_unmap_single(dev, request->dma_desc,
-				 TALITOS_DESC_SIZE,
-				 DMA_BIDIRECTIONAL);
+		if (is_sec1) {
+			dma_unmap_single(dev, request->dma_desc,
+					 TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+			edesc = container_of(request->desc,
+					     struct talitos_edesc, desc);
+			while (edesc->next_desc) {
+				dma_unmap_single(
+					dev, be32_to_cpu(edesc->desc.next_desc),
+					TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+				edesc = edesc->next_desc;
+			}
+		} else {
+			dma_unmap_single(dev, request->dma_desc,
+					TALITOS_DESC_SIZE,
+					DMA_BIDIRECTIONAL);
+		}
 
 		/* copy entries so we can call callback outside lock */
 		saved_req.desc = request->desc;
@@ -477,8 +514,12 @@ DEF_TALITOS2_DONE(ch1_3, TALITOS2_ISR_CH_1_3_DONE)
 static __be32 current_desc_hdr(struct device *dev, int ch)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
+	bool is_sec1 = has_ftr_sec1(priv);
+	struct talitos_request *request;
+	struct talitos_edesc *edesc;
 	int tail, iter;
 	dma_addr_t cur_desc;
+	__be32 hdr = 0;
 
 	cur_desc = ((u64)in_be32(priv->chan[ch].reg + TALITOS_CDPR)) << 32;
 	cur_desc |= in_be32(priv->chan[ch].reg + TALITOS_CDPR_LO);
@@ -489,27 +530,35 @@ static __be32 current_desc_hdr(struct device *dev, int ch)
 	}
 
 	tail = priv->chan[ch].tail;
-
 	iter = tail;
-	while (priv->chan[ch].fifo[iter].dma_desc != cur_desc &&
-	       priv->chan[ch].fifo[iter].desc->next_desc != cpu_to_be32(cur_desc)) {
-		iter = (iter + 1) & (priv->fifo_len - 1);
-		if (iter == tail) {
-			dev_err(dev, "couldn't locate current descriptor\n");
-			return 0;
+	do {
+		request = &priv->chan[ch].fifo[iter];
+
+		if (request->dma_desc == cur_desc) {
+			hdr = request->desc->hdr;
+		} else if (is_sec1) {
+			edesc = container_of(request->desc,
+					     struct talitos_edesc, desc);
+			while (edesc->next_desc) {
+				if (edesc->desc.next_desc ==
+				    cpu_to_be32(cur_desc)) {
+					hdr = edesc->next_desc->desc.hdr1;
+					break;
+				}
+				edesc = edesc->next_desc;
+			}
 		}
-	}
 
-	if (priv->chan[ch].fifo[iter].desc->next_desc == cpu_to_be32(cur_desc)) {
-		struct talitos_edesc *edesc;
+		if (hdr)
+			break;
 
-		edesc = container_of(priv->chan[ch].fifo[iter].desc,
-				     struct talitos_edesc, desc);
-		return ((struct talitos_desc *)
-			(edesc->buf + edesc->dma_len))->hdr;
-	}
+		iter = (iter + 1) & (priv->fifo_len - 1);
+	} while (iter != tail);
+
+	if (!hdr)
+		dev_err(dev, "couldn't locate current descriptor\n");
 
-	return priv->chan[ch].fifo[iter].desc->hdr;
+	return hdr;
 }
 
 /*
@@ -1408,10 +1457,6 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 		dma_len = 0;
 	}
 	alloc_len += icv_stashing ? authsize : 0;
-
-	/* if its a ahash, add space for a second desc next to the first one */
-	if (is_sec1 && !dst)
-		alloc_len += sizeof(struct talitos_desc);
 	alloc_len += ivsize;
 
 	edesc = kmalloc(ALIGN(alloc_len, dma_get_cache_alignment()), flags);
@@ -1427,6 +1472,7 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 	edesc->dst_nents = dst_nents;
 	edesc->iv_dma = iv_dma;
 	edesc->dma_len = dma_len;
+	edesc->next_desc = NULL;
 	if (dma_len)
 		edesc->dma_link_tbl = dma_map_single(dev, &edesc->link_tbl[0],
 						     edesc->dma_len,
@@ -1727,8 +1773,10 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 	struct talitos_desc *desc = &edesc->desc;
-	struct talitos_desc *desc2 = (struct talitos_desc *)
-				     (edesc->buf + edesc->dma_len);
+	struct talitos_desc *desc2;
+
+	if (desc->next_desc)
+		desc2 = &edesc->next_desc->desc;
 
 	unmap_single_talitos_ptr(dev, &desc->ptr[5], DMA_FROM_DEVICE);
 	if (desc->next_desc &&
@@ -1756,10 +1804,17 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	if (edesc->dma_len)
 		dma_unmap_single(dev, edesc->dma_link_tbl, edesc->dma_len,
 				 DMA_BIDIRECTIONAL);
+}
 
-	if (desc->next_desc)
-		dma_unmap_single(dev, be32_to_cpu(desc->next_desc),
-				 TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+static void free_edesc_list_from(struct talitos_edesc *edesc)
+{
+	struct talitos_edesc *next;
+
+	while (edesc) {
+		next = edesc->next_desc;
+		kfree(edesc);
+		edesc = next;
+	}
 }
 
 static void ahash_done(struct device *dev,
@@ -1778,7 +1833,7 @@ static void ahash_done(struct device *dev,
 	}
 	common_nonsnoop_hash_unmap(dev, edesc, areq);
 
-	kfree(edesc);
+	free_edesc_list_from(edesc);
 
 	if (err) {
 		ahash_request_complete(areq, err);
@@ -1894,14 +1949,23 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
 
 	if (is_sec1 && req_ctx->nbuf && length) {
-		struct talitos_desc *desc2 = (struct talitos_desc *)
-					     (edesc->buf + edesc->dma_len);
-		dma_addr_t next_desc;
+		struct talitos_edesc *edesc2;
+		struct talitos_desc *desc2;
+
+		edesc2 = kzalloc(sizeof(*edesc2),
+				 areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+					 GFP_KERNEL :
+					 GFP_ATOMIC);
+		if (!edesc2) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		edesc->next_desc = edesc2;
+
+		desc2 = &edesc2->desc;
 
-		memset(desc2, 0, sizeof(*desc2));
 		desc2->hdr = desc->hdr;
 		desc2->hdr &= ~DESC_HDR_MODE0_MDEU_INIT;
-		desc2->hdr1 = desc2->hdr;
 		desc->hdr &= ~DESC_HDR_MODE0_MDEU_PAD;
 		desc->hdr |= DESC_HDR_MODE0_MDEU_CONT;
 		desc->hdr &= ~DESC_HDR_DONE_NOTIFY;
@@ -1925,21 +1989,21 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 						      req_ctx->hw_context_size,
 						      req_ctx->hw_context,
 						      DMA_FROM_DEVICE);
-
-		next_desc = dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,
-					   DMA_BIDIRECTIONAL);
-		desc->next_desc = cpu_to_be32(next_desc);
 	}
 
 	if (sync_needed)
 		dma_sync_single_for_device(dev, edesc->dma_link_tbl,
 					   edesc->dma_len, DMA_BIDIRECTIONAL);
 
-	ret = talitos_submit(dev, ctx->ch, desc, callback, areq);
-	if (ret != -EINPROGRESS) {
-		common_nonsnoop_hash_unmap(dev, edesc, areq);
-		kfree(edesc);
-	}
+	ret = talitos_submit(dev, ctx->ch, desc, callback,
+			     areq);
+	if (ret != -EINPROGRESS)
+		goto err;
+
+	return -EINPROGRESS;
+err:
+	common_nonsnoop_hash_unmap(dev, edesc, areq);
+	kfree(edesc);
 	return ret;
 }
 
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 1a93ee355929..596f96bba3ef 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -49,6 +49,7 @@ struct talitos_desc {
  * @iv_dma: dma address of iv for checking continuity and link table
  * @dma_len: length of dma mapped link_tbl space
  * @dma_link_tbl: bus physical address of link_tbl/buf
+ * @next_desc: next descriptor
  * @desc: h/w descriptor
  * @link_tbl: input and output h/w link tables (if {src,dst}_nents > 1) (SEC2)
  * @buf: input and output buffeur (if {src,dst}_nents > 1) (SEC1)
@@ -63,6 +64,7 @@ struct talitos_edesc {
 	dma_addr_t iv_dma;
 	int dma_len;
 	dma_addr_t dma_link_tbl;
+	struct talitos_edesc *next_desc;
 	struct talitos_desc desc;
 	union {
 		DECLARE_FLEX_ARRAY(struct talitos_ptr, link_tbl);

-- 
2.54.0


