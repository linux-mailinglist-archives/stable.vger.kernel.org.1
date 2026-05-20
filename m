Return-Path: <stable+bounces-250885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEj4NSXwDWqo4wUAu9opvQ
	(envelope-from <stable+bounces-250885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B815C593E59
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6BB31B8D0B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C93F1AC7;
	Wed, 20 May 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l22v8lgq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB583E314D;
	Wed, 20 May 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296563; cv=none; b=BJ8ybd6n2a7vDZFmavhIuMnjUHS6IuLsTreb64fW56H4MysqYXXbUBCQ9BiMUL/QvUhvaZtwAT/wKY9B3btl+v1ieuA1sioVwJbW7ys8wHT9HJ6g/3zmJWIbZZ9eKVEWetkbFH7fGgky/LPvabysdgZqVKXTB2u2cy903FVnmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296563; c=relaxed/simple;
	bh=lDMa4p4jqpPGtkt/hmo7gbGNDCmOLGxCXfgAwtwkf94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+CZQgFVv/mEYhKFaYYzy4B5RT6Tst/gEkIoJXv6C6IzAX+/tw1BDdrUjCSQ+/rDqKH6hK9eePagW1xtZeBMcGpf9oyU3uhthlya3BxpKrtnCQsL/UHPb2eZwXtUcV3JwOUB4J8hkEg1r4tUnMX31bSSIYmHG+l4szJacQ4S20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l22v8lgq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469B01F000E9;
	Wed, 20 May 2026 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296558;
	bh=2L6VhVlUFRIaGKlkh8dSN816oErQHrJJsreq+9lNI0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l22v8lgq3PLJ3Xyl/rc2IlfHo3ArjXuW4j6+J7Nr0FGS+7xSjX/zkxMMX0+Qvbxmf
	 mdN2iJqAnybIrZIOJ4iS0ENZJ41xDqqo92uLStpA7ADeeCwTI/5n6FnRF/F5/oC8ke
	 vg8Cw3HLazSo+NwhRC3XKUyM/xAXhU+zaFRBah4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0845/1146] net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
Date: Wed, 20 May 2026 18:18:15 +0200
Message-ID: <20260520162207.358333165@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250885-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B815C593E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index ab166c1d04d30..be0fece69bc32 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1063,12 +1063,15 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 
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
@@ -1079,8 +1082,33 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
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




