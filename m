Return-Path: <stable+bounces-244241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLxQCUQv+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:56:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712B4D2633
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE0D30BE09B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F34A33F0;
	Tue,  5 May 2026 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j7mcfpQN"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE148C8C5;
	Tue,  5 May 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003639; cv=none; b=jyWt9vlaqJgP/CyoUdWYEmQOQkkTQ116eF8eY2LkDRQhk/VRBlRvDUb4HV5kb/x5PdKvb6nt4KVdjuc2R/2WKt+SOA8WuG4HDehFvHiAJH2LBWFc9B1Hrf/LCexNcMsqy6Kq1thtmKsWwLiw/FiwkzCKJKsZCY4WxEo2nzIvZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003639; c=relaxed/simple;
	bh=2HprfiJ0pisWR//NJMpSah5IqgwIGz1YNJLlOWkvG9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyQ/u6tv52rNOwqKgbsEhPnmFTyawNJisJyQJtsDnFgRDiHa61b7Z6uRidsWB1VJg8JtIm6MA1D1mBJjFxTcNadwQl+2r/s4SL0IVGsWVhgA7Dg5flMlVfN4UXTTyBdnTwuDdH2So2JJsZ4hbN0IwTRU3brbJHLv9C7kmCKx3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j7mcfpQN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 41366C5CD52;
	Tue,  5 May 2026 17:54:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 573F26053C;
	Tue,  5 May 2026 17:53:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22BE811AD040F;
	Tue,  5 May 2026 19:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778003634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FoC8tR9VPR8Ki1XrtOVKBVTKCTXbNjL0c7/3kI3kmHU=;
	b=j7mcfpQN7jZHrLFx98oEP4uvPoHlaVcyTxVKro8fIBlnD2yWSjHoykGJ9w1K4qaI2BOCbA
	6Xa5QJXvMsnC8NeIyzwmy2+E6DkRy/JCJ84odm6KzFtjfgcYzveKIc7CDakyJe+MSYcw0G
	6bJ5yFArVtJH+ewYR12n06XyjalO5oH61QR87cn0zCrvhV6YIskUDzb5g5OC/4e1ZZ86AY
	d9tiegsuJpTdS1WvRd0VhY0XhMiSlZslIOpNeRTmT/AwQTr4LYdvw+9mPllXJ2jxC18zdF
	/FV4dzIDNyTmVwhHu4QaCp0U+WXzNiWtw/i8furnU0hJAYOuC/RdzPtG9m8Hqw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 05 May 2026 19:53:05 +0200
Subject: [PATCH v2 04/12] crypto: talitos - move dma mapping code in
 talitos_submit() into a standalone dma_map_request() function
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-4-5818064bd190@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778003630; l=3486;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=2HprfiJ0pisWR//NJMpSah5IqgwIGz1YNJLlOWkvG9M=;
 b=29CIUBYQOQVX8MDt1numu7iV8eo+NfAQ71iNLQU0uuq+jrpS57+wumhSmgKX7I8LKvi/BHqeA
 4WXDaxIQ+RPBzvvmz2e9iIW72LJwumd9oYJRtaqoUedDyN6b4NKMoS9
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7712B4D2633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244241-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Previously added code to talitos_submit() in order to map an entire
descriptor chain.

Move that code into a standalone function to improve readability.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 79 ++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index e26689bf7c9d..3b1d8e34e86e 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -256,6 +256,48 @@ static int init_device(struct device *dev)
 	return 0;
 }
 
+static void dma_map_request(struct device *dev, struct talitos_request *request,
+			    struct talitos_desc *desc, bool is_sec1)
+{
+	struct talitos_edesc *edesc =
+		container_of(desc, struct talitos_edesc, desc);
+	dma_addr_t dma_desc, prev_dma_desc;
+	struct talitos_edesc *prev_edesc = NULL;
+
+	if (is_sec1) {
+		request->desc_chain = edesc->node.prev;
+
+		list_for_each_entry(edesc, request->desc_chain, node) {
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
+						   TALITOS_DESC_SIZE,
+						   DMA_TO_DEVICE);
+
+next:
+			prev_edesc = edesc;
+			prev_dma_desc = dma_desc;
+		}
+	} else {
+		request->dma_desc = dma_map_single(dev, desc, TALITOS_DESC_SIZE,
+						   DMA_BIDIRECTIONAL);
+		request->desc_chain = NULL;
+	}
+}
+
 /**
  * talitos_submit - submits a descriptor to the device for processing
  * @dev:	the SEC device to be used
@@ -274,10 +316,7 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 					   void *context, int error),
 			  void *context)
 {
-	struct talitos_edesc *edesc = container_of(desc, struct talitos_edesc, desc);
 	struct talitos_private *priv = dev_get_drvdata(dev);
-	dma_addr_t dma_desc, prev_dma_desc;
-	struct talitos_edesc *prev_edesc = NULL;
 	struct talitos_request *request;
 	unsigned long flags;
 	int head;
@@ -295,39 +334,7 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 	request = &priv->chan[ch].fifo[head];
 
 	/* map descriptor and save caller data */
-	if (is_sec1) {
-		request->desc_chain = edesc->node.prev;
-
-		list_for_each_entry(edesc, request->desc_chain, node) {
-			edesc->desc.hdr1 = edesc->desc.hdr;
-
-			dma_desc = dma_map_single(dev, &edesc->desc.hdr1,
-						  TALITOS_DESC_SIZE,
-						  DMA_BIDIRECTIONAL);
-
-			if (!prev_edesc) {
-				request->dma_desc = dma_desc;
-				goto next;
-			}
-
-			/* Chain in any previous descriptors. */
-
-			prev_edesc->desc.next_desc = cpu_to_be32(dma_desc);
-
-			dma_sync_single_for_device(dev, prev_dma_desc,
-						   TALITOS_DESC_SIZE,
-						   DMA_TO_DEVICE);
-
-next:
-			prev_edesc = edesc;
-			prev_dma_desc = dma_desc;
-		}
-	} else {
-		request->dma_desc = dma_map_single(dev, desc,
-						   TALITOS_DESC_SIZE,
-						   DMA_BIDIRECTIONAL);
-		request->desc_chain = NULL;
-	}
+	dma_map_request(dev, request, desc, is_sec1);
 	request->callback = callback;
 	request->context = context;
 

-- 
2.53.0


