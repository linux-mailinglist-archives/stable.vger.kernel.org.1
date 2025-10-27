Return-Path: <stable+bounces-189975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C9C0DD44
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6016419A58D5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B62459D7;
	Mon, 27 Oct 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="wPxwM/Nd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0x7se5w6"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBCE335C7
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569927; cv=none; b=ZrIZ1boBzjtTKm4CgrsrrafMJmDVGOzatNiS4zhmPSHt6wzEdYfDw5YP0khY3d+pWA5j4u0d8XJN3uRZEa3NY+aYUolDKNSYPCqDsq0o0hViC4ZeIbDHL0tEVKMRiod4Dzn4WvdB8yT3FM7abpUnV/XaJgLbTvpCGmJqINWuo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569927; c=relaxed/simple;
	bh=1wn96zodtrUyUfYcryHxIDYocgit5ZO4W+YZDQ60gmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg7Xh2ZsPtlxuF9ey3wOd0aaz1v6sfOyeSRsSM6JSwPjcnhs/uw6br0wRx3z0X2AJT4Sq6sTcCmSeC/LdOfzKZrrOjLnGsvKn1jTV8Q7/VQWXKMkApXVhZeY3aZwucdZPjBeMGF2LxS2PSZwrBFcxyTO7BXUnvlaiOSS20aqVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=wPxwM/Nd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0x7se5w6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 880B9EC0274;
	Mon, 27 Oct 2025 08:58:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 08:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761569924; x=1761656324; bh=8ceJxg0l6EKKNNHTkTCy7
	m5P5noTq51DP1CnYhAWyAw=; b=wPxwM/NdHckmx1j/D8b/Q17juSRv6MKAmWCer
	7tjhc3xos/+YUKOmmkGLIJOjg0vT9Xhc4EvvugYwTn798gjSvq9krGs8wZ+Lz8w8
	arj2FBJhg9vXDZXiOuETCHy0vfuAE51jNoqaA5cFuFgNgNEnvZ1YnwsNzkXk/jr7
	X62HmXfzQv4ekbhPFhVeCDGcTT5lqljQxZAFa6RdztsbDU5cwFgdQtjp35peP8+k
	0RqE7BR7dwwAFHuqwH8qFnaDUVpmKWy8zkj/jMqumm2R7fD2PuPXkAk3D7455Jbe
	4WKpO6LTl8aeWU3NbUCl7lDjtxx2me5j8Ivh6Q/RwqtONVgxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761569924; x=1761656324; bh=8
	ceJxg0l6EKKNNHTkTCy7m5P5noTq51DP1CnYhAWyAw=; b=0x7se5w6K3gBNkVpa
	E8Badt08QHTh0OIlA3AmxOmYvN11nMLAd3uQo9VRS14cIwTXacS3OnGSFs2ht0w5
	Ezgx6+enjVFpRRPFwwRvRsPe9viuZEBsOCF1dfEhYLG58xNRb2BHhpl2jcftSPsK
	ptcwOFSfj56JFU/ffivK7zWxG3wS3ULBVnqkIm7oEYT+lO0fwhxVk9IllUiG1f/e
	9c/r69vTW1tl4zNF6Bb2R8SqU8WlJ5xdxP6pRVhk4J3vmQjpMOiZvC7J8vbrSQGo
	P9V5iDVLDFK1/bEvJLLc+PfUDqkc+tLM4GI0ENnMIkCaOSVMst0Pft3TtUzl6Wux
	C8AmQ==
X-ME-Sender: <xms:hGz_aKCUxCuKr3fg2CEwOGzv1Nahrf-ZgqjR4EvracliiPYAIFmPPA>
    <xme:hGz_aLbu5x4YGYgmae6LcX2sTAK7kyTH4b0c3w_4O79ucMu532btZesUq-DQiE0sE
    W0BLFuTz69MxYLpDTaewBohEzRupstFLtPRRxfQ1V8p7i0ySXvo4Ss->
X-ME-Received: <xmr:hGz_aF66EhDLtbD6vXjw5wxoaGTjwnuU4OZWth1jJbE5O7bVv_jVYKQw10wNmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hGz_aEb4soNIo9MuY1w_v7d9_peYH0aiTnX3Lrhh3r7vtUJWx8WYFA>
    <xmx:hGz_aMhW4KcMrr9mfYXPHCWhShSdif8qYCFeZ6boUfhGJ349UjgoiQ>
    <xmx:hGz_aN_82HyJAEPh8qyil3hMDw8DHcCjPh-wJRCbh8b1O7XY-UOkcA>
    <xmx:hGz_aPpMYfHQmFgN1gZBnlulFXsPod0o6FEB9pUZ_YEckC1-dogEcA>
    <xmx:hGz_aBqkw_7vit7LPlbqqKx9cVeAk0EiieD91Ig02cCMaCOR3ZxQskeM>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:58:43 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 27 Oct 2025 20:58:36 +0800
Message-ID: <20251027125835.799467-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102040-unusual-concur-90e9@gregkh>
References: <2025102040-unusual-concur-90e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=uwu@coelacanthus.name; h=from:subject; bh=1wn96zodtrUyUfYcryHxIDYocgit5ZO4W+YZDQ60gmQ=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjP851VLT0lvOpbMln/68oVd9fqJvaFlX/eS4lojda 8xjv/BcutRRysIgxsUgK6bIklfC8pPz0tnuvR3bu2DmsDKBDGHg4hSAibgGMfxPmxDOdqanfXtD imjrwlzjgn63v3bJFdt/n+psnWkfPX0FI0PHUa/UjSe3OjqWa1t9u79t8VUN7Tl3WYWfO/C6Nlc wCDECAEwtSOc=
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
index 864db200f45e..58a7ac1d7c7f 100644
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
+	struct gs_can *canch[];
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
2.51.1


