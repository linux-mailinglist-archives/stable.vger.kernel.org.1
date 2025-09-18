Return-Path: <stable+bounces-174067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825DB36113
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304771BC1E39
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26031D90C8;
	Tue, 26 Aug 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxzZwHr6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112918DB2A;
	Tue, 26 Aug 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213404; cv=none; b=iwMQrTjceQECzFXOYalHFxI5gHf7KxvxkpiUP7EtagOQQiw6Yv9LcGMf8hvBDXeCQYSVzBvFL9dvi85BJODBIVjxDs/X5lIuy9IsMkxq+Y9zSaun85JJSznLAvTwT6OdxFtIOW7ctjz3W+jksSYUMAXohatMRNj6tz+skBKlCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213404; c=relaxed/simple;
	bh=HZGcjeHJvGtXZ1UctAiPukx+1CuBEBvnOmsLgRH478A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRECC79jFNqqIHPx7iJ2pNmCp93ib5krS2c+miLaUUWxxqHJnlihcm92CPcSPJQ9yx5jjmpwqEXyAsWY2gtIHI7q9P9djYXQ0OeIX0y9qXo3yaXIGvN+soG9ASpPBSXZ9mFrCM+ueaPGFUFEo0dbcwyqmkCEeMqWfHWYgumygIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxzZwHr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FE3C4CEF1;
	Tue, 26 Aug 2025 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213404;
	bh=HZGcjeHJvGtXZ1UctAiPukx+1CuBEBvnOmsLgRH478A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxzZwHr66V9Tq8y1guOC45JEvQR5aJHxuQzHqxdH1Ic6OkJxJjwIC1ErjrQ92056V
	 ZRNJqWvpkFTQHTtZb5MzIHYQUp/q3sJJR2Y7oyHl5J9aEMD+XqUa2GxcGBrCIq3wqv
	 eKdU+s/LjNajRebIOrXLK61EgDdvLA1YJEUCUMWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.6 333/587] usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()
Date: Tue, 26 Aug 2025 13:08:02 +0200
Message-ID: <20250826111001.387872033@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 8d1b02e5d7e3a6d2acffb1f4c094678fda9e3456 upstream.

