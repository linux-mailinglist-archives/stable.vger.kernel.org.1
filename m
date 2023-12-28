Return-Path: <stable+bounces-8653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BA81F80D
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876A91F2150D
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74B7466;
	Thu, 28 Dec 2023 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pT084p6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D987462
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C0AC433C8;
	Thu, 28 Dec 2023 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765304;
	bh=IIuVCOB8nQZ137v+xxIOtgbETkMvuzm4DBdOBZiZ71U=;
	h=Subject:To:Cc:From:Date:From;
	b=pT084p6OGh+W7Xb/SGsoYLZEqS+lbijNy+9gaPjNKJoETWzhju6GRxFYkP6DOie5d
	 Xr8hT3GrP2DCRaqpOzym+4LWDDZVHQUnZsEC3/MTO9k8+KLhDCDL53S2L4LweDw/dj
	 VvGoXsTVJjnCJjbwWLdMiMdBs8QUYTyl8d1oKb+E=
Subject: FAILED: patch "[PATCH] net: ks8851: Fix TX stall caused by TX buffer overrun" failed to apply to 4.14-stable tree
To: ronald.wahl@raritan.com,Tristram.Ha@microchip.com,ben.dooks@codethink.co.uk,davem@davemloft.net,edumazet@google.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:08:22 +0000
Message-ID: <2023122822-ankle-geiger-9d60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 3dc5d44545453de1de9c53cc529cc960a85933da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122822-ankle-geiger-9d60@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
b07f987a8d77 ("net: ks8851: Separate SPI operations into separate file")
7a552c850c45 ("net: ks8851: Implement register, FIFO, lock accessor callbacks")
d2a1c643a00e ("net: ks8851: Permit overridding interrupt enable register")
144ad36c3d3b ("net: ks8851: Factor out TX work flush function")
24be72632c68 ("net: ks8851: Split out SPI specific code from probe() and remove()")
d48b7634c692 ("net: ks8851: Split out SPI specific entries in struct ks8851_net")
18a3df730932 ("net: ks8851: Factor out SKB receive function")
22726020050b ("net: ks8851: Factor out bus lock handling")
aa39bf6730b7 ("net: ks8851: Use 16-bit read of RXFC register")
88cfedd0d7ab ("net: ks8851: Use 16-bit writes to program MAC address")
806f66495e79 ("net: ks8851: Remove ks8851_rdreg32()")
2c5b0a86ac54 ("net: ks8851: Use dev_{get,set}_drvdata()")
b6948e1b7b09 ("net: ks8851: Use devm_alloc_etherdev()")
bfd1e0eb08f6 ("net: ks8851: Rename ndev to netdev in probe")
d320692d9f85 ("net: ks8851: Factor out spi->dev in probe()/remove()")
aae079aa76d0 ("net: ks8851: Deduplicate register macros")
9624bafa5f64 ("net: ks8851: Set initial carrier state to down")
d268f3155279 ("net: ks8851: Delay requesting IRQ until opened")
761cfa979a0c ("net: ks8851: Reassert reset pin if chip ID check fails")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3dc5d44545453de1de9c53cc529cc960a85933da Mon Sep 17 00:00:00 2001
From: Ronald Wahl <ronald.wahl@raritan.com>
Date: Thu, 14 Dec 2023 19:11:12 +0100
Subject: [PATCH] net: ks8851: Fix TX stall caused by TX buffer overrun

There is a bug in the ks8851 Ethernet driver that more data is written
to the hardware TX buffer than actually available. This is caused by
wrong accounting of the free TX buffer space.

The driver maintains a tx_space variable that represents the TX buffer
space that is deemed to be free. The ks8851_start_xmit_spi() function
adds an SKB to a queue if tx_space is large enough and reduces tx_space
by the amount of buffer space it will later need in the TX buffer and
then schedules a work item. If there is not enough space then the TX
queue is stopped.

The worker function ks8851_tx_work() dequeues all the SKBs and writes
the data into the hardware TX buffer. The last packet will trigger an
interrupt after it was send. Here it is assumed that all data fits into
the TX buffer.

In the interrupt routine (which runs asynchronously because it is a
threaded interrupt) tx_space is updated with the current value from the
hardware. Also the TX queue is woken up again.

Now it could happen that after data was sent to the hardware and before
handling the TX interrupt new data is queued in ks8851_start_xmit_spi()
when the TX buffer space had still some space left. When the interrupt
is actually handled tx_space is updated from the hardware but now we
already have new SKBs queued that have not been written to the hardware
TX buffer yet. Since tx_space has been overwritten by the value from the
hardware the space is not accounted for.

Now we have more data queued then buffer space available in the hardware
and ks8851_tx_work() will potentially overrun the hardware TX buffer. In
many cases it will still work because often the buffer is written out
fast enough so that no overrun occurs but for example if the peer
throttles us via flow control then an overrun may happen.

This can be fixed in different ways. The most simple way would be to set
tx_space to 0 before writing data to the hardware TX buffer preventing
the queuing of more SKBs until the TX interrupt has been handled. I have
chosen a slightly more efficient (and still rather simple) way and
track the amount of data that is already queued and not yet written to
the hardware. When new SKBs are to be queued the already queued amount
of data is honoured when checking free TX buffer space.

