Return-Path: <stable+bounces-48081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B378FCC20
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2601F214E6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEF1B29BA;
	Wed,  5 Jun 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsxfZCxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477E1B29B3;
	Wed,  5 Jun 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588460; cv=none; b=nZnQC/pw+tKIdxnXMyqKo7IOUcQ0ELVpqifmDQTMWtQN6g1DTfAnnfOm1C+WucNFcPj+9fEQU96JxwROe2ybHIP09XiCpMcJiEQi09hINr7ZxUyXctyQ/JraB8phomuapJdlVo51tEBmuWHb4ymYvv7AaTaMT8Ps7X+SSToxGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588460; c=relaxed/simple;
	bh=keKYWfzN1djD6KLmxuPPa4XdGqVyHQTp9UFTeJAwljs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLe8Y6DsKyAxGzwhnOjYVln5qv5LZGATMb54FQkbjWpoMhRgQndTX2zGladVigGA0nek7txkm/kLlx3pIOOL5rmWqFR+ccNu29gxC0jAFYKrRoWv+WJaL4NrQudQg0IjMr7JZx2CLHAc0k2CjnPZpYzLTsjTFp0epdBvFDLrmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsxfZCxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8214C32786;
	Wed,  5 Jun 2024 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588460;
	bh=keKYWfzN1djD6KLmxuPPa4XdGqVyHQTp9UFTeJAwljs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsxfZCxCYXH+wR+Lu6r6XGhpITj8mjTotbY/9FA1WspKbcPVuUzyUR6dSSr9PEalN
	 JbmwSm30f6wiMgM+0Ow3IFi7daUdK+gLJ2KSDTiEXZGPsijrv0Nf8xkido5hs/GBXD
	 MaKoWHQnESjuaMxUotHUn9x11Cj+0gUR/Ktx3Izfc0NTV5o0jLXgBMJ4OchvpB5zra
	 qasRUa7IdQcpKy9kFtvuHkJduerrgn+5S/FSoiu8ciF03JxhLNYwZFkXf85EC6fPlo
	 MKzbNA8/IcBWoGbsJYIwy/suz78IRC1g+KIXvaqWWhfW6YG6B3AVjcWw9XAaJE+pZ/
	 lyUt8W1cg64zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	sudipm.mukherjee@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] usb: misc: uss720: check for incompatible versions of the Belkin F5U002
Date: Wed,  5 Jun 2024 07:54:00 -0400
Message-ID: <20240605115415.2964165-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
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


