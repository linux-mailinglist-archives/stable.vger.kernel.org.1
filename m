Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B070C5EE
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjEVTNf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjEVTNf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86EBCA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D9E61F18
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926BBC433EF;
        Mon, 22 May 2023 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782812;
        bh=gWZhqljVWe3mTlRaib7RFl77yUTaSGkJLlRkfcrpiCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zht6LrR32Nr+50JoAaifZIpIiHe+Ay0v8J0rJDEWlRj5en40qTxaU2AL+TZUS11J9
         QxHnnCefyvhFEcq31sdHsjsHhN4+9eytYB/n9H9/TdLuRciPE4u6qJR8XnfU9gdssW
         B4vHffIqySiKeDxWEwJKYs95lfyJeq4leqjl/oMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Cochran <richardcochran@gmail.com>,
        Wong Vee Khee <vee.khee.wong@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/203] net: stmmac: switch to use interrupt for hw crosstimestamping
Date:   Mon, 22 May 2023 20:07:11 +0100
Message-Id: <20230522190355.151217083@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wong Vee Khee <vee.khee.wong@linux.intel.com>

[ Upstream commit 76c16d3e19446deea98b7883f261758b96b8781a ]

Using current implementation of polling mode, there is high chances we
will hit into timeout error when running phc2sys. Hence, update the
implementation of hardware crosstimestamping to use the MAC interrupt
service routine instead of polling for TSIS bit in the MAC Timestamp
Interrupt Status register to be set.

Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Wong Vee Khee <vee.khee.wong@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 8efbdbfa9938 ("net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 25 ++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  3 ++-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  4 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  5 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 12 +--------
 include/linux/stmmac.h                        |  1 +
 7 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index fb9ff4ce94530..c9e88df9e8665 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -298,6 +298,11 @@ static void get_arttime(struct mii_bus *mii, int intel_adhoc_addr,
 	*art_time = ns;
 }
 
+static int stmmac_cross_ts_isr(struct stmmac_priv *priv)
+{
+	return (readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE);
+}
+
 static int intel_crosststamp(ktime_t *device,
 			     struct system_counterval_t *system,
 			     void *ctx)
@@ -313,8 +318,6 @@ static int intel_crosststamp(ktime_t *device,
 	u32 num_snapshot;
 	u32 gpio_value;
 	u32 acr_value;
-	int ret;
-	u32 v;
 	int i;
 
 	if (!boot_cpu_has(X86_FEATURE_ART))
@@ -328,6 +331,8 @@ static int intel_crosststamp(ktime_t *device,
 	if (priv->plat->ext_snapshot_en)
 		return -EBUSY;
 
+	priv->plat->int_snapshot_en = 1;
+
 	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
@@ -347,6 +352,7 @@ static int intel_crosststamp(ktime_t *device,
 		break;
 	default:
 		mutex_unlock(&priv->aux_ts_lock);
+		priv->plat->int_snapshot_en = 0;
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -368,13 +374,12 @@ static int intel_crosststamp(ktime_t *device,
 	gpio_value |= GMAC_GPO1;
 	writel(gpio_value, ioaddr + GMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + GMAC_INT_STATUS, v,
-				 (v & GMAC_INT_TSIE), 100, 10000);
-
-	if (ret == -ETIMEDOUT) {
-		pr_err("%s: Wait for time sync operation timeout\n", __func__);
-		return ret;
+	/* Time sync done Indication - Interrupt method */
+	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
+					      stmmac_cross_ts_isr(priv),
+					      HZ / 100)) {
+		priv->plat->int_snapshot_en = 0;
+		return -ETIMEDOUT;
 	}
 
 	num_snapshot = (readl(ioaddr + GMAC_TIMESTAMP_STATUS) &
@@ -392,6 +397,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	priv->plat->int_snapshot_en = 0;
 
 	return 0;
 }
@@ -576,6 +582,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->has_crossts = true;
 	plat->crosststamp = intel_crosststamp;
+	plat->int_snapshot_en = 0;
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 462ca7ed095a2..71dad409f78b0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -150,7 +150,8 @@
 #define	GMAC_PCS_IRQ_DEFAULT	(GMAC_INT_RGSMIIS | GMAC_INT_PCS_LINK |	\
 				 GMAC_INT_PCS_ANE)
 
-#define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN)
+#define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN | \
+				 GMAC_INT_TSIE)
 
 enum dwmac4_irq_status {
 	time_stamp_irq = 0x00001000,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cd85a2d076c99..0cb4d2d35786a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -23,6 +23,7 @@
 static void dwmac4_core_init(struct mac_device_info *hw,
 			     struct net_device *dev)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
 
@@ -58,6 +59,9 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 		value |= GMAC_INT_FPE_EN;
 
 	writel(value, ioaddr + GMAC_INT_EN);
+
+	if (GMAC_INT_DEFAULT_ENABLE & GMAC_INT_TSIE)
+		init_waitqueue_head(&priv->tstamp_busy_wait);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 05b5371ca036b..f03779205ade4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -265,6 +265,7 @@ struct stmmac_priv {
 	spinlock_t ptp_lock;
 	/* Protects auxiliary snapshot registers from concurrent access. */
 	struct mutex aux_ts_lock;
+	wait_queue_head_t tstamp_busy_wait;
 
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 4538e4fd81898..2c6245b2281ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -180,6 +180,11 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	u64 ptp_time;
 	int i;
 
+	if (priv->plat->int_snapshot_en) {
+		wake_up(&priv->tstamp_busy_wait);
+		return;
+	}
+
 	tsync_int = readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE;
 
 	if (!tsync_int)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 487418ef9b4f8..e6221c33572d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -175,11 +175,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	void __iomem *ptpaddr = priv->ptpaddr;
-	void __iomem *ioaddr = priv->hw->pcsr;
 	struct stmmac_pps_cfg *cfg;
-	u32 intr_value, acr_value;
 	int ret = -EOPNOTSUPP;
 	unsigned long flags;
+	u32 acr_value;
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
@@ -213,19 +212,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 			netdev_dbg(priv->dev, "Auxiliary Snapshot %d enabled.\n",
 				   priv->plat->ext_snapshot_num >>
 				   PTP_ACR_ATSEN_SHIFT);
-			/* Enable Timestamp Interrupt */
-			intr_value = readl(ioaddr + GMAC_INT_EN);
-			intr_value |= GMAC_INT_TSIE;
-			writel(intr_value, ioaddr + GMAC_INT_EN);
-
 		} else {
 			netdev_dbg(priv->dev, "Auxiliary Snapshot %d disabled.\n",
 				   priv->plat->ext_snapshot_num >>
 				   PTP_ACR_ATSEN_SHIFT);
-			/* Disable Timestamp Interrupt */
-			intr_value = readl(ioaddr + GMAC_INT_EN);
-			intr_value &= ~GMAC_INT_TSIE;
-			writel(intr_value, ioaddr + GMAC_INT_EN);
 		}
 		writel(acr_value, ptpaddr + PTP_ACR);
 		mutex_unlock(&priv->aux_ts_lock);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index cc338c6c74954..24bc3f7967c3b 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -260,6 +260,7 @@ struct plat_stmmacenet_data {
 	bool has_crossts;
 	int int_snapshot_num;
 	int ext_snapshot_num;
+	bool int_snapshot_en;
 	bool ext_snapshot_en;
 	bool multi_msi_en;
 	int msi_mac_vec;
-- 
2.39.2



