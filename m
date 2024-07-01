Return-Path: <stable+bounces-56248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA291E276
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F53D1C20FA6
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6161662E3;
	Mon,  1 Jul 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+vQkSJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5346436
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844262; cv=none; b=PdDJyg+atf/D4zX04lIAKucPpe0E+I6mah13EzStOkJOAtOhvEVkuAm6ArI/MW5/jbPN2gStu4agEIbgorlUAXuW3OW9lAtNFPram3hw/ixHDrcVWqZwh9xwO0S1pgEpnUJ7tcIk5uiYVD+pPS8O0WLyKcLCFbe+N5UW0JCEe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844262; c=relaxed/simple;
	bh=z6LblBoCAZ9KwTpWeC0Y4KwgcQaqQL56TL6GsqRLN1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JgLDvuLuudyj1QRIejXDoATjss/spJvm8ePm/uUKD5q7IBaPUKeAtQedg5XUFadhINZ1vKIQmh2AMrRgNfWeoL8E0sbijHcqMOC20QDMfMMADpTyRP+ZooKuh8NLJQoedd61bISSJNqCNSLfmhL5adFxBRTONkg9XDWEKv+aGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+vQkSJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A11C116B1;
	Mon,  1 Jul 2024 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719844262;
	bh=z6LblBoCAZ9KwTpWeC0Y4KwgcQaqQL56TL6GsqRLN1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=g+vQkSJtRAn/YbrAq4Ur924wfM4sVfRn2Fn+t/mpp18xYgCahJE8sMLBCB9ZA7hxs
	 VsBmrg6XoSXtCLcJ6VWPf9hk0p2YG27MMoMukI5ewJee/xFFCAwgMiGx7NR0mLgslR
	 JBihkxE+NylynEio44AtCoLFloMkk+H5LuVzOm0w=
Subject: FAILED: patch "[PATCH] can: mcp251xfd: fix infinite loop when xmit fails" failed to apply to 5.15-stable tree
To: vitor.soares@toradex.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:30:05 +0200
Message-ID: <2024070105-reformat-gallantly-7ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d8fb63e46c884c898a38f061c2330f7729e75510
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070105-reformat-gallantly-7ae0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d8fb63e46c88 ("can: mcp251xfd: fix infinite loop when xmit fails")
9263c2e92be9 ("can: mcp251xfd: ring: add support for runtime configurable RX/TX ring parameters")
c9e6b80dfd48 ("can: mcp251xfd: update macros describing ring, FIFO and RAM layout")
0a1f2e6502a1 ("can: mcp251xfd: ring: prepare support for runtime configurable RX/TX ring parameters")
d86ba8db6af3 ("can: mcp251xfd: ethtool: add support")
a1439a5add62 ("can: mcp251xfd: ram: add helper function for runtime ring size calculation")
aada74220f00 ("can: mcp251xfd: mcp251xfd_priv: introduce macros specifying the number of supported TEF/RX/TX rings")
fa0b68df7c95 ("can: mcp251xfd: ring: mcp251xfd_ring_init(): checked RAM usage of ring setup")
62713f0d9a38 ("can: mcp251xfd: ring: change order of TX and RX FIFOs")
617283b9c4db ("can: mcp251xfd: ring: prepare to change order of TX and RX FIFOs")
d2d5397fcae1 ("can: mcp251xfd: mcp251xfd_ring_init(): split ring_init into separate functions")
c912f19ee382 ("can: mcp251xfd: introduce struct mcp251xfd_tx_ring::nr and ::fifo_nr and make use of it")
2a68dd8663ea ("can: mcp251xfd: add support for internal PLL")
e39ea1360ca7 ("can: mcp251xfd: mcp251xfd_chip_clock_init(): prepare for PLL support, wait for OSC ready")
14193ea2bfee ("can: mcp251xfd: mcp251xfd_chip_timestamp_init(): factor out into separate function")
1ba3690fa2c6 ("can: mcp251xfd: mcp251xfd_chip_sleep(): introduce function to bring chip into sleep mode")
3044a4f271d2 ("can: mcp251xfd: introduce and make use of mcp251xfd_is_fd_mode()")
55bc37c85587 ("can: mcp251xfd: move ring init into separate function")
335c818c5a7a ("can: mcp251xfd: move chip FIFO init into separate file")
1e846c7aeb06 ("can: mcp251xfd: move TEF handling into separate file")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8fb63e46c884c898a38f061c2330f7729e75510 Mon Sep 17 00:00:00 2001
From: Vitor Soares <vitor.soares@toradex.com>
Date: Fri, 17 May 2024 14:43:55 +0100
Subject: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails

