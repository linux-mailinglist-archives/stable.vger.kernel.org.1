Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B8E76136C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjGYLKr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjGYLKU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB1211E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D666165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66704C433C7;
        Tue, 25 Jul 2023 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283350;
        bh=4jbtmZfuTb35Q+UuHvzXNLD8WWAVrGvdqEO4MH9J2tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEYAU7vk0zued4fzdOkyO4mBgsNBy4KcbqME2/8pA4oEqJty+3A0qVHJU1TurSeoX
         5Qjc7bz5+PcPVo8pyk5Bk64xC9MZMY18wZwRZ9IoVz4fm+Dzkh1kS9X9YIl3wtxJDY
         bFiqgU7gWLS0CPF7p0b3z2SAiEzCNaqCPEovMg6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 44/78] ethernet: use eth_hw_addr_set() instead of ether_addr_copy()
Date:   Tue, 25 Jul 2023 12:46:35 +0200
Message-ID: <20230725104453.006223803@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit f3956ebb3bf06ab2266ad5ee2214aed46405810c ]

Convert Ethernet from ether_addr_copy() to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - ether_addr_copy(dev->dev_addr, np)
  + eth_hw_addr_set(dev, np)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1d6d537dc55d ("net: ethernet: mtk_eth_soc: handle probe deferral")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/agere/et131x.c                        | 4 ++--
 drivers/net/ethernet/alacritech/slicoss.c                  | 2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c               | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c            | 2 +-
 drivers/net/ethernet/broadcom/bgmac-bcma.c                 | 2 +-
 drivers/net/ethernet/broadcom/bgmac.c                      | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c              | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c             | 4 ++--
 drivers/net/ethernet/brocade/bna/bnad.c                    | 4 ++--
 drivers/net/ethernet/cavium/liquidio/lio_core.c            | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c            | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c         | 2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c           | 3 +--
 drivers/net/ethernet/emulex/benet/be_main.c                | 2 +-
 drivers/net/ethernet/ethoc.c                               | 2 +-
 drivers/net/ethernet/ezchip/nps_enet.c                     | 2 +-
 drivers/net/ethernet/faraday/ftgmac100.c                   | 4 ++--
 drivers/net/ethernet/google/gve/gve_adminq.c               | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            | 4 ++--
 drivers/net/ethernet/ibm/ibmveth.c                         | 2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                         | 5 ++---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c            | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c               | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c                | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c                | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c            | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c                  | 4 ++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c          | 6 +++---
 drivers/net/ethernet/korina.c                              | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c            | 4 ++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c             | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c   | 2 +-
 drivers/net/ethernet/marvell/prestera/prestera_main.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 2 +-
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 2 +-
 drivers/net/ethernet/microchip/enc28j60.c                  | 4 ++--
 drivers/net/ethernet/microchip/lan743x_main.c              | 4 ++--
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c      | 2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c              | 2 +-
 drivers/net/ethernet/mscc/ocelot_net.c                     | 2 +-
 drivers/net/ethernet/netronome/nfp/abm/main.c              | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c          | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c        | 2 +-
 drivers/net/ethernet/ni/nixge.c                            | 2 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c             | 4 ++--
 drivers/net/ethernet/qlogic/qede/qede_main.c               | 2 +-
 drivers/net/ethernet/qualcomm/emac/emac.c                  | 2 +-
 drivers/net/ethernet/sfc/ef10_sriov.c                      | 2 +-
 drivers/net/ethernet/sfc/efx.c                             | 2 +-
 drivers/net/ethernet/sfc/efx_common.c                      | 4 ++--
 drivers/net/ethernet/sfc/falcon/efx.c                      | 6 +++---
 drivers/net/ethernet/socionext/netsec.c                    | 2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                   | 2 +-
 drivers/net/ethernet/ti/cpsw_new.c                         | 4 ++--
 drivers/net/ethernet/ti/davinci_emac.c                     | 2 +-
 drivers/net/ethernet/ti/netcp_core.c                       | 2 +-
 include/linux/etherdevice.h                                | 2 +-
 57 files changed, 77 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 920633161174d..f4edc616388c0 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -3863,7 +3863,7 @@ static int et131x_change_mtu(struct net_device *netdev, int new_mtu)
 
 	et131x_init_send(adapter);
 	et131x_hwaddr_init(adapter);
