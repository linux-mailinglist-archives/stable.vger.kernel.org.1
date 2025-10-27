Return-Path: <stable+bounces-189968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95587C0DB48
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC114F7D46
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996523D7C0;
	Mon, 27 Oct 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="YL+8X6dE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/781K4p"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305622DFA4
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569255; cv=none; b=h+9oasV9TJ+xEQf4XAFkmdWzWbOcX4y4ZLoM5qYINkYD24klkOzbPili+C08x1Gk6QEZbNV5k2ar7yugj5Mj/3Yrqnb8C8aOrtxP9lTdNr4uTNU4kQ6JILve/NoXOgpSw/gARQUet6oAhMdaI9Vt4ZBrx8SfsNPWgw62MienJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569255; c=relaxed/simple;
	bh=CNn1GysOcgqV1lK3ic+yV8cGgPp6bk2zgOeZEbSSVdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGVl6wtWgZFfaI7H1OjPPl7dfXGGJ/P3vPyWRifT/lfTCJcjeUdTjbpz21cswZ34H/Y/8OsveBuAaH9xdAeop+8vcyqMGpoX+GQIbaPGXGkeDz0GVcnW7Q49USfnJOo6gjSCVe/bPchyy18Ey8gvZUijDITgWhTVwPKSUacBoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=YL+8X6dE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/781K4p; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C2A5EC0206;
	Mon, 27 Oct 2025 08:47:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 08:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761569253; x=1761655653; bh=duH/MD7ZL5LJ8+nQp/PdW
	5XUFRD0S1BCheAzdeEdr4E=; b=YL+8X6dEYL5j8WlVXhO1TPjnThI+4muI/WAAv
	c/JSS4BGVKnlFVa7tHDzDT6mTHgk6qXSDE5IA5OvcAr+O+xO8BShY+r+KNhuCMgE
	JgcX/h0uL/GC5iTXVO/UPmePcpAtL8kpe7w77L19o3yDSPKFjkY9sQCVGGx+QrV7
	i+9b188RlDaynnNmIlAnvE6qz/CMqjzXDHRUlny3SjC0xjQPQibzxJydNKM5Kfxr
	XjCJPJFYR2vG1SC5s9nC8bYAZB9S+ULRgU2CznfS13EEyX9sN1+q24o2tfxZFNRe
	VymHKPdtJ5SGD1EnZAsQUU9W2UHwym/Z1QVm2c1r70pvmGn/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761569253; x=1761655653; bh=d
	uH/MD7ZL5LJ8+nQp/PdW5XUFRD0S1BCheAzdeEdr4E=; b=w/781K4puxckMttG4
	KjYbdJDAm2/+8fDL6Gv9IHK5EYhSCgpGKBE2b/0nPl9p0RWlWThPBWAhr/feVR0T
	aeJRQvNt+G/zr2+aRz0FGAhRmixX8C6CTDGMVkLTZ0hLS8Upv/h24HhccT2RsaBJ
	NQyrarpj7y/KHQr5rnm2019O9BBxUluToINHQ+0WmqxTqzebv7RQscguX3brLIij
	NkQo+FtU0fTMPtHN66KE009VT2DZdvqgHUjVMUzMHnonMRDlY80oKuQdBjw85b4j
	a5MsvUfX+JldwK0Gkn4mkxLGJcjcZpAFiTYImfj59vC+WrgczzjlDc6ZmIsnRYlL
	lrrwg==
X-ME-Sender: <xms:5Gn_aG0GK77bC-NIMyFZRi9hStSdwgtlG0HroqK2Q182m0Q29yqTWg>
    <xme:5Gn_aP-QwC25vUIpQ3tYaLMFYn4JQphuhTYlRQBDt1Tpdu7YcMoRfbtR1h0S_l0iE
    kEj2FHh2A9zjE3iLLodydx6roR4E2T4XTLYDA2bFQoW7hBMvUqX6Zua>