When the mcp251xfd_start_xmit() function fails, the driver stops
processing messages, and the interrupt routine does not return,
running indefinitely even after killing the running application.

Error messages:
[  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
[  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
... and repeat forever.

The issue can be triggered when multiple devices share the same SPI
interface. And there is concurrent access to the bus.

The problem occurs because tx_ring->head increments even if
mcp251xfd_start_xmit() fails. Consequently, the driver skips one TX
package while still expecting a response in
mcp251xfd_handle_tefif_one().

Resolve the issue by starting a workqueue to write the tx obj
synchronously if err = -EBUSY. In case of another error, decrement
tx_ring->head, remove skb from the echo stack, and drop the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Link: https://lore.kernel.org/all/20240517134355.770777-1-ivitro@gmail.com
[mkl: use more imperative wording in patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..bf1589aef1fc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1618,11 +1618,20 @@ static int mcp251xfd_open(struct net_device *ndev)
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
+	priv->wq = alloc_ordered_workqueue("%s-mcp251xfd_wq",
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM,
+					   dev_name(&spi->dev));
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto out_can_rx_offload_disable;
+	}
+	INIT_WORK(&priv->tx_work, mcp251xfd_tx_obj_write_sync);
+
 	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
 				   IRQF_SHARED | IRQF_ONESHOT,
 				   dev_name(&spi->dev), priv);
 	if (err)
-		goto out_can_rx_offload_disable;
+		goto out_destroy_workqueue;
 
 	err = mcp251xfd_chip_interrupts_enable(priv);
 	if (err)
@@ -1634,6 +1643,8 @@ static int mcp251xfd_open(struct net_device *ndev)
 
  out_free_irq:
 	free_irq(spi->irq, priv);
+ out_destroy_workqueue:
+	destroy_workqueue(priv->wq);
  out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
@@ -1661,6 +1672,7 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	hrtimer_cancel(&priv->tx_irq_timer);
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
+	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
 	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..b1de8052a45c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -131,6 +131,39 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	tx_obj->xfer[0].len = len;
 }
 
+static void mcp251xfd_tx_failure_drop(const struct mcp251xfd_priv *priv,
+				      struct mcp251xfd_tx_ring *tx_ring,
+				      int err)
+{
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
+	unsigned int frame_len = 0;
+	u8 tx_head;
+
+	tx_ring->head--;
+	stats->tx_dropped++;
+	tx_head = mcp251xfd_get_tx_head(tx_ring);
+	can_free_echo_skb(ndev, tx_head, &frame_len);
+	netdev_completed_queue(ndev, 1, frame_len);
+	netif_wake_queue(ndev);
+
+	if (net_ratelimit())
+		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+}
+
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work)
+{
+	struct mcp251xfd_priv *priv = container_of(work, struct mcp251xfd_priv,
+						   tx_work);
+	struct mcp251xfd_tx_obj *tx_obj = priv->tx_work_obj;
+	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+	int err;
+
+	err = spi_sync(priv->spi, &tx_obj->msg);
+	if (err)
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+}
+
 static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
 				  struct mcp251xfd_tx_obj *tx_obj)
 {
@@ -162,6 +195,11 @@ static bool mcp251xfd_tx_busy(const struct mcp251xfd_priv *priv,
 	return false;
 }
 
+static bool mcp251xfd_work_busy(struct work_struct *work)
+{
+	return work_busy(work);
+}
+
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
@@ -175,7 +213,8 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
-	if (mcp251xfd_tx_busy(priv, tx_ring))
+	if (mcp251xfd_tx_busy(priv, tx_ring) ||
+	    mcp251xfd_work_busy(&priv->tx_work))
 		return NETDEV_TX_BUSY;
 
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
@@ -193,13 +232,13 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 		netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
-
-	return NETDEV_TX_OK;
-
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+	if (err == -EBUSY) {
+		netif_stop_queue(ndev);
+		priv->tx_work_obj = tx_obj;
+		queue_work(priv->wq, &priv->tx_work);
+	} else if (err) {
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..b35bfebd23f2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -633,6 +633,10 @@ struct mcp251xfd_priv {
 	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
 	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct mcp251xfd_tx_obj *tx_work_obj;
+
 	DECLARE_BITMAP(flags, __MCP251XFD_FLAGS_SIZE__);
 
 	u8 rx_ring_num;
@@ -952,6 +956,7 @@ void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev);
 