-	ether_addr_copy(netdev->dev_addr, adapter->addr);
+	eth_hw_addr_set(netdev, adapter->addr);
 
 	/* Init the device with the new settings */
 	et131x_adapter_setup(adapter);
@@ -3966,7 +3966,7 @@ static int et131x_pci_setup(struct pci_dev *pdev,
 
 	netif_napi_add(netdev, &adapter->napi, et131x_poll, 64);
 
-	ether_addr_copy(netdev->dev_addr, adapter->addr);
+	eth_hw_addr_set(netdev, adapter->addr);
 
 	rc = -ENOMEM;
 
diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 696517eae77f0..82f4f26081021 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1660,7 +1660,7 @@ static int slic_read_eeprom(struct slic_device *sdev)
 		goto free_eeprom;
 	}
 	/* set mac address */
-	ether_addr_copy(sdev->netdev->dev_addr, mac[devfn]);
+	eth_hw_addr_set(sdev->netdev, mac[devfn]);
 free_eeprom:
 	dma_free_coherent(&sdev->pdev->dev, SLIC_EEPROM_SIZE, eeprom, paddr);
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 23c9750850e98..f3673be4fc087 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4119,7 +4119,7 @@ static void ena_set_conf_feat_params(struct ena_adapter *adapter,
 		ether_addr_copy(adapter->mac_addr, netdev->dev_addr);
 	} else {
 		ether_addr_copy(adapter->mac_addr, feat->dev_attr.mac_addr);
-		ether_addr_copy(netdev->dev_addr, adapter->mac_addr);
+		eth_hw_addr_set(netdev, adapter->mac_addr);
 	}
 
 	/* Set offload features */
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index ea2e7cd8946da..c52093589d7cf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -330,7 +330,7 @@ int aq_nic_ndev_register(struct aq_nic_s *self)
 	{
 		static u8 mac_addr_permanent[] = AQ_CFG_MAC_ADDR_PERMANENT;
 
-		ether_addr_copy(self->ndev->dev_addr, mac_addr_permanent);
+		eth_hw_addr_set(self->ndev, mac_addr_permanent);
 	}
 #endif
 
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 92453e68d381b..bdb1b8053b69f 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -150,7 +150,7 @@ static int bgmac_probe(struct bcma_device *core)
 			err = -ENOTSUPP;
 			goto err;
 		}
-		ether_addr_copy(bgmac->net_dev->dev_addr, mac);
+		eth_hw_addr_set(bgmac->net_dev, mac);
 	}
 
 	/* On BCM4706 we need common core to access PHY */
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 54ff28c9b2148..a9c99ac81730a 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1241,7 +1241,7 @@ static int bgmac_set_mac_address(struct net_device *net_dev, void *addr)
 	if (ret < 0)
 		return ret;
 
