Return-Path: <stable+bounces-8646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D365E81F797
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3481F227FB
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B56FBB;
	Thu, 28 Dec 2023 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDJRI0go"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE956FC3
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 11:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE4BC433C7;
	Thu, 28 Dec 2023 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703761623;
	bh=2zMBm3dGmji9eKHxqibs6JrbgkFm30JtYh4Kf+i/2e0=;
	h=Subject:To:Cc:From:Date:From;
	b=lDJRI0goyWPaa5Run8MNQoqiNUMehcHRZ06PsGt8WA2u8yBSSof+V/5YQ8bpdg8gT
	 nQvnIRwXGYneTA9TEIU8PfO71KcjNJcSsLFgxfGF6UwF67sGtnWMbDgVBXwQvzsiV8
	 mGgoSVtU7R4501ICBIsPff5GbkC/VuJtOlsgUQ4g=
Subject: FAILED: patch "[PATCH] net: usb: ax88179_178a: avoid failed operations when device" failed to apply to 4.19-stable tree
To: jtornosm@redhat.com,gregkh@linuxfoundation.org,stable@vger.kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 11:06:56 +0000
Message-ID: <2023122855-periscope-hamlet-2e77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x aef05e349bfd81c95adb4489639413fadbb74a83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122855-periscope-hamlet-2e77@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

aef05e349bfd ("net: usb: ax88179_178a: avoid failed operations when device is disconnected")
5050531610a6 ("net: usb: ax88179_178a: wol optimizations")
843f92052da7 ("net: usb: ax88179_178a: clean up pm calls")
766607570bec ("ethernet: constify references to netdev->dev_addr in drivers")
7b3c8e27d67e ("bnxt_en: Move bnxt_approve_mac().")
bd78980be1a6 ("net: usb: ax88179_178a: initialize local variables before use")
de6e0b198239 ("net: ethernet: actions: Add Actions Semi Owl Ethernet MAC driver")
4dca650991e4 ("net/mlx5: Enable QP number request when creating IPoIB underlay QP")
8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
40f05e5b0d0e ("net: atlantic: proper rss_ctrl1 (54c0) initialization")
43c670c8e48a ("net: atlantic: A2 ingress / egress hw configuration")
e54dcf4bba3e ("net: atlantic: basic A2 init/deinit hw_ops")
ec7629e0c221 ("net: atlantic: HW bindings for basic A2 init/deinit hw_ops")
3417368494db ("net: atlantic: add A2 RPF hw_ops")
57fe8fd2255c ("net: atlantic: HW bindings for A2 RFP")
b3f0c79cba20 ("net: atlantic: A2 hw_ops skeleton")
5cfd54d7dc18 ("net: atlantic: minimal A2 fw_ops")
258ff0cf61d6 ("net: atlantic: minimal A2 HW bindings required for fw_ops")
f67619611b4c ("net: atlantic: A2 driver-firmware interface")
c6168161f693 ("net/mlx5: Add support for release all pages event")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aef05e349bfd81c95adb4489639413fadbb74a83 Mon Sep 17 00:00:00 2001
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Thu, 7 Dec 2023 18:50:07 +0100
Subject: [PATCH] net: usb: ax88179_178a: avoid failed operations when device
 is disconnected

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

cc:  <stable@vger.kernel.org>
Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231207175007.263907-1-jtornosm@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..5a1bf42ce156 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -173,6 +173,7 @@ struct ax88179_data {
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
+	u8 disconnecting;
 };
 
 struct ax88179_int_data {
@@ -208,6 +209,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -219,7 +221,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
 		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -231,6 +233,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -242,7 +245,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely((ret < 0) && !(ret == -ENODEV && ax179_data->disconnecting)))
 		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -492,6 +495,20 @@ static int ax88179_resume(struct usb_interface *intf)
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
+	ax179_data->disconnecting = 1;
+
+	usbnet_disconnect(intf);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1906,7 +1923,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
-	.disconnect =	usbnet_disconnect,
+	.disconnect =	ax88179_disconnect,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };


