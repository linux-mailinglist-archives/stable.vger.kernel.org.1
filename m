Return-Path: <stable+bounces-223207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BIxEhqYqWm7AgEAu9opvQ
	(envelope-from <stable+bounces-223207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:50:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09F213D73
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7518031CBF4B
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC843A6F06;
	Thu,  5 Mar 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCBZ3zRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870713C918
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721221; cv=none; b=oG84A1As9P6iaob50FbflG2u70AKpO7NLEbH75MJQ5C8yExhqmmu7ITcKHi9+xXSTrC9uavkMEt1XMNiu2g91nXCDvdqPLAmMxCMbkolJ9F7l4aUSjkovTqUgw8CXkfRoy20+BVqJBd4No+eFKt+d26agNibrUUNiswEZHEqbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721221; c=relaxed/simple;
	bh=4eT3D3g80FssQI0tnFYVQ3K8PF/PCF8oq0EsRcjm9Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P2Ut6xPSbPx+iH+FFH+aTBUMB5SlWsmTXQLhBVUqK+ScrlhLVtUZCT7DbdaKAJ/x8Fox7gHwVrjcqYStRHRtqRHtfoS28o7fG4OZNj4Gv5wN8r0AjNsy+irh1779J9VhT1GnaeveMWQE9o0ZoPU+OoqENKVi715HLQh/IuVRF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCBZ3zRu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a019a7f3so98068841cf.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772721218; x=1773326018; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar9RsVFxBZUWUg9Rgu1+EQpRr9zNJUYue1v36pHePqE=;
        b=eCBZ3zRuBRDAwwjOr9SF6tlg/4ISvqp+ELeKSlP/qhznCz46G+zO8jPNj2Y4bqyEi3
         NobWUsmHNo9dE8j1VnrfeRmdf4ibuFA+gpx7X/1b7LoUCiAFDMsxeEEl2lRp1P4k2Wtw
         mV5OOs9yOx71ysXONl8XjD9caJ1nrygHxKvpRe4iMzkH4jxu5tJmfNSPhFfmZFQGYcDo
         oqBfNgE32xjTi3my7SmU1J9U0Ec/5pHZX7zlqqv9G7JRBvS0w9183LA0nrJuQ43V9JXP
         Eg8hirdOZjoK2c/ayBAQfAV3cHhdan5eVoha14ZEgsq2PcEjATm2z7+Oncm5am4xvbUC
         +CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721218; x=1773326018;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar9RsVFxBZUWUg9Rgu1+EQpRr9zNJUYue1v36pHePqE=;
        b=qi4ZB2Lnslzuv5n/7xVwVN6+UXKzzL+FfRCb2c+U6Ka6FLE9zXYllAWXmsvNKrEmCd
         c4Jrq8YBOPBPpV7ScQ6GLQpcjkK5NdWuos9XTMiaBJcjEhWwXIcd4D3hwG1k1+/4wwH/
         C+bCnkRpxTgPDbD9Tw7Qrage6UdjG04m0aK9YW8anhdyWumsugvYCtK+TdO5go8w5OC9
         aPgoFz+mTzfSY7WXQVw1Jjsyg3nZ5zKPGEXBt48/Z09TrrJSWi6IWZtot9AFP3hWdmzE
         vJBln1FGwsZVCQkpmJQ8L74PrN8OgPp2kftKahPmZxdzOp2/Rm7k/yVKDrYqFDsWHPh2
         h8+A==
X-Forwarded-Encrypted: i=1; AJvYcCU/Z0eeXyrarfkx1kIuitQIAh9d/hhz7BfpotXF4FBrvRWUngJbAQ16BchFY2xP+F75fm4ZB6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM6Vnmhvq4tgfPSlLgVfh3nwei7njGB8ujtr3MUjp5iKXbC9z
	rXtPfEUSpUdSigJdWCcdSKjUtJmorVj5nO/Zcz+HaRWaYD+Dfj6QdOtX
X-Gm-Gg: ATEYQzyak/sUj/ogProTZpJf+w+pe8ZxqE9Ow24W89AEZXTVLr/TurRV4oMQ/1OinC8
	tXlbrdHeB2jVfEE0V6p3zSd2FfvtNsDXAEkyRsVjgcbHD89ZtOoMnchec/RP5z0BZwBadrqNo8h
	ZbAr0C6BAUh2O4uHIJJqf6FAHMD+yqBs4KJU2Qr/o/u+wbJpqbP2XGvFPnvXIFuK4EzqI7nzq5I
	RkYMHqwmik7eShSSiLN06D88yQmkep+/5ZGt85wngxA+CJoWIIpqFtnP2oA7KGfCDkLzH96jnbH
	xy+z2hhaX0soGJB0K72KOm40FLZtXaUHSmgqfDILToDxqUG7keD7n2Iw7dNj11csH+Z4t8YICq/
	Jg2m+5Dl/IGlNboswkuA7jYi+vczkJ7htNaNEqduzHEtQs2hhvfCtgy98gWMjGxeGLPg8iM/iHV
	4E1JTlRRAmKGtypIOwwgCfN4QcO6gLunwu2k8n+BSNrRQ=
X-Received: by 2002:ac8:590d:0:b0:506:9d3e:67e3 with SMTP id d75a77b69052e-508db3ad17cmr73909121cf.70.1772721218001;
        Thu, 05 Mar 2026 06:33:38 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507512559b2sm155794251cf.17.2026.03.05.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:33:37 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Mar 2026 22:32:29 +0800
Subject: [PATCH net] net: macb: Shuffle the tx ring before enabling tx
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-zynqmp-v1-1-5de72254d56b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPyTqWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0MT3arKvMLcAl1zkxRj0zRjCzOjNAsloOKCotS0zAqwQdFKeaklSrG
 1tQBN2duEXQAAAA==
X-Change-ID: 20260214-zynqmp-74d35f3862f8
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, 
 Quanyang Wang <quanyang.wang@windriver.com>, stable@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 9B09F213D73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,windriver.com,vger.kernel.org,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tuxon.dev:email,amd.com:url,microchip.com:email,lunn.ch:email]