-	ether_addr_copy(net_dev->dev_addr, sa->sa_data);
+	eth_hw_addr_set(net_dev, sa->sa_data);
 	bgmac_write_mac_address(bgmac, net_dev->dev_addr);
 
 	eth_commit_mac_addr_change(net_dev, addr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 9401936b74fa2..8eb28e0885820 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -475,7 +475,7 @@ static void bnxt_vf_rep_netdev_init(struct bnxt *bp, struct bnxt_vf_rep *vf_rep,
 	dev->features |= pf_dev->features;
 	bnxt_vf_rep_eth_addr_gen(bp->pf.mac_addr, vf_rep->vf_idx,
 				 dev->perm_addr);
-	ether_addr_copy(dev->dev_addr, dev->perm_addr);
+	eth_hw_addr_set(dev, dev->perm_addr);
 	/* Set VF-Rep's max-mtu to the corresponding VF's max-mtu */
 	if (!bnxt_hwrm_vfr_qcfg(bp, vf_rep, &max_mtu))
 		dev->max_mtu = max_mtu;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9d4f406408c9d..e036a244b78bf 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3610,7 +3610,7 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
 	if (netif_running(dev))
 		return -EBUSY;
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
@@ -4060,7 +4060,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
 
 	if (pd && !IS_ERR_OR_NULL(pd->mac_address))
-		ether_addr_copy(dev->dev_addr, pd->mac_address);
+		eth_hw_addr_set(dev, pd->mac_address);
 	else
 		if (!device_get_mac_address(&pdev->dev, dev->dev_addr, ETH_ALEN))
 			if (has_acpi_companion(&pdev->dev))
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ba47777d9cff7..b1947fd9a07cc 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -875,7 +875,7 @@ bnad_set_netdev_perm_addr(struct bnad *bnad)
 
 	ether_addr_copy(netdev->perm_addr, bnad->perm_addr);
 	if (is_zero_ether_addr(netdev->dev_addr))
-		ether_addr_copy(netdev->dev_addr, bnad->perm_addr);
+		eth_hw_addr_set(netdev, bnad->perm_addr);
 }
 
 /* Control Path Handlers */
@@ -3249,7 +3249,7 @@ bnad_set_mac_address(struct net_device *netdev, void *addr)
 
 	err = bnad_mac_addr_set_locked(bnad, sa->sa_data);
 	if (!err)
-		ether_addr_copy(netdev->dev_addr, sa->sa_data);
+		eth_hw_addr_set(netdev, sa->sa_data);
 
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 2a0d64e5797c8..ec7928b54e4a7 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -411,7 +411,7 @@ void octeon_pf_changed_vf_macaddr(struct octeon_device *oct, u8 *mac)
 
 	if (!ether_addr_equal(netdev->dev_addr, mac)) {
 		macaddr_changed = true;
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 		ether_addr_copy(((u8 *)&lio->linfo.hw_addr) + 2, mac);
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev);
 	}
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index ae68821dd56d5..443755729d793 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3650,7 +3650,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 		/* Copy MAC Address to OS network device structure */
 
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 
 		/* By default all interfaces on a single Octeon uses the same
 		 * tx and rx queues
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index f6396ac64006c..8a969a9d4b637 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -2148,7 +2148,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 			mac[j] = *((u8 *)(((u8 *)&lio->linfo.hw_addr) + 2 + j));
 
 		/* Copy MAC Address to OS network device structure */
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 
 		if (liquidio_setup_io_queues(octeon_dev, i,
 					     lio->linfo.num_txpciq,
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index b43b97e15a6f0..8418797be205e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -221,8 +221,7 @@ static void  nicvf_handle_mbx_intr(struct nicvf *nic)
 		nic->tns_mode = mbx.nic_cfg.tns_mode & 0x7F;
 		nic->node = mbx.nic_cfg.node_id;
 		if (!nic->set_mac_pending)
-			ether_addr_copy(nic->netdev->dev_addr,
-					mbx.nic_cfg.mac_addr);
+			eth_hw_addr_set(nic->netdev, mbx.nic_cfg.mac_addr);
 		nic->sqs_mode = mbx.nic_cfg.sqs_mode;
 		nic->loopback_supported = mbx.nic_cfg.loopback_supported;
 		nic->link_up = false;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index e874b907bfbdf..3ccb955eb6f23 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -369,7 +369,7 @@ static int be_mac_addr_set(struct net_device *netdev, void *p)
 	/* Remember currently programmed MAC */
 	ether_addr_copy(adapter->dev_mac, addr->sa_data);
 done:
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 	dev_info(dev, "MAC address changed to %pM\n", addr->sa_data);
 	return 0;
 err:
diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index ed1ed48e74838..e63aef6a9e33a 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1148,7 +1148,7 @@ static int ethoc_probe(struct platform_device *pdev)
 
 	/* Allow the platform setup code to pass in a MAC address. */
 	if (pdata) {
-		ether_addr_copy(netdev->dev_addr, pdata->hwaddr);
+		eth_hw_addr_set(netdev, pdata->hwaddr);
 		priv->phy_id = pdata->phy_id;
 	} else {
 		of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index f9a288a6ec8cc..f5935eb5a791c 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -421,7 +421,7 @@ static s32 nps_enet_set_mac_address(struct net_device *ndev, void *p)
 
 	res = eth_mac_addr(ndev, p);
 	if (!res) {
-		ether_addr_copy(ndev->dev_addr, addr->sa_data);
+		eth_hw_addr_set(ndev, addr->sa_data);
 		nps_enet_set_hw_mac_address(ndev);
 	}
 
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 4a2dadb91f024..11f76e56d0316 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -186,7 +186,7 @@ static void ftgmac100_initial_mac(struct ftgmac100 *priv)
 
 	addr = device_get_mac_address(priv->dev, mac, ETH_ALEN);
 	if (addr) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 		dev_info(priv->dev, "Read MAC address %pM from device tree\n",
 			 mac);
 		return;
@@ -203,7 +203,7 @@ static void ftgmac100_initial_mac(struct ftgmac100 *priv)
 	mac[5] = l & 0xff;
 
 	if (is_valid_ether_addr(mac)) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 		dev_info(priv->dev, "Read MAC address %pM from chip\n", mac);
 	} else {
 		eth_hw_addr_random(priv->netdev);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index ce507464f3d62..54d649e5ee65b 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -733,7 +733,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	}
 	priv->dev->max_mtu = mtu;
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	ether_addr_copy(priv->dev->dev_addr, descriptor->mac);
+	eth_hw_addr_set(priv->dev, descriptor->mac);
 	mac = descriptor->mac;
 	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index dc835f316d471..2acf50ed6025a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2251,7 +2251,7 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 		return ret;
 	}
 
-	ether_addr_copy(netdev->dev_addr, mac_addr->sa_data);
+	eth_hw_addr_set(netdev, mac_addr->sa_data);
 
 	return 0;
 }
