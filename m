Return-Path: <stable+bounces-227127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKJNOMbiumm7cwIAu9opvQ
	(envelope-from <stable+bounces-227127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:37:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4137C2C0681
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7498A349800E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3780D3D5254;
	Wed, 18 Mar 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc6OTsSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B73D47AF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852440; cv=none; b=KsHPFdk7OYcshjaPS2o2tIlyXvuw4M2vwhOLcpFyOqUc26WPDELunYvXTPSziKepaR8Rwtd1FpSgBqRnMWE1FgiJfmgPmUEV29wvI4HaU+wGOzzeK1wny7rZQGDt7HSf8BWLpgbRoS0RrCtilIkNLPjUL+okdvwOlSY5KGhHdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852440; c=relaxed/simple;
	bh=oBwZY4a2G/Yeig3bVPBK0J/l6hJbOqO9843f0ckrj3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIDD9OQqgL8KH7j6VemasR9risFSyExozzUrpCLQXa0EyhQCzL2LWFjuyA9jnVX9GKlLN4SyjL6FOEei3KvcM6o23RgZh2RWfsGIWP0BL8Bl1v0jhIhWZMw44EGByCQuFD7XgHihyxbbqfwsTkaq0P5aU/htnOJWcxXBvdGc2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc6OTsSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED263C2BC87;
	Wed, 18 Mar 2026 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773852439;
	bh=oBwZY4a2G/Yeig3bVPBK0J/l6hJbOqO9843f0ckrj3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hc6OTsSuH7q8lOzDI3EYimlve55b/Xo3fNCrnAAzY9GhtwdM8usTyUxo2tp7kFN/Y
	 74K1H2xiuKTZHWyw7BFEIKDP4bA0XpZ3Z6WrPaIjjvEbXoj7z2L0ci0lVSSdWUSSAq
	 0YVZoyEIqYiKdP9TxVSalPpYqIIEYOjXmUhmLSVZcgvLFx/E17Q7zBjwvdcbXSefIz
	 ZjPSYVMmZhRjiD2SdIYstU5h+xMeKHBYOwttsvymMauJJg7IxWjkZBAz/iTa3uX1ze
	 XKe8dajtzh8W+k3Rdj8NvZ5nzJXQybtldbImfopw7hROgU5XGZI95zJDjW/osGjenE
	 gnoAY8OmcqZ+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Quanyang Wang <quanyang.wang@windriver.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: macb: Shuffle the tx ring before enabling tx
Date: Wed, 18 Mar 2026 12:47:17 -0400
Message-ID: <20260318164717.1118974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031734-fasting-frosted-346c@gregkh>
References: <2026031734-fasting-frosted-346c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,windriver.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227127-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:url,msgid.link:url,windriver.com:email]
X-Rspamd-Queue-Id: 4137C2C0681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 881a0263d502e1a93ebc13a78254e9ad19520232 ]

Quanyang observed that when using an NFS rootfs on an AMD ZynqMp board,
the rootfs may take an extended time to recover after a suspend.
Upon investigation, it was determined that the issue originates from a
problem in the macb driver.

According to the Zynq UltraScale TRM [1], when transmit is disabled,
the transmit buffer queue pointer resets to point to the address
specified by the transmit buffer queue base address register.

In the current implementation, the code merely resets `queue->tx_head`
and `queue->tx_tail` to '0'. This approach presents several issues:

- Packets already queued in the tx ring are silently lost,
  leading to memory leaks since the associated skbs cannot be released.

- Concurrent write access to `queue->tx_head` and `queue->tx_tail` may
  occur from `macb_tx_poll()` or `macb_start_xmit()` when these values
  are reset to '0'.

- The transmission may become stuck on a packet that has already been sent
  out, with its 'TX_USED' bit set, but has not yet been processed. However,
  due to the manipulation of 'queue->tx_head' and 'queue->tx_tail',
  `macb_tx_poll()` incorrectly assumes there are no packets to handle
  because `queue->tx_head == queue->tx_tail`. This issue is only resolved
  when a new packet is placed at this position. This is the root cause of
  the prolonged recovery time observed for the NFS root filesystem.

