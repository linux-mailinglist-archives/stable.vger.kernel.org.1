Return-Path: <stable+bounces-43962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC578C5073
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8C51C21448
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669113D60F;
	Tue, 14 May 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oaHAQL9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294113D605;
	Tue, 14 May 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683372; cv=none; b=dj6G3V6/wNp8u9g4Wsmar9AO/5bCbwfERs2oG5rRIgEWmgDFB5Klf46dlPnHDl6IlVaAWlNjd8YqUoUSXUe1vIhb+7V0zJPHrN8vBlVVe2S20wD2Rue4pVbanUi8xXJxVOO5xHerb8KhSPzNwg9Jn3Vgm583E4sB3LY2J3EwyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683372; c=relaxed/simple;
	bh=7HqLMqWOSTxBVvrVFGLvUdVN1ynV7rtZiVCPJZy94BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCihdzyppQTbS7GJcbwn5R+jQS3YyEtbEIw/AQeIhmjRmZZZ4O0CeGWMlAdCfriLmKQjQnnF/v4evtx03N6cHa+OP4NQc+CLiMDxPRRkGJ/tzaowGZmm6eHCosymDFyEA5wbnts33RONE8aDV0+PsLhQBEGnmL2eT+dUudXj99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oaHAQL9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102CDC2BD10;
	Tue, 14 May 2024 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683372;
	bh=7HqLMqWOSTxBVvrVFGLvUdVN1ynV7rtZiVCPJZy94BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaHAQL9PlmGs3+9EgxUasq8GAdzzWDpm2TCXharVLCoBO+RQW6CQrVMbuWL78lVRW
	 zi+NqNFFDBAlVoIlCANZphLjpNDKxFEfVhMyzDdav55CT8IgCooMcyGl/kEUuI6gjf
	 gseUNAfiFABg0aY8HXqoll+pH4Qf7sujbDKzhj0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH 6.8 205/336] net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs
Date: Tue, 14 May 2024 12:16:49 +0200
Message-ID: <20240514101046.342475967@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit e0863634bf9f7cf36291ebb5bfa2d16632f79c49 ]

Currently the driver uses local_bh_disable()/local_bh_enable() in its
IRQ handler to avoid triggering net_rx_action() softirq on exit from
netif_rx(). The net_rx_action() could trigger this driver .start_xmit
callback, which is protected by the same lock as the IRQ handler, so
calling the .start_xmit from netif_rx() from the IRQ handler critical
section protected by the lock could lead to an attempt to claim the
already claimed lock, and a hang.

The local_bh_disable()/local_bh_enable() approach works only in case
the IRQ handler is protected by a spinlock, but does not work if the
IRQ handler is protected by mutex, i.e. this works for KS8851 with
Parallel bus interface, but not for KS8851 with SPI bus interface.

Remove the BH manipulation and instead of calling netif_rx() inside
the IRQ handler code protected by the lock, queue all the received
SKBs in the IRQ handler into a queue first, and once the IRQ handler
exits the critical section protected by the lock, dequeue all the
queued SKBs and push them all into netif_rx(). At this point, it is
safe to trigger the net_rx_action() softirq, since the netif_rx()
call is outside of the lock that protects the IRQ handler.

Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thread to fix hang")
Tested-by: Ronald Wahl <ronald.wahl@raritan.com> # KS8851 SPI
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240502183436.117117-1-marex@denx.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index d4cdf3d4f5525..502518cdb4618 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -234,12 +234,13 @@ static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
+ * @rxq: Queue of packets received in this function.
  *
  * This is called from the IRQ work queue when the system detects that there
  * are packets in the receive queue. Find out how many packets there are and
  * read them from the FIFO.
  */
-static void ks8851_rx_pkts(struct ks8851_net *ks)
+static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
 {
 	struct sk_buff *skb;
 	unsigned rxfc;
@@ -299,7 +300,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				__netif_rx(skb);
+				__skb_queue_tail(rxq, skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -326,11 +327,11 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
+	struct sk_buff_head rxq;
 	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
-
-	local_bh_disable();
+	struct sk_buff *skb;
 
 	ks8851_lock(ks, &flags);
 
@@ -384,7 +385,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		 * from the device so do not bother masking just the RX
 		 * from the device. */
 
-		ks8851_rx_pkts(ks);
+		__skb_queue_head_init(&rxq);
+		ks8851_rx_pkts(ks, &rxq);
 	}
 
 	/* if something stopped the rx process, probably due to wanting
@@ -408,7 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	local_bh_enable();
+	if (status & IRQ_RXI)
+		while ((skb = __skb_dequeue(&rxq)))
+			netif_rx(skb);
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0




