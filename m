Return-Path: <stable+bounces-4917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5107E8086E1
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83191F22760
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F5381D7;
	Thu,  7 Dec 2023 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWaTtJ+E"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E29D53
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 03:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701949345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHxTURiY+BajALQ6jlUVzV1suGGc/R1HBwIs10ym2wE=;
	b=PWaTtJ+EXObP72DIUsZlxzdtghgetEFpWL3J80MropjgWDFXnd/tEHls4VBPhGDAMKviH5
	zvrPPLn9QLowqnCb16ZVzRvzlYRpOGaMQb7HUu+wU5visl8FmJShNTHG3RCN6mLJOFcZXg
	kglp77EQ++7JlylmcL12i/xa3rrOFlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-hiY-S404OzuPt_BL-Qw82w-1; Thu, 07 Dec 2023 06:42:21 -0500
X-MC-Unique: hiY-S404OzuPt_BL-Qw82w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5F8E8030C4;
	Thu,  7 Dec 2023 11:42:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 365F38CD0;
	Thu,  7 Dec 2023 11:42:18 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: stern@rowland.harvard.edu
Cc: davem@davemloft.net,
	edumazet@google.com,
	greg@kroah.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v5] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date: Thu,  7 Dec 2023 12:42:09 +0100
Message-ID: <20231207114209.14595-1-jtornosm@redhat.com>
In-Reply-To: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
References: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

When the device is disconnected we get the following messages showing
failed operations:
Nov 28 20:22:11 localhost kernel: usb 2-3: USB disconnect, device number 2
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: unregister 'ax88179_178a' usb-0000:02:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to read reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to write reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0001: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19

The reason is that although the device is detached, normal stop and
unbind operations are commanded from the driver. These operations are
not necessary in this situation, so avoid these logs when the device is
detached if the result of the operation is -ENODEV and if the new flag
informing about the disconnecting status is enabled.

cc: stable@vger.kernel.org
Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Follow the suggestions from Alan Stern and Oliver Neukum to check the
result of the operations (-ENODEV) and not the internal state of the USB 
layer (USB_STATE_NOTATTACHED).
V2 -> V3
- Add cc: stable line in the signed-off-by area.
V3 -> V4
- Follow the suggestions from Oliver Neukum to use only one flag when
disconnecting and include barriers to avoid memory ordering issues.
V4 -> V5
- Fix my misundestanding and follow the suggestion from Alan Stern to 
syncronize and not order the flag.

 drivers/net/usb/ax88179_178a.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..e07614799f75 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -173,6 +173,8 @@ struct ax88179_data {
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
+	u8 disconnecting;
+	struct mutex lock;
 };
 
 struct ax88179_int_data {
@@ -208,6 +210,8 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u8 disconnecting;
 
 	BUG_ON(!dev);
 
@@ -219,9 +223,14 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
-		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
-			    index, ret);
+	if (unlikely(ret < 0)) {
+		mutex_lock(&ax179_data->lock);
+		disconnecting = ax179_data->disconnecting;
+		mutex_unlock(&ax179_data->lock);
+		if (!(ret == -ENODEV && disconnecting))
+			netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
+				    index, ret);
+	}
 
 	return ret;
 }
@@ -231,6 +240,8 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	u8 disconnecting;
 
 	BUG_ON(!dev);
 
@@ -242,9 +253,14 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
-		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
-			    index, ret);
+	if (unlikely(ret < 0)) {
+		mutex_lock(&ax179_data->lock);
+		disconnecting = ax179_data->disconnecting;
+		mutex_unlock(&ax179_data->lock);
+		if (!(ret == -ENODEV && disconnecting))
+			netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
+				    index, ret);
+	}
 
 	return ret;
 }
@@ -492,6 +508,22 @@ static int ax88179_resume(struct usb_interface *intf)
 	return usbnet_resume(intf);
 }
 
+static void ax88179_disconnect(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+
+	if (!dev)
+		return;
+
+	ax179_data = dev->driver_priv;
+	mutex_lock(&ax179_data->lock);
+	ax179_data->disconnecting = 1;
+	mutex_unlock(&ax179_data->lock);
+
+	usbnet_disconnect(intf);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1274,6 +1306,7 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
 	if (!ax179_data)
 		return -ENOMEM;
+	mutex_init(&ax179_data->lock);
 
 	dev->driver_priv = ax179_data;
 
@@ -1906,7 +1939,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
-	.disconnect =	usbnet_disconnect,
+	.disconnect =	ax88179_disconnect,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
-- 
2.43.0


