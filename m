Return-Path: <stable+bounces-7245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC8817196
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C149A1C24440
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0EA1D148;
	Mon, 18 Dec 2023 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3f7714/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A41D137;
	Mon, 18 Dec 2023 13:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F04C433C8;
	Mon, 18 Dec 2023 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907947;
	bh=HWNnshOQ1+K8joMJ+XRcHpxTk+sKgS9TEZhkeY0GuYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3f7714/Y+762uRpjuYf/ixtECI3whu5mOIUhu1MZ+2yaqM73EOJkz1UYg1nS6KYu
	 IBZji+V/o3SftQAajYCxz33Yx9TFoxLjehk1pa400dCDes4LJ2t/P1gTaxhMD4/gyL
	 Dip8YzKuv7xAdNl5kWbp8PcULC2ULmbXDER+7hFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hayes Wang <hayeswang@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 105/106] r8152: remove rtl_vendor_mode function
Date: Mon, 18 Dec 2023 14:51:59 +0100
Message-ID: <20231218135059.558618285@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hayes Wang <hayeswang@realtek.com>

commit 95a4c1d617b92cdc4522297741b56e8f6cd01a1e upstream.

After commit ec51fbd1b8a2 ("r8152: add USB device driver for
config selection"), the code about changing USB configuration
in rtl_vendor_mode() wouldn't be run anymore. Therefore, the
function could be removed.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |   39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8288,43 +8288,6 @@ static bool rtl_check_vendor_ok(struct u
 	return true;
 }
 
-static bool rtl_vendor_mode(struct usb_interface *intf)
-{
-	struct usb_host_interface *alt = intf->cur_altsetting;
-	struct usb_device *udev;
-	struct usb_host_config *c;
-	int i, num_configs;
-
-	if (alt->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC)
-		return rtl_check_vendor_ok(intf);
-
-	/* The vendor mode is not always config #1, so to find it out. */
-	udev = interface_to_usbdev(intf);
-	c = udev->config;
-	num_configs = udev->descriptor.bNumConfigurations;
-	if (num_configs < 2)
-		return false;
-
-	for (i = 0; i < num_configs; (i++, c++)) {
-		struct usb_interface_descriptor	*desc = NULL;
-
-		if (c->desc.bNumInterfaces > 0)
-			desc = &c->intf_cache[0]->altsetting->desc;
-		else
-			continue;
-
-		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
-			usb_driver_set_configuration(udev, c->desc.bConfigurationValue);
-			break;
-		}
-	}
-
-	if (i == num_configs)
-		dev_err(&intf->dev, "Unexpected Device\n");
-
-	return false;
-}
-
 static int rtl8152_pre_reset(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
@@ -9686,7 +9649,7 @@ static int rtl8152_probe(struct usb_inte
 	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
 		return -ENODEV;
 
-	if (!rtl_vendor_mode(intf))
+	if (!rtl_check_vendor_ok(intf))
 		return -ENODEV;
 
 	usb_reset_device(udev);



