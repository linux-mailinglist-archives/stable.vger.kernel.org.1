Return-Path: <stable+bounces-7792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96875817759
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 17:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404B51C25A46
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832D4FF82;
	Mon, 18 Dec 2023 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q0Y3+3YF"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99967498B8;
	Mon, 18 Dec 2023 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFBAB1C0007;
	Mon, 18 Dec 2023 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702916601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoIlun1JjSNLq1gPPPffdSuDW5Li447GWbbWCncLmyA=;
	b=Q0Y3+3YFcjvtmsjkkyZnggtOd0FqkiUMbcG+QkwGU86eOMWuPJCx1ZdkI0+78dZnUggJZ0
	0st3qbEsedGVMjSWAxf1SMiDjjCWjjKkwSxGWB07hHjdqjTvhjbPcvribUtQg/VwW9/+aN
	dcnxHY//gbVkfAdSrwV1I8n0qp9TXl07bcArDAAEHbkM2mWDrUW9wCVhAQLKJBeLSRrmKm
	7Re+IMFCv44/OIEjDEog7WGjx5i+oKRJbC4uE96YYgDW3Z9RleP7xpsVwpmG5u8iOgb8xi
	fkdQG8kxJmOF3gNP5nE0Vy41QhFEgrvxRU3QTFlrdjCG8KUzAThf4CS3ARNvaw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Date: Mon, 18 Dec 2023 17:23:23 +0100
Message-ID: <20231218162326.173127-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218162326.173127-1-romain.gantois@bootlin.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

Some stmmac cores have Checksum Offload Engines that cannot handle DSA tags
properly. These cores find the IP/TCP headers on their own and end up
computing an incorrect checksum when a DSA tag is inserted between the MAC
header and IP header.

Add an additional check on stmmac link up so that COE is deactivated
when the stmmac device is used as a DSA conduit.

Add a new dma_feature flag to allow cores to signal that their COEs can't
handle DSA tags on TX.

Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
Cc: stable@vger.kernel.org
Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
Reported-by: Romain Gantois <romain.gantois@bootlin.com>
Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h     |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 +++++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index a381dee8b52d..1469d95e77a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -406,6 +406,7 @@ struct dma_features {
 	unsigned int rx_coe_type1;
 	unsigned int rx_coe_type2;
 	unsigned int rxfifo_over_2048;
+	unsigned int dsa_breaks_tx_coe;
 	/* TX and RX number of channels */
 	unsigned int number_rx_channel;
 	unsigned int number_tx_channel;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..50686cdc3320 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -264,6 +264,7 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
 	/* Alternate (enhanced) DESC mode */
 	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
+	dma_cap->dsa_breaks_tx_coe = 1;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9b6b383e863..733348c65e04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -42,6 +42,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
+#include <net/dsa.h>
 #include "stmmac_ptp.h"
 #include "stmmac.h"
 #include "stmmac_xdp.h"
@@ -993,8 +994,11 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 			       int speed, int duplex,
 			       bool tx_pause, bool rx_pause)
 {
-	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	unsigned int tx_queue_cnt;
 	u32 old_ctrl, ctrl;
+	int queue;
 
 	if ((priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
 	    priv->plat->serdes_powerup)
@@ -1102,6 +1106,16 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
+
+	/* DSA tags break COEs on some cores. Disable TX checksum
+	 * offloading on those cores if the netdevice is a DSA conduit.
+	 */
+	if (priv->dma_cap.dsa_breaks_tx_coe && netdev_uses_dsa(ndev)) {
+		tx_queue_cnt = priv->plat->tx_queues_to_use;
+		for (queue = 0; queue < tx_queue_cnt; queue++)
+			priv->plat->tx_queues_cfg[queue].coe_unsupported = true;
+	}
+
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
-- 
2.43.0


