Return-Path: <stable+bounces-232632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBcHGMpqzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:46:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479437345A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4A38300B470
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A491E9B35;
	Wed,  1 Apr 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no54+qVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679371E7C12
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004327; cv=none; b=tjqOPMOo+h3V696KnPQ1tSUJMMBPtZWIaiz3hCLOho/YizZHXVxfwdsfcpYvu+OalI23bQbGbRXk5LcE6ofoIXhLfGBofabrUmSULkpI6ryFt3R9Okuq09G9g07IsgAcpwmmKLX+FoB2u1mSoT4CLcSadF6N72UIskRU5+y2prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004327; c=relaxed/simple;
	bh=ioZmnuRlozyWUndKMeb3CS6uJXtzUiz1zS9mvy34YNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqOdfnN7gHhLG6nEQIeFn0/SWN2uBueQl17VI6TwjQX5n/unQkxUhumtW0Qed0YVq1sJVcov8hXGS04nEr9iyhaar4IBsergg12vYYeFFU8x0hs1tiGL92jRcroFAlQCfsdFVAKgmBs4WUrReDVXqXSfU21bnMZC+hUJC/PlHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no54+qVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6695DC19423;
	Wed,  1 Apr 2026 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775004327;
	bh=ioZmnuRlozyWUndKMeb3CS6uJXtzUiz1zS9mvy34YNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=no54+qVQMUAQAPE7SBT1Zm81n5DldTBRJyTM+5knASBIUXDLCjdFS+++fuvQP664L
	 XpKeblSLOL2RnCryb83emiCpXK8nrAothQwu4CLQ2RCU/fF4zoDA5Tv0HMPaEE1f5I
	 6ahmNtlX5j9ZbrfSBkQJMOm16SRvuDmKOJZ80Pam2UBYjhdn/sDJropKvCTz+54bDb
	 FtTGPnvy/nQ/S3ocmQhfVgx9SwfpijJ3VzDjZtCG72mz8rPU9umfezuGwFlOaiAvKU
	 Ycamy+HzG0KwLbyjucyoHe5FXGru3gAxTlPBzZTNIt1C70/tz62y+sp+yAzasZm/3A
	 3s9UYCp+DERsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Frank Li <Frank.Li@nxp.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Tue, 31 Mar 2026 20:45:24 -0400
Message-ID: <20260401004524.4038525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033033-anaconda-untruth-e995@gregkh>
References: <2026033033-anaconda-untruth-e995@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232632-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 3479437345A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

[ Upstream commit abb863e6213dc41a58ef8bb3289b7e77460dabf3 ]

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ replaced scoped_guard(spinlock_irqsave) with explicit spin_lock_irqsave/spin_unlock_irqrestore calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/rz-dmac.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index e6f8257c76672..17661e0513200 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -422,6 +422,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -473,12 +474,17 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	struct rz_dmac_desc *desc;
+	unsigned long irqflags;
 
 	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
 		__func__, channel->index, &src, &dest, len);
 
-	if (list_empty(&channel->ld_free))
+	spin_lock_irqsave(&channel->vc.lock, irqflags);
+
+	if (list_empty(&channel->ld_free)) {
+		spin_unlock_irqrestore(&channel->vc.lock, irqflags);
 		return NULL;
+	}
 
 	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
@@ -489,6 +495,9 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	desc->direction = DMA_MEM_TO_MEM;
 
 	list_move_tail(channel->ld_free.next, &channel->ld_queue);
+
+	spin_unlock_irqrestore(&channel->vc.lock, irqflags);
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -501,17 +510,21 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	struct rz_dmac_desc *desc;
 	struct scatterlist *sg;
+	unsigned long irqflags;
 	int dma_length = 0;
 	int i = 0;
 
-	if (list_empty(&channel->ld_free))
+	spin_lock_irqsave(&channel->vc.lock, irqflags);
+
+	if (list_empty(&channel->ld_free)) {
+		spin_unlock_irqrestore(&channel->vc.lock, irqflags);
 		return NULL;
+	}
 
 	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
+	for_each_sg(sgl, sg, sg_len, i)
 		dma_length += sg_dma_len(sg);
-	}
 
 	desc->type = RZ_DMAC_DESC_SLAVE_SG;
 	desc->sg = sgl;
@@ -525,6 +538,9 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		desc->dest = channel->dst_per_address;
 
 	list_move_tail(channel->ld_free.next, &channel->ld_queue);
+
+	spin_unlock_irqrestore(&channel->vc.lock, irqflags);
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
-- 
2.53.0


