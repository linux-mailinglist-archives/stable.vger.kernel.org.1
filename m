Return-Path: <stable+bounces-206405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF74D05D7E
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 318D930412B0
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1D2F83AC;
	Thu,  8 Jan 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFoQJB2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4817C77;
	Thu,  8 Jan 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900136; cv=none; b=uenqDYvhu/eMAB/5S9r29rlXQbic5hZoI4KjJAKcorvtuf6lqGswPZx/IfS4Pkf0XpNYh5dVjOl4g2zMu75YGmNPDEeR0toHsXZWxam8bR/kXcn7aNFGbAe0zdvYW7xouWpA5fSGDAr5KCHo8vZIUVl6A156XzZ4W0mkohCQnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900136; c=relaxed/simple;
	bh=SgiIwSGNIMEYoLsEOhMCECPsYkJzdCrSAXL1UwjjorQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=na6UTiISQunfRQLRCctOFJIFLV2m4I8xDXK8M+I0RwO9GDF7WKIfSlHN1cFA4fJRd9ALA7dwXR0QwuPfqfaRHho60YwCGphKkTymdwkH2b3TikASN6396oPf4rrFwfOVWY7a6eLGqHpjGDyFpWkWOuqbqn2eUGCWjrwbni/WVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFoQJB2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D2C116C6;
	Thu,  8 Jan 2026 19:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767900135;
	bh=SgiIwSGNIMEYoLsEOhMCECPsYkJzdCrSAXL1UwjjorQ=;
	h=From:Date:Subject:To:Cc:From;
	b=IFoQJB2UH9klc8P7g1i9nr243qSGMbM5qOmlgbCWc6yynUhz7TPhoy7i5uEjDEV3d
	 2AGvTv19bz5vyhMihU9sXkKf7Zq6cRmD4j0aVRnWqDZf4LdZ5p8l1tOJp9SY66NJk0
	 n7RjWWwFVrMfhs9YuroW/m9BrCa7138CywjeKNLFdpIqYlfqB0QNPXy93J7PWdboaf
	 vIanBmYnYPPlV9G4egZfUOrPHqk69UOxzk3DSD3qFw5Y/v/d3B/ftOypzCBJpSiXd6
	 sbT1ADXaibziY+0YSKNsP99pQxyyQtEH1HXoMacK5i9AJmR+GV+9tm8pqZBL5CDq8F
	 FHUQxSs4TdaUw==
From: Sven Peter <sven@kernel.org>
Date: Thu, 08 Jan 2026 20:21:45 +0100
Subject: [PATCH] usb: dwc3: apple: Set USB2 PHY mode before dwc3 init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMgDYGkC/x2MSwqAMAwFryJZG2grSPEq4kKbaAOipcUf4t2tL
 ucxb25IHIUTNMUNkXdJsi4ZdFmA8/0yMQplBqNMrbSySIersA9hZtzSYIK/cJQT3ajpMyyRgnw
 OkfP8h9vueV7teDr4aAAAAA==
X-Change-ID: 20260108-dwc3-apple-usb2phy-fix-cf1d26018dd0
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Calligeros <jcalligeros99@gmail.com>, stable@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4784; i=sven@kernel.org;
 h=from:subject:message-id; bh=SgiIwSGNIMEYoLsEOhMCECPsYkJzdCrSAXL1UwjjorQ=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ2YC8+Ml7RU12+actexbe+TSmgke2hu/vpYKf6jHtUnne
 Gfr6d6/HaUsDGJcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJrFzP8M+yX/u+j4vF3xXP
 O/5atyyM6lltNY9vosG/+75LFZbWvrnF8JNRsfLhgfcBpr5x+mskhT/92emyZ9niQ8/6CyXZFl4
 6vJkFAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93

Now that the upstream code has been getting broader test coverage by our
users we occasionally see issues with USB2 devices plugged in during boot.
Before Linux is running, the USB2 PHY has usually been running in device
mode and it turns out that sometimes host->device or device->host
transitions don't work.
The root cause: If the role inside the USB2 PHY is re-configured when it
has already been powered on or when dwc2 has already enabled the ULPI
interface the new configuration sometimes doesn't take affect until dwc3
is reset again. Fix this rare issue by configuring the role much earlier.
Note that the USB3 PHY does not suffer from this issue and actually
requires dwc3 to be up before the correct role can be configured there.

Reported-by: James Calligeros <jcalligeros99@gmail.com>
Reported-by: Janne Grunau <j@jannau.net>
Fixes: 0ec946d32ef7 ("usb: dwc3: Add Apple Silicon DWC3 glue layer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
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


