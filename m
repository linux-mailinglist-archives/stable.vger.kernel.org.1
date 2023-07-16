Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC68754DF3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGPJJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPJJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D9DF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA93F60C44
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848ADC433C7;
        Sun, 16 Jul 2023 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498552;
        bh=a6bjgeGigBQGwGBHqkI4VtvmomIBAYAxtg+qtNfHKL4=;
        h=Subject:To:Cc:From:Date:From;
        b=X/BHnYIyt78oQuSQgMFgVLg3H4zV/Muly3Vio6lPzXPRcMUAFOCWAJbAaKYrt3JyM
         MMvu9gC7/Zpi6w2kwvX+Er3X+UZgORXUG2HIlW+oaKUZi93aMei8WPYncqICRIy/AA
         ga2va2EjTQ+u88J8KvP+Lk+M30shG1V6axfFg7tk=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7921e: fix init command fail with enabled" failed to apply to 5.15-stable tree
To:     quan.zhou@mediatek.com, deren.wu@mediatek.com,
        juan.martinez@amd.com, kai.heng.feng@canonical.com,
        kuba@kernel.org, leon.yen@mediatek.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:09:04 +0200
Message-ID: <2023071604-urgency-jiffy-cbcf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 525c469e5de9bf7e53574396196e80fc716ac9eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071604-urgency-jiffy-cbcf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

525c469e5de9 ("wifi: mt76: mt7921e: fix init command fail with enabled device")
28fec923d240 ("mt76: connac: move mt76_connac2_load_patch in connac module")
b9ec27102ac0 ("mt76: connac: move mt76_connac2_load_ram in connac module")
c132fc7d83bb ("mt76: mt7921: move fw toggle in mt7921_load_firmware")
3d8c636c3e9e ("mt76: connac: move shared fw structures in connac module")
a55a0c701c12 ("mt76: mt7921s: fix firmware download random fail")
99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
ade25ca7950b ("mt76: mt7915: fix mcs_map in mt7915_mcu_set_sta_he_mcs()")
11005b18f453 ("mt76: mt7921s: fix a possible memory leak in mt7921_load_patch")
4a74ecc8f0f6 ("mt76: connac: move mt76_connac_lmac_mapping in mt76-connac module")
602cc0c9618a ("mt76: mt7921e: fix possible probe failure after reboot")
97cef84d1043 ("mt76: connac: move mt76_connac_mcu_rdd_cmd in mt76-connac module")
9e90c3511041 ("mt76: connac: move mt76_connac_mcu_gen_dl_mode in mt76-connac module")
a6ef46fcccf2 ("mt76: mt7915: rely on mt76_connac_mcu_init_download")
ad1a2333350f ("mt76: mt7915: rely on mt76_connac_mcu_patch_sem_ctrl/mt76_connac_mcu_start_patch")
ae90bdd6ad54 ("mt76: connac: move mt76_connac_mcu_restart in common module")
3dc531b92b69 ("mt76: mt7915: rely on mt76_connac_mcu_start_firmware")
48d743d185a5 ("mt76: connac: move mt76_connac_mcu_set_pm in connac module")
2fec2ea644c5 ("mt76: connac: introduce is_connac_v1 utility routine")
187169de13d1 ("mt76: mt7915: rely on mt76_connac_mcu_wtbl_ht_tlv")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 525c469e5de9bf7e53574396196e80fc716ac9eb Mon Sep 17 00:00:00 2001
From: Quan Zhou <quan.zhou@mediatek.com>
Date: Wed, 5 Jul 2023 23:26:38 +0800
Subject: [PATCH] wifi: mt76: mt7921e: fix init command fail with enabled
 device

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

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index f0a80c2b476a..4153cd6c2a01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -231,10 +231,6 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7921_wfsys_reset(dev);
-	if (ret)
-		return ret;
-
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
 					 MT7921_TX_RING_SIZE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c69ce6df4956..f55caa00ac69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -476,12 +476,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
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
@@ -504,8 +498,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 		return -EIO;
 	}
 
-fw_loaded:
-
 #ifdef CONFIG_PM
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ddb1fa4ee01d..95610a117d2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -325,6 +325,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	bus_ops->rmw = mt7921_rmw;
 	dev->mt76.bus = bus_ops;
 
+	ret = mt7921e_mcu_fw_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
 	ret = __mt7921e_mcu_drv_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
@@ -333,6 +337,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	ret = mt7921_wfsys_reset(dev);
+	if (ret)
+		goto err_free_dev;
+
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);

