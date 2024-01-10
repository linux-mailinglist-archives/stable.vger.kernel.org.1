Return-Path: <stable+bounces-9514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7798232B9
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA641F24D17
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E21C280;
	Wed,  3 Jan 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0piIWsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB741BDF4;
	Wed,  3 Jan 2024 17:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACDCC433C8;
	Wed,  3 Jan 2024 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301843;
	bh=lc2ROPNA7gqqcqPwx0beeLyb4qlqLE1coJ87y7HYXnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0piIWsjb3OgF0AhSJkRz7TUo6cwAyUI+/Pk/iWMy6hEkCGB0E1vWXEPNYD4/cxPA
	 FbgneDQhriQ+eqCTAaLihG4+ofVJUYjXQHoBx52SLrYKoE8IOgeQZZpWRJWtdd3mGz
	 8uOONLrpRjoRtShSrpBv8q/54w9m7tZ0ulr/DvRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	netdev@vger.kernel.org,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 5.10 45/75] net: ks8851: Fix TX stall caused by TX buffer overrun
Date: Wed,  3 Jan 2024 17:55:26 +0100
Message-ID: <20240103164849.940037823@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit 3dc5d44545453de1de9c53cc529cc960a85933da upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/micrel/ks8851.h        |    3 ++
 drivers/net/ethernet/micrel/ks8851_common.c |   20 ++++++-------
 drivers/net/ethernet/micrel/ks8851_spi.c    |   42 ++++++++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

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
@@ -398,6 +400,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;
 
 	struct sk_buff_head	txq;
+	unsigned int		queued_len;
 
 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -363,16 +363,18 @@ static irqreturn_t ks8851_irq(int irq, v
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
@@ -415,9 +417,6 @@ static irqreturn_t ks8851_irq(int irq, v
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }
 
@@ -501,6 +500,7 @@ static int ks8851_net_open(struct net_de
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
+	ks->queued_len = 0;
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -289,6 +289,18 @@ static void ks8851_wrfifo_spi(struct ks8
 }
 
 /**
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
+/**
  * ks8851_rx_skb_spi - receive skbuff
  * @ks: The device state
  * @skb: The skbuff
@@ -307,7 +319,9 @@ static void ks8851_rx_skb_spi(struct ks8
  */
 static void ks8851_tx_work(struct work_struct *work)
 {
+	unsigned int dequeued_len = 0;
 	struct ks8851_net_spi *kss;
+	unsigned short tx_space;
 	struct ks8851_net *ks;
 	unsigned long flags;
 	struct sk_buff *txb;
@@ -324,6 +338,8 @@ static void ks8851_tx_work(struct work_s
 		last = skb_queue_empty(&ks->txq);
 
 		if (txb) {
+			dequeued_len += calc_txlen(txb->len);
+
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
 					   ks->rc_rxqcr | RXQCR_SDA);
 			ks8851_wrfifo_spi(ks, txb, last);
@@ -334,6 +350,13 @@ static void ks8851_tx_work(struct work_s
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
 
@@ -349,18 +372,6 @@ static void ks8851_flush_tx_work_spi(str
 }
 
 /**
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
-/**
  * ks8851_start_xmit_spi - transmit packet using SPI
  * @skb: The buffer to transmit
  * @dev: The device used to transmit the packet.
@@ -388,16 +399,17 @@ static netdev_tx_t ks8851_start_xmit_spi
 
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



