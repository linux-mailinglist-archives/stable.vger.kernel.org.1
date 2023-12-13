Return-Path: <stable+bounces-5667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48F80D5E2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A301B28239B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE875102B;
	Mon, 11 Dec 2023 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDWNgw1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20E5101A;
	Mon, 11 Dec 2023 18:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E2C433C7;
	Mon, 11 Dec 2023 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319342;
	bh=WzCbZJJfMNstGBM+IDyzIGZKV9yENqxwQ9fYmGbmneI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDWNgw1/NSw+hTxGp7hSkIJGXP2mFv9R76pDIUT1Piyxl3RcW0ypS8aMN5wA/Aao0
	 ZRlA3uvkbVLQ3+9XNXUqRd0efMz0oqrVWEG0kGXR7R9p462XwAVkTzKw5B+NnAeRPx
	 r4RecI8aFVK5Pc4mRQaPRVz6lVsJsJaE86oKHwmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Jianheng Zhang <Jianheng.Zhang@synopsys.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/244] net: stmmac: fix FPE events losing
Date: Mon, 11 Dec 2023 19:18:55 +0100
Message-ID: <20231211182047.697938241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianheng Zhang <Jianheng.Zhang@synopsys.com>

[ Upstream commit 37e4b8df27bc68340f3fc80dbb27e3549c7f881c ]

The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
handler missing FPE event status and leads to FPE handshaking failure and
retries.
To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
MAC_FPE_CTRL_STS in those methods.

Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Link: https://lore.kernel.org/r/CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 45 ++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  4 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 +++-
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  1 +
 include/linux/stmmac.h                        |  1 +
 7 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e95d35f1e5a0c..8fd167501fa0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 	}
 }
 
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
 
-	if (!enable) {
-		value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &= ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
-		return;
+	if (enable) {
+		cfg->fpe_csr = EFPE;
+		value = readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &= ~GMAC_RXQCTRL_FPRQ;
+		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr = 0;
 	}
-
-	value = readl(ioaddr + GMAC_RXQ_CTRL1);
-	value &= ~GMAC_RXQCTRL_FPRQ;
-	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-	writel(value, ioaddr + GMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |= EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
 }
 
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	status = FPE_EVENT_UNKNOWN;
 
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
 	value = readl(ioaddr + MAC_FPE_CTRL_STS);
 
 	if (value & TRSP) {
@@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	return status;
 }
 
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type)
 {
-	u32 value;
+	u32 value = cfg->fpe_csr;
 
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (type == MPACKET_VERIFY) {
-		value &= ~SRSP;
+	if (type == MPACKET_VERIFY)
 		value |= SVER;
-	} else {
-		value &= ~SVER;
+	else if (type == MPACKET_RESPONSE)
 		value |= SRSP;
-	}
 
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 53c138d0ff480..34e620790eb37 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 453e88b75be08..a74e71db79f94 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	return 0;
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index b95d3e1378136..68aa2d5ca6e56 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -412,9 +412,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fa4da96c8f50..69b9c71f0eded 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 	bool *hs_enable = &fpe_cfg->hs_enable;
 
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state = FPE_STATE_OFF;
 		*lp_state = FPE_STATE_OFF;
@@ -5803,6 +5804,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
 
@@ -7227,6 +7229,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 		if (*lo_state == FPE_STATE_ENTERING_ON &&
 		    *lp_state == FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7245,6 +7248,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7259,6 +7263,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
 	if (priv->plat->fpe_cfg->hs_enable != enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
@@ -7719,6 +7724,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4cbd2f0..6ad3e0a119366 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	priv->plat->fpe_cfg->enable = false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ce89cc3e49135..e3f7ee169c086 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -174,6 +174,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
 
 struct stmmac_safety_feature_cfg {
-- 
2.42.0