After a recent change in clang to expose uninitialized warnings from
const variables [1], there is a warning in cxacru_heavy_init():

  drivers/usb/atm/cxacru.c:1104:6: error: variable 'bp' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
   1104 |         if (instance->modem_type->boot_rom_patch) {
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/usb/atm/cxacru.c:1113:39: note: uninitialized use occurs here
   1113 |         cxacru_upload_firmware(instance, fw, bp);
        |                                              ^~
  drivers/usb/atm/cxacru.c:1104:2: note: remove the 'if' if its condition is always true
   1104 |         if (instance->modem_type->boot_rom_patch) {
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/usb/atm/cxacru.c:1095:32: note: initialize the variable 'bp' to silence this warning
   1095 |         const struct firmware *fw, *bp;
        |                                       ^
        |                                        = NULL

While the warning is technically correct that bp is conditionally passed
uninitialized to cxacru_upload_firmware(), it is ultimately a false
positive warning on the uninitialized use of bp because the same
condition that initializes bp, instance->modem_type->boot_rom_patch, is
the same one that gates the use of bp within cxacru_upload_firmware().
As this warning occurs in clang's frontend before inlining occurs, it
cannot know that these conditions are indentical to avoid the warning.

Manually inline cxacru_upload_firmware() into cxacru_heavy_init(), as
that is its only callsite, so that clang can see that bp is initialized
and used under the same condition, clearing up the warning without any
functional changes to the code (LLVM was already doing this inlining
later).

Cc: stable@vger.kernel.org
Fixes: 1b0e61465234 ("[PATCH] USB ATM: driver for the Conexant AccessRunner chipset cxacru")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2102
Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250722-usb-cxacru-fix-clang-21-uninit-warning-v2-1-6708a18decd2@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/atm/cxacru.c |  106 +++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 57 deletions(-)

--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -980,25 +980,60 @@ cleanup:
 	return ret;
 }
 
-static void cxacru_upload_firmware(struct cxacru_data *instance,
-				   const struct firmware *fw,
-				   const struct firmware *bp)
+
+static int cxacru_find_firmware(struct cxacru_data *instance,
+				char *phase, const struct firmware **fw_p)
 {
-	int ret;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct device *dev = &usbatm->usb_intf->dev;
+	char buf[16];
+
+	sprintf(buf, "cxacru-%s.bin", phase);
+	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
+
+	if (request_firmware(fw_p, buf, dev)) {
+		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
+		return -ENOENT;
+	}
+
+	usb_info(usbatm, "found firmware %s\n", buf);
+
+	return 0;
+}
+
+static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
+			     struct usb_interface *usb_intf)
+{
+	const struct firmware *fw, *bp;
+	struct cxacru_data *instance = usbatm_instance->driver_data;
 	struct usbatm_data *usbatm = instance->usbatm;
 	struct usb_device *usb_dev = usbatm->usb_dev;
 	__le16 signature[] = { usb_dev->descriptor.idVendor,
 			       usb_dev->descriptor.idProduct };
 	__le32 val;
+	int ret;
+
+	ret = cxacru_find_firmware(instance, "fw", &fw);
+	if (ret) {
+		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
+		return ret;
+	}
 
-	usb_dbg(usbatm, "%s\n", __func__);
+	if (instance->modem_type->boot_rom_patch) {
+		ret = cxacru_find_firmware(instance, "bp", &bp);
+		if (ret) {
+			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
+			release_firmware(fw);
+			return ret;
+		}
+	}
 
 	/* FirmwarePllFClkValue */
 	val = cpu_to_le32(instance->modem_type->pll_f_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLFCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllFClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* FirmwarePllBClkValue */
@@ -1006,7 +1041,7 @@ static void cxacru_upload_firmware(struc
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLBCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllBClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Enable SDRAM */
@@ -1014,7 +1049,7 @@ static void cxacru_upload_firmware(struc
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SDRAMEN_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "Enable SDRAM failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Firmware */
@@ -1022,7 +1057,7 @@ static void cxacru_upload_firmware(struc
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, FW_ADDR, fw->data, fw->size);
 	if (ret) {
 		usb_err(usbatm, "Firmware upload failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Boot ROM patch */
@@ -1031,7 +1066,7 @@ static void cxacru_upload_firmware(struc
 		ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, BR_ADDR, bp->data, bp->size);
 		if (ret) {
 			usb_err(usbatm, "Boot ROM patching failed: %d\n", ret);
-			return;
+			goto done;
 		}
 	}
 
@@ -1039,7 +1074,7 @@ static void cxacru_upload_firmware(struc
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SIG_ADDR, (u8 *) signature, 4);
 	if (ret) {
 		usb_err(usbatm, "Signature storing failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	usb_info(usbatm, "starting device\n");
@@ -1051,7 +1086,7 @@ static void cxacru_upload_firmware(struc
 	}
 	if (ret) {
 		usb_err(usbatm, "Passing control to firmware failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Delay to allow firmware to start up. */
@@ -1065,53 +1100,10 @@ static void cxacru_upload_firmware(struc
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_STATUS, NULL, 0, NULL, 0);
 	if (ret < 0) {
 		usb_err(usbatm, "modem failed to initialize: %d\n", ret);
-		return;
-	}
-}
-
-static int cxacru_find_firmware(struct cxacru_data *instance,
-				char *phase, const struct firmware **fw_p)
-{
-	struct usbatm_data *usbatm = instance->usbatm;
-	struct device *dev = &usbatm->usb_intf->dev;
-	char buf[16];
-
-	sprintf(buf, "cxacru-%s.bin", phase);
-	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
-
-	if (request_firmware(fw_p, buf, dev)) {
-		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
-		return -ENOENT;
+		goto done;
 	}
 
-	usb_info(usbatm, "found firmware %s\n", buf);
-
-	return 0;
-}
-
-static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
-			     struct usb_interface *usb_intf)
-{
-	const struct firmware *fw, *bp;
-	struct cxacru_data *instance = usbatm_instance->driver_data;
-	int ret = cxacru_find_firmware(instance, "fw", &fw);
-
-	if (ret) {
-		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
-		return ret;
-	}
-
-	if (instance->modem_type->boot_rom_patch) {
-		ret = cxacru_find_firmware(instance, "bp", &bp);
-		if (ret) {
-			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
-			release_firmware(fw);
-			return ret;
-		}
-	}
-
-	cxacru_upload_firmware(instance, fw, bp);
-
+done:
 	if (instance->modem_type->boot_rom_patch)
 		release_firmware(bp);
 	release_firmware(fw);