To resolve this issue, shuffle the tx ring and tx skb array so that
the first unsent packet is positioned at the start of the tx ring.
Additionally, ensure that updates to `queue->tx_head` and
`queue->tx_tail` are properly protected with the appropriate lock.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Fixes: bf9cf80cab81 ("net: macb: Fix tx/rx malfunction after phy link down and up")
Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ #include context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 98 +++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1df1546a2d6e..e489bf739f58e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -38,6 +38,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/gcd.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -719,6 +720,97 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	netif_tx_stop_all_queues(ndev);
 }
 
+/* Use juggling algorithm to left rotate tx ring and tx skb array */
+static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
+{
+	unsigned int head, tail, count, ring_size, desc_size;
+	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
+	struct macb_dma_desc *desc_curr, *desc_next;
+	unsigned int i, cycles, shift, curr, next;
+	struct macb *bp = queue->bp;
+	unsigned char desc[24];
+	unsigned long flags;
+
+	desc_size = macb_dma_desc_get_size(bp);
+
+	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
+		return;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	head = queue->tx_head;
+	tail = queue->tx_tail;
+	ring_size = bp->tx_ring_size;
+	count = CIRC_CNT(head, tail, ring_size);
+
+	if (!(tail % ring_size))
+		goto unlock;
+
+	if (!count) {
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
+		goto unlock;
+	}
+
+	shift = tail % ring_size;
+	cycles = gcd(ring_size, shift);
+
+	for (i = 0; i < cycles; i++) {
+		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
+		memcpy(&tx_skb, macb_tx_skb(queue, i),
+		       sizeof(struct macb_tx_skb));
+
+		curr = i;
+		next = (curr + shift) % ring_size;
+
+		while (next != i) {
+			desc_curr = macb_tx_desc(queue, curr);
+			desc_next = macb_tx_desc(queue, next);
+
+			memcpy(desc_curr, desc_next, desc_size);
+
+			if (next == ring_size - 1)
+				desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
+			if (curr == ring_size - 1)
+				desc_curr->ctrl |= MACB_BIT(TX_WRAP);
+
+			skb_curr = macb_tx_skb(queue, curr);
+			skb_next = macb_tx_skb(queue, next);
+			memcpy(skb_curr, skb_next, sizeof(struct macb_tx_skb));
+
+			curr = next;
+			next = (curr + shift) % ring_size;
+		}
+
+		desc_curr = macb_tx_desc(queue, curr);
+		memcpy(desc_curr, &desc, desc_size);
+		if (i == ring_size - 1)
+			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
+		if (curr == ring_size - 1)
+			desc_curr->ctrl |= MACB_BIT(TX_WRAP);
+		memcpy(macb_tx_skb(queue, curr), &tx_skb,
+		       sizeof(struct macb_tx_skb));
+	}
+
+	queue->tx_head = count;
+	queue->tx_tail = 0;
+
+	/* Make descriptor updates visible to hardware */
+	wmb();
+
+unlock:
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
+}
+
+/* Rotate the queue so that the tail is at index 0 */
+static void gem_shuffle_tx_rings(struct macb *bp)
+{
+	struct macb_queue *queue;
+	int q;
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
+		gem_shuffle_tx_one_ring(queue);
+}
+
 static void macb_mac_link_up(struct phylink_config *config,
 			     struct phy_device *phy,
 			     unsigned int mode, phy_interface_t interface,
@@ -757,8 +849,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 			ctrl |= MACB_BIT(PAE);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			queue->tx_head = 0;
-			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 		}
@@ -772,8 +862,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		macb_set_tx_clk(bp, speed);
+		gem_shuffle_tx_rings(bp);
+	}
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);
-- 
2.51.0


