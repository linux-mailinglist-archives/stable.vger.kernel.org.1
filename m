Return-Path: <stable+bounces-251904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OF/Bc4fDmp26QUAu9opvQ
	(envelope-from <stable+bounces-251904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:55:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAFD59A51E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1ED36440EC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE53F1AD9;
	Wed, 20 May 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GTXeOLom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C7349AFF;
	Wed, 20 May 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299191; cv=none; b=ItYCSfG7nZ6C1H4OlGKgsV+VRXELlgw4kVvXcwIgUaZ8am8qqw6Ahv5YcteYw21k2/EUz7LZZdW6ZrhqgyjwyeWv2NUOpsbFHISyH4PBdPJer+vNvurVnhiPfYX26iO15mCRdtkuHl+OrMhqydOwTWvQBMbZT61Aa+uuTnloh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299191; c=relaxed/simple;
	bh=tyTHx0iafAgXhiIrRTT8Lo/xGL3EkvxrXCxLSmHrRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvOQvNVtDOmyLTyZUt/tWhhu6w7vKIgG9FnufU3f6tkHHWP4O5vkprJ9oGj7kzFeb2AF1ayNpR99JZTuFfkENkunbvrOSeQfKBKX8ldCNGmNnUPvvsEhjQGcrISvdvM4EORm9MJbsD+G76tOnWEjXcujzul04OPr8WnWPTdHOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GTXeOLom; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B11B1F000E9;
	Wed, 20 May 2026 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299190;
	bh=fQUmozgWNP8OKrRu1b9yBPPGjZaXOiJOqgITzAO58eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTXeOLom5Y1JkTXNkP83WnZtmZKnIGpcjw+MDLLVQtJY7UHbDR6M+Xs9NrW3/U0CN
	 CvNbNYdXgM52nMVYykPBTnu0wT4hJmlnA4LVshFkoEypaPVBFBMdpWSIqVLnoifRqj
	 vaYi403ZmA+rpYOI/EfI1+zQ+PbrTE+iO5OhlCy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 696/957] net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
Date: Wed, 20 May 2026 18:19:39 +0200
Message-ID: <20260520162149.634191211@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251904-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 7CAFD59A51E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 3309965fe44c00fd65af7cef5016e9e782c021a7 ]

Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-2-e04bcc2c9642@kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 32 ++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9f6f517b5fdf9..f088f25128eb4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1094,12 +1094,15 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->qdma->eth;
-	int i;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int i, qid = q - &qdma->q_tx[0];
+	u16 index = 0;
 
 	spin_lock_bh(&q->lock);
 	for (i = 0; i < q->ndesc; i++) {
 		struct airoha_queue_entry *e = &q->entry[i];
+		struct airoha_qdma_desc *desc = &q->desc[i];
 
 		if (!e->dma_addr)
 			continue;
@@ -1110,8 +1113,33 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 		e->dma_addr = 0;
 		e->skb = NULL;
 		list_add_tail(&e->list, &q->tx_list);
+
+		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->ctrl, 0);
+		WRITE_ONCE(desc->addr, 0);
+		WRITE_ONCE(desc->data, 0);
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		WRITE_ONCE(desc->msg2, 0);
+
 		q->queued--;
 	}
+
+	if (!list_empty(&q->tx_list)) {
+		struct airoha_queue_entry *e;
+
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+				     list);
+		index = e - q->entry;
+	}
+	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+
 	spin_unlock_bh(&q->lock);
 }
 
-- 
2.53.0




