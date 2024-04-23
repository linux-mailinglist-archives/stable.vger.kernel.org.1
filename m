Return-Path: <stable+bounces-40799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C38AF91C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7321F22248
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0C143C6F;
	Tue, 23 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hjs2ZDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F94143C4D;
	Tue, 23 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908470; cv=none; b=WZW4YF514JAoGUdxqliYQ6oHF+TeAJ+/u3ox0zH0Fk67Z34OFvGRqBud9Jr/rT2XEuHVQ7m4EjPGmVqU8ttavWbnZ0h6E1wNXOMwLPhcqq4tfaFuNY7omyKpRaKgIgDYp4GmH1fPOOjHXrIkp/2ds+IsUvD2ULWdgOYMG6fyyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908470; c=relaxed/simple;
	bh=eeqkELhaNhpszgfy/fjO5lrNR/buTgd4LsyGan6JZVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClzNP+6FMVq1oDTjt6lSaTiiw1r/LUtWy2ShVS17xbCuSCM4fBH5uRLLSXE+3ibWiFqWEJB2z7e2iSekVmrRxL9oJzOfxRBU3qGz8a0A2sxdNw/qR8/DLpbvRxA9tw+nTkQ2wnFD6duRfbKOTcs5DQNVOioQ2nnJ1w6LY9f/Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0hjs2ZDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D513C4AF09;
	Tue, 23 Apr 2024 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908470;
	bh=eeqkELhaNhpszgfy/fjO5lrNR/buTgd4LsyGan6JZVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0hjs2ZDZOwX473u+B0SAIZLBVJxTHxPq0YWFCutXZHaFoeZ3ShgI6HJUuqOfqab+i
	 yl8ewMMNG+sbYiQIlnKGU8NY3Cs96RWYgkkxDbfKpkmLI2UO1jJEiGHosoSqZ0xd50
	 kgq9ZW8AXWHgHPFAUoch7S3WKs9d7zwyum1kcV8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 036/158] net: stmmac: Fix IP-cores specific MAC capabilities
Date: Tue, 23 Apr 2024 14:37:38 -0700
Message-ID: <20240423213857.077780044@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 9cb54af214a7cdc91577ec083e5569f2ce2c86d8 ]

Here is the list of the MAC capabilities specific to the particular DW MAC
IP-cores currently supported by the driver:

DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
	   MAC_10 | MAC_100

DW GMAC:  MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_10 | MAC_100 | MAC_1000

Allwinner sun8i MAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
                     MAC_10 | MAC_100 | MAC_1000

DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
            MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
if there is more than 1 active Tx/Rx queues:
	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
           MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD

DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD

DW XLGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD |
          MAC_25000FD | MAC_40000FD | MAC_50000FD | MAC_100000FD

As you can see there are only two common capabilities:
MAC_ASYM_PAUSE | MAC_SYM_PAUSE.
Meanwhile what is currently implemented defines 10/100/1000 link speeds
for all IP-cores, which is definitely incorrect for DW MAC100, DW XGMAC
and DW XLGMAC devices.

Seeing the flow-control is implemented as a callback for each MAC IP-core
(see dwmac100_flow_ctrl(), dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(),
etc) and since the MAC-specific setup() method is supposed to be called
for each available DW MAC-based device, the capabilities initialization
can be freely moved to these setup() functions, thus correctly setting up
the MAC-capabilities for each IP-core (including the Allwinner Sun8i). A
new stmmac_link::caps field was specifically introduced for that so to
have all link-specific info preserved in a single structure.

Note the suggested change fixes three earlier commits at a time. The
commit 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC
supports") permitted the 10-100 link speeds and 1G half-duplex mode for DW
XGMAC IP-core even though it doesn't support them. The commit df7699c70c1b
("net: stmmac: Do not cut down 1G modes") incorrectly added the MAC1000
capability to the DW MAC100 IP-core. Similarly to the DW XGMAC the commit
8a880936e902 ("net: stmmac: Add XLGMII support") incorrectly permitted the
10-100 link speeds and 1G half-duplex mode for DW XLGMAC IP-core.

Fixes: 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC supports")
Fixes: df7699c70c1b ("net: stmmac: Do not cut down 1G modes")
Fixes: 8a880936e902 ("net: stmmac: Add XLGMII support")
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 ++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c   |  2 ++
 .../ethernet/stmicro/stmmac/dwmac100_core.c    |  2 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 10 ++++------
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    | 18 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  7 ++++---
 7 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 5ba606a596e77..5a1d46dcd5de0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -550,6 +550,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 struct mac_link {
+	u32 caps;
 	u32 speed_mask;
 	u32 speed10;
 	u32 speed100;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b21d99faa2d04..e1b761dcfa1dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1096,6 +1096,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3927609abc441..8555299443f4e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	mac->link.duplex = GMAC_CONTROL_DM;
 	mac->link.speed10 = GMAC_CONTROL_PS;
 	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index a6e8d7bd95886..7667d103cd0eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	dev_info(priv->device, "\tDWMAC100\n");
 
 	mac->pcsr = priv->ioaddr;
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100;
 	mac->link.duplex = MAC_CONTROL_F;
 	mac->link.speed10 = 0;
 	mac->link.speed100 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index ec6a13e644b36..a38226d7cc6a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -70,14 +70,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
 {
-	priv->phylink_config.mac_capabilities |= MAC_2500FD;
-
 	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
+		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
@@ -1385,6 +1381,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 	mac->link.duplex = GMAC_CONFIG_DM;
 	mac->link.speed10 = GMAC_CONFIG_PS;
 	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index e841e312077ef..f8e7775bb6336 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
-static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
-						 MAC_10000FD | MAC_25000FD |
-						 MAC_40000FD | MAC_50000FD |
-						 MAC_100000FD;
-}
-
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1540,7 +1532,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1601,7 +1592,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
@@ -1661,6 +1651,9 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD;
 	mac->link.duplex = 0;
 	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
 	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
@@ -1698,6 +1691,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD |
+			 MAC_40000FD | MAC_50000FD |
+			 MAC_100000FD;
 	mac->link.duplex = 0;
 	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
 	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a48277ed614f..83b732c30c1bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1225,12 +1225,11 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10 | MAC_100 | MAC_1000;
-
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
 
+	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
+
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
@@ -7288,6 +7287,8 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 
 	stmmac_mac_phylink_get_caps(priv);
 
+	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
+
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-- 
2.43.0




