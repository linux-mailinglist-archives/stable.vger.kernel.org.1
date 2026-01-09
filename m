Return-Path: <stable+bounces-207891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC35D0B694
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11EEE307E810
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53A364EA6;
	Fri,  9 Jan 2026 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCMKfyYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6D3644DA;
	Fri,  9 Jan 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977031; cv=none; b=Y6gkhgcVYusBcXPxAMxoOOd68wawTblf531E7VPziKb0suSQzwCJchj+kVr2cDZkJdBPZP/DVO4nxTwF4DTTM2HYrsAGrIjdj5LwyLIHsaHlbFMR4hoTImCr4SqEI9kjiT18F/hgXIk9azJbzzAhAS36W869Yn3RYTO8/FJKBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977031; c=relaxed/simple;
	bh=+RnyNDAFYZmy9UXiV2xcpvmL7grvkNRrzz2vsXKxrpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hs+I4/+J6+hlrTCn+z86p3AjjgYacaGejj1yXJJnYuN3iFbeNJ5MVcYZLVyw4IzTDyAqiSBul2KrxnjCrnDUccA9tWa7IuYl6ooSIwSWeEhx1260tF2l5NlFToR8xlJtPrNvU3n4ukcB0dES/uuGHUKlzeH7FW9xATFdLzIauHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCMKfyYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C776C4CEF7;
	Fri,  9 Jan 2026 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767977030;
	bh=+RnyNDAFYZmy9UXiV2xcpvmL7grvkNRrzz2vsXKxrpM=;
	h=From:Date:Subject:To:Cc:From;
	b=uCMKfyYfKXY9HxJ66OR3+1hNu7gwaPm2opxFTnTBcd7SU248Vr0oA7SC2QWVg4gu8
	 3V+kM8VpSwTRe9comxh/3xNQnGsacnM1ZdI5Q8ko8zG7ldx28RsjtdZzjNVw7nV7ox
	 C/cZ6u7co3oMSoXvzv+FehvSvx34/SweSzOpuIUaPnImP3/G19IjPP062bmhKh2Dyy
	 8jDOqWXesy+VTBRoO07EpfyloSBvdtztcztUuIdWnHwAKJewRhtM7xh33BLEuaOjJB
	 AH1eFub1Fsb6wV1Lq2dfDriN5A9bgg3+NpEM41Q2OQ57ZZYr+ZramWRaLCvElvR+EV
	 5j1x6d7jj66mg==
From: Sven Peter <sven@kernel.org>
Date: Fri, 09 Jan 2026 17:43:34 +0100
Subject: [PATCH v2] usb: dwc3: apple: Set USB2 PHY mode before dwc3 init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-dwc3-apple-usb2phy-fix-v2-1-ab6b041e3b26@kernel.org>
X-B4-Tracking: v=1; b=H4sIADUwYWkC/4WNTQ6CMBBGr0Jm7Zi2IhJX3MOwgM5AGwk0rVYJ6
 d0tXMDle/l+NgjsLQe4Fxt4jjbYZc6gTgVo080jo6XMoISqhBQ10kdfsHNuYnyHXjmz4mC/qAd
 Je6ImEpDLznPWx/CjzWxseC1+PX6i3O3fyShR4pXo1uuqVKIUzZP9zNN58SO0KaUfsOiour0AA
 AA=
X-Change-ID: 20260108-dwc3-apple-usb2phy-fix-cf1d26018dd0
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Calligeros <jcalligeros99@gmail.com>, stable@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5121; i=sven@kernel.org;
 h=from:subject:message-id; bh=+RnyNDAFYZmy9UXiV2xcpvmL7grvkNRrzz2vsXKxrpM=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ2aigeUndpGO6asUCg27Qieb/eu0U5rkcv+Pv0jppRk2j
 NOc3+R1lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACaSv5nhf5aWNc/9SW33nwfq
 20+5JJLzeG3LvuAj34pmhRiX1B1LMmJkOBNlHnvc/5j/La9jGp2t+SePcSqUmZTNfiriILo/vHs
 xKwA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93

Now that the upstream code has been getting broader test coverage by our
users we occasionally see issues with USB2 devices plugged in during boot.
Before Linux is running, the USB2 PHY has usually been running in device
mode and it turns out that sometimes host->device or device->host
transitions don't work.
The root cause: If the role inside the USB2 PHY is re-configured when it
has already been powered on or when dwc3 has already enabled the ULPI
interface the new configuration sometimes doesn't take affect until dwc3
is reset again. Fix this rare issue by configuring the role much earlier.
Note that the USB3 PHY does not suffer from this issue and actually
requires dwc3 to be up before the correct role can be configured there.

