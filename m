Return-Path: <stable+bounces-85436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1E99E750
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E724286072
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6F1D5ACD;
	Tue, 15 Oct 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHB7OXhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBD1CFEA9;
	Tue, 15 Oct 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993109; cv=none; b=OMVmacDf/Pk/Noy51P4+btIENF4BEBQ5Ulp7B6rrkegQsX/HAik2VKcPr1x4kdY0nk6xlfdSGBSXJs18hUUy+EcMBP4/r9NThGcAdR0jvblkT5QdpxAxuczr1AtdLcDusuSrBpYUWeXLxMZHNsINdp4x00q3TtDu9LkOZxHcW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993109; c=relaxed/simple;
	bh=QWut94yMKlmqbE7HCJrEELiv9RSX3plG27HtPwtY53U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqbvJzLqvpMelPWmeleafqCg5MeFbvSmwkJ6HSdJsndYX9rFr/666XoUCD8tasnX6guhNJYANEgLU/8eq2YI6iaNMHcBMWMeKZ9ot9gTm1Z6tnfz6vMYdDPF2lesQXnq8JHMjapFSXb7W999L9DOXCRM5knwojdkTyvAKPaoPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHB7OXhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20DAC4CEC6;
	Tue, 15 Oct 2024 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993109;
	bh=QWut94yMKlmqbE7HCJrEELiv9RSX3plG27HtPwtY53U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHB7OXhQ4xaKRrS7A9JXZ9hyU/w+lgc5w2XUgzGWnEqIrBXffebYTpINRwfsLeNWx
	 oKDwvzHE15tZWhsBvjvMV45uaap9ADvyHF3KhCCD19h+x2EhbgZUltJv2uikVmCVRV
	 bk7Ph6B8EA/ynYlakwWph6+2G4Ofpi30aDz6Ry90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Hancock <robert.hancock@calian.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 282/691] net: axienet: Clean up DMA start/stop and error handling
Date: Tue, 15 Oct 2024 13:23:50 +0200
Message-ID: <20241015112451.537234521@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit 84b9ccc0749a7036bcaf707f02273dcbd4756fbf ]

Simplify the DMA error handling process, and remove some duplicated code
between the DMA error handling and the stop function.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 280 +++++++-----------
 1 file changed, 105 insertions(+), 175 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 50738ef43fb42..25b5054ad3e9b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -226,6 +226,44 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			  lp->rx_bd_p);
 }
 
+/**
+ * axienet_dma_start - Set up DMA registers and start DMA operation
+ * @lp:		Pointer to the axienet_local structure
+ */
+static void axienet_dma_start(struct axienet_local *lp)
+{
+	u32 rx_cr, tx_cr;
+
+	/* Start updating the Rx channel control register */
+	rx_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
+		(XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
+		XAXIDMA_IRQ_ALL_MASK;
+	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, rx_cr);
+
+	/* Start updating the Tx channel control register */
+	tx_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
+		(XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
+		XAXIDMA_IRQ_ALL_MASK;
+	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, tx_cr);
+
+	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
+	 * halted state. This will make the Rx side ready for reception.
+	 */
+	axienet_dma_out_addr(lp, XAXIDMA_RX_CDESC_OFFSET, lp->rx_bd_p);
+	rx_cr |= XAXIDMA_CR_RUNSTOP_MASK;
+	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, rx_cr);
+	axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
+			     (sizeof(*lp->rx_bd_v) * (lp->rx_bd_num - 1)));
+
+	/* Write to the RS (Run-stop) bit in the Tx channel control register.
+	 * Tx channel is now ready to run. But only after we write to the
+	 * tail pointer register that the Tx channel will start transmitting.
+	 */
+	axienet_dma_out_addr(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
+	tx_cr |= XAXIDMA_CR_RUNSTOP_MASK;
+	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, tx_cr);
+}
+
 /**
  * axienet_dma_bd_init - Setup buffer descriptor rings for Axi DMA
  * @ndev:	Pointer to the net_device structure
@@ -238,7 +276,6 @@ static void axienet_dma_bd_release(struct net_device *ndev)
  */
 static int axienet_dma_bd_init(struct net_device *ndev)
 {
-	u32 cr;
 	int i;
 	struct sk_buff *skb;
 	struct axienet_local *lp = netdev_priv(ndev);
@@ -296,50 +333,7 @@ static int axienet_dma_bd_init(struct net_device *ndev)
 		lp->rx_bd_v[i].cntrl = lp->max_frm_size;
 	}
 