I tested this with a setup of two linked KS8851 running iperf3 between
the two in bidirectional mode. Before the fix I got a stall after some
minutes. With the fix I saw now issues anymore after hours.

Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231214181112.76052-1-rwahl@gmx.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index fecd43754cea..e5ec0a363aff 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -350,6 +350,8 @@ union ks8851_tx_hdr {
  * @rxd: Space for receiving SPI data, in DMA-able space.
  * @txd: Space for transmitting SPI data, in DMA-able space.
  * @msg_enable: The message flags controlling driver output (see ethtool).
+ * @tx_space: Free space in the hardware TX buffer (cached copy of KS_TXMIR).
+ * @queued_len: Space required in hardware TX buffer for queued packets in txq.
  * @fid: Incrementing frame id tag.
  * @rc_ier: Cached copy of KS_IER.
  * @rc_ccr: Cached copy of KS_CCR.
@@ -399,6 +401,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;
 
 	struct sk_buff_head	txq;
+	unsigned int		queued_len;
 
 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index cfbc900d4aeb..0bf13b38b8f5 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -362,16 +362,18 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		handled |= IRQ_RXPSI;
 
 	if (status & IRQ_TXI) {
-		handled |= IRQ_TXI;
+		unsigned short tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 
-		/* no lock here, tx queue should have been stopped */
+		netif_dbg(ks, intr, ks->netdev,
+			  "%s: txspace %d\n", __func__, tx_space);
 
-		/* update our idea of how much tx space is available to the
-		 * system */
-		ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
+		spin_lock(&ks->statelock);
+		ks->tx_space = tx_space;
+		if (netif_queue_stopped(ks->netdev))
+			netif_wake_queue(ks->netdev);
+		spin_unlock(&ks->statelock);
 
-		netif_dbg(ks, intr, ks->netdev,
-			  "%s: txspace %d\n", __func__, ks->tx_space);
+		handled |= IRQ_TXI;
 	}
 
 	if (status & IRQ_RXI)
@@ -414,9 +416,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }
 
@@ -500,6 +499,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
+	ks->queued_len = 0;
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 70bc7253454f..88e26c120b48 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -286,6 +286,18 @@ static void ks8851_wrfifo_spi(struct ks8851_net *ks, struct sk_buff *txp,
 		netdev_err(ks->netdev, "%s: spi_sync() failed\n", __func__);
 }
 
+/**
+ * calc_txlen - calculate size of message to send packet
+ * @len: Length of data
+ *
+ * Returns the size of the TXFIFO message needed to send
+ * this packet.
+ */
+static unsigned int calc_txlen(unsigned int len)
+{
+	return ALIGN(len + 4, 4);
+}
+
 /**
  * ks8851_rx_skb_spi - receive skbuff
  * @ks: The device state
@@ -305,7 +317,9 @@ static void ks8851_rx_skb_spi(struct ks8851_net *ks, struct sk_buff *skb)
  */
 static void ks8851_tx_work(struct work_struct *work)
 {
+	unsigned int dequeued_len = 0;
 	struct ks8851_net_spi *kss;
+	unsigned short tx_space;
 	struct ks8851_net *ks;
 	unsigned long flags;
 	struct sk_buff *txb;
@@ -322,6 +336,8 @@ static void ks8851_tx_work(struct work_struct *work)
 		last = skb_queue_empty(&ks->txq);
 
 		if (txb) {
+			dequeued_len += calc_txlen(txb->len);
+
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
 					   ks->rc_rxqcr | RXQCR_SDA);
 			ks8851_wrfifo_spi(ks, txb, last);
@@ -332,6 +348,13 @@ static void ks8851_tx_work(struct work_struct *work)
 		}
 	}
 
+	tx_space = ks8851_rdreg16_spi(ks, KS_TXMIR);
+
+	spin_lock(&ks->statelock);
+	ks->queued_len -= dequeued_len;
+	ks->tx_space = tx_space;
+	spin_unlock(&ks->statelock);
+
 	ks8851_unlock_spi(ks, &flags);
 }
 
@@ -346,18 +369,6 @@ static void ks8851_flush_tx_work_spi(struct ks8851_net *ks)
 	flush_work(&kss->tx_work);
 }
 
-/**
- * calc_txlen - calculate size of message to send packet
- * @len: Length of data
- *
- * Returns the size of the TXFIFO message needed to send
- * this packet.
- */
-static unsigned int calc_txlen(unsigned int len)
-{
-	return ALIGN(len + 4, 4);
-}
-
 /**
  * ks8851_start_xmit_spi - transmit packet using SPI
  * @skb: The buffer to transmit
@@ -386,16 +397,17 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buff *skb,
 
 	spin_lock(&ks->statelock);
 
-	if (needed > ks->tx_space) {
+	if (ks->queued_len + needed > ks->tx_space) {
 		netif_stop_queue(dev);
 		ret = NETDEV_TX_BUSY;
 	} else {
-		ks->tx_space -= needed;
+		ks->queued_len += needed;
 		skb_queue_tail(&ks->txq, skb);
 	}
 
 	spin_unlock(&ks->statelock);
-	schedule_work(&kss->tx_work);
+	if (ret == NETDEV_TX_OK)
+		schedule_work(&kss->tx_work);
 
 	return ret;
 }