@@ -4921,7 +4921,7 @@ static int hns3_init_mac_addr(struct net_device *netdev)
 		dev_warn(priv->dev, "using random MAC address %s\n",
 			 format_mac_addr);
 	} else if (!ether_addr_equal(netdev->dev_addr, mac_addr_temp)) {
-		ether_addr_copy(netdev->dev_addr, mac_addr_temp);
+		eth_hw_addr_set(netdev, mac_addr_temp);
 		ether_addr_copy(netdev->perm_addr, mac_addr_temp);
 	} else {
 		return 0;
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3d9b4f99d357f..77d8db9b8a1d8 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1620,7 +1620,7 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 		return rc;
 	}
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 765dee2e4882e..450b4fd9aa7f7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4689,8 +4689,7 @@ static int handle_change_mac_rsp(union ibmvnic_crq *crq,
 	/* crq->change_mac_addr.mac_addr is the requested one
 	 * crq->change_mac_addr_rsp.mac_addr is the returned valid one.
 	 */
-	ether_addr_copy(netdev->dev_addr,
-			&crq->change_mac_addr_rsp.mac_addr[0]);
+	eth_hw_addr_set(netdev, &crq->change_mac_addr_rsp.mac_addr[0]);
 	ether_addr_copy(adapter->mac_addr,
 			&crq->change_mac_addr_rsp.mac_addr[0]);
 out:
@@ -5658,7 +5657,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->login_pending = false;
 
 	ether_addr_copy(adapter->mac_addr, mac_addr_p);
-	ether_addr_copy(netdev->dev_addr, adapter->mac_addr);
+	eth_hw_addr_set(netdev, adapter->mac_addr);
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmvnic_netdev_ops;
 	netdev->ethtool_ops = &ibmvnic_ethtool_ops;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2fb52bd6fc0e1..2cca9e84e31e1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -990,7 +990,7 @@ static int fm10k_set_mac(struct net_device *dev, void *p)
 	}
 
 	if (!err) {
-		ether_addr_copy(dev->dev_addr, addr->sa_data);
+		eth_hw_addr_set(dev, addr->sa_data);
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
 		dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index adfa2768f024d..b473cb7d7c575 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -300,7 +300,7 @@ static int fm10k_handle_reset(struct fm10k_intfc *interface)
 		if (is_valid_ether_addr(hw->mac.perm_addr)) {
 			ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
 			ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
-			ether_addr_copy(netdev->dev_addr, hw->mac.perm_addr);
+			eth_hw_addr_set(netdev, hw->mac.perm_addr);
 			netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
 		}
 
@@ -2045,7 +2045,7 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		netdev->addr_assign_type |= NET_ADDR_RANDOM;
 	}
 