-	/* Start updating the Rx channel control register */
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	/* Update the interrupt coalesce count */
-	cr = ((cr & ~XAXIDMA_COALESCE_MASK) |
-	      ((lp->coalesce_count_rx) << XAXIDMA_COALESCE_SHIFT));
-	/* Update the delay timer count */
-	cr = ((cr & ~XAXIDMA_DELAY_MASK) |
-	      (XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
-	/* Enable coalesce, delay timer and error interrupts */
-	cr |= XAXIDMA_IRQ_ALL_MASK;
-	/* Write to the Rx channel control register */
-	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
-
-	/* Start updating the Tx channel control register */
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	/* Update the interrupt coalesce count */
-	cr = (((cr & ~XAXIDMA_COALESCE_MASK)) |
-	      ((lp->coalesce_count_tx) << XAXIDMA_COALESCE_SHIFT));
-	/* Update the delay timer count */
-	cr = (((cr & ~XAXIDMA_DELAY_MASK)) |
-	      (XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
-	/* Enable coalesce, delay timer and error interrupts */
-	cr |= XAXIDMA_IRQ_ALL_MASK;
-	/* Write to the Tx channel control register */
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
-	 * halted state. This will make the Rx side ready for reception.
-	 */
-	axienet_dma_out_addr(lp, XAXIDMA_RX_CDESC_OFFSET, lp->rx_bd_p);
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET,
-			  cr | XAXIDMA_CR_RUNSTOP_MASK);
-	axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
-			     (sizeof(*lp->rx_bd_v) * (lp->rx_bd_num - 1)));
-
-	/* Write to the RS (Run-stop) bit in the Tx channel control register.
-	 * Tx channel is now ready to run. But only after we write to the
-	 * tail pointer register that the Tx channel will start transmitting.
-	 */
-	axienet_dma_out_addr(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET,
-			  cr | XAXIDMA_CR_RUNSTOP_MASK);
+	axienet_dma_start(lp);
 
 	return 0;
 out:
@@ -531,6 +525,44 @@ static int __axienet_device_reset(struct axienet_local *lp)
 	return 0;
 }
 
+/**
+ * axienet_dma_stop - Stop DMA operation
+ * @lp:		Pointer to the axienet_local structure
+ */
+static void axienet_dma_stop(struct axienet_local *lp)
+{
+	int count;
+	u32 cr, sr;
+
+	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
+	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+	synchronize_irq(lp->rx_irq);
+
+	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
+	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
+	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+	synchronize_irq(lp->tx_irq);
+
+	/* Give DMAs a chance to halt gracefully */
+	sr = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+	for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
+		msleep(20);
+		sr = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+	}
+
+	sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+	for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
+		msleep(20);
+		sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+	}
+
+	/* Do a reset to ensure DMA is really stopped */
+	axienet_lock_mii(lp);
+	__axienet_device_reset(lp);
+	axienet_unlock_mii(lp);
+}
+
 /**
  * axienet_device_reset - Reset and initialize the Axi Ethernet hardware.
  * @ndev:	Pointer to the net_device structure
@@ -950,41 +982,27 @@ static void axienet_recv(struct net_device *ndev)
  */
 static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
 {
-	u32 cr;
 	unsigned int status;
 	struct net_device *ndev = _ndev;
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	status = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	if (status & (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK)) {
-		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
-		axienet_start_xmit_done(lp->ndev);
-		goto out;
-	}
+
 	if (!(status & XAXIDMA_IRQ_ALL_MASK))
 		return IRQ_NONE;
-	if (status & XAXIDMA_IRQ_ERROR_MASK) {
-		dev_err(&ndev->dev, "DMA Tx error 0x%x\n", status);
-		dev_err(&ndev->dev, "Current BD is at: 0x%x%08x\n",
-			(lp->tx_bd_v[lp->tx_bd_ci]).phys_msb,
-			(lp->tx_bd_v[lp->tx_bd_ci]).phys);
-
-		cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-		/* Disable coalesce, delay timer and error interrupts */
-		cr &= (~XAXIDMA_IRQ_ALL_MASK);
-		/* Write to the Tx channel control register */
-		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-		cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-		/* Disable coalesce, delay timer and error interrupts */
-		cr &= (~XAXIDMA_IRQ_ALL_MASK);
-		/* Write to the Rx channel control register */
-		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
 
+	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
+
+	if (unlikely(status & XAXIDMA_IRQ_ERROR_MASK)) {
+		netdev_err(ndev, "DMA Tx error 0x%x\n", status);
+		netdev_err(ndev, "Current BD is at: 0x%x%08x\n",
+			   (lp->tx_bd_v[lp->tx_bd_ci]).phys_msb,
+			   (lp->tx_bd_v[lp->tx_bd_ci]).phys);
 		schedule_work(&lp->dma_err_task);
-		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
+	} else {
+		axienet_start_xmit_done(lp->ndev);
 	}
-out:
+
 	return IRQ_HANDLED;
 }
 
@@ -1000,41 +1018,27 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
  */
 static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 {
-	u32 cr;
 	unsigned int status;
 	struct net_device *ndev = _ndev;
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	status = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	if (status & (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK)) {
-		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
-		axienet_recv(lp->ndev);
-		goto out;
-	}
+
 	if (!(status & XAXIDMA_IRQ_ALL_MASK))
 		return IRQ_NONE;
-	if (status & XAXIDMA_IRQ_ERROR_MASK) {
-		dev_err(&ndev->dev, "DMA Rx error 0x%x\n", status);
-		dev_err(&ndev->dev, "Current BD is at: 0x%x%08x\n",
-			(lp->rx_bd_v[lp->rx_bd_ci]).phys_msb,
-			(lp->rx_bd_v[lp->rx_bd_ci]).phys);
-
-		cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-		/* Disable coalesce, delay timer and error interrupts */
-		cr &= (~XAXIDMA_IRQ_ALL_MASK);
-		/* Finally write to the Tx channel control register */
-		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-		cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-		/* Disable coalesce, delay timer and error interrupts */
-		cr &= (~XAXIDMA_IRQ_ALL_MASK);
-		/* write to the Rx channel control register */
-		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
 
+	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
+
+	if (unlikely(status & XAXIDMA_IRQ_ERROR_MASK)) {
+		netdev_err(ndev, "DMA Rx error 0x%x\n", status);
+		netdev_err(ndev, "Current BD is at: 0x%x%08x\n",
+			   (lp->rx_bd_v[lp->rx_bd_ci]).phys_msb,
+			   (lp->rx_bd_v[lp->rx_bd_ci]).phys);
 		schedule_work(&lp->dma_err_task);
-		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
+	} else {
+		axienet_recv(lp->ndev);
 	}
-out:
+
 	return IRQ_HANDLED;
 }
 
@@ -1152,8 +1156,6 @@ static int axienet_open(struct net_device *ndev)
  */
 static int axienet_stop(struct net_device *ndev)
 {
-	u32 cr, sr;
-	int count;
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
@@ -1164,34 +1166,10 @@ static int axienet_stop(struct net_device *ndev)
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
-	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
-
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+	axienet_dma_stop(lp);
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
 
-	/* Give DMAs a chance to halt gracefully */
-	sr = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
-		msleep(20);
-		sr = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	}
-
-	sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
-		msleep(20);
-		sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	}
-
-	/* Do a reset to ensure DMA is really stopped */
-	axienet_lock_mii(lp);
-	__axienet_device_reset(lp);
-	axienet_unlock_mii(lp);
-
 	cancel_work_sync(&lp->dma_err_task);
 
 	if (lp->eth_irq > 0)
@@ -1748,22 +1726,17 @@ static const struct phylink_mac_ops axienet_phylink_ops = {
  */
 static void axienet_dma_err_handler(struct work_struct *work)
 {
+	u32 i;
 	u32 axienet_status;
-	u32 cr, i;
+	struct axidma_bd *cur_p;
 	struct axienet_local *lp = container_of(work, struct axienet_local,
 						dma_err_task);
 	struct net_device *ndev = lp->ndev;
-	struct axidma_bd *cur_p;
 
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
-	/* When we do an Axi Ethernet reset, it resets the complete core
-	 * including the MDIO. MDIO must be disabled before resetting.
-	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
-	 */
-	axienet_lock_mii(lp);
-	__axienet_device_reset(lp);
-	axienet_unlock_mii(lp);
+
+	axienet_dma_stop(lp);
 
 	for (i = 0; i < lp->tx_bd_num; i++) {
 		cur_p = &lp->tx_bd_v[i];
@@ -1803,50 +1776,7 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	lp->tx_bd_tail = 0;
 	lp->rx_bd_ci = 0;
 
-	/* Start updating the Rx channel control register */
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	/* Update the interrupt coalesce count */
-	cr = ((cr & ~XAXIDMA_COALESCE_MASK) |
-	      (XAXIDMA_DFT_RX_THRESHOLD << XAXIDMA_COALESCE_SHIFT));
-	/* Update the delay timer count */
-	cr = ((cr & ~XAXIDMA_DELAY_MASK) |
-	      (XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
-	/* Enable coalesce, delay timer and error interrupts */
-	cr |= XAXIDMA_IRQ_ALL_MASK;
-	/* Finally write to the Rx channel control register */
-	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
-
-	/* Start updating the Tx channel control register */
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	/* Update the interrupt coalesce count */
-	cr = (((cr & ~XAXIDMA_COALESCE_MASK)) |
-	      (XAXIDMA_DFT_TX_THRESHOLD << XAXIDMA_COALESCE_SHIFT));
-	/* Update the delay timer count */
-	cr = (((cr & ~XAXIDMA_DELAY_MASK)) |
-	      (XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
-	/* Enable coalesce, delay timer and error interrupts */
-	cr |= XAXIDMA_IRQ_ALL_MASK;
-	/* Finally write to the Tx channel control register */
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
-
-	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
-	 * halted state. This will make the Rx side ready for reception.
-	 */
-	axienet_dma_out_addr(lp, XAXIDMA_RX_CDESC_OFFSET, lp->rx_bd_p);
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET,
-			  cr | XAXIDMA_CR_RUNSTOP_MASK);
-	axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
-			     (sizeof(*lp->rx_bd_v) * (lp->rx_bd_num - 1)));
-
-	/* Write to the RS (Run-stop) bit in the Tx channel control register.
-	 * Tx channel is now ready to run. But only after we write to the
-	 * tail pointer register that the Tx channel will start transmitting
-	 */
-	axienet_dma_out_addr(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET,
-			  cr | XAXIDMA_CR_RUNSTOP_MASK);
+	axienet_dma_start(lp);
 
 	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
 	axienet_status &= ~XAE_RCW1_RX_MASK;
-- 
2.43.0




