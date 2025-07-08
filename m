Return-Path: <stable+bounces-160951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236CAFD2B6
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B769586D5C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B92E54B2;
	Tue,  8 Jul 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+KzoLgw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5F2045B5;
	Tue,  8 Jul 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993167; cv=none; b=LAePnmeqdedpaotQbVKuSQYoMeSofdV/KxBlmUJlD7ymsj0ZxMz9SirH44mO10itMLu+DB174riJZgIeC6XcIO4zRW5UBUL4MF7jtUPoTzDfbXltTUzrTkHHeoDvkOKo99xpWUzc1zqc3Bdtrq1/lAkzZFZK54nv1WMRRWjRjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993167; c=relaxed/simple;
	bh=h19ytu2aCJHZPHqjWvnaXrpn4zXLLm1GccvkP9j+mkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlmcagtH745QDWr52VXAjtskfisuxZkEFSxvu4Azybdpc6CRbL9XuOn3/+Tpwi+9S/ygod1r5bPFfl6ca7tobVhTbClNfImf5tNdY2S3n/w367KS/gnTeBfEwKLu/lKkEmkxBMaUUNsRzv3OW6I/vtl4wOzXdzXCDdfTB9PblHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+KzoLgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C384C4CEED;
	Tue,  8 Jul 2025 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993166;
	bh=h19ytu2aCJHZPHqjWvnaXrpn4zXLLm1GccvkP9j+mkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+KzoLgwgMOZjP6qzssK5dsWfN9l6yfDUOYpnw8v69x6OKcrXdOgxs667E7O1gehM
	 dbr9I3mWwq7fmJVHBZWNHYjGoiJxH1HW4sxtoQq29t0kzHNFC4aM1230Mj2FQZzRTo
	 KERDSf7XG8NTdw515rp/VBzI3cPQO20o+WgzzymU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.12 211/232] usb: acpi: fix device link removal
Date: Tue,  8 Jul 2025 18:23:27 +0200
Message-ID: <20250708162246.962402747@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 3b18405763c1ebb1efc15feef5563c9cdb2cc3a7 upstream.

The device link to the USB4 host interface has to be removed
manually since it's no longer auto removed.

Fixes: 623dae3e7084 ("usb: acpi: fix boot hang due to early incorrect 'tunneled' USB3 device links")
Cc: stable <stable@kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/r/20250611111415.2707865-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c      |    3 +++
 drivers/usb/core/usb-acpi.c |    4 +++-
 include/linux/usb.h         |    2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2336,6 +2336,9 @@ void usb_disconnect(struct usb_device **
 	usb_remove_ep_devs(&udev->ep0);
 	usb_unlock_device(udev);
 
+	if (udev->usb4_link)
+		device_link_del(udev->usb4_link);
+
 	/* Unregister the device.  The device driver is responsible
 	 * for de-configuring the device and invoking the remove-device
 	 * notifier chain (used by usbfs and possibly others).
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(usb_acpi_set_power_sta
  */
 static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 {
-	const struct device_link *link;
+	struct device_link *link;
 	struct usb_port *port_dev;
 	struct usb_hub *hub;
 
@@ -188,6 +188,8 @@ static int usb_acpi_add_usb4_devlink(str
 	dev_dbg(&port_dev->dev, "Created device link from %s to %s\n",
 		dev_name(&port_dev->child->dev), dev_name(nhi_fwnode->dev));
 
+	udev->usb4_link = link;
+
 	return 0;
 }
 
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -612,6 +612,7 @@ struct usb3_lpm_parameters {
  *	FIXME -- complete doc
  * @authenticated: Crypto authentication passed
  * @tunnel_mode: Connection native or tunneled over USB4
+ * @usb4_link: device link to the USB4 host interface
  * @lpm_capable: device supports LPM
  * @lpm_devinit_allow: Allow USB3 device initiated LPM, exit latency is in range
  * @usb2_hw_lpm_capable: device can perform USB2 hardware LPM
@@ -722,6 +723,7 @@ struct usb_device {
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
 	enum usb_link_tunnel_mode tunnel_mode;
+	struct device_link *usb4_link;
 
 	int slot_id;
 	struct usb2_lpm_parameters l1_params;



