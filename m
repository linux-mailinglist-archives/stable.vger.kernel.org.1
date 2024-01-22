Return-Path: <stable+bounces-12743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD748371BF
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95C51F32748
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADF5B5D8;
	Mon, 22 Jan 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zs+Zrwgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4055C1E
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949109; cv=none; b=oZIRyCy+NepRyMT49xM5voO/cShnHJD4YiT+FB+h2erDRPGFLrJDtnXr9wuAOBYRw0UjVnie8cbxfZph4okzEqwGTkq3J0E/0Yh0YtuJRXYjS7TszUKugTXtlKOqHPSYrwKUXu68UG6m/mhtJ/TTUWqxv2kGpGcaTHeDgkMcWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949109; c=relaxed/simple;
	bh=gbbPA79cZ8JJPyMxS14sn7Ih2jJbJ50EcAJ4mEK+980=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s0FZvGu4MMiXjnG0JD9V4iqs54DTaEz1HTrNiLf5cBzdHRxTCNJ8atYoM1peP4kXwsDrnyuYigx6d7l2NfwVJpEamLdwtliekfoUtHdhLtPuULKAIfj++qhEG9qX5RaLAjtQCyluaUeMAVvhu48ESKb8GdzUV43Pocgvc21qkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zs+Zrwgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D156C433C7;
	Mon, 22 Jan 2024 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949109;
	bh=gbbPA79cZ8JJPyMxS14sn7Ih2jJbJ50EcAJ4mEK+980=;
	h=Subject:To:Cc:From:Date:From;
	b=Zs+ZrwgglsPoWf6VSqptz7XbjLf6Bj8Zl0r9M6dFOQmMnv8ZdaQmIKJVU7TxLMdj3
	 xz99Ru/+nkgq3KZWhUi5rbghprt+ZYJC+Jx58ISd2/4vvbS5DZaPWTIBLNcFDW+rbq
	 6tg/IWcAEdCHi1JXhCMRW7mvvphmRAoQ30YG+5xE=
Subject: FAILED: patch "[PATCH] usb: cdns3: fix iso transfer error when mult is not zero" failed to apply to 5.4-stable tree
To: Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:45:05 -0800
Message-ID: <2024012205-reload-daunting-acff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 92f02efa1d86d7dcaef7f38a5fe3396c4e88a93c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012205-reload-daunting-acff@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

92f02efa1d86 ("usb: cdns3: fix iso transfer error when mult is not zero")
2627335a1329 ("usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config")
dbe678f6192f ("usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM")
dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
64b558f597d1 ("usb: cdns3: Change file names for cdns3 driver.")
118b2a3237cf ("usb: cdnsp: Add tracepoints for CDNSP driver")
3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
e93e58d27402 ("usb: cdnsp: Device side header file for CDNSP driver")
0b490046d8d7 ("usb: cdns3: Refactoring names in reusable code")
394c3a144de8 ("usb: cdns3: Moves reusable code to separate module")
f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
db8892bb1bb6 ("usb: cdns3: Add support for DRD CDNSP")
d2a968dddf98 ("Merge tag 'usb-v5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92f02efa1d86d7dcaef7f38a5fe3396c4e88a93c Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 24 Dec 2023 10:38:14 -0500
Subject: [PATCH] usb: cdns3: fix iso transfer error when mult is not zero

ISO basic transfer is
	ITP(SOF) Package_0 Package_1 ... Package_n

CDNS3 DMA start dma transfer from memmory to internal FIFO when get SOF,
controller will transfer data to usb bus from internal FIFO when get IN
token.

According USB spec defination:
	Maximum number of packets = (bMaxBurst + 1) * (Mult + 1)

Internal memory should be the same as (bMaxBurst + 1) * (Mult + 1). DMA
don't fetch data advance when ISO transfer, so only reserve
(bMaxBurst + 1) * (Mult + 1) internal memory for ISO transfer.

Need save Mult and bMaxBurst information and set it into EP_CFG register,
otherwise only 1 package is sent by controller, other package will be
lost.

Cc:  <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231224153816.1664687-3-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 22a31ffa6942..4c6893af22dd 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2065,11 +2065,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
-	u32 max_packet_size = 0;
-	u8 maxburst = 0;
+	u32 max_packet_size = priv_ep->wMaxPacketSize;
+	u8 maxburst = priv_ep->bMaxBurst;
 	u32 ep_cfg = 0;
 	u8 buffering;
-	u8 mult = 0;
 	int ret;
 
 	buffering = priv_dev->ep_buf_size - 1;
@@ -2091,8 +2090,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = priv_dev->ep_iso_burst - 1;
-		buffering = mult + 1;
+		buffering = (priv_ep->bMaxBurst + 1) * (priv_ep->mult + 1) - 1;
 	}
 
 	switch (priv_dev->gadget.speed) {
@@ -2103,17 +2101,8 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		max_packet_size = is_iso_ep ? 1024 : 512;
 		break;
 	case USB_SPEED_SUPER:
-		/* It's limitation that driver assumes in driver. */
-		mult = 0;
-		max_packet_size = 1024;
-		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = priv_dev->ep_iso_burst - 1;
-			buffering = (mult + 1) *
-				    (maxburst + 1);
-
-			if (priv_ep->interval > 1)
-				buffering++;
-		} else {
+		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+			max_packet_size = 1024;
 			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
@@ -2142,7 +2131,6 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	if (priv_dev->dev_ver < DEV_VER_V2)
 		priv_ep->trb_burst_size = 16;
 
-	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
 
@@ -2176,7 +2164,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	}
 
 	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
