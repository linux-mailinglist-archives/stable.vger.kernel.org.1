Return-Path: <stable+bounces-185236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FEBD4BA9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49BD9543720
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAB30FC05;
	Mon, 13 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSCyEPHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49926F2B6;
	Mon, 13 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369720; cv=none; b=WNGGyFjkGzqYyx1mneczxk5pzQjv6FhekmTKDU5ubW0XAmn3D96+PDCXtSfNCeMRRw/s4F1nJRZDvqBoHXa5OQ0MGuauczdyQjYrX3AgmOFhSZTT+nOvTxpc7atd5KPZdiO1ddwiknBLbaNsspIxRKR7tSNZPsQkEb5evYUF+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369720; c=relaxed/simple;
	bh=3B/dfrP8Uz6DsiiGavA+p8GKFDSs4ja5t8FK2+3qh2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfGsjxEHmT04wvrRV5UO6K7ZWIknAdx3B2OuOzCUnMFsxVn3Wlnn16wKsaQYVySbj9mShmXPgLj5FB01KyS0/ZK9FLvgZvCIul2931lcWIrrdLW5T5zUhkl1LGjdBWbczRqQoSeBT+sHqCDUvMAr54KvWAGcDIW1nYCDlAsexwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSCyEPHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EB9C4CEE7;
	Mon, 13 Oct 2025 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369720;
	bh=3B/dfrP8Uz6DsiiGavA+p8GKFDSs4ja5t8FK2+3qh2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSCyEPHPlQ5uZSkBRTLuam/0Ro+zdL7NLHnQvF5XjmzNtPdY9Yr5SqPT2YpiaJSYm
	 EdLHoupDduiPHlExj6/D4muOTCP+Jxu7dQ9LG5aeq7P4L2DfF+pr5YoneSDkjTPWC8
	 2L7EXho5zeYre9MY70XG+YWeQ057M6zNxd90Nzsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 311/563] wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)
Date: Mon, 13 Oct 2025 16:42:52 +0200
Message-ID: <20251013144422.532118728@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>

[ Upstream commit 74e2ef72bd4b25ce21c8f309d4f5b91b5df9ff5b ]

Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
has not officially released any firmware binary for it. It is incorrect to
maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
chip's firmware Vendor ID as "WCC" as suggested by the maintainer.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20250724101136.6691-1-gokulkumar.sivakumar@infineon.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++----
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 -
 include/linux/mmc/sdio_ids.h                              | 2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 8ab7d1e34a6e1..6a3f187320fc4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -997,9 +997,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43751, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 9074ab49e8068..4239f2b21e542 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -738,8 +738,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
-	case CY_CC_43752_CHIP_ID:
 	case BRCM_CC_43751_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case BRCM_CC_4377_CHIP_ID:
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
@@ -1452,7 +1452,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
 	case BRCM_CC_43751_CHIP_ID:
-	case CY_CC_43752_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
 		reg = chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8a0bad5119a0d..8cf9d7e7c3f70 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -655,10 +655,10 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
 	BRCMF_FW_ENTRY(BRCM_CC_43751_CHIP_ID, 0xFFFFFFFF, 43752),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
-	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
 #define TXCTL_CREDITS	2
@@ -3426,8 +3426,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
 	if (bus->ci->chip == BRCM_CC_43751_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43752_CHIP_ID)
+	    bus->ci->chip == BRCM_CC_43752_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
@@ -4278,8 +4278,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 		switch (sdiod->func1->device) {
 		case SDIO_DEVICE_ID_BROADCOM_43751:
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index b39c5c1ee18b6..df3b67ba4db29 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -60,7 +60,6 @@
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
-#define CY_CC_43752_CHIP_ID		43752
 
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index fe3d6d98f8da4..673cbdf434533 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -77,7 +77,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_43751		0xaae7
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
-- 
2.51.0




