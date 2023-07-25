Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D476136E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjGYLKs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjGYLKU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8A1BE9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E24061655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC3BC433C9;
        Tue, 25 Jul 2023 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283355;
        bh=yWOK5lxiR1g890UL6uKlmt5dZwRRFbdCTIwGwDPjaBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uExSp1dHn7aK9rC6W37SAsLt7SxlQB0W6Dp95U5PKeD49runottw5z5O26zh6TvEj
         hYyVSNqm1xPq/6NBLu+6cUDwy6tHz721Q+YbulqcON9Z0xk8e0qLwQ1Ap+MKEwNeFI
         URgwwAQlkPpQcdo+2gJFccLZhRS8aXoGgyDkmcW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 46/78] ethernet: use of_get_ethdev_address()
Date:   Tue, 25 Jul 2023 12:46:37 +0200
Message-ID: <20230725104453.068747127@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 9ca01b25dffffecf6c59339aad6b4736680e9fa3 ]

Use the new of_get_ethdev_address() helper for the cases
where dev->dev_addr is passed in directly as the destination.

  @@
  expression dev, np;
  @@
  - of_get_mac_address(np, dev->dev_addr)
  + of_get_ethdev_address(np, dev)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1d6d537dc55d ("net: ethernet: mtk_eth_soc: handle probe deferral")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c           |    2 +-
 drivers/net/ethernet/altera/altera_tse_main.c         |    2 +-
 drivers/net/ethernet/arc/emac_main.c                  |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c                 |    2 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c          |    2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c            |    2 +-
 drivers/net/ethernet/broadcom/bgmac-bcma.c            |    2 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c        |    2 +-
 drivers/net/ethernet/cadence/macb_main.c              |    2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c      |    2 +-
 drivers/net/ethernet/ethoc.c                          |    2 +-
 drivers/net/ethernet/ezchip/nps_enet.c                |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c          |    2 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |    2 +-
 drivers/net/ethernet/freescale/gianfar.c              |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c             |    2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c           |    2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c         |    2 +-
 drivers/net/ethernet/korina.c                         |    2 +-
 drivers/net/ethernet/lantiq_xrx200.c                  |    2 +-
 drivers/net/ethernet/litex/litex_liteeth.c            |    2 +-
 drivers/net/ethernet/marvell/mvneta.c                 |    2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c             |    2 +-
 drivers/net/ethernet/marvell/sky2.c                   |    2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c           |    2 +-
 drivers/net/ethernet/micrel/ks8851_common.c           |    2 +-
 drivers/net/ethernet/nxp/lpc_eth.c                    |    2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c               |    2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c              |    2 +-
 drivers/net/ethernet/renesas/ravb_main.c              |    2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c   |    2 +-
 drivers/net/ethernet/socionext/sni_ave.c              |    2 +-
 drivers/net/ethernet/ti/netcp_core.c                  |    2 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c         |    2 +-
 34 files changed, 34 insertions(+), 34 deletions(-)

