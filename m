Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B278DB06
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjH3SiW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbjH3Pgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 11:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E8113
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 08:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5489C61771
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 15:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A78C433CD;
        Wed, 30 Aug 2023 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693409791;
        bh=CHMTJa5u9Fi7yM7su8LSRIpicYPxpgkmZq/a7La+atk=;
        h=Subject:To:Cc:From:Date:From;
        b=H4d56koNI6+llgShRMS2mJsVrZVHlzT81rJwG0xc3bHNMTR78yUTVWxMICd7SdesQ
         KEVIiGQGzlQ7KvtATFM+d/S7dWc8IoKNWLZx2K4z75vyX0tSwAwdJdzN9jysxLT0oy
         Ugr+AhxfK4UfzCmukOmAO/1mokqiFvfQ0dTtaAlc=
Subject: FAILED: patch "[PATCH] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C" failed to apply to 6.4-stable tree
To:     max.chou@realtek.com, hildawu@realtek.com,
        juerg.haefliger@canonical.com, luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 30 Aug 2023 17:36:22 +0200
Message-ID: <2023083022-salvage-resume-3b5d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x bd003fb338afee97c76f13c3e9144a7e4ad37179
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023083022-salvage-resume-3b5d@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd003fb338afee97c76f13c3e9144a7e4ad37179 Mon Sep 17 00:00:00 2001
From: Max Chou <max.chou@realtek.com>
Date: Mon, 7 Aug 2023 19:42:59 +0800
Subject: [PATCH] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C

In this commit, prefer to load FW v2 if available. Fallback to FW v1
otherwise. This behavior is only for RTL8852C.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: stable@vger.kernel.org
Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Tested-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index ddae6524106d..84c2c2e1122f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -104,7 +104,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = false,
-	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
+	  .fw_name = "rtl_bt/rtl8723a_fw",
 	  .cfg_name = NULL,
 	  .hw_info = "rtl8723au" },
 
@@ -112,7 +112,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723bs_fw",
 	  .cfg_name = "rtl_bt/rtl8723bs_config",
 	  .hw_info  = "rtl8723bs" },
 
@@ -120,7 +120,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723b_fw",
 	  .cfg_name = "rtl_bt/rtl8723b_config",
 	  .hw_info  = "rtl8723bu" },
 
@@ -132,7 +132,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_cg_config",
 	  .hw_info  = "rtl8723cs-cg" },
 
@@ -144,7 +144,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_vf_config",
 	  .hw_info  = "rtl8723cs-vf" },
 
@@ -156,7 +156,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_xx_config",
 	  .hw_info  = "rtl8723cs" },
 
@@ -164,7 +164,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723d_fw",
 	  .cfg_name = "rtl_bt/rtl8723d_config",
 	  .hw_info  = "rtl8723du" },
 
@@ -172,7 +172,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723ds_fw",
 	  .cfg_name = "rtl_bt/rtl8723ds_config",
 	  .hw_info  = "rtl8723ds" },
 
@@ -180,7 +180,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821a_fw",
 	  .cfg_name = "rtl_bt/rtl8821a_config",
 	  .hw_info  = "rtl8821au" },
 
@@ -189,7 +189,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821c_fw",
 	  .cfg_name = "rtl_bt/rtl8821c_config",
 	  .hw_info  = "rtl8821cu" },
 
@@ -198,7 +198,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821cs_fw",
 	  .cfg_name = "rtl_bt/rtl8821cs_config",
 	  .hw_info  = "rtl8821cs" },
 
@@ -206,7 +206,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761a_fw",
 	  .cfg_name = "rtl_bt/rtl8761a_config",
 	  .hw_info  = "rtl8761au" },
 
@@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761b_fw",
 	  .cfg_name = "rtl_bt/rtl8761b_config",
 	  .hw_info  = "rtl8761btv" },
 
@@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761bu_fw",
 	  .cfg_name = "rtl_bt/rtl8761bu_config",
 	  .hw_info  = "rtl8761bu" },
 
@@ -232,7 +232,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config",
 	  .hw_info  = "rtl8822cs" },
 
@@ -241,7 +241,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config",
 	  .hw_info  = "rtl8822cs" },
 
@@ -250,7 +250,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cu_fw",
 	  .cfg_name = "rtl_bt/rtl8822cu_config",
 	  .hw_info  = "rtl8822cu" },
 
@@ -259,7 +259,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822b_fw",
 	  .cfg_name = "rtl_bt/rtl8822b_config",
 	  .hw_info  = "rtl8822bu" },
 
@@ -268,7 +268,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852au_fw",
 	  .cfg_name = "rtl_bt/rtl8852au_config",
 	  .hw_info  = "rtl8852au" },
 
@@ -277,7 +277,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bs_fw",
 	  .cfg_name = "rtl_bt/rtl8852bs_config",
 	  .hw_info  = "rtl8852bs" },
 
@@ -286,7 +286,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bu_fw",
 	  .cfg_name = "rtl_bt/rtl8852bu_config",
 	  .hw_info  = "rtl8852bu" },
 
@@ -295,7 +295,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852cu_fw",
 	  .cfg_name = "rtl_bt/rtl8852cu_config",
 	  .hw_info  = "rtl8852cu" },
 
@@ -304,7 +304,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = false,
-	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8851bu_fw",
 	  .cfg_name = "rtl_bt/rtl8851bu_config",
 	  .hw_info  = "rtl8851bu" },
 	};
@@ -1045,6 +1045,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
 	struct hci_command_hdr *cmd;
+	char fw_name[40];
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
@@ -1154,8 +1155,26 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			goto err_free;
 	}
 
-	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
-					  &btrtl_dev->fw_data);
+	if (!btrtl_dev->ic_info->fw_name) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	btrtl_dev->fw_len = -EIO;
+	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
+		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
+				btrtl_dev->ic_info->fw_name);
+		btrtl_dev->fw_len = rtl_load_file(hdev, fw_name,
+				&btrtl_dev->fw_data);
+	}
+
+	if (btrtl_dev->fw_len < 0) {
+		snprintf(fw_name, sizeof(fw_name), "%s.bin",
+				btrtl_dev->ic_info->fw_name);
+		btrtl_dev->fw_len = rtl_load_file(hdev, fw_name,
+				&btrtl_dev->fw_data);
+	}
+
 	if (btrtl_dev->fw_len < 0) {
 		rtl_dev_err(hdev, "firmware file %s not found",
 			    btrtl_dev->ic_info->fw_name);
@@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");