-	ether_addr_copy(netdev->dev_addr, hw->mac.addr);
+	eth_hw_addr_set(netdev, hw->mac.addr);
 	ether_addr_copy(netdev->perm_addr, hw->mac.addr);
 
 	if (!is_valid_ether_addr(netdev->perm_addr)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8411f277d1355..d3f3874220a31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1686,7 +1686,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 	 */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_del_mac_filter(vsi, netdev->dev_addr);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 	i40e_add_mac_filter(vsi, netdev->dev_addr);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
@@ -13659,7 +13659,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	i40e_add_mac_filter(vsi, broadcast);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-	ether_addr_copy(netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(netdev, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
 
 	/* i40iw_net_event() reads 16 bytes from neigh->primary_key */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a3caab0b6fa2a..3e45ca40288ad 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1963,7 +1963,7 @@ static void iavf_init_get_resources(struct iavf_adapter *adapter)
 		eth_hw_addr_random(netdev);
 		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 	} else {
-		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index c6eb0d0748ea9..262482c694587 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1726,7 +1726,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
 		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
@@ -1757,7 +1757,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 		} else {
 			/* refresh current mac address if changed */
-			ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 			ether_addr_copy(netdev->perm_addr,
 					adapter->hw.mac.addr);
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bf9fe385274e1..a18fa054b4fae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3183,7 +3183,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	if (vsi->type == ICE_VSI_PF) {
 		SET_NETDEV_DEV(netdev, ice_pf_to_dev(vsi->back));
 		ether_addr_copy(mac_addr, vsi->port_info->mac.perm_addr);
-		ether_addr_copy(netdev->dev_addr, mac_addr);
+		eth_hw_addr_set(netdev, mac_addr);
 		ether_addr_copy(netdev->perm_addr, mac_addr);
 	}
 
@@ -5225,7 +5225,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 		netdev_err(netdev, "can't set MAC %pM. filter update failed\n",
 			   mac);
 		netif_addr_lock_bh(netdev);
-		ether_addr_copy(netdev->dev_addr, old_mac);
+		eth_hw_addr_set(netdev, old_mac);
 		netif_addr_unlock_bh(netdev);
 		return err;
 	}
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 0e7ff15af9687..3a05e458ded2f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2541,7 +2541,7 @@ void ixgbevf_reset(struct ixgbevf_adapter *adapter)
 	}
 
 	if (is_valid_ether_addr(adapter->hw.mac.addr)) {
-		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
 
@@ -3055,7 +3055,7 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 		else if (is_zero_ether_addr(adapter->hw.mac.addr))
 			dev_info(&pdev->dev,
 				 "MAC address not assigned by administrator.\n");
-		ether_addr_copy(netdev->dev_addr, hw->mac.addr);
+		eth_hw_addr_set(netdev, hw->mac.addr);
 	}
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
@@ -4232,7 +4232,7 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 
 	ether_addr_copy(hw->mac.addr, addr->sa_data);
 	ether_addr_copy(hw->mac.perm_addr, addr->sa_data);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 3e9f324f1061f..097516af43256 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1297,7 +1297,7 @@ static int korina_probe(struct platform_device *pdev)
 	lp = netdev_priv(dev);
 
 	if (mac_addr)
-		ether_addr_copy(dev->dev_addr, mac_addr);
+		eth_hw_addr_set(dev, mac_addr);
 	else if (of_get_mac_address(pdev->dev.of_node, dev->dev_addr) < 0)
 		eth_hw_addr_random(dev);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 524913c28f3b6..ddd4ed34b0f20 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6087,7 +6087,7 @@ static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
 
 	if (fwnode_get_mac_address(fwnode, fw_mac_addr, ETH_ALEN)) {
 		*mac_from = "firmware node";
-		ether_addr_copy(dev->dev_addr, fw_mac_addr);
+		eth_hw_addr_set(dev, fw_mac_addr);
 		return;
 	}
 
@@ -6095,7 +6095,7 @@ static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
 		mvpp21_get_mac_address(port, hw_mac_addr);
 		if (is_valid_ether_addr(hw_mac_addr)) {
 			*mac_from = "hardware";
-			ether_addr_copy(dev->dev_addr, hw_mac_addr);
+			eth_hw_addr_set(dev, hw_mac_addr);
 			return;
 		}
 	}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index a8188b972ccbc..9af22f497a40f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -2333,7 +2333,7 @@ int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 		return err;
 
 	/* Set addr in the device */
-	ether_addr_copy(dev->dev_addr, da);
+	eth_hw_addr_set(dev, da);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2e225309de9ca..b743646993ca2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -188,7 +188,7 @@ static int otx2_hw_get_mac_addr(struct otx2_nic *pfvf,
 		return PTR_ERR(msghdr);
 	}
 	rsp = (struct nix_get_mac_addr_rsp *)msghdr;