--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -852,7 +852,7 @@ static int emac_probe(struct platform_de
 	}
 
 	/* Read MAC-address from DT */
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		/* if the MAC address is invalid get a random one */
 		eth_hw_addr_random(ndev);
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1531,7 +1531,7 @@ static int altera_tse_probe(struct platf
 	priv->rx_dma_buf_sz = ALTERA_RXDMABUFFER_SIZE;
 
 	/* get default MAC address from device tree */
-	ret = of_get_mac_address(pdev->dev.of_node, ndev->dev_addr);
+	ret = of_get_ethdev_address(pdev->dev.of_node, ndev);
 	if (ret)
 		eth_hw_addr_random(ndev);
 
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -941,7 +941,7 @@ int arc_emac_probe(struct net_device *nd
 	}
 
 	/* Get MAC address from device tree */
-	err = of_get_mac_address(dev->of_node, ndev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, ndev);
 	if (err)
 		eth_hw_addr_random(ndev);
 
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1964,7 +1964,7 @@ static int ag71xx_probe(struct platform_
 	ag->stop_desc->ctrl = 0;
 	ag->stop_desc->next = (u32)ag->stop_desc_dma;
 
-	err = of_get_mac_address(np, ndev->dev_addr);
+	err = of_get_ethdev_address(np, ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "invalid MAC address, using random address\n");
 		eth_random_addr(ndev->dev_addr);
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -719,7 +719,7 @@ static int bcm4908_enet_probe(struct pla
 		return err;
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
-	err = of_get_mac_address(dev->of_node, netdev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 	netdev->netdev_ops = &bcm4908_enet_netdev_ops;
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2561,7 +2561,7 @@ static int bcm_sysport_probe(struct plat
 	}
 
 	/* Initialize netdevice members */
-	ret = of_get_mac_address(dn, dev->dev_addr);
+	ret = of_get_ethdev_address(dn, dev);
 	if (ret) {
 		dev_warn(&pdev->dev, "using random Ethernet MAC\n");
 		eth_hw_addr_random(dev);
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -128,7 +128,7 @@ static int bgmac_probe(struct bcma_devic
 
 	bcma_set_drvdata(core, bgmac);
 
-	err = of_get_mac_address(bgmac->dev->of_node, bgmac->net_dev->dev_addr);
+	err = of_get_ethdev_address(bgmac->dev->of_node, bgmac->net_dev);
 	if (err == -EPROBE_DEFER)
 		return err;
 
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -192,7 +192,7 @@ static int bgmac_probe(struct platform_d
 	bgmac->dev = &pdev->dev;
 	bgmac->dma_dev = &pdev->dev;
 
-	ret = of_get_mac_address(np, bgmac->net_dev->dev_addr);
+	ret = of_get_ethdev_address(np, bgmac->net_dev);
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4835,7 +4835,7 @@ static int macb_probe(struct platform_de
 	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
 		bp->rx_intr_mask |= MACB_BIT(RXUBR);
 
-	err = of_get_mac_address(np, bp->dev->dev_addr);
+	err = of_get_ethdev_address(np, bp->dev);
 	if (err == -EPROBE_DEFER)
 		goto err_out_free_netdev;
 	else if (err)
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1501,7 +1501,7 @@ static int octeon_mgmt_probe(struct plat
 	netdev->min_mtu = 64 - OCTEON_MGMT_RX_HEADROOM;
 	netdev->max_mtu = 16383 - OCTEON_MGMT_RX_HEADROOM - VLAN_HLEN;
 
-	result = of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+	result = of_get_ethdev_address(pdev->dev.of_node, netdev);
 	if (result)
 		eth_hw_addr_random(netdev);
 
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1151,7 +1151,7 @@ static int ethoc_probe(struct platform_d
 		eth_hw_addr_set(netdev, pdata->hwaddr);
 		priv->phy_id = pdata->phy_id;
 	} else {
-		of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+		of_get_ethdev_address(pdev->dev.of_node, netdev);
 		priv->phy_id = -1;
 	}
 
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -601,7 +601,7 @@ static s32 nps_enet_probe(struct platfor
 	dev_dbg(dev, "Registers base address is 0x%p\n", priv->regs_base);
 
 	/* set kernel MAC address to dev */
-	err = of_get_mac_address(dev->of_node, ndev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, ndev);
 	if (err)
 		eth_hw_addr_random(ndev);
 
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -890,7 +890,7 @@ static int mpc52xx_fec_probe(struct plat
 	 *
 	 * First try to read MAC address from DT
 	 */
-	rv = of_get_mac_address(np, ndev->dev_addr);
+	rv = of_get_ethdev_address(np, ndev);
 	if (rv) {
 		struct mpc52xx_fec __iomem *fec = priv->fec;
 
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1005,7 +1005,7 @@ static int fs_enet_probe(struct platform
 	spin_lock_init(&fep->lock);
 	spin_lock_init(&fep->tx_lock);
 
-	of_get_mac_address(ofdev->dev.of_node, ndev->dev_addr);
+	of_get_ethdev_address(ofdev->dev.of_node, ndev);
 
 	ret = fep->ops->allocate_bd(ndev);
 	if (ret)
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -753,7 +753,7 @@ static int gfar_of_init(struct platform_
 	if (stash_len || stash_idx)
 		priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
 
-	err = of_get_mac_address(np, dev->dev_addr);
+	err = of_get_ethdev_address(np, dev);
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3731,7 +3731,7 @@ static int ucc_geth_probe(struct platfor
 		goto err_free_netdev;
 	}
 
-	of_get_mac_address(np, dev->dev_addr);
+	of_get_ethdev_address(np, dev);
 
 	ugeth->ug_info = ug_info;
 	ugeth->dev = device;
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -841,7 +841,7 @@ static int hisi_femac_drv_probe(struct p
 			   (unsigned long)phy->phy_id,
 			   phy_modes(phy->interface));
 
-	ret = of_get_mac_address(node, ndev->dev_addr);
+	ret = of_get_ethdev_address(node, ndev);
 	if (ret) {
 		eth_hw_addr_random(ndev);
 		dev_warn(dev, "using random MAC address %pM\n",
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1219,7 +1219,7 @@ static int hix5hd2_dev_probe(struct plat
 		goto out_phy_node;
 	}
 
-	ret = of_get_mac_address(node, ndev->dev_addr);
+	ret = of_get_ethdev_address(node, ndev);
 	if (ret) {
 		eth_hw_addr_random(ndev);
 		netdev_warn(ndev, "using random MAC address %pM\n",
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1298,7 +1298,7 @@ static int korina_probe(struct platform_
 
 	if (mac_addr)
 		eth_hw_addr_set(dev, mac_addr);
-	else if (of_get_mac_address(pdev->dev.of_node, dev->dev_addr) < 0)
+	else if (of_get_ethdev_address(pdev->dev.of_node, dev) < 0)
 		eth_hw_addr_random(dev);
 
 	clk = devm_clk_get_optional(&pdev->dev, "mdioclk");
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -474,7 +474,7 @@ static int xrx200_probe(struct platform_
 		return PTR_ERR(priv->clk);
 	}
 
-	err = of_get_mac_address(np, net_dev->dev_addr);
+	err = of_get_ethdev_address(np, net_dev);
 	if (err)
 		eth_hw_addr_random(net_dev);
 
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -266,7 +266,7 @@ static int liteeth_probe(struct platform
 	priv->tx_base = buf_base + priv->num_rx_slots * priv->slot_size;
 	priv->tx_slot = 0;
 
-	err = of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+	err = of_get_ethdev_address(pdev->dev.of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5242,7 +5242,7 @@ static int mvneta_probe(struct platform_
 		goto err_free_ports;
 	}
 
-	err = of_get_mac_address(dn, dev->dev_addr);
+	err = of_get_ethdev_address(dn, dev);
 	if (!err) {
 		mac_from = "device tree";
 	} else {
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1434,7 +1434,7 @@ static int pxa168_eth_probe(struct platf
 
 	INIT_WORK(&pep->tx_timeout_task, pxa168_eth_tx_timeout_task);
 
-	err = of_get_mac_address(pdev->dev.of_node, dev->dev_addr);
+	err = of_get_ethdev_address(pdev->dev.of_node, dev);
 	if (err) {
 		/* try reading the mac address, if set by the bootloader */
 		pxa168_eth_get_mac_address(dev, dev->dev_addr);
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4802,7 +4802,7 @@ static struct net_device *sky2_init_netd
 	 * 1) from device tree data
 	 * 2) from internal registers set by bootloader
 	 */
-	ret = of_get_mac_address(hw->pdev->dev.of_node, dev->dev_addr);
+	ret = of_get_ethdev_address(hw->pdev->dev.of_node, dev);
 	if (ret)
 		memcpy_fromio(dev->dev_addr, hw->regs + B2_MAC_1 + port * 8,
 			      ETH_ALEN);
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2618,7 +2618,7 @@ static int __init mtk_init(struct net_de
 	struct mtk_eth *eth = mac->hw;
 	int ret;
 
-	ret = of_get_mac_address(mac->of_node, dev->dev_addr);
+	ret = of_get_ethdev_address(mac->of_node, dev);
 	if (ret) {
 		/* If the mac address is invalid, use random mac address */
 		eth_hw_addr_random(dev);
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -195,7 +195,7 @@ static void ks8851_init_mac(struct ks885
 	struct net_device *dev = ks->netdev;
 	int ret;
 
-	ret = of_get_mac_address(np, dev->dev_addr);
+	ret = of_get_ethdev_address(np, dev);
 	if (!ret) {
 		ks8851_write_mac_addr(dev);
 		return;
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1349,7 +1349,7 @@ static int lpc_eth_drv_probe(struct plat
 	__lpc_get_mac(pldat, ndev->dev_addr);
 
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
-		of_get_mac_address(np, ndev->dev_addr);
+		of_get_ethdev_address(np, ndev);
 	}
 	if (!is_valid_ether_addr(ndev->dev_addr))
 		eth_hw_addr_random(ndev);
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -967,7 +967,7 @@ qca_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, qcaspi_devs);
 
-	ret = of_get_mac_address(spi->dev.of_node, qca->net_dev->dev_addr);
+	ret = of_get_ethdev_address(spi->dev.of_node, qca->net_dev);
 	if (ret) {
 		eth_hw_addr_random(qca->net_dev);
 		dev_info(&spi->dev, "Using random MAC address: %pM\n",
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -347,7 +347,7 @@ static int qca_uart_probe(struct serdev_
 
 	of_property_read_u32(serdev->dev.of_node, "current-speed", &speed);
 
-	ret = of_get_mac_address(serdev->dev.of_node, qca->net_dev->dev_addr);
+	ret = of_get_ethdev_address(serdev->dev.of_node, qca->net_dev);
 	if (ret) {
 		eth_hw_addr_random(qca->net_dev);
 		dev_info(&serdev->dev, "Using random MAC address: %pM\n",
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -114,7 +114,7 @@ static void ravb_read_mac_address(struct
 {
 	int ret;
 
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		u32 mahr = ravb_read(ndev, MAHR);
 		u32 malr = ravb_read(ndev, MALR);
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -118,7 +118,7 @@ static int sxgbe_platform_probe(struct p
 	}
 
 	/* Get MAC address if available (DT) */
-	of_get_mac_address(node, priv->dev->dev_addr);
+	of_get_ethdev_address(node, priv->dev);
 
 	/* Get the TX/RX IRQ numbers */
 	for (i = 0, chan = 1; i < SXGBE_TX_QUEUES; i++) {
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1601,7 +1601,7 @@ static int ave_probe(struct platform_dev
 
 	ndev->max_mtu = AVE_MAX_ETHFRAME - (ETH_HLEN + ETH_FCS_LEN);
 
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		/* if the mac address is invalid, use random mac address */
 		eth_hw_addr_random(ndev);
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2035,7 +2035,7 @@ static int netcp_create_interface(struct
 		devm_iounmap(dev, efuse);
 		devm_release_mem_region(dev, res.start, size);
 	} else {
-		ret = of_get_mac_address(node_interface, ndev->dev_addr);
+		ret = of_get_ethdev_address(node_interface, ndev);
 		if (ret)
 			eth_random_addr(ndev->dev_addr);
 	}
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1151,7 +1151,7 @@ static int xemaclite_of_probe(struct pla
 	lp->tx_ping_pong = get_bool(ofdev, "xlnx,tx-ping-pong");
 	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
 
-	rc = of_get_mac_address(ofdev->dev.of_node, ndev->dev_addr);
+	rc = of_get_ethdev_address(ofdev->dev.of_node, ndev);
 	if (rc) {
 		dev_warn(dev, "No MAC address found, using random\n");
 		eth_hw_addr_random(ndev);