-		  EP_CFG_MULT(mult) |
+		  EP_CFG_MULT(priv_ep->mult) |			/* must match EP setting */
 		  EP_CFG_BUFFERING(buffering) |
 		  EP_CFG_MAXBURST(maxburst);
 
@@ -2266,6 +2254,13 @@ usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
 	priv_ep->type = usb_endpoint_type(desc);
 	priv_ep->flags |= EP_CLAIMED;
 	priv_ep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
+	priv_ep->wMaxPacketSize =  usb_endpoint_maxp(desc);
+	priv_ep->mult = USB_EP_MAXP_MULT(priv_ep->wMaxPacketSize);
+	priv_ep->wMaxPacketSize &= USB_ENDPOINT_MAXP_MASK;
+	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && comp_desc) {
+		priv_ep->mult =  USB_SS_MULT(comp_desc->bmAttributes) - 1;
+		priv_ep->bMaxBurst = comp_desc->bMaxBurst;
+	}
 
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return &priv_ep->endpoint;
@@ -3049,22 +3044,40 @@ static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
+	int iso = 0;
+	int out = 1;
 	int total;
+	int n;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
 		priv_ep = ep_to_cdns3_ep(ep);
-		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
-			n_in++;
+		if (!(priv_ep->flags & EP_CLAIMED))
+			continue;
+
+		n = (priv_ep->mult + 1) * (priv_ep->bMaxBurst + 1);
+		if (ep->address & USB_DIR_IN) {
+			/*
+			 * ISO transfer: DMA start move data when get ISO, only transfer
+			 * data as min(TD size, iso). No benefit for allocate bigger
+			 * internal memory than 'iso'.
+			 */
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				iso += n;
+			else
+				n_in++;
+		} else {
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				out = max_t(int, out, n);
+		}
 	}
 
 	/* 2KB are reserved for EP0, 1KB for out*/
-	total = 2 + n_in + 1;
+	total = 2 + n_in + out + iso;
 
 	if (total > priv_dev->onchip_buffers)
 		return -ENOMEM;
 
-	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
-			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+	priv_dev->ep_buf_size = (priv_dev->onchip_buffers - 2 - iso) / (n_in + out);
 
 	return 0;
 }
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index fbe4a8e3aa89..086a7bb83897 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -1168,6 +1168,9 @@ struct cdns3_endpoint {
 	u8			dir;
 	u8			num;
 	u8			type;
+	u8			mult;
+	u8			bMaxBurst;
+	u16			wMaxPacketSize;
 	int			interval;
 
 	int			free_trbs;


