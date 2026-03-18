Return-Path: <stable+bounces-227093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEP8DAO+ummqbQIAu9opvQ
	(envelope-from <stable+bounces-227093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:00:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BCE2BDB93
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DE7B301689B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B83DEAC5;
	Wed, 18 Mar 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKpsxvi5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467C3B9608
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846000; cv=none; b=a5oQfbcNI2sHglwKAolOWar95xHAYRfMVqdRK4qoxW6CQaqiXiVOogGiJaNWmtDgRwqUd67SHxCEzVy0/t2EF3GikCNVhLbfr0uD4lB+JMfC74lLs7QKHUVdiAni6E1qkzqtE2mXdLFvwdTGaHX0hVafhZZb5dSXkwKqpS0ie/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846000; c=relaxed/simple;
	bh=XgvN6mqLfK2aZBbXLWWDzLhP+575EYrwP1a0i2orxjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3oJfYKH/TBADTxeHdNRSC5mCkCEAxGnmTmF0pf6j2LklBcG4wkjFGkM1YHmr2an7Crbrw8ng0vED90tK9td8O9t/M889GoS0z9ENv7e5moAAEI70RgBJa2nbBlVzdxK1qzQeOxHA053cIuiUaVL9L2QdXBMruwGiuu2J2q40Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKpsxvi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31389C2BCB0;
	Wed, 18 Mar 2026 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773846000;
	bh=XgvN6mqLfK2aZBbXLWWDzLhP+575EYrwP1a0i2orxjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKpsxvi5JiXl/ouMVitHtWZSpaPcpWqnKSkRmvQNIYFDBuYkqKFNv075GqO4jWH8O
	 WfyvBNwLl16gZaULQiidAzKWb3qDqrjo0esTL97rjSL0cpH9wQ5t3XeTXqCle+F3Z6
	 X8biSbLyDicp7FNcYEK1xUuqcdZo6kohTkO48jy1zg02WazmUjmrbWCM/T75r09E9w
	 ubeVKbOIFf2GAvRhFCuEgLTHSgYzEYqnmWvo9ShcYYWJUf2ZwN9tqK+m1EDai7c/Pb
	 whTj9GiXEX41jSjLJA9mekb7e+Osc7lJOg3vtSzcOicfum3pvPKDmuvynULGf8/nmG
	 lM/PNhQJ/llNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Quanyang Wang <quanyang.wang@windriver.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net: macb: Shuffle the tx ring before enabling tx
Date: Wed, 18 Mar 2026 10:59:56 -0400
Message-ID: <20260318145956.858944-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318145956.858944-1-sashal@kernel.org>
References: <2026031732-womanless-smother-6439@gregkh>
 <20260318145956.858944-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,windriver.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227093-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:url]
X-Rspamd-Queue-Id: F3BCE2BDB93
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 98 +++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f168469f7a58c..35d258048aa0e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -37,6 +37,7 @@
 #include <linux/tcp.h>
 #include <linux/types.h>
 #include <linux/udp.h>
+#include <linux/gcd.h>
 #include <net/pkt_sched.h>
 #include "macb.h"
 
@@ -705,6 +706,97 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -743,8 +835,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 			ctrl |= MACB_BIT(PAE);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			queue->tx_head = 0;
-			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 		}
@@ -758,8 +848,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 
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