Reported-by: James Calligeros <jcalligeros99@gmail.com>
Reported-by: Janne Grunau <j@jannau.net>
Fixes: 0ec946d32ef7 ("usb: dwc3: Add Apple Silicon DWC3 glue layer driver")
Cc: stable@vger.kernel.org
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Sven Peter <sven@kernel.org>
---
Changes in v2:
- Picked up tags, thanks!
- Fixed a typo in the commit messages (dwc2 -> dwc3)
- Link to v1: https://patch.msgid.link/20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org
---
 drivers/usb/dwc3/dwc3-apple.c | 48 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-apple.c b/drivers/usb/dwc3/dwc3-apple.c
index cc47cad232e397ac4498b09165dfdb5bd215ded7..c2ae8eb21d514e5e493d2927bc12908c308dfe19 100644
--- a/drivers/usb/dwc3/dwc3-apple.c
+++ b/drivers/usb/dwc3/dwc3-apple.c
@@ -218,25 +218,31 @@ static int dwc3_apple_core_init(struct dwc3_apple *appledwc)
 	return ret;
 }
 
-static void dwc3_apple_phy_set_mode(struct dwc3_apple *appledwc, enum phy_mode mode)
-{
-	lockdep_assert_held(&appledwc->lock);
-
-	/*
-	 * This platform requires SUSPHY to be enabled here already in order to properly configure
-	 * the PHY and switch dwc3's PIPE interface to USB3 PHY.
-	 */
-	dwc3_enable_susphy(&appledwc->dwc, true);
-	phy_set_mode(appledwc->dwc.usb2_generic_phy[0], mode);
-	phy_set_mode(appledwc->dwc.usb3_generic_phy[0], mode);
-}
-
 static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state state)
 {
 	int ret, ret_reset;
 
 	lockdep_assert_held(&appledwc->lock);
 
+	/*
+	 * The USB2 PHY on this platform must be configured for host or device mode while it is
+	 * still powered off and before dwc3 tries to access it. Otherwise, the new configuration
+	 * will sometimes only take affect after the *next* time dwc3 is brought up which causes
+	 * the connected device to just not work.
+	 * The USB3 PHY must be configured later after dwc3 has already been initialized.
+	 */
+	switch (state) {
+	case DWC3_APPLE_HOST:
+		phy_set_mode(appledwc->dwc.usb2_generic_phy[0], PHY_MODE_USB_HOST);
+		break;
+	case DWC3_APPLE_DEVICE:
+		phy_set_mode(appledwc->dwc.usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		break;
+	default:
+		/* Unreachable unless there's a bug in this driver */
+		return -EINVAL;
+	}
+
 	ret = reset_control_deassert(appledwc->reset);
 	if (ret) {
 		dev_err(appledwc->dev, "Failed to deassert reset, err=%d\n", ret);
@@ -257,7 +263,13 @@ static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state st
 	case DWC3_APPLE_HOST:
 		appledwc->dwc.dr_mode = USB_DR_MODE_HOST;
 		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_HOST);
-		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_HOST);
+		/*
+		 * This platform requires SUSPHY to be enabled here already in order to properly
+		 * configure the PHY and switch dwc3's PIPE interface to USB3 PHY. The USB2 PHY
+		 * has already been configured to the correct mode earlier.
+		 */
+		dwc3_enable_susphy(&appledwc->dwc, true);
+		phy_set_mode(appledwc->dwc.usb3_generic_phy[0], PHY_MODE_USB_HOST);
 		ret = dwc3_host_init(&appledwc->dwc);
 		if (ret) {
 			dev_err(appledwc->dev, "Failed to initialize host, ret=%d\n", ret);
@@ -268,7 +280,13 @@ static int dwc3_apple_init(struct dwc3_apple *appledwc, enum dwc3_apple_state st
 	case DWC3_APPLE_DEVICE:
 		appledwc->dwc.dr_mode = USB_DR_MODE_PERIPHERAL;
 		dwc3_apple_set_ptrcap(appledwc, DWC3_GCTL_PRTCAP_DEVICE);
-		dwc3_apple_phy_set_mode(appledwc, PHY_MODE_USB_DEVICE);
+		/*
+		 * This platform requires SUSPHY to be enabled here already in order to properly
+		 * configure the PHY and switch dwc3's PIPE interface to USB3 PHY. The USB2 PHY
+		 * has already been configured to the correct mode earlier.
+		 */
+		dwc3_enable_susphy(&appledwc->dwc, true);
+		phy_set_mode(appledwc->dwc.usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 		ret = dwc3_gadget_init(&appledwc->dwc);
 		if (ret) {
 			dev_err(appledwc->dev, "Failed to initialize gadget, ret=%d\n", ret);

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260108-dwc3-apple-usb2phy-fix-cf1d26018dd0

Best regards,
-- 
Sven Peter <sven@kernel.org>


