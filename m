Return-Path: <stable+bounces-46436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E758D0467
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CB1C21670
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D016E870;
	Mon, 27 May 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc4dU6F4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EA16E868;
	Mon, 27 May 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819530; cv=none; b=Qx7ZuYg8R/TmtxY2qHfLtKxb7FbI1uxEihnClWnOszHHhcUW8zjGvY6lWoAOeYfP59oTYLlRcpOLZesHpKNUhe+BckX8NOd5zfoBI/J3SrG79eE3B/jKC24H0Qw/p+ewPOXw0LR81JBYIOyINJ4on5TgdRhFudBGbEhS2SYYz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819530; c=relaxed/simple;
	bh=Z5T0gu59/dQrO1Cfehp1ybI1Sur9v7U7wxLbsRARcmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzBMU0x5AdXj5iWDj/eJSwm+p7ygoKTZ8ZVCj31hA9duecnbPDJMTaEu+C0NNf1nitSQ3JUUVd01c1enhZr+9Gb7r7qSkoHqKOTvCkyJOZ7B/XFT8mga5PZ/JegidICNWkTLaDiOTvDchKeU3slvYfdxZagYO5r4iwuHklLY76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc4dU6F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2427C32781;
	Mon, 27 May 2024 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819529;
	bh=Z5T0gu59/dQrO1Cfehp1ybI1Sur9v7U7wxLbsRARcmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bc4dU6F4BMLEko2pd7P8i9Mudi6yBZtRBzCxxGMai21fYfI8YJzLtxtyX0ziQwYEd
	 AOYFJxs9jZPAcxTFMKzxeWT+Zok2DsZ4yH0xKq3Xqtc4wuSS3o9hK/xXpjnYBxEhJi
	 WUMpzilbzHMAU4n0SFimpSbT+ury1pIjfT+BjWJ3TzpPB8TAOPbEtQCBVX6U09tfuk
	 6RAaflufoaWQH9coycoJuoVjlHoTsgM4R0uOhf6LkQlWwg2rmmA8SG0HRO6ms7O8yn
	 teygqmil4JA9x9YTvyQzwt5uopskiyjpbmD096zmY4yv3I6IlWRmZZN4Ww/RGDLFHq
	 QMaG52uhP/u5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uri Arev <me@wantyapps.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/13] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
Date: Mon, 27 May 2024 10:18:07 -0400
Message-ID: <20240527141819.3854376-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141819.3854376-1-sashal@kernel.org>
References: <20240527141819.3854376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Uri Arev <me@wantyapps.xyz>

[ Upstream commit 68aa21054ec3a1a313af90a5f95ade16c3326d20 ]

This fixes some CHECKs reported by the checkpatch script.

Issues reported in ath3k.c:
-------
ath3k.c
-------
CHECK: Please don't use multiple blank lines
+
+

CHECK: Blank lines aren't necessary after an open brace '{'
+static const struct usb_device_id ath3k_blist_tbl[] = {
+

CHECK: Alignment should match open parenthesis
+static int ath3k_load_firmware(struct usb_device *udev,
+                               const struct firmware *firmware)

CHECK: Alignment should match open parenthesis
+               err = usb_bulk_msg(udev, pipe, send_buf, size,
+                                       &len, 3000);

CHECK: Unnecessary parentheses around 'len != size'
+               if (err || (len != size)) {

CHECK: Alignment should match open parenthesis
+static int ath3k_get_version(struct usb_device *udev,
+                       struct ath3k_version *version)

CHECK: Alignment should match open parenthesis
+static int ath3k_load_fwfile(struct usb_device *udev,
+               const struct firmware *firmware)

CHECK: Alignment should match open parenthesis
+               err = usb_bulk_msg(udev, pipe, send_buf, size,
+                                       &len, 3000);

CHECK: Unnecessary parentheses around 'len != size'
+               if (err || (len != size)) {

CHECK: Blank lines aren't necessary after an open brace '{'
+       switch (fw_version.ref_clock) {
+

CHECK: Alignment should match open parenthesis
+       snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
+               le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");

CHECK: Alignment should match open parenthesis
+static int ath3k_probe(struct usb_interface *intf,
+                       const struct usb_device_id *id)

CHECK: Alignment should match open parenthesis
+                       BT_ERR("Firmware file \"%s\" not found",
+                                                       ATH3K_FIRMWARE);

CHECK: Alignment should match open parenthesis
+               BT_ERR("Firmware file \"%s\" request failed (err=%d)",
+                                               ATH3K_FIRMWARE, ret);

total: 0 errors, 0 warnings, 14 checks, 540 lines checked

Signed-off-by: Uri Arev <me@wantyapps.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/ath3k.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 759d7828931d9..56ada48104f0e 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2008-2009 Atheros Communications Inc.
  */
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -129,7 +128,6 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
  * for AR3012
  */
 static const struct usb_device_id ath3k_blist_tbl[] = {
-
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
@@ -203,7 +201,7 @@ static inline void ath3k_log_failed_loading(int err, int len, int size,
 #define TIMEGAP_USEC_MAX	100
 
 static int ath3k_load_firmware(struct usb_device *udev,
-				const struct firmware *firmware)
+			       const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -238,9 +236,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
+				   &len, 3000);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			goto error;
 		}
@@ -263,7 +261,7 @@ static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
 }
 
 static int ath3k_get_version(struct usb_device *udev,
-			struct ath3k_version *version)
+			     struct ath3k_version *version)
 {
 	return usb_control_msg_recv(udev, 0, ATH3K_GETVERSION,
 				    USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
@@ -272,7 +270,7 @@ static int ath3k_get_version(struct usb_device *udev,
 }
 
 static int ath3k_load_fwfile(struct usb_device *udev,
-		const struct firmware *firmware)
+			     const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -311,8 +309,8 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
-		if (err || (len != size)) {
+				   &len, 3000);
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			kfree(send_buf);
 			return err;
@@ -426,7 +424,6 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	switch (fw_version.ref_clock) {
-
 	case ATH3K_XTAL_FREQ_26M:
 		clk_value = 26;
 		break;
@@ -442,7 +439,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
+		 le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -457,7 +454,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 }
 
 static int ath3k_probe(struct usb_interface *intf,
-			const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	const struct firmware *firmware;
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -506,10 +503,10 @@ static int ath3k_probe(struct usb_interface *intf,
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			BT_ERR("Firmware file \"%s\" not found",
-							ATH3K_FIRMWARE);
+			       ATH3K_FIRMWARE);
 		else
 			BT_ERR("Firmware file \"%s\" request failed (err=%d)",
-							ATH3K_FIRMWARE, ret);
+			       ATH3K_FIRMWARE, ret);
 		return ret;
 	}
 
-- 
2.43.0


