Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B42755425
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGPU1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGPU1L (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99450E40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 387A060EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9C9C433C8;
        Sun, 16 Jul 2023 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539226;
        bh=p1MkgCNW63gV3ClpRDB//GcW6EsFM4u2zpW7P7mftLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1an2QGRBqmUTcFXNpB4/SG/kUwWmzQxgr/xq4L0pkDg+qDf7P2iazxBvjxzilqfI
         EgK7ElVh753GLr3Q/ai3h4pMyHeJPfwrlDSTz1jYMVpaI1kefK8lfPugMvaDMK/KTX
         /N7/Hh1+bD3m1Yu0zQbLX7KCzdaHULb+mV2ZNTnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Juan Martinez <juan.martinez@amd.com>,
        Leon Yen <leon.yen@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 733/800] wifi: mt76: mt7921e: fix init command fail with enabled device
Date:   Sun, 16 Jul 2023 21:49:46 +0200
Message-ID: <20230716195006.142165843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Quan Zhou <quan.zhou@mediatek.com>

commit 525c469e5de9bf7e53574396196e80fc716ac9eb upstream.

For some cases as below, we may encounter the unpreditable chip stats
in driver probe()
* The system reboot flow do not work properly, such as kernel oops while
  rebooting, and then the driver do not go back to default status at
  this moment.
* Similar to the flow above. If the device was enabled in BIOS or UEFI,
  the system may switch to Linux without driver fully shutdown.

To avoid the problem, force push the device back to default in probe()
* mt7921e_mcu_fw_pmctrl() : return control privilege to chip side.
* mt7921_wfsys_reset()    : cleanup chip config before resource init.

Error log
[59007.600714] mt7921e 0000:02:00.0: ASIC revision: 79220010
[59010.889773] mt7921e 0000:02:00.0: Message 00000010 (seq 1) timeout
[59010.889786] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59014.217839] mt7921e 0000:02:00.0: Message 00000010 (seq 2) timeout
[59014.217852] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59017.545880] mt7921e 0000:02:00.0: Message 00000010 (seq 3) timeout
[59017.545893] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59020.874086] mt7921e 0000:02:00.0: Message 00000010 (seq 4) timeout
[59020.874099] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59024.202019] mt7921e 0000:02:00.0: Message 00000010 (seq 5) timeout
[59024.202033] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59027.530082] mt7921e 0000:02:00.0: Message 00000010 (seq 6) timeout
[59027.530096] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59030.857888] mt7921e 0000:02:00.0: Message 00000010 (seq 7) timeout
[59030.857904] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59034.185946] mt7921e 0000:02:00.0: Message 00000010 (seq 8) timeout
[59034.185961] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59037.514249] mt7921e 0000:02:00.0: Message 00000010 (seq 9) timeout
[59037.514262] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59040.842362] mt7921e 0000:02:00.0: Message 00000010 (seq 10) timeout
[59040.842375] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59040.923845] mt7921e 0000:02:00.0: hardware init failed

Cc: stable@vger.kernel.org
Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Juan Martinez <juan.martinez@amd.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Message-ID: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c |    4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c |    8 --------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c |    8 ++++++++
 3 files changed, 8 insertions(+), 12 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -231,10 +231,6 @@ int mt7921_dma_init(struct mt7921_dev *d
 	if (ret)
 		return ret;
 
-	ret = mt7921_wfsys_reset(dev);
-	if (ret)
-		return ret;
-
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
 					 MT7921_TX_RING_SIZE,
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -476,12 +476,6 @@ static int mt7921_load_firmware(struct m
 {
 	int ret;
 
-	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
-	if (ret && mt76_is_mmio(&dev->mt76)) {
-		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
-		goto fw_loaded;
-	}
-
 	ret = mt76_connac2_load_patch(&dev->mt76, mt7921_patch_name(dev));
 	if (ret)
 		return ret;
@@ -504,8 +498,6 @@ static int mt7921_load_firmware(struct m
 		return -EIO;
 	}
 
-fw_loaded:
-
 #ifdef CONFIG_PM
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -325,6 +325,10 @@ static int mt7921_pci_probe(struct pci_d
 	bus_ops->rmw = mt7921_rmw;
 	dev->mt76.bus = bus_ops;
 
+	ret = mt7921e_mcu_fw_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
 	ret = __mt7921e_mcu_drv_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
@@ -333,6 +337,10 @@ static int mt7921_pci_probe(struct pci_d
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	ret = mt7921_wfsys_reset(dev);
+	if (ret)
+		goto err_free_dev;
+
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);


