Return-Path: <stable+bounces-188690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7723BF8933
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F608404FE3
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B135265CDD;
	Tue, 21 Oct 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guQlKu5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC10350A0D;
	Tue, 21 Oct 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077208; cv=none; b=dwjhez/K3HBKfgJHx6GEwcxW+ntTOAHzjUGGpN4vyp+7wwI0gH08GT5CM5kw+tEfnoOgZw1SmSzER5nRnytFr9ayKdgRsQWggEejbklZtqRlhDTjD7IgK7nFBWHLwhKnsZDF3HfE9miB1UstBGZYKcPLWoUxYhv/MXALZbu04tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077208; c=relaxed/simple;
	bh=RZN3jkHreAjNjR71eVkk/lc29vP/vPnMwu6lgxE/SYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEdQPeipoO0uoOTPXpHYKQKXDGV4C5PqE9nLBFWFFrdQe+0IoNQjYHYuwMp3Ypeoi+XIFLElYdQG/wpXwf/zU9u1V6faT1fbnzhv0J2TrUQZwGVV8VK+zHX5L4A5T36VBaULBRiCnhv1WrHsq0fZUof98apTH6qhDW5J2EetPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guQlKu5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A706C4CEF1;
	Tue, 21 Oct 2025 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761077208;
	bh=RZN3jkHreAjNjR71eVkk/lc29vP/vPnMwu6lgxE/SYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guQlKu5UJx8d5NGs02MWIhLANipjw7x2uC7QIcC/s/SuEJNqsf5PSBQaqJA6zduFJ
	 A9GB19xBlHtj0EbW1BSNghOWbDDZXCtbcmfauZDpenHWCo2+xyX0s5k0+PQ2VVQ+sg
	 Uio1dD/bANMVzi/6O78EJUsfC/RyL9j/ciM+yfBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Celeste Liu <uwu@coelacanthus.name>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.17 032/159] can: gs_usb: increase max interface to U8_MAX
Date: Tue, 21 Oct 2025 21:50:09 +0200
Message-ID: <20251021195043.970154893@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Celeste Liu <uwu@coelacanthus.name>

commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream.

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 interfaces
device to test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel index type in gs_host_frame is u8,
just make canch[] become a flexible array with a u8 index, so it
naturally constraint by U8_MAX and avoid statically allocate 256
pointer for every gs_usb device.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -289,11 +289,6 @@ struct gs_host_frame {
 #define GS_MAX_RX_URBS 30
 #define GS_NAPI_WEIGHT 32
 
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
-
 struct gs_tx_context {
 	struct gs_can *dev;
 	unsigned int echo_id;
@@ -324,7 +319,6 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 
@@ -336,9 +330,11 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -699,7 +695,7 @@ resubmit_urb:
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1461,17 +1457,19 @@ static int gs_usb_probe(struct usb_inter
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
 
-	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
 	if (!parent)
 		return -ENOMEM;
 
+	parent->channel_cnt = icount;
+
 	init_usb_anchor(&parent->rx_submitted);
 
 	usb_set_intfdata(intf, parent);
@@ -1532,7 +1530,7 @@ static void gs_usb_disconnect(struct usb
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 