X-Rspamd-Action: no action

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
---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/net/ethernet/cadence/macb_main.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 17f0ad3d7a0924a7dc2fc0a13505aff7d2499ffa..fce144a1830823da9821ad3245784e62fed97e33 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/tcp.h>
 #include <linux/types.h>
 #include <linux/udp.h>
+#include <linux/gcd.h>
 #include <net/pkt_sched.h>
 #include "macb.h"
 
@@ -684,6 +685,88 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	netif_tx_stop_all_queues(ndev);
 }
 
+/* Use juggling algorithm to left rotate tx ring and tx skb array */
+static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
+{
+	unsigned int i, head, tail, count, size, cycles, shift, curr, next;
+	struct macb_dma_desc desc, *desc_curr, *desc_next;
+	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
+	struct macb *bp = queue->bp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	head = queue->tx_head;
+	tail = queue->tx_tail;
+	size = bp->tx_ring_size;
+	count = CIRC_CNT(head, tail, size);
+
+	if (!(tail % size))
+		goto unlock;
+
+	if (!count) {
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
+		goto unlock;
+	}
+
+	shift = tail % size;
+	cycles = gcd(size, shift);
+
+	for (i = 0; i < cycles; i++) {
+		memcpy(&desc, macb_tx_desc(queue, i), sizeof(struct macb_dma_desc));
+		memcpy(&tx_skb, macb_tx_skb(queue, i), sizeof(struct macb_tx_skb));
+
+		curr = i;
+		next = (curr + shift) % size;
+
+		while (next != i) {
+			desc_curr = macb_tx_desc(queue, curr);
+			desc_next = macb_tx_desc(queue, next);
+
+			memcpy(desc_curr, desc_next, sizeof(struct macb_dma_desc));
+
+			if (next == bp->tx_ring_size - 1)
+				desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
+			if (curr == bp->tx_ring_size - 1)
+				desc_curr->ctrl |= MACB_BIT(TX_WRAP);
+
+			skb_curr = macb_tx_skb(queue, curr);
+			skb_next = macb_tx_skb(queue, next);
+			memcpy(skb_curr, skb_next, sizeof(struct macb_tx_skb));
+
+			curr = next;
+			next = (curr + shift) % size;
+		}
+
+		desc_curr = macb_tx_desc(queue, curr);
+		memcpy(desc_curr, &desc, sizeof(struct macb_dma_desc));
+		if (i == bp->tx_ring_size - 1)
+			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
+		if (curr == bp->tx_ring_size - 1)
+			desc_curr->ctrl |= MACB_BIT(TX_WRAP);
+		memcpy(macb_tx_skb(queue, curr), &tx_skb, sizeof(struct macb_tx_skb));
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
@@ -722,8 +805,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 			ctrl |= MACB_BIT(PAE);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			queue->tx_head = 0;
-			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 		}
@@ -737,8 +818,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		macb_set_tx_clk(bp, speed);
+		gem_shuffle_tx_rings(bp);
+	}
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);

---
base-commit: fc7b1a72c6cd5cbbd989c6c32a6486e3e4e3594d
change-id: 20260214-zynqmp-74d35f3862f8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


