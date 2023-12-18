Return-Path: <stable+bounces-7542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0C817301
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3022C2894FE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBC3A1B3;
	Mon, 18 Dec 2023 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyIQK3YN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CC1D15C;
	Mon, 18 Dec 2023 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE02C433C8;
	Mon, 18 Dec 2023 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908749;
	bh=aYBt9QAwbnTOOcAd7EnLjqOA/MAyAXeepcUmBIKh16M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyIQK3YNUctxSIazyefrqXADKtMPwukTwFZhHXUH6FDElA1LtI/9sytV+V3hlOd75
	 4loYiIKRmjd69a3hhBQrvCoqd3dyySgCYI3g/vbGnR+7n2K0jwGuvO6HbFiXRIUqSk
	 03I2l2O5F+bViOpp4KZ4JLpcCV14XOjgfMOP2xwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 02/83] r8152: add USB device driver for config selection
Date: Mon, 18 Dec 2023 14:51:23 +0100
Message-ID: <20231218135049.845730019@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjørn Mork <bjorn@mork.no>

[ Upstream commit ec51fbd1b8a2bca2948dede99c14ec63dc57ff6b ]

Subclassing the generic USB device driver to override the
default configuration selection regardless of matching interface
drivers.

The r815x family devices expose a vendor specific function which
the r8152 interface driver wants to handle.  This is the preferred
device mode. Additionally one or more USB class functions are
usually supported for hosts lacking a vendor specific driver. The
choice is USB configuration based, with one alternate function per
configuration.

Example device with both NCM and ECM alternate cfgs:

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  3
P:  Vendor=0bda ProdID=8156 Rev=31.00
S:  Manufacturer=Realtek
S:  Product=USB 10/100/1G/2.5G LAN
S:  SerialNumber=001000001
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=256mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=00 Driver=r8152
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=128ms
C:  #Ifs= 2 Cfg#= 2 Atr=a0 MxPwr=256mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0d Prot=00 Driver=
E:  Ad=83(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=01 Driver=
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
C:  #Ifs= 2 Cfg#= 3 Atr=a0 MxPwr=256mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=
E:  Ad=83(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

A problem with this is that Linux will prefer class functions over
vendor specific functions. Using the above example, Linux defaults
to cfg #2, running the device in a sub-optimal NCM mode.

Previously we've attempted to work around the problem by
blacklisting the devices in the ECM class driver "cdc_ether", and
matching on the ECM class function in the vendor specific interface
driver. The latter has been used to switch back to the vendor
specific configuration when the driver is probed for a class
function.

This workaround has several issues;
- class driver blacklists is additional maintanence cruft in an
  unrelated driver
- class driver blacklists prevents users from optionally running
  the devices in class mode
- each device needs double match entries in the vendor driver
- the initial probing as a class function slows down device
  discovery

Now these issues have become even worse with the introduction of
firmware supporting both NCM and ECM, where NCM ends up as the
default mode in Linux. To use the same workaround, we now have
to blacklist the devices in to two different class drivers and
add yet another match entry to the vendor specific driver.

This patch implements an alternative workaround strategy -
independent of the interface drivers.  It avoids adding a
blacklist to the cdc_ncm driver and will let us remove the
existing blacklist from the cdc_ether driver.

As an additional bonus, removing the blacklists allow users to
select one of the other device modes if wanted.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 115 ++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 33 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 54779caf18f9b..bcf7492bcf540 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9639,6 +9639,9 @@ static int rtl8152_probe(struct usb_interface *intf,
 	if (version == RTL_VER_UNKNOWN)
 		return -ENODEV;
 
+	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
+		return -ENODEV;
+
 	if (!rtl_vendor_mode(intf))
 		return -ENODEV;
 
@@ -9848,43 +9851,35 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 	}
 }
 
-#define REALTEK_USB_DEVICE(vend, prod)	{ \
-	USB_DEVICE_INTERFACE_CLASS(vend, prod, USB_CLASS_VENDOR_SPEC), \
-}, \
-{ \
-	USB_DEVICE_AND_INTERFACE_INFO(vend, prod, USB_CLASS_COMM, \
-			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE), \
-}
-
 /* table of devices that work with this driver */
 static const struct usb_device_id rtl8152_table[] = {
 	/* Realtek */
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8050),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8053),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8152),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8153),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8155),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8156),
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8050) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8053) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8152) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8153) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8155) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8156) },
 
 	/* Microsoft */
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e),
-	REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3054),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3069),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3082),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x720c),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7214),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x721e),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0xa387),
-	REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041),
-	REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff),
-	REALTEK_USB_DEVICE(VENDOR_ID_TPLINK,  0x0601),
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
+	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
+	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
+	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
+	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{}
 };
 
@@ -9904,7 +9899,61 @@ static struct usb_driver rtl8152_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(rtl8152_driver);
+static int rtl8152_cfgselector_probe(struct usb_device *udev)
+{
+	struct usb_host_config *c;
+	int i, num_configs;
+
+	/* The vendor mode is not always config #1, so to find it out. */
+	c = udev->config;
+	num_configs = udev->descriptor.bNumConfigurations;
+	for (i = 0; i < num_configs; (i++, c++)) {
+		struct usb_interface_descriptor	*desc = NULL;
+
+		if (!c->desc.bNumInterfaces)
+			continue;
+		desc = &c->intf_cache[0]->altsetting->desc;
+		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
+			break;
+	}
+
+	if (i == num_configs)
+		return -ENODEV;
+
+	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
+		dev_err(&udev->dev, "Failed to set configuration %d\n",
+			c->desc.bConfigurationValue);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct usb_device_driver rtl8152_cfgselector_driver = {
+	.name =		MODULENAME "-cfgselector",
+	.probe =	rtl8152_cfgselector_probe,
+	.id_table =	rtl8152_table,
+	.generic_subclass = 1,
+};
+
+static int __init rtl8152_driver_init(void)
+{
+	int ret;
+
+	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
+	if (ret)
+		return ret;
+	return usb_register(&rtl8152_driver);
+}
+
+static void __exit rtl8152_driver_exit(void)
+{
+	usb_deregister(&rtl8152_driver);
+	usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+}
+
+module_init(rtl8152_driver_init);
+module_exit(rtl8152_driver_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.43.0