-	ether_addr_copy(netdev->dev_addr, rsp->mac_addr);
+	eth_hw_addr_set(netdev, rsp->mac_addr);
 	mutex_unlock(&pfvf->mbox.lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 656c68cfd7ec6..912759ea6ec59 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -141,7 +141,7 @@ static int prestera_port_set_mac_address(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 82849bed27f4c..fdc4a5a80da41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3224,7 +3224,7 @@ static int mlx5e_set_mac(struct net_device *netdev, void *addr)
 		return -EADDRNOTAVAIL;
 
 	netif_addr_lock_bh(netdev);
-	ether_addr_copy(netdev->dev_addr, saddr->sa_data);
+	eth_hw_addr_set(netdev, saddr->sa_data);
 	netif_addr_unlock_bh(netdev);
 
 	mlx5e_nic_set_rx_mode(priv);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 6704f5c1aa32e..b990782c1eb1f 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -75,7 +75,7 @@ static void mlxbf_gige_initial_mac(struct mlxbf_gige *priv)
 	u64_to_ether_addr(local_mac, mac);
 
 	if (is_valid_ether_addr(mac)) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 	} else {
 		/* Provide a random MAC if for some reason the device has
 		 * not been configured with a valid MAC address already.
diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index 09cdc2f2e7ffb..bf77e8adffbf3 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -517,7 +517,7 @@ static int enc28j60_set_mac_address(struct net_device *dev, void *addr)
 	if (!is_valid_ether_addr(address->sa_data))
 		return -EADDRNOTAVAIL;
 
-	ether_addr_copy(dev->dev_addr, address->sa_data);
+	eth_hw_addr_set(dev, address->sa_data);
 	return enc28j60_set_hw_macaddr(dev);
 }
 
@@ -1573,7 +1573,7 @@ static int enc28j60_probe(struct spi_device *spi)
 	}
 
 	if (device_get_mac_address(&spi->dev, macaddr, sizeof(macaddr)))
-		ether_addr_copy(dev->dev_addr, macaddr);
+		eth_hw_addr_set(dev, macaddr);
 	else
 		eth_hw_addr_random(dev);
 	enc28j60_set_hw_macaddr(dev);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index d66ee9bf5558c..a3392c74372a8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -829,7 +829,7 @@ static int lan743x_mac_init(struct lan743x_adapter *adapter)
 			eth_random_addr(adapter->mac_address);
 	}
 	lan743x_mac_set_address(adapter, adapter->mac_address);
-	ether_addr_copy(netdev->dev_addr, adapter->mac_address);
+	eth_hw_addr_set(netdev, adapter->mac_address);
 
 	return 0;
 }
@@ -2677,7 +2677,7 @@ static int lan743x_netdev_set_mac_address(struct net_device *netdev,
 	ret = eth_prepare_mac_addr_change(netdev, sock_addr);
 	if (ret)
 		return ret;
-	ether_addr_copy(netdev->dev_addr, sock_addr->sa_data);
+	eth_hw_addr_set(netdev, sock_addr->sa_data);
 	lan743x_mac_set_address(adapter, sock_addr->sa_data);
 	lan743x_rfe_update_mac_address(adapter);
 	return 0;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 5c7b21ce64edb..a84038db8e1ad 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -172,7 +172,7 @@ static int sparx5_set_mac_address(struct net_device *dev, void *p)
 	sparx5_mact_learn(sparx5, PGID_CPU, addr->sa_data, port->pvid);
 
 	/* Record the address */
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4b8c239932178..6224b7c21e0af 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1619,7 +1619,7 @@ static int mana_init_port(struct net_device *ndev)
 	if (apc->num_queues > apc->max_queues)
 		apc->num_queues = apc->max_queues;
 
-	ether_addr_copy(ndev->dev_addr, apc->mac_addr);
+	eth_hw_addr_set(ndev, apc->mac_addr);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index c08c56e07b1d3..da8a4e01d4be3 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -606,7 +606,7 @@ static int ocelot_port_set_mac_address(struct net_device *dev, void *p)
 	/* Then forget the previous one. */
 	ocelot_mact_forget(ocelot, dev->dev_addr, ocelot_port->pvid_vlan.vid);
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 605a1617b195e..5d3df28c648ff 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -305,7 +305,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 		return;
 	}
 
-	ether_addr_copy(nn->dp.netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(nn->dp.netdev, mac_addr);
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index d10a938013445..74c4bf4d397d8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -55,7 +55,7 @@ nfp_net_get_mac_addr(struct nfp_pf *pf, struct net_device *netdev,
 		return;
 	}
 
-	ether_addr_copy(netdev->dev_addr, eth_port->mac_addr);
+	eth_hw_addr_set(netdev, eth_port->mac_addr);
 	ether_addr_copy(netdev->perm_addr, eth_port->mac_addr);
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index c0e2f4394aef8..87f2268b16d6e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -58,7 +58,7 @@ static void nfp_netvf_get_mac_addr(struct nfp_net *nn)
 		return;
 	}
 
-	ether_addr_copy(nn->dp.netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(nn->dp.netdev, mac_addr);
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
 }
 
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 5d0cecf80b380..486fa794b6c7a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1285,7 +1285,7 @@ static int nixge_probe(struct platform_device *pdev)
 
 	mac_addr = nixge_get_nvmem_address(&pdev->dev);
 	if (mac_addr && is_valid_ether_addr(mac_addr)) {
-		ether_addr_copy(ndev->dev_addr, mac_addr);
+		eth_hw_addr_set(ndev, mac_addr);
 		kfree(mac_addr);
 	} else {
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index f99b085b56a54..03c51dd37e1f3 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -557,7 +557,7 @@ void qede_force_mac(void *dev, u8 *mac, bool forced)
 		return;
 	}
 
-	ether_addr_copy(edev->ndev->dev_addr, mac);
+	eth_hw_addr_set(edev->ndev, mac);
 	__qede_unlock(edev);
 }
 
