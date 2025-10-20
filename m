Return-Path: <stable+bounces-188043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E68BF1299
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A1C3A8268
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE545311C3A;
	Mon, 20 Oct 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="i1XmFziE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEv+r2uE"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92995304967
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963034; cv=none; b=JvjaeSQ6jcFVPJBr6BWqJ1ahirxFXsedd9T4QMpLcN88vJdLrY0oDwuYDyypJkmrpdvEhlKcMYP47vsBFUsttec9OPUorBlxiBinggLVB+2MALTMGYsCdRI9uBQ9QXWp/a6EaJgiecn0N76nRuQoHeQoG7lMy7i08bYYjOZO4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963034; c=relaxed/simple;
	bh=vYUJ+xGeX8WoNFkyg5K6nyrI2bZw1/G526oTuJhvBH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dfo6+/I9lvLPAYTAFjl4rXNy6jehRttc9VseL47OBCP9prnrEkKdImKWk+N48Cnh84Xl1OKsk30DQHpo5oE/W4kJ9BYgE7cry2iFKUKNk6i6V5lZXRAsQvkgDqe0X/PTr5OOCEeLv/hdo1xCba1Wcqrr9RJNQBVtFULTQqrcmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=i1XmFziE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEv+r2uE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A44B1D00026;
	Mon, 20 Oct 2025 08:23:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 20 Oct 2025 08:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1760963031; x=1761049431; bh=cfl/FhP8lg3ZCS9xRETNw
	jvbpvfF7q2LsEUJfyLeMBY=; b=i1XmFziEMOSI1246b719jnSnf9JqIyqzI0Lbt
	O7cH9+3y+q4CWbqsCSE7GSNKu6L6EqsvtdQxnCwMGS0NmWmTQmxL3HPl+cy2gvW1
	CZuRORFQK3aTqkndrnZF/AqbMB2ak6tsdXkZujKYbavdLM8uobiKHta6+UFafvdE
	PjlbM+fC9wi3g4WyAn0gYa8eWEUoYx/JSSxoiU6K1flo4HLFKMpT0leuKHQXFZWJ
	xiQ7qHRJTIY81oEO64I8GnEs8J/hWUmx5AiRZK2Bnye/D/78nSgdmoa9qdTJbQKD
	NQd4dVgXnjfdpIiod3uEbRYwjMLGQ3P8AVpDqK4PrGdpqYQag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760963031; x=1761049431; bh=c
	fl/FhP8lg3ZCS9xRETNwjvbpvfF7q2LsEUJfyLeMBY=; b=ZEv+r2uEVixC0ovMu
	LNhKXRsbqXNbnl8xY/xC8QUnRslZ4qA/MD9sS5Q6KEc3jkSrHG/+UhzcP00ck279
	0MOGIQmwgbIPul9tvZB8GGFy2rQWcG6SFGKNjmDlzNZEZxLOn4fZZZ9J+8ByfRZn
	7UqaEllwbfvn5lnb/ObP/ZxOTxEnRh95qdaJJaxPZPVsnvMD3m+vrOFvKKmpYE07
	16oFTa7+b4f+sBLbfMtrY7CdoSVvDqIfDw7e8RpNFVx9pYXko7IIRSlJ13L/kdnS
	8viNGMM/su00GY6/Lk2gtSylDtpkYphPGC0SQ3SAa0LnYq3X7N6qkrBciSixjvYy
	Phrqw==
X-ME-Sender: <xms:1yn2aOWdbCCUZn7qqvQxhXRrAcesGOyPJGl1XamtCb_sFWcX6EmK2Q>
    <xme:1yn2aBffY6TcTOunJfazgb3CRIjY3-x3b0L4GmL5ddxJmu2zT1Tm-0LcTySnDCYO7
    bTTr8zEw7d_o8DkmxIx-hZM2Dhk1eHJ8j_aWYYKwF6_9b_75zvnmTk>
X-ME-Received: <xmr:1yn2aKs5O_cxVxwHlwnVrBzQK755YBbCd8-kMrkrXLvD651BfEIdk_6Auqb41Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1yn2aA9aTHMlu4s4qjgHhWJh8F588NNnkXpyWwglpIF5R0Hqgmgnwg>
    <xmx:1yn2aF2PVe1JaTNxj_ntPP7dRaKbwC2Oz9HJl6NJMhKribsZqZw9kA>
    <xmx:1yn2aFDy879PUXACoRwN452789T3VGYRWoe_ZHTfEGetjxXVmjEiQw>
    <xmx:1yn2aBdUi_7KLDeDScusv2XEMJ4D5XdKTzV4fJJQHCO-5vyoQSUNJw>
    <xmx:1yn2aMtwDHcMuhJkOJampxiK5Hqow_irVbNmYnbQ9DZPANt8ldl-yu5A>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 08:23:50 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 20 Oct 2025 20:23:43 +0800
Message-ID: <20251020122342.1517889-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <2025102040-unusual-concur-90e9@gregkh>
References: <2025102040-unusual-concur-90e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797; i=uwu@coelacanthus.name; h=from:subject; bh=vYUJ+xGeX8WoNFkyg5K6nyrI2bZw1/G526oTuJhvBH8=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjG+a5+NC5+TMjIpVl/T7mGZ2Lct0t2XtIUGuoHbNy JN9U07ac3WUsjCIcTHIiimy5JWw/OS8dLZ7b8f2Lpg5rEwgQxi4OAXgIryMDEs3HYvtslr9KkJm y0qpBYF/2V4d3vmTRW/RlLhcy+hXiRYM/3MlFGzfKWv0zVysmnb9ypq0kle/Nxjwz7ypef9rxc1 6CU4Ay3RIBQ==
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
index 864db200f45e..f39bd429f77d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -156,10 +156,6 @@ struct gs_host_frame {
 #define GS_MAX_TX_URBS 10
 /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
 #define GS_MAX_RX_URBS 30
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 2 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 2
 
 struct gs_tx_context {
 	struct gs_can *dev;
@@ -190,10 +186,11 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 	u8 active_channels;
+	u8 channel_cnt;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -321,7 +318,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= usbcan->channel_cnt)
 		goto device_detach;
 
 	dev = usbcan->canch[hf->channel];
@@ -409,7 +406,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
  device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < usbcan->channel_cnt; rc++) {
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
 		}
@@ -991,20 +988,22 @@ static int gs_usb_probe(struct usb_interface *intf,
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
@@ -1045,7 +1044,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < dev->channel_cnt; i++)
 		if (dev->canch[i])
 			gs_destroy_candev(dev->canch[i]);
 
-- 
2.51.1.dirty