X-ME-Received: <xmr:5Gn_aHNpae2zGykNScH6dlxcu3HUyF-gbiu4W0fCJjga0sZzH7K5M5pMTESEvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvegvlhgvshht
    vgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeetteeggfevudevffeileehtdeuteekieehvdefjeetffeiueehieejiedu
    heevieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhmshhgihgurdhlihhnkhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhrtghpth
    htoheprhhunhgthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdprhgtphhtthhopehm
    rghilhhhohhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlsehpvghnghhuth
    hrohhnihigrdguvg
X-ME-Proxy: <xmx:5Gn_aDdiRECkcnIQq88IXxWcBCsIHs9R9nr6-v2pKCdsPFMNpw17nw>
    <xmx:5Gn_aGX4JD9IOCdeMQJS93wmWMEY9S15-QSc35onSw-qtPo62xPRwQ>
    <xmx:5Gn_aLjaALHJgHFILspvjVREUBVk_zJcuZsNMKlXX9lt-Jvj0JAgGQ>
    <xmx:5Gn_aF-4t6ni_PfcISglPhNVH-bW9mf6tfCYfns_YC1MHbzOphYTGA>
    <xmx:5Wn_aDcWF0UXFzQeoQ__nupJt2iNw33QllNXXcM3hzO7sTtQIv-48_5N>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:47:31 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 27 Oct 2025 20:47:27 +0800
Message-ID: <20251027124726.734092-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102039-detoxify-trustee-aa22@gregkh>
References: <2025102039-detoxify-trustee-aa22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=uwu@coelacanthus.name; h=from:subject; bh=CNn1GysOcgqV1lK3ic+yV8cGgPp6bk2zgOeZEbSSVdo=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjP+Z97o4NXdLPf5n8WjZZjYh3ku35pglnGW9XbJBe Ymr06zmDb87SlkYxLgYZMUUWfJKWH5yXjrbvbdjexfMHFYmkCEMXJwCMJGCfobfbFzzDsVev6tc 3qre8LTUwOvUbX6bjTe9ZB8qHQor6XqTwfCH51S0bkj1Kc2yH9r/n83yeH6JP06PY7EQx4epr+5 wC+vzAQCmIkqf
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp; fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863
Content-Transfer-Encoding: 8bit

commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream

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
---
 drivers/net/can/usb/gs_usb.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7dc4fb574e45..ffa2a4d92d01 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -157,10 +157,6 @@ struct gs_host_frame {
 #define GS_MAX_TX_URBS 10
 /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
 #define GS_MAX_RX_URBS 30
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 2 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 2
 
 struct gs_tx_context {
 	struct gs_can *dev;
@@ -191,10 +187,11 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 	u8 active_channels;
+	u8 channel_cnt;
+	struct gs_can *canch[];
 };
 
 /* 'allocate' a tx context.
@@ -322,7 +319,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= usbcan->channel_cnt)
 		goto device_detach;
 
 	dev = usbcan->canch[hf->channel];
@@ -410,7 +407,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
  device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
 		}
@@ -993,20 +990,22 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf->icount + 1;
 	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(typeof(dev->channel_cnt))) {
 		dev_err(&intf->dev,
-			"Driver cannot handle more that %d CAN interfaces\n",
-			GS_MAX_INTF);
+			"Driver cannot handle more that %u CAN interfaces\n",
+			type_max(typeof(dev->channel_cnt)));
 		kfree(dconf);
 		return -EINVAL;
 	}
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(struct_size(dev, canch, icount), GFP_KERNEL);
 	if (!dev) {
 		kfree(dconf);
 		return -ENOMEM;
 	}
 
+	dev->channel_cnt = icount;
+
 	init_usb_anchor(&dev->rx_submitted);
 
 	usb_set_intfdata(intf, dev);
@@ -1047,7 +1046,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < dev->channel_cnt; i++)
 		if (dev->canch[i])
 			gs_destroy_candev(dev->canch[i]);
 
-- 
2.51.1


