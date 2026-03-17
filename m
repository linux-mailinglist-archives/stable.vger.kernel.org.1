Return-Path: <stable+bounces-225899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC3ACy5FuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:12:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9732A99CD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70AA30BCE8A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD33BD225;
	Tue, 17 Mar 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHb7iHvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B023BF663
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749274; cv=none; b=K1glk0jvG9hyqB7QsT4HJtpdoACvt2CZu3q14XGbTyxiRRKqkSFy9KKjfp7eC+brbqhtl1cCnb+Z4N3qcQnSBIBu9SL5Nyh06Z/rQXFj3veY2rU3tx9okH2pZ9idCQsG7t/VqD0nIiHRZL1relyFMvJ4fLhlGJA9NldHVl4y/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749274; c=relaxed/simple;
	bh=SZHMEM5yBUdw8OZCfukPf4gR1CbNqMl3FWNpBNNXVTE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mgUCrP9zEP1sbSf3KMXiaVuGjfZN8D9MTONDLjQXRGEWeKW+FLYmTLT9oze5XgMVsFEAjCeQ3dDGH2Mx42N+hLE2OsO+8mSrxEPoOv5/+qACLlUWexwGsFLYJAxLGAW/Qlxod/I/cXJVSnF8/UEJXaV0UGj/EiVVD1ofBXKJKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHb7iHvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E16C2BC86;
	Tue, 17 Mar 2026 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773749274;
	bh=SZHMEM5yBUdw8OZCfukPf4gR1CbNqMl3FWNpBNNXVTE=;
	h=Subject:To:Cc:From:Date:From;
	b=BHb7iHvLsS2/JsUZ9nsjPCQOcu7QIPXJ/Aolkp3heiHfPhBrRAPnVOhW8ixcPDOHW
	 vLBuWDasXNdXhnsdFgJBXKP5bSVhldEV6Mksk7/ZCH9/ATYLKC4NRsmPimcdsSXmNd
	 pNVhERr3DquB8ZDUMrDdN1Sw5wk77vOKlLdkF0dw=
Subject: FAILED: patch "[PATCH] net: macb: Shuffle the tx ring before enabling tx" failed to apply to 6.1-stable tree
To: haokexin@gmail.com,horms@kernel.org,kuba@kernel.org,quanyang.wang@windriver.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:07:35 +0100
Message-ID: <2026031735-sake-septum-dbad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225899-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,windriver.com:email,amd.com:url,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9C9732A99CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 881a0263d502e1a93ebc13a78254e9ad19520232
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031735-sake-septum-dbad@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 881a0263d502e1a93ebc13a78254e9ad19520232 Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 7 Mar 2026 15:08:54 +0800
Subject: [PATCH] net: macb: Shuffle the tx ring before enabling tx

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

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..f290d608b409 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/tcp.h>
 #include <linux/types.h>
 #include <linux/udp.h>
+#include <linux/gcd.h>
 #include <net/pkt_sched.h>
 #include "macb.h"
 
@@ -668,6 +669,97 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -706,8 +798,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 			ctrl |= MACB_BIT(PAE);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			queue->tx_head = 0;
-			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 		}
@@ -721,8 +811,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		macb_set_tx_clk(bp, speed);
+		gem_shuffle_tx_rings(bp);
+	}
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);


