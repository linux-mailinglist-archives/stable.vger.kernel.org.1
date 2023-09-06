Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3E7935E6
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIFHG7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFHG6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 03:06:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08FE50
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 00:06:52 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19A433F460
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 07:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693984011;
        bh=s66oUGo8hrMsvdXnZfYlr16tvYjZz8ogiPF8h0o69fc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BXlU7NtbSnwDwSFH3sGI+fX5Es0BxMHwa2JGgswPXL92wTDYEaDordqyOZ/F1E7gD
         WJhWiHxiW6JNr/e7iPFsFV87O/e5sUeUh3uOTVrZBmwbiP/qNAPrl+UpVG6ABvSiPQ
         28y7L51jTxqgZ44cHa1JvmU8CtDsijOvPGRxbiiWy2X9t12jfcrbhh4T5MMt3v+0tW
         0YXKaYoshcAqMd5mnYCv5UeLn8I8RIAfVnqmJ6bp43buLKzukv+UAb8V+oEWcFybz1
         cAGXksogD/EShF25OTM8sKewdp8MhnyhipM+CV/Js16fsnuFcBXWGBgxnnKuUyaT+5
         v4T3VKaP7YYsA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401d8873904so21448295e9.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 00:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984010; x=1694588810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s66oUGo8hrMsvdXnZfYlr16tvYjZz8ogiPF8h0o69fc=;
        b=Wy8yQR2LkD/7EPRnhSvGTSbYpgZd53dxZAaQf/shPlBpAJRkvuNZjb8QeOTUmTGPYr
         mFCGDGID8DSb7jEX87X2ro+Lzai/7aLPvvz6idjs1ab3CUeWCQ/npKf2J61Mf/e//Bey
         4Gt4xKbJk/tsO+VtbnKyglqCJkcFI9D9GDZ5QL6z8WNjrtOy4AfMGchoZKCdwWoI6kp2
         ItF92O8b8z9YdLOsN5nBpbF0xMmMPXo0DQrLL9OU7XGKMNY6NeJLFuWIiJXbV+StrU+N
         iHX+ePf1wOocd9E7k6jkN4o0QZiBjyd7PQ7EWlhQG5EZRbJSvqU7CI/jMemsr7uDxO8R
         SgZg==
X-Gm-Message-State: AOJu0Yx1oBI4P1w7d4I9EiFs5MnArrnHUsmvKoXBmmnmEfjHwdfr5RFU
        8UI2cDKx7FxvSI/zuLvW3dJNSudbR3Tr/ml3ZgTFWjQIbIz4epQ+Ddlh3zvedJy8NB5EcdeTShN
        8YWRv6Q+Zpo+/TeSUv4+W/h8F+aPuP2Hiqic/HGiFUQ==
X-Received: by 2002:a05:600c:2349:b0:3fb:c9f4:1506 with SMTP id 9-20020a05600c234900b003fbc9f41506mr1604473wmq.1.1693984010753;
        Wed, 06 Sep 2023 00:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET6m6j6p5u5NO5LJ5GNZGqya7D2uJkXi2gdcbXVf2lzlm52fzoCF42F5MQc6CAPoLrtMgCjA==
X-Received: by 2002:a05:600c:2349:b0:3fb:c9f4:1506 with SMTP id 9-20020a05600c234900b003fbc9f41506mr1604451wmq.1.1693984010346;
        Wed, 06 Sep 2023 00:06:50 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm19532309wrq.59.2023.09.06.00.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:06:50 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Hilda Wu <hildawu@realtek.com>,
        Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.4.y] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
Date:   Wed,  6 Sep 2023 09:06:43 +0200
Message-Id: <20230906070643.36088-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023083022-salvage-resume-3b5d@gregkh>
References: <2023083022-salvage-resume-3b5d@gregkh>
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
index 2915c82d719d..c22c1d10cc46 100644
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
@@ -1382,6 +1401,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
-- 
2.39.2