@@ -1101,7 +1101,7 @@ int qede_set_mac_addr(struct net_device *ndev, void *p)
 			goto out;
 	}
 
-	ether_addr_copy(ndev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(ndev, addr->sa_data);
 	DP_INFO(edev, "Setting device MAC to %pM\n", addr->sa_data);
 
 	if (edev->state != QEDE_STATE_OPEN) {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 41f0a3433c3a2..6c22bfc16ee6b 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -843,7 +843,7 @@ static void qede_init_ndev(struct qede_dev *edev)
 	ndev->max_mtu = QEDE_MAX_JUMBO_PACKET_SIZE;
 
 	/* Set network device HW mac */
-	ether_addr_copy(edev->ndev->dev_addr, edev->dev_info.common.hw_mac);
+	eth_hw_addr_set(edev->ndev, edev->dev_info.common.hw_mac);
 
 	ndev->mtu = edev->dev_info.common.mtu;
 }
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index bb7f3286824f4..94090856cf3a9 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -550,7 +550,7 @@ static int emac_probe_resources(struct platform_device *pdev,
 
 	/* get mac address */
 	if (device_get_mac_address(&pdev->dev, maddr, ETH_ALEN))
-		ether_addr_copy(netdev->dev_addr, maddr);
+		eth_hw_addr_set(netdev, maddr);
 	else
 		eth_hw_addr_random(netdev);
 
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index f488461a23d1c..eeaecea77cb83 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -527,7 +527,7 @@ int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, u8 *mac)
 			goto fail;
 
 		if (vf->efx)
-			ether_addr_copy(vf->efx->net_dev->dev_addr, mac);
+			eth_hw_addr_set(vf->efx->net_dev, mac);
 	}
 
 	ether_addr_copy(vf->mac, mac);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 41eb6f9f5596e..bc1f4350360bc 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -128,7 +128,7 @@ static int efx_probe_port(struct efx_nic *efx)
 		return rc;
 
 	/* Initialise MAC address to permanent address */
