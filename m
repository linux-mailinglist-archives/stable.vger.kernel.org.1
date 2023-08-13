Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5177AC55
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHMVcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjHMVcM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB36173E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C166162B75
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EB2C433C8;
        Sun, 13 Aug 2023 21:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962308;
        bh=uE4JaVpSeZxzPAW9wWotZXradXPcYkxAOtlC5eVGsD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3ngpPgwepwI2TV11vcx23/ECxcpnQlsq3XuBCiUP1jgr/ZSeeOCIzFW0gCUKm1yc
         +oGXJDo2SoB3H+J7eiAS2ca8zFeNeXdwZl4iQiBDn2Y3OaYa/F95f1IpOxWoLaCAHQ
         fT3YMXMr9ZiDMre+pEc7nQm1IS/SdTGhP9wKdQHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 159/206] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
Date:   Sun, 13 Aug 2023 23:18:49 +0200
Message-ID: <20230813211729.577354754@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

commit f0168042a21292d20007d24ab2e4fc32f79ebf11 upstream.

The workaround implemented in commit 3222b5b613db ("net: enetc:
initialize RFS/RSS memories for unused ports too") is no longer
effective after commit 6fffbc7ae137 ("PCI: Honor firmware's device
disabled status"). Thus, it has introduced a regression and we see AER
errors being reported again:

$ ip link set sw2p0 up && dhclient -i sw2p0 && ip addr show sw2p0
fsl_enetc 0000:00:00.2 eno2: configuring for fixed/internal link mode
fsl_enetc 0000:00:00.2 eno2: Link is Up - 2.5Gbps/Full - flow control rx/tx
mscc_felix 0000:00:00.5 swp2: configuring for fixed/sgmii link mode
mscc_felix 0000:00:00.5 swp2: Link is Up - 1Gbps/Full - flow control off
sja1105 spi2.2 sw2p0: configuring for phy/rgmii-id link mode
sja1105 spi2.2 sw2p0: Link is Up - 1Gbps/Full - flow control off
pcieport 0000:00:1f.0: AER: Multiple Corrected error received: 0000:00:00.0
pcieport 0000:00:1f.0: AER: can't find device of ID0000

Rob's suggestion is to reimplement the enetc driver workaround as a
PCI fixup, and to modify the PCI core to run the fixups for all PCI
functions. This change handles the first part.

We refactor the common code in enetc_psi_create() and enetc_psi_destroy(),
and use the PCI fixup only for those functions for which enetc_pf_probe()
won't get called. This avoids some work being done twice for the PFs
which are enabled.

Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Link: https://lore.kernel.org/netdev/CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com/
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c |  103 +++++++++++++++++-------
 1 file changed, 73 insertions(+), 30 deletions(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1222,50 +1222,81 @@ static int enetc_pf_register_with_ierb(s
 	return enetc_ierb_register_pf(ierb_pdev, pdev);
 }
 
-static int enetc_pf_probe(struct pci_dev *pdev,
-			  const struct pci_device_id *ent)
+static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-	struct enetc_ndev_priv *priv;
-	struct net_device *ndev;
 	struct enetc_si *si;
-	struct enetc_pf *pf;
 	int err;
 
-	err = enetc_pf_register_with_ierb(pdev);
-	if (err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Could not register with IERB driver: %pe, please update the device tree\n",
-			 ERR_PTR(err));
-
-	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
-	if (err)
-		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(struct enetc_pf));
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+		goto out;
+	}
 
 	si = pci_get_drvdata(pdev);
 	if (!si->hw.port || !si->hw.global) {
 		err = -ENODEV;
 		dev_err(&pdev->dev, "could not map PF space, probing a VF?\n");
-		goto err_map_pf_space;
+		goto out_pci_remove;
 	}
 
 	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
 			       &si->cbd_ring);
 	if (err)
-		goto err_setup_cbdr;
+		goto out_pci_remove;
 
 	err = enetc_init_port_rfs_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RFS memory\n");
-		goto err_init_port_rfs;
+		goto out_teardown_cbdr;
 	}
 
 	err = enetc_init_port_rss_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RSS memory\n");
-		goto err_init_port_rss;
+		goto out_teardown_cbdr;
+	}
+
+	return si;
+
+out_teardown_cbdr:
+	enetc_teardown_cbdr(&si->cbd_ring);
+out_pci_remove:
+	enetc_pci_remove(pdev);
+out:
+	return ERR_PTR(err);
+}
+
+static void enetc_psi_destroy(struct pci_dev *pdev)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+
+	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_pci_remove(pdev);
+}
+
+static int enetc_pf_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_ndev_priv *priv;
+	struct net_device *ndev;
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pf_register_with_ierb(pdev);
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Could not register with IERB driver: %pe, please update the device tree\n",
+			 ERR_PTR(err));
+
+	si = enetc_psi_create(pdev);
+	if (IS_ERR(si)) {
+		err = PTR_ERR(si);
+		goto err_psi_create;
 	}
 
 	if (node && !of_device_is_available(node)) {
@@ -1353,15 +1384,10 @@ err_alloc_si_res:
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
-err_init_port_rss:
-err_init_port_rfs:
 err_device_disabled:
 err_setup_mac_addresses:
-	enetc_teardown_cbdr(&si->cbd_ring);
-err_setup_cbdr:
-err_map_pf_space:
-	enetc_pci_remove(pdev);
-
+	enetc_psi_destroy(pdev);
+err_psi_create:
 	return err;
 }
 
@@ -1384,12 +1410,29 @@ static void enetc_pf_remove(struct pci_d
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(&si->cbd_ring);
 
 	free_netdev(si->ndev);
 
-	enetc_pci_remove(pdev);
+	enetc_psi_destroy(pdev);
+}
+
+static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_si *si;
+
+	/* Only apply quirk for disabled functions. For the ones
+	 * that are enabled, enetc_pf_probe() will apply it.
+	 */
+	if (node && of_device_is_available(node))
+		return;
+
+	si = enetc_psi_create(pdev);
+	if (si)
+		enetc_psi_destroy(pdev);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
+			enetc_fixup_clear_rss_rfs);
 
 static const struct pci_device_id enetc_pf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF) },


