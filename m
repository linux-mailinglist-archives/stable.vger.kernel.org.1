Return-Path: <stable+bounces-223415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPVyMzjPq2lhhAEAu9opvQ
	(envelope-from <stable+bounces-223415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 08:09:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610B22A8E3
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 08:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DD923018432
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F536E478;
	Sat,  7 Mar 2026 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aju4W2lZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821733B6D0
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867377; cv=none; b=bYwEpAtRSijKqWnBunHWiACa7m04qD3WprOc3ZHsCxwQ2JOgscgBdFm/U3UX8QrheYXS4P+Kqc7Xx9YiNEI8Q8BMjYa/F2CJmoirqrwXR+H5QdceE/im+52aISF8qwXIvpbOCHSKheEN3+OD/g5KFte67igvy38bQGo8A2eWEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867377; c=relaxed/simple;
	bh=QL9BKetlDyYpgfINgsubMIhGmpsylXXyhHbGNaDmUEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pO4wg+GwSKj61Y3Wj803iQAlgZfbvvOMzjoJ/EqiHShPG4wdvokUEEeEMmw/5khl736fUgTdkanemNRNafjPC6hojtnKeQiHq+p9DIUvhQwtUPt4NjKQsNQodbWvq032QfNmxDKr3/tdAExSZXWQgQ+Dpr3RtD+PhPKTkv2QWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aju4W2lZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb40149037so1045493585a.2
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 23:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772867375; x=1773472175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Re/IoXRnVnrwqwk2PCf3MrXGdyviIMQnH+YNq0WCLs=;
        b=Aju4W2lZjwPnL77OAKXVOY8ZXs/20TjC3mZN4u11l/RVIuqAzj3oGc2Wc1qZpOsB6+
         LaY7czTpS62y1Lj9iuqOC3Zou193+3ZxsIv4x039tb8lScIeBBi0yV9nRtI4peM07dyF
         /pwXjJFiThdnWGRu8zek878NiajaXcvKe8f7mfQqdzJLFd3ZWk4cxzaHhRld6nYI9ubf
         vGztJV11a20RejJ+Yt6JdFO4q4ohfAH5VLq6VRiOzg/hIVsqlvRZ+jlHNMBqcNRQdTpr
         2rqGjNRKXRu8yITj+jJKyjmSVoM9ikG6k0WFNzTuTGAWz1XHYt5a/WkzhwQrDpTBRBcH
         wGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772867375; x=1773472175;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Re/IoXRnVnrwqwk2PCf3MrXGdyviIMQnH+YNq0WCLs=;
        b=mIcOPrZS2473ggJuwK6l3oSFDBNz/gTZJduSwVIU/GynJyt0lMzkpndoeYhqvKPsgl
         bAHuJ1g3/f7koXPPkjUJkjJznX/VTh6Ra0A7rom3za92zzGr54/tSKPRPpxrlcns8apr
         +kLSGmQ9CKcRk+aMAhsJxGrPD7pX3jVyneaG4iMo7NHRUMA1cgwmk0FofsLdmrCI2EXO
         PZgBbRsyfFLrMv1HW2/vHke9UuutxhGcrRxEdKxH9Cse4kLtqQoCi3VxX9zbEE7GdtGH
         +2yomAQdMkY1//NOGqI5t3bGsCbG5Vi/B9MER2ZJHCKwrX6GtIiqi3m86dvKSpsOlqw+
         FLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUhbHueawjMJXQ8PCS2++DxZbsDTUbrfBiZEu7cTywZg174LrPsz2egyxHZi7l3+XYFZXeE+J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYDNvtTGJQbOca+YGHOnTtID3f3tGZFOr4buDkL5h43JleIYe
	b2CYNfRS6qWbYyZ6Hkn1/p9TWjER/2pDLj2gQjFXbHjd7F2PkuCeP/hVvXBk+RY5buk=
X-Gm-Gg: ATEYQzznfr2r3O03CAIgKGtJq39nRcex0OdMsKoN8ji17PLRBKDFqsYf36eCWfSir0Z
	/Nwe55IPBywJkxnW+6UsS5bDBCeChdcaAebakdvi9kQZjs3btjlMpoqPhdn0Jh/7BYqIReaTlj2
	cn3It37pApOw3Cdn/K7h9I2eRiPROpgZvNfWIJZj97VvAQoUqCPJcPFFJV+brUayWKCnKM4od/B
	1HFTOqrK6/g85kkm7fQEg7/0yk9lI3RlE0DKDjjSPcFKQvUw7fjvl0fQp48OLUEaO40p7xcUoD4
	2Pvi8zQyiEJ5g1mXU1HcsBfTel9tKQNsBpm+bA5w5p9TOO3JuqPE3y8bC4lJ2pgYHBKy/iza3lZ
	NZpxsxMLmZo+55ebeyVX/MeYTWBm9fBDMVywqp+kKByyjotBh4sbIdLy5oy0S5vpNP6t9IJg3ye
	Y7psJr+Ery/wsUrdcLAqplnE/Qj/g9+4+4
X-Received: by 2002:a05:620a:1729:b0:8b2:dcde:b668 with SMTP id af79cd13be357-8cd6d51357emr597796685a.62.1772867374858;
        Fri, 06 Mar 2026 23:09:34 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f5736c0sm262405985a.49.2026.03.06.23.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:09:34 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 07 Mar 2026 15:08:54 +0800
Subject: [PATCH net v2] net: macb: Shuffle the tx ring before enabling tx
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-zynqmp-v2-1-6ef98a70e1d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAbPq2kC/zXMSwqDMBAG4KvIrJtiRhOlq96juLBmogM12kSkV
 nL3hkCX/4PvhECeKcCtOMHTzoEXlwJeChim3o0k2KQMWKIuUdbie7j3vIqmNpWyVavRtpDOqyf
 Lnww9wNEGXSonDtvij4zvMk/ZqUr1d3YppFCGGkRVG6Wf93Hu+XUdlhm6GOMP1dAmLaEAAAA=
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
X-Rspamd-Queue-Id: 4610B22A8E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223415-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,windriver.com,vger.kernel.org,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
Changes in v2:
- Resolves the issue of incomplete copying of the tx descriptor, as identified by the AI [1].

- Resolves warnings for lines exceeding 80 columns.

- Link to v1: https://lore.kernel.org/r/20260305-zynqmp-v1-1-5de72254d56b@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=44318d8b-d8c3-42c8-8884-238421f708c5
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
 drivers/net/ethernet/cadence/macb_main.c | 98 +++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3dcae4d5f74c9709a86fae837d25501da4484bf7..952aaf84757c20e94f3bbc98162a18330aa4cf73 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -37,6 +37,7 @@
 #include <linux/tcp.h>
 #include <linux/types.h>
 #include <linux/udp.h>
+#include <linux/gcd.h>
 #include <net/pkt_sched.h>
 #include "macb.h"
 
@@ -786,6 +787,97 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -824,8 +916,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 			ctrl |= MACB_BIT(PAE);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			queue->tx_head = 0;
-			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 		}
@@ -839,8 +929,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		macb_set_tx_clk(bp, speed);
+		gem_shuffle_tx_rings(bp);
+	}
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260214-zynqmp-74d35f3862f8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