-	ether_addr_copy(efx->net_dev->dev_addr, efx->net_dev->perm_addr);
+	eth_hw_addr_set(efx->net_dev, efx->net_dev->perm_addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 6038b7e3e8236..7249ea594b31d 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -181,11 +181,11 @@ int efx_set_mac_address(struct net_device *net_dev, void *data)
 
 	/* save old address */
 	ether_addr_copy(old_addr, net_dev->dev_addr);
-	ether_addr_copy(net_dev->dev_addr, new_addr);
+	eth_hw_addr_set(net_dev, new_addr);
 	if (efx->type->set_mac_address) {
 		rc = efx->type->set_mac_address(efx);
 		if (rc) {
-			ether_addr_copy(net_dev->dev_addr, old_addr);
+			eth_hw_addr_set(net_dev, old_addr);
 			return rc;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 423bdf81200fd..c68837a951f47 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1044,7 +1044,7 @@ static int ef4_probe_port(struct ef4_nic *efx)
 		return rc;
 
 	/* Initialise MAC address to permanent address */
-	ether_addr_copy(efx->net_dev->dev_addr, efx->net_dev->perm_addr);
+	eth_hw_addr_set(efx->net_dev, efx->net_dev->perm_addr);
 
 	return 0;
 }
@@ -2162,11 +2162,11 @@ static int ef4_set_mac_address(struct net_device *net_dev, void *data)
 
 	/* save old address */
 	ether_addr_copy(old_addr, net_dev->dev_addr);
-	ether_addr_copy(net_dev->dev_addr, new_addr);
+	eth_hw_addr_set(net_dev, new_addr);
 	if (efx->type->set_mac_address) {
 		rc = efx->type->set_mac_address(efx);
 		if (rc) {
-			ether_addr_copy(net_dev->dev_addr, old_addr);
+			eth_hw_addr_set(net_dev, old_addr);
 			return rc;
 		}
 	}
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index f0451911ab8f6..6b8013fb17c38 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2041,7 +2041,7 @@ static int netsec_probe(struct platform_device *pdev)
 
 	mac = device_get_mac_address(&pdev->dev, macbuf, sizeof(macbuf));
 	if (mac)
-		ether_addr_copy(ndev->dev_addr, mac);
+		eth_hw_addr_set(ndev, mac);
 
 	if (priv->eeprom_base &&
 	    (!mac || !is_valid_ether_addr(ndev->dev_addr))) {
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 692c291d9a01a..daf0779261f3e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1981,7 +1981,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
 	SET_NETDEV_DEV(port->ndev, dev);
 
-	ether_addr_copy(port->ndev->dev_addr, port->slave.mac_addr);
+	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
 	port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
 	port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 277c91d135708..0d921f6542d6f 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1000,7 +1000,7 @@ static int cpsw_ndo_set_mac_address(struct net_device *ndev, void *p)
 			   flags, vid);
 
 	ether_addr_copy(priv->mac_addr, addr->sa_data);
-	ether_addr_copy(ndev->dev_addr, priv->mac_addr);
+	eth_hw_addr_set(ndev, priv->mac_addr);
 	cpsw_set_slave_mac(&cpsw->slaves[slave_no], priv);
 
 	pm_runtime_put(cpsw->dev);
@@ -1404,7 +1404,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 			dev_info(cpsw->dev, "Random MACID = %pM\n",
 				 priv->mac_addr);
 		}
-		ether_addr_copy(ndev->dev_addr, slave_data->mac_addr);
+		eth_hw_addr_set(ndev, slave_data->mac_addr);
 		ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
 
 		cpsw->slaves[i].ndev = ndev;
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index d243ca5dfde00..fbd6bd80f51f4 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1911,7 +1911,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
 	if (!rc)
-		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
+		eth_hw_addr_set(ndev, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
 		/* Use random MAC if still none obtained. */
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 07bdeece1723d..0cd47348890db 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2028,7 +2028,7 @@ static int netcp_create_interface(struct netcp_device *netcp_device,
 
 		emac_arch_get_mac_addr(efuse_mac_addr, efuse, efuse_mac);
 		if (is_valid_ether_addr(efuse_mac_addr))
-			ether_addr_copy(ndev->dev_addr, efuse_mac_addr);
+			eth_hw_addr_set(ndev, efuse_mac_addr);
 		else
 			eth_random_addr(ndev->dev_addr);
 
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 7f28fa702bb72..ca0e26a858bee 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -323,7 +323,7 @@ static inline void eth_hw_addr_inherit(struct net_device *dst,
 				       struct net_device *src)
 {
 	dst->addr_assign_type = src->addr_assign_type;
-	ether_addr_copy(dst->dev_addr, src->dev_addr);
+	eth_hw_addr_set(dst, src->dev_addr);
 }
 
 /**
-- 
2.39.2



