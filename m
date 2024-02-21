Return-Path: <stable+bounces-22471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6995F85DC33
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D335B1F22215
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC47C097;
	Wed, 21 Feb 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUGzV3bp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD57C08C;
	Wed, 21 Feb 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523410; cv=none; b=VD3x+a5SEa6fQASXzny9ShQBkhHvCg3jB2Ip9K4nN9dpS/gvoqDwzMyDd58W+kogwhPgg9bAIQeuWn2hmUFFYhaf5CwqCyIsoUCCCIXfBufdECjcK4sQqPQvWA4MyHbju7OA2+2zc76TgVauK4ueQlVYO4FUd+GiXwdIIT4xYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523410; c=relaxed/simple;
	bh=+hH5DFSxH041FQu2nNckzf+RyrSYcpJY2G18WPnvYZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD1g4ghP1hk91Qa4y49Ibjlx8VC/yxwPUbCUKTDoo7wO631F4qcpWh3X5M+qHfaWQShZkYNSy8Pvjo+j1mhyM8eExkjF/bcR0EHSYtXAW02XFebP2ttQVm7BR4/SMEgceXEh7ioiVEfuzpwE555lRRvqGJ1WcFkxDeVE4SDSYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUGzV3bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05B9C433C7;
	Wed, 21 Feb 2024 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523410;
	bh=+hH5DFSxH041FQu2nNckzf+RyrSYcpJY2G18WPnvYZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUGzV3bpXJKCJdU7iGUl6/yZtPoDFYiTxzRIB69/Frh0i3jnihDDA9bAVdntAg91I
	 WdnVrpDd++onXv1ha7vf33kUNLB5yQgSNvdPN6/WpPbkUzhCalFoxioSasXVkuqJKD
	 Cko6tjHDQrkO+FbrkFAI7gO2HglXoHp1CSybgbps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 428/476] wifi: mwifiex: Support SD8978 chipset
Date: Wed, 21 Feb 2024 14:07:59 +0100
Message-ID: <20240221130023.845977547@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit bba047f15851c8b053221f1b276eb7682d59f755 ]

The Marvell SD8978 (aka NXP IW416) uses identical registers as SD8987,
so reuse the existing mwifiex_reg_sd8987 definition.

Note that mwifiex_reg_sd8977 and mwifiex_reg_sd8997 are likewise
identical, save for the fw_dump_ctrl register:  They define it as 0xf0
whereas mwifiex_reg_sd8987 defines it as 0xf9.  I've verified that
0xf9 is the correct value on SD8978.  NXP's out-of-tree driver uses
0xf9 for all of them, so there's a chance that 0xf0 is not correct
in the mwifiex_reg_sd8977 and mwifiex_reg_sd8997 definitions.  I cannot
test that for lack of hardware, hence am leaving it as is.

NXP has only released a firmware which runs Bluetooth over UART.
Perhaps Bluetooth over SDIO is unsupported by this chipset.
Consequently, only an "sdiouart" firmware image is referenced, not an
alternative "sdsd" image.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/536b4f17a72ca460ad1b07045757043fb0778988.1674827105.git.lukas@wunner.de
Stable-dep-of: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/net/wireless/marvell-8xxx.txt    |  4 ++-
 drivers/net/wireless/marvell/mwifiex/Kconfig  |  5 ++--
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 25 +++++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  1 +
 include/linux/mmc/sdio_ids.h                  |  1 +
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
index 9bf9bbac16e2..cdc303caf5f4 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
@@ -1,4 +1,4 @@
-Marvell 8787/8897/8997 (sd8787/sd8897/sd8997/pcie8997) SDIO/PCIE devices
+Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
 ------
 
 This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
@@ -10,7 +10,9 @@ Required properties:
   - compatible : should be one of the following:
 	* "marvell,sd8787"
 	* "marvell,sd8897"
+	* "marvell,sd8978"
 	* "marvell,sd8997"
+	* "nxp,iw416"
 	* "pci11ab,2b42"
 	* "pci1b4b,2b42"
 
