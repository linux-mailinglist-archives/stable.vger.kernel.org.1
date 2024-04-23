Return-Path: <stable+bounces-41010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB38AF9FB
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A75287A28
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D485148300;
	Tue, 23 Apr 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGa6Y1jV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC111482F6;
	Tue, 23 Apr 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908616; cv=none; b=pGYnmXhm9P+R0j2X2oFuCah5p6kaMuWNuG0S1+MhmIlKTI01mTBtSrF/LbEYwnpc1VJHVLSsONWo8Q0fb064qGRP+osZNn7IyZbJT/Wy0XwgNRJhaod5dOiZXMuC0G/B3p+qqw1F7vZvBUoio7IowNl0vNHPgPjXWY/HwVKghQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908616; c=relaxed/simple;
	bh=63XjUU5+spzbdBY4FaTCf4RM+xvyLkx4ufTRwZ3Y1Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJWUGHQepVjupkKFGjMCVxQzUNonoYOKhxo2GiPKT/7hS271bLggYcRPAHKEVW7j0RiadvBVYnDF9uYPIaoOIHqz9Lwb43Gyo347lnychieaHkSidYgkXNAyrhrC95/AaSBXDmqI2iEBabxgu7+D1zF0C0ObiUCdQMUKRxtv0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGa6Y1jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29DBC116B1;
	Tue, 23 Apr 2024 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908615;
	bh=63XjUU5+spzbdBY4FaTCf4RM+xvyLkx4ufTRwZ3Y1Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGa6Y1jVv+nZBJqK/fuVunx+m7/zlr1zT2Ms8szFwO/J1oMIBObkjuc9Vx/ToKweB
	 Jt5eyRDN1tvXFXaKYrRcJ2BE2MP1pDi2HajXqmv/j9WxrCpKIV4f8YspD945uUnTJ0
	 DGW3hQPwYLg5Yj5jT4ql9rTznPsQOL0H6QORowbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 088/158] usb: new quirk to reduce the SET_ADDRESS request timeout
Date: Tue, 23 Apr 2024 14:38:45 -0700
Message-ID: <20240423213858.611915960@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit 5a1ccf0c72cf917ff3ccc131d1bb8d19338ffe52 ]

This patch introduces a new USB quirk,
USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT, which modifies the timeout value
for the SET_ADDRESS request. The standard timeout for USB request/command
is 5000 ms, as recommended in the USB 3.2 specification (section 9.2.6.1).

However, certain scenarios, such as connecting devices through an APTIV
hub, can lead to timeout errors when the device enumerates as full speed
initially and later switches to high speed during chirp negotiation.

In such cases, USB analyzer logs reveal that the bus suspends for
5 seconds due to incorrect chirp parsing and resumes only after two
consecutive timeout errors trigger a hub driver reset.

Packet(54) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
_______| Time Stamp(28 . 105 910 682)
_______|_____________________________________________________________Ch0
Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
_______| Time Stamp(28 . 106 910 632)
_______|_____________________________________________________________Ch0
Packet(56) Dir(?) Full Speed J(399.650 us) Idle(222.582 us)
_______| Time Stamp(28 . 107 910 600)
_______|_____________________________________________________________Ch0
Packet(57) Dir Chirp J( 23.955 ms) Idle(115.169 ms)
_______| Time Stamp(28 . 108 532 832)
_______|_____________________________________________________________Ch0
Packet(58) Dir(?) Full Speed J (Suspend)( 5.347 sec) Idle(  5.366 us)
_______| Time Stamp(28 . 247 657 600)
_______|_____________________________________________________________Ch0

This 5-second delay in device enumeration is undesirable, particularly
in automotive applications where quick enumeration is crucial
(ideally within 3 seconds).

The newly introduced quirks provide the flexibility to align with a
3-second time limit, as required in specific contexts like automotive
applications.

By reducing the SET_ADDRESS request timeout to 500 ms, the
system can respond more swiftly to errors, initiate rapid recovery, and
ensure efficient device enumeration. This change is vital for scenarios
where rapid smartphone enumeration and screen projection are essential.

To use the quirk, please write "vendor_id:product_id:p" to
/sys/bus/usb/drivers/hub/module/parameter/quirks

For example,
echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameters/quirks"

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231027152029.104363-2-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/usb/core/hub.c                          | 15 +++++++++++++--
 drivers/usb/core/quirks.c                       |  7 +++++++
 include/linux/usb/quirks.h                      |  3 +++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4cd15aee16c20..66dfc348043d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6853,6 +6853,9 @@
 					pause after every control message);
 				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
 					delay after resetting its port);
+				p = USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT
+					(Reduce timeout of the SET_ADDRESS
+					request from 5000 ms to 500 ms);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 73ab30e0da774..7417972202b8b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -60,6 +60,12 @@
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 #define USB_REDUCE_FRAME_INTR_BINTERVAL	9
 
+/*
+ * The SET_ADDRESS request timeout will be 500 ms when
+ * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT quirk flag is set.
+ */
+#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT	500  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -4663,7 +4669,12 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
+	unsigned int timeout_ms = USB_CTRL_SET_TIMEOUT;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	if (hub->hdev->quirks & USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT)
+		timeout_ms = USB_SHORT_SET_ADDRESS_REQ_TIMEOUT;
 
 	/*
 	 * The host controller will choose the device address,
@@ -4676,11 +4687,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev, USB_CTRL_SET_TIMEOUT);
+		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
-				NULL, 0, USB_CTRL_SET_TIMEOUT);
+				NULL, 0, timeout_ms);
 	if (retval == 0) {
 		update_devnum(udev, devnum);
 		/* Device now using proper address. */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d2..b4783574b8e66 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -527,6 +530,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* APTIV AUTOMOTIVE HUB */
+	{ USB_DEVICE(0x2c48, 0x0132), .driver_info =
+			USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index eeb7c2157c72f..59409c1fc3dee 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -72,4 +72,7 @@
 /* device has endpoints that should be ignored */
 #define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
+/* short SET_ADDRESS request timeout */
+#define USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT	BIT(16)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.43.0




