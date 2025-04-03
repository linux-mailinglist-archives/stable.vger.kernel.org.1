Return-Path: <stable+bounces-127614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C0A7A6C8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D32177D8B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A7250C1B;
	Thu,  3 Apr 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXO40nat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABD250BF7;
	Thu,  3 Apr 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693873; cv=none; b=iNiRV95/hhnJZ9S3dwkNu/+cT6L+6baSJqQcOrihoATcGQBljPU7m5balELK8/uZHA/FD37kSjzXZEJ51rY9B4NkUV9X3BLadXLpxT0L7liG4HGRaoRAYR0xQN8u5qtCmg9qtx5z58FO7jPVbeRoTRuiID4tje0izq1qkxOJsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693873; c=relaxed/simple;
	bh=0xD8fX456dBDnVZfYF4bVzaLYz5/PVyQTp6Lu4Tf7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzPdFonqBF7XErUrHptJQ5YcARHahTGIhXFvDZuBSHAlA08/fF/4S8so1UJYl4fEBxzu1zUOXZbVSEfLcJHwK5p7mWb1P6WDq8vMSey+sB0ARY8B7pHf9iuzzeXvfPDiep+MBGV395H47kgH9W0ee2D+BA0uA83JcDZieZpF8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXO40nat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A27C4CEE3;
	Thu,  3 Apr 2025 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693872;
	bh=0xD8fX456dBDnVZfYF4bVzaLYz5/PVyQTp6Lu4Tf7rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wXO40natq4lhCBWyViuWiSR9dJgrllUZjMI80uYO1uPQkgeBY1myrsGoHTcsYJULY
	 geywP9Ofd4BH2MoGhqbPfzPZ6e4FnuBOZ5ELY6gb/pv1q0LOssZWcsyuQe/MrlE3vG
	 6FddnmZ0cM5fwd5S53C2j6UIrc1aCAMmmYbqVlOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ahmed Naseef <naseefkm@gmail.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Oliver Neukum <oneukum@suse.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 15/22] net: usb: usbnet: restore usb%d name exception for local mac addresses
Date: Thu,  3 Apr 2025 16:20:25 +0100
Message-ID: <20250403151622.476842049@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
References: <20250403151622.055059925@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

commit 2ea396448f26d0d7d66224cb56500a6789c7ed07 upstream.

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
that local addresses always came from the kernel, but some devices hand
out local mac addresses so we ended up with point-to-point devices with
a mac set by the driver, renaming to eth%d when they used to be named
usb%d.

Userspace should not rely on device name, but for the sake of stability
restore the local mac address check portion of the naming exception:
point to point devices which either have no mac set by the driver or
have a local mac handed out by the driver will keep the usb%d name.

(some USB LTE modems are known to hand out a stable mac from the locally
administered range; that mac appears to be random (different for
mulitple devices) and can be reset with device-specific commands, so
while such devices would benefit from getting a OUI reserved, we have
to deal with these and might as well preserve the existing behavior
to avoid breaking fragile openwrt configurations and such on upgrade.)

Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
Cc: stable@vger.kernel.org
Tested-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/usbnet.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbn
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1773,11 @@ usbnet_probe (struct usb_interface *udev
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)