diff --git a/drivers/net/wireless/marvell/mwifiex/Kconfig b/drivers/net/wireless/marvell/mwifiex/Kconfig
index 2b4ff2b78a7e..b182f7155d66 100644
--- a/drivers/net/wireless/marvell/mwifiex/Kconfig
+++ b/drivers/net/wireless/marvell/mwifiex/Kconfig
@@ -10,13 +10,14 @@ config MWIFIEX
 	  mwifiex.
 
 config MWIFIEX_SDIO
-	tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8987/SD8997"
+	tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
 	depends on MWIFIEX && MMC
 	select FW_LOADER
 	select WANT_DEV_COREDUMP
 	help
 	  This adds support for wireless adapters based on Marvell
-	  8786/8787/8797/8887/8897/8977/8987/8997 chipsets with SDIO interface.
+	  8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
+	  SDIO interface. SD8978 is also known as NXP IW416.
 
 	  If you choose to build it as a module, it will be called
 	  mwifiex_sdio.
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 016065a56e6c..919f1bae61dc 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -275,7 +275,7 @@ static const struct mwifiex_sdio_card_reg mwifiex_reg_sd8887 = {
 				 0x68, 0x69, 0x6a},
 };
 
-static const struct mwifiex_sdio_card_reg mwifiex_reg_sd8987 = {
+static const struct mwifiex_sdio_card_reg mwifiex_reg_sd89xx = {
 	.start_rd_port = 0,
 	.start_wr_port = 0,
 	.base_0_reg = 0xF8,
@@ -406,6 +406,22 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.can_ext_scan = true,
 };
 
+static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
+	.firmware_sdiouart = SD8978_SDIOUART_FW_NAME,
+	.reg = &mwifiex_reg_sd89xx,
+	.max_ports = 32,
+	.mp_agg_pkt_limit = 16,
+	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_4K,
+	.mp_tx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.mp_rx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.supports_sdio_new_mode = true,
+	.has_control_mask = false,
+	.can_dump_fw = true,
+	.fw_dump_enh = true,
+	.can_auto_tdls = false,
+	.can_ext_scan = true,
+};
+
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.firmware = SD8997_DEFAULT_FW_NAME,
 	.reg = &mwifiex_reg_sd8997,
@@ -439,7 +455,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.firmware = SD8987_DEFAULT_FW_NAME,
-	.reg = &mwifiex_reg_sd8987,
+	.reg = &mwifiex_reg_sd89xx,
 	.max_ports = 32,
 	.mp_agg_pkt_limit = 16,
 	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_2K,
@@ -493,7 +509,9 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 static const struct of_device_id mwifiex_sdio_of_match_table[] __maybe_unused = {
 	{ .compatible = "marvell,sd8787" },
 	{ .compatible = "marvell,sd8897" },
+	{ .compatible = "marvell,sd8978" },
 	{ .compatible = "marvell,sd8997" },
+	{ .compatible = "nxp,iw416" },
 	{ }
 };
 
@@ -931,6 +949,8 @@ static const struct sdio_device_id mwifiex_ids[] = {
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8801},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8977},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8978_WLAN),
+		.driver_data = (unsigned long)&mwifiex_sdio_sd8978},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8987},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_WLAN),
@@ -3175,5 +3195,6 @@ MODULE_FIRMWARE(SD8797_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8897_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8887_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8977_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
 MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index ad2c28cbb630..e9a9de566cc8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -37,6 +37,7 @@
 #define SD8887_DEFAULT_FW_NAME "mrvl/sd8887_uapsta.bin"
 #define SD8801_DEFAULT_FW_NAME "mrvl/sd8801_uapsta.bin"
 #define SD8977_DEFAULT_FW_NAME "mrvl/sdsd8977_combo_v2.bin"
+#define SD8978_SDIOUART_FW_NAME "mrvl/sdiouartiw416_combo_v0.bin"
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
 #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index a85c9f0bd470..d1524c5e49a1 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -101,6 +101,7 @@
 #define SDIO_DEVICE_ID_MARVELL_8977_BT		0x9146
 #define SDIO_DEVICE_ID_MARVELL_8987_WLAN	0x9149
 #define SDIO_DEVICE_ID_MARVELL_8987_BT		0x914a
+#define SDIO_DEVICE_ID_MARVELL_8978_WLAN	0x9159
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
-- 
2.43.0




