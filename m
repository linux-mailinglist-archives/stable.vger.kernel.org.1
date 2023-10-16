Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB567CA225
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjJPIqd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjJPIqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A055B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1537C433C7;
        Mon, 16 Oct 2023 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445987;
        bh=UW4FsLEjWuETLjn7BK4+35A1ytSARoxip/BEv3PRW/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnQ5cjEUGA9OyX1A1Oj5+9Qd6Pj3du1orsmOZYsRn/cPtMXDRfSvtI5RVFW6EDrQg
         VvtM5FJC806cwfImLpdMk1FyAEt/RCIXyFUCXAnk7bKOrQbfUQqVHT2em/88h3hLVZ
         HPFCCvl7HtAj7qwNXDEVhHcQbCOSWHdVbq+mOesQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 026/102] eth: remove copies of the NAPI_POLL_WEIGHT define
Date:   Mon, 16 Oct 2023 10:40:25 +0200
Message-ID: <20231016083954.403720671@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 5f012b40ef639343a976553bf3cc26dd0474756e ]

Defining local versions of NAPI_POLL_WEIGHT with the same
values in the drivers just makes refactoring harder.

Drop the special defines in a bunch of drivers where the
removal is relatively simple so grouping into one patch
does not impact reviewability.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 66cf7435a269 ("xen-netback: use default TX queue size for vifs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c         | 4 +---
 drivers/net/ethernet/marvell/skge.c           | 3 +--
 drivers/net/ethernet/marvell/sky2.c           | 3 +--
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 +--
 drivers/net/ethernet/ti/davinci_emac.c        | 3 +--
 drivers/net/ethernet/ti/netcp_core.c          | 5 ++---
 drivers/net/xen-netback/interface.c           | 3 +--
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8361faf03e429..d0ba5ca862cf5 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -68,7 +68,6 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define DEFAULT_GMAC_RXQ_ORDER		9
 #define DEFAULT_GMAC_TXQ_ORDER		8
 #define DEFAULT_RX_BUF_ORDER		11
-#define DEFAULT_NAPI_WEIGHT		64
 #define TX_MAX_FRAGS			16
 #define TX_QUEUE_NUM			1	/* max: 6 */
 #define RX_MAX_ALLOC_ORDER		2
@@ -2466,8 +2465,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
-	netif_napi_add(netdev, &port->napi, gmac_napi_poll,
-		       DEFAULT_NAPI_WEIGHT);
+	netif_napi_add(netdev, &port->napi, gmac_napi_poll, NAPI_POLL_WEIGHT);
 
 	if (is_valid_ether_addr((void *)port->mac_addr)) {
 		memcpy(netdev->dev_addr, port->mac_addr, ETH_ALEN);
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 051dd3fb5b038..791a209158cd1 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -50,7 +50,6 @@
 #define PHY_RETRIES	        1000
 #define ETH_JUMBO_MTU		9000
 #define TX_WATCHDOG		(5 * HZ)
-#define NAPI_WEIGHT		64
 #define BLINK_MS		250
 #define LINK_HZ			HZ
 
@@ -3828,7 +3827,7 @@ static struct net_device *skge_devinit(struct skge_hw *hw, int port,
 		dev->features |= NETIF_F_HIGHDMA;
 
 	skge = netdev_priv(dev);
-	netif_napi_add(dev, &skge->napi, skge_poll, NAPI_WEIGHT);
+	netif_napi_add(dev, &skge->napi, skge_poll, NAPI_POLL_WEIGHT);
 	skge->netdev = dev;
 	skge->hw = hw;
 	skge->msg_enable = netif_msg_init(debug, default_msg);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index ac0dbf1b97437..a1a182bb47c77 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -63,7 +63,6 @@
 #define TX_DEF_PENDING		63
 
 #define TX_WATCHDOG		(5 * HZ)
-#define NAPI_WEIGHT		64
 #define PHY_RETRIES		1000
 
 #define SKY2_EEPROM_MAGIC	0x9955aabb
@@ -5073,7 +5072,7 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	netif_napi_add(dev, &hw->napi, sky2_poll, NAPI_WEIGHT);
+	netif_napi_add(dev, &hw->napi, sky2_poll, NAPI_POLL_WEIGHT);
 
 	err = register_netdev(dev);
 	if (err) {
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 1d5dd2015453f..8f3493e146e50 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -30,7 +30,6 @@
 #define MTK_STAR_WAIT_TIMEOUT			300
 #define MTK_STAR_MAX_FRAME_SIZE			1514
 #define MTK_STAR_SKB_ALIGNMENT			16
-#define MTK_STAR_NAPI_WEIGHT			64
 #define MTK_STAR_HASHTABLE_MC_LIMIT		256
 #define MTK_STAR_HASHTABLE_SIZE_MAX		512
 
@@ -1551,7 +1550,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &mtk_star_netdev_ops;
 	ndev->ethtool_ops = &mtk_star_ethtool_ops;
 
-	netif_napi_add(ndev, &priv->napi, mtk_star_poll, MTK_STAR_NAPI_WEIGHT);
+	netif_napi_add(ndev, &priv->napi, mtk_star_poll, NAPI_POLL_WEIGHT);
 
 	return devm_register_netdev(dev, ndev);
 }
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index fbd6bd80f51f4..305779f9685a7 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -113,7 +113,6 @@ static const char emac_version_string[] = "TI DaVinci EMAC Linux v6.1";
 #define EMAC_DEF_RX_NUM_DESC		(128)
 #define EMAC_DEF_MAX_TX_CH		(1) /* Max TX channels configured */
 #define EMAC_DEF_MAX_RX_CH		(1) /* Max RX channels configured */
-#define EMAC_POLL_WEIGHT		(64) /* Default NAPI poll weight */
 
 /* Buffer descriptor parameters */
 #define EMAC_DEF_TX_MAX_SERVICE		(32) /* TX max service BD's */
@@ -1923,7 +1922,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &ethtool_ops;
-	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
+	netif_napi_add(ndev, &priv->napi, emac_poll, NAPI_POLL_WEIGHT);
 
 	pm_runtime_enable(&pdev->dev);
 	rc = pm_runtime_get_sync(&pdev->dev);
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index a6450055908db..2f00be789a8a9 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -24,7 +24,6 @@
 #include "netcp.h"
 
 #define NETCP_SOP_OFFSET	(NET_IP_ALIGN + NET_SKB_PAD)
-#define NETCP_NAPI_WEIGHT	64
 #define NETCP_TX_TIMEOUT	(5 * HZ)
 #define NETCP_PACKET_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
 #define NETCP_MIN_PACKET_SIZE	ETH_ZLEN
@@ -2096,8 +2095,8 @@ static int netcp_create_interface(struct netcp_device *netcp_device,
 	}
 
 	/* NAPI register */
-	netif_napi_add(ndev, &netcp->rx_napi, netcp_rx_poll, NETCP_NAPI_WEIGHT);
-	netif_tx_napi_add(ndev, &netcp->tx_napi, netcp_tx_poll, NETCP_NAPI_WEIGHT);
+	netif_napi_add(ndev, &netcp->rx_napi, netcp_rx_poll, NAPI_POLL_WEIGHT);
+	netif_tx_napi_add(ndev, &netcp->tx_napi, netcp_tx_poll, NAPI_POLL_WEIGHT);
 
 	/* Register the network device */
 	ndev->dev_id		= 0;
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index e1a5610b1747e..e321669bc37af 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -42,7 +42,6 @@
 #include <xen/balloon.h>
 
 #define XENVIF_QUEUE_LENGTH 32
-#define XENVIF_NAPI_WEIGHT  64
 
 /* Number of bytes allowed on the internal guest Rx queue. */
 #define XENVIF_RX_QUEUE_BYTES (XEN_NETIF_RX_RING_SIZE/2 * PAGE_SIZE)
@@ -725,7 +724,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 	atomic_set(&queue->inflight_packets, 0);
 
 	netif_napi_add(queue->vif->dev, &queue->napi, xenvif_poll,
-			XENVIF_NAPI_WEIGHT);
+			NAPI_POLL_WEIGHT);
 
 	queue->stalled = true;
 
-- 
2.40.1



