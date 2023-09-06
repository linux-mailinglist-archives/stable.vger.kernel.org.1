Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61C7935F7
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjIFHLr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 03:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjIFHLq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 03:11:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FF83
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 00:11:42 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0E173F17D
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693984300;
        bh=cU9VFPzW+Bp14ddGSVp6unLZ7Sxa3lrbEIU0KLlZ/F0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=da5H7scRaEiPyT1KFMO6S0P8WuHxV4D8zE7LVKRjH6latKfIdlyCgu2vtA6nBe9FN
         2sNl12YCAljR/bGzpeuvE/cjYawxzgv/6OITQOrHaUvUmuuRDWKRLrZ63KcQh1i6xL
         IAHefzLfAkpn4EQqmGkhIghuE0DX/4dL4OtZI/8Zu6xp3dJJuSqJqxnsUZU7e+UavP
         iU8snpQWm4xGleYNQj5LHHO+ZdsC3VmxWuhLiERmlk3srfyroLj6DgVXf2XSZP7hoV
         cPqjKuD8FO9hLTcL+UEfMj+GH3fQhJfPm5qoJ1Oo7wByiDb9H+MJ7knroST+HiRDXc
         vnmPzhFmKXwFQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31f3eaa5c5eso1795634f8f.3
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 00:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984300; x=1694589100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU9VFPzW+Bp14ddGSVp6unLZ7Sxa3lrbEIU0KLlZ/F0=;
        b=RVZMe5ODiO5vcjA3GaZ2v5KXg93iUZb80450MjQR/qsrZHX0x/lGlRx5c9wd9vFnxN
         RIsV3avno6a9loc7k5RrC/wNGKrE61jl4KVky/dGptzQdIIVj9ZrqaZDC5oyVsMlhK2L
         PVMvSr7+MLGwNjHJWWn/IXPVn+e6fsTLuy2Wy0FZ3ooLJwhtytpdqSwjmoRJzKFgmW4u
         1yTA7w7D5tdfdojFbaETg7JVziET9GYTpHjtlMTRTCwfZ+0LCl57/zbA2pcK+27QVULp
         JuH7FpJLsr8i5Pz0o2mtruuQRXKOGeqHxTt0fBkCF6fKufh+2YWLQa1JUSg72VAMsEnR
         tADQ==
X-Gm-Message-State: AOJu0YyfyUXV408R6cq1BNMgFf4hBe2vBmRopbRkFsBO5moGR+DMuzZo
        CeoxUrIFetd1PmfLXhLzgD0rcoBtPYA39y80+Rcc/hJXrm/cU5mGjTviFTaRfLYbuQUxJmhOjYK
        N3Lx1MYVoi06iZqZZhDl0PnSnTY1c46upD/mnHwAbGA==
X-Received: by 2002:a05:6000:1092:b0:319:6fff:f2c1 with SMTP id y18-20020a056000109200b003196ffff2c1mr1418890wrw.38.1693984300345;
        Wed, 06 Sep 2023 00:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCzXU+TPwMJkUNoKeEaDZ0ctOlQdns5DrLhlHQh9jfylPzAdxKZ7oaSX7pSsjXCstELfMrpg==
X-Received: by 2002:a05:6000:1092:b0:319:6fff:f2c1 with SMTP id y18-20020a056000109200b003196ffff2c1mr1418881wrw.38.1693984300007;
        Wed, 06 Sep 2023 00:11:40 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d6643000000b00318147fd2d3sm19519369wrw.41.2023.09.06.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:11:39 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Hilda Wu <hildawu@realtek.com>,
        Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.5.y] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
Date:   Wed,  6 Sep 2023 09:11:29 +0200
Message-Id: <20230906071129.37071-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023083021-unease-catfish-92ad@gregkh>
References: <2023083021-unease-catfish-92ad@gregkh>
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

In this commit, prefer to load FW v2 if available. Fallback to FW v1
otherwise. This behavior is only for RTL8852C.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: stable@vger.kernel.org
Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Tested-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[juergh: Adjusted context due to missing .hw_info struct element]
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/bluetooth/btrtl.c | 70 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d978e7cea873..8824686bb09d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -101,21 +101,21 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = false,
-	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
+	  .fw_name = "rtl_bt/rtl8723a_fw",
 	  .cfg_name = NULL },
 
 	/* 8723BS */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723bs_fw",
 	  .cfg_name = "rtl_bt/rtl8723bs_config" },
 
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723b_fw",
 	  .cfg_name = "rtl_bt/rtl8723b_config" },
 
 	/* 8723CS-CG */
@@ -126,7 +126,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_cg_config" },
 
 	/* 8723CS-VF */
@@ -137,7 +137,7 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_vf_config" },
 
 	/* 8723CS-XX */
@@ -148,28 +148,28 @@ static const struct id_table ic_id_table[] = {
 	  .hci_bus = HCI_UART,
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw",
 	  .cfg_name = "rtl_bt/rtl8723cs_xx_config" },
 
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723d_fw",
 	  .cfg_name = "rtl_bt/rtl8723d_config" },
 
 	/* 8723DS */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8723ds_fw",
 	  .cfg_name = "rtl_bt/rtl8723ds_config" },
 
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821a_fw",
 	  .cfg_name = "rtl_bt/rtl8821a_config" },
 
 	/* 8821C */
@@ -177,7 +177,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821c_fw",
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
 	/* 8821CS */
@@ -185,14 +185,14 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8821cs_fw",
 	  .cfg_name = "rtl_bt/rtl8821cs_config" },
 
 	/* 8761A */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761a_fw",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
 	/* 8761B */
@@ -200,14 +200,14 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761b_fw",
 	  .cfg_name = "rtl_bt/rtl8761b_config" },
 
 	/* 8761BU */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8761bu_fw",
 	  .cfg_name = "rtl_bt/rtl8761bu_config" },
 
 	/* 8822C with UART interface */
@@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
 	/* 8822C with UART interface */
@@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cs_fw",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
 	/* 8822C with USB interface */
@@ -231,7 +231,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822cu_fw",
 	  .cfg_name = "rtl_bt/rtl8822cu_config" },
 
 	/* 8822B */
@@ -239,7 +239,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8822b_fw",
 	  .cfg_name = "rtl_bt/rtl8822b_config" },
 
 	/* 8852A */
@@ -247,7 +247,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852au_fw",
 	  .cfg_name = "rtl_bt/rtl8852au_config" },
 
 	/* 8852B with UART interface */
@@ -255,7 +255,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bs_fw",
 	  .cfg_name = "rtl_bt/rtl8852bs_config" },
 
 	/* 8852B */
@@ -263,7 +263,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852bu_fw",
 	  .cfg_name = "rtl_bt/rtl8852bu_config" },
 
 	/* 8852C */
@@ -271,7 +271,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
-	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8852cu_fw",
 	  .cfg_name = "rtl_bt/rtl8852cu_config" },
 
 	/* 8851B */
@@ -279,7 +279,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .has_msft_ext = false,
-	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
+	  .fw_name  = "rtl_bt/rtl8851bu_fw",
 	  .cfg_name = "rtl_bt/rtl8851bu_config" },
 	};
 
@@ -967,6 +967,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
+	char fw_name[40];
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
@@ -1079,8 +1080,26 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
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
@@ -1398,4 +1417,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
-- 
2.39.2

