Return-Path: <stable+bounces-48090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC78FCC3E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05C51C233E7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF70198831;
	Wed,  5 Jun 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU3dP4oG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C319882A;
	Wed,  5 Jun 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588488; cv=none; b=YRB9zhLkx1aU7uTcLWAURwHXR1pGiNEDOaJuovaxTr3cZa71FgVQQvEyhznk09o+PsKR651vs+gmUEZBuYdlBKVPJXvhdHyO5hRPyXj1W8bAfUgD9OOpwQ4R442xYzWt0Es0bh+JySxrWYppCSEs/aJ89N/k/5kkvTBhm/IA5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588488; c=relaxed/simple;
	bh=keKYWfzN1djD6KLmxuPPa4XdGqVyHQTp9UFTeJAwljs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqOsU9xE+kg8/935jH5ND+W8xCJ0A9jBjX2mD8vVjvE1B1QRSTln5P49cN5xbLPrB7pssyITbbPht0md4CFrt9ZacSliLFTHEqPsWKYbbNu+yDyth8BJejJJO7k6nxc2o5TqrLYREsm+abAgnCLJFCEy/XlifciuALNAET4fk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU3dP4oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CF3C32786;
	Wed,  5 Jun 2024 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588487;
	bh=keKYWfzN1djD6KLmxuPPa4XdGqVyHQTp9UFTeJAwljs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nU3dP4oGHGWshq8APClBLEUanqpxmKUBD+ZCLzbLwqUfJj++cPEL5h50Bcth3tdmN
	 8rej/RqiRbkLueOx+8MliCrbPc/XTBnVIFbfrXwoRgJTfuzXXLDevo8JSA0LFbkPSP
	 ESvbND2NSHr/+mcuy/KEDtEwwDmMpMR9WbWFyMnFHhHK5lcP1vys+wcYZ0BFHWyJ/M
	 Ey6ivuhEaFMzMeNozZpHjexOIoq3xwBi0W+EZs6EeqfZp7UATXPS50lITuAjlnx39u
	 iFLs/uwYdYFHQRulNmigjeYEPJ5d5iOLJkHFLBw/vu2FTm7vTtbgDoCfkyH3oRenrT
	 W0yWlf44DZSRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	sudipm.mukherjee@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/7] usb: misc: uss720: check for incompatible versions of the Belkin F5U002
Date: Wed,  5 Jun 2024 07:54:31 -0400
Message-ID: <20240605115442.2964376-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115442.2964376-1-sashal@kernel.org>
References: <20240605115442.2964376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit 3295f1b866bfbcabd625511968e8a5c541f9ab32 ]

The incompatible device in my possession has a sticker that says
"F5U002 Rev 2" and "P80453-B", and lsusb identifies it as
"050d:0002 Belkin Components IEEE-1284 Controller". There is a bug
report from 2007 from Michael Trausch who was seeing the exact same
errors that I saw in 2024 trying to use this cable.

Link: https://lore.kernel.org/all/46DE5830.9060401@trausch.us/
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Link: https://lore.kernel.org/r/20240326150723.99939-5-alexhenrie24@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/uss720.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 0be8efcda15d5..d972c09629397 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -677,7 +677,7 @@ static int uss720_probe(struct usb_interface *intf,
 	struct parport_uss720_private *priv;
 	struct parport *pp;
 	unsigned char reg;
-	int i;
+	int ret;
 
 	dev_dbg(&intf->dev, "probe: vendor id 0x%x, device id 0x%x\n",
 		le16_to_cpu(usbdev->descriptor.idVendor),
@@ -688,8 +688,8 @@ static int uss720_probe(struct usb_interface *intf,
 		usb_put_dev(usbdev);
 		return -ENODEV;
 	}
-	i = usb_set_interface(usbdev, intf->altsetting->desc.bInterfaceNumber, 2);
-	dev_dbg(&intf->dev, "set interface result %d\n", i);
+	ret = usb_set_interface(usbdev, intf->altsetting->desc.bInterfaceNumber, 2);
+	dev_dbg(&intf->dev, "set interface result %d\n", ret);
 
 	interface = intf->cur_altsetting;
 
@@ -725,12 +725,18 @@ static int uss720_probe(struct usb_interface *intf,
 	set_1284_register(pp, 7, 0x00, GFP_KERNEL);
 	set_1284_register(pp, 6, 0x30, GFP_KERNEL);  /* PS/2 mode */
 	set_1284_register(pp, 2, 0x0c, GFP_KERNEL);
-	/* debugging */
-	get_1284_register(pp, 0, &reg, GFP_KERNEL);
+
+	/* The Belkin F5U002 Rev 2 P80453-B USB parallel port adapter shares the
+	 * device ID 050d:0002 with some other device that works with this
+	 * driver, but it itself does not. Detect and handle the bad cable
+	 * here. */
+	ret = get_1284_register(pp, 0, &reg, GFP_KERNEL);
 	dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
+	if (ret < 0)
+		return ret;
 
-	i = usb_find_last_int_in_endpoint(interface, &epd);
-	if (!i) {
+	ret = usb_find_last_int_in_endpoint(interface, &epd);
+	if (!ret) {
 		dev_dbg(&intf->dev, "epaddr %d interval %d\n",
 				epd->bEndpointAddress, epd->bInterval);
 	}
-- 
2.43.0


