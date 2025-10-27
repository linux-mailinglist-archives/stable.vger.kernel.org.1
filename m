Return-Path: <stable+bounces-189972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B007C0DC46
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB519C0F54
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95982472A4;
	Mon, 27 Oct 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="rr2bOtEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lw4OxB1d"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D931FB1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569747; cv=none; b=AMf/LTh9dpu1q0cD4v327Hexq4LInt94PFZFTBhkjc8DwRhBkoH+4C/t+FSd9LYmOvP7Jx+jtxSTQ9kvgny1tq8/xCz7EIWy4D4v5VLw+BFAGQA4FnxpEfenDdHQLbETDBae2isDQ92Gfr6ZXyBmxq3cPRbMwaimxVsLhpV1vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569747; c=relaxed/simple;
	bh=bL/uWU2hpSVBwdMhFUODbVsAyoNHFnenx527gJhPC4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3+Ccp11SSngbfSUg/gDmLEzZEoZlnqva8Jm4DV4kXailby2XIG1NEgduKvn043i6dS6j1dhYNuB2sj7716SLZeaOkmvoGuw9zdq19aci6jKc1R+f0Fed7546iWOYHgCRU5EZEh4Kffb4YA42N9x67c1KzvNTF6KqtQb20cA3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=rr2bOtEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lw4OxB1d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ED915EC033E;
	Mon, 27 Oct 2025 08:55:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 08:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761569744; x=1761656144; bh=CUqG7V4AuOmflYjcaWOa8
	dXL54tFD4TTcFw4SmuzwqQ=; b=rr2bOtEAlIohAsx2URmLDdOVqrGAQJYlswhwg
	16/tqaD6z5ocWP9Dbpe8y9rc5DVCE1BEj2u1LgS7NfdV2QE7SGWm5BqSaV8lBagZ
	JSdrXmauwsTgiCyDLIy20RXVRD44IZOcQggLpMz3Mpf/9SMuHVNDsQNazaHgv7ar
	ZyALIWNIpVEHZYGcoTGObtKh9dUttY95/JTuxTUZTUbWM6lwbMaOXwKQoL/LOH9O
	R4zoHKKNcJqrTYaN5qbhurpOEsBsb2sEWlROV5G+X9WzItNZmBCGsvJqWBvcG7K0
	wXqDy0rBZiwsdIE73jlG8Q77hWw/lyrnaYfP+vWynXRqLWMPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761569744; x=1761656144; bh=C
	UqG7V4AuOmflYjcaWOa8dXL54tFD4TTcFw4SmuzwqQ=; b=lw4OxB1d5PAzfTMvQ
	bUSS8F8fI6pV0o7u+JYC0P/riao2y4Z/ABTvsxRo88S/5hb3AqjvJAFH3oFvRyJY
	67SUN2WWJxza4+EZI/SlbyN0nuaf2Wq+D6ZH3wzPiPJOFha4btXzm6E0Cva+RhEH
	qB1dvDPU4O0hfiflvbpngqYZwIBQrvRh1VY7siv1UmArI5vI53+iEPMIQc2DNZrr
	LzRmZngoZ7nfIUM9OYF3VR8SgKQdu5q+ZrCAg/Oyrh+UQ3idXJhAwrQbXjMxemJy
	hUCGoalX3LgFJdDpDPfzuvuYCkd66GOb8sHBEZ6iTj73VfzALKUKCVCWWQl6lFBW
	9wbQg==
X-ME-Sender: <xms:0Gv_aLq_Z9Um7GaMCuWdamyY8uWnvK3CKpROTCpxWQ9PANUsvOCnIw>
    <xme:0Gv_aBJR-MG0hKZQ61etlw8of7ghGSNafm66_citQDiuwFNVs9ZDxo13v8G5hcMKH
    vo0OjeVKe7v30rs_TCAmTeOLS-mhYLYxY7xv89y13MM3ongpTrGmRc>
X-ME-Received: <xmr:0Gv_aOrayY0UdpKhlftZvAPm9PH331qM7bDmnF4sMEqwmKuzV20XMuqDG5h0Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0Gv_aJwubqo4PMGibO5V9c4QbmL9asrs3W4ZGBb5wwvdj2DyOJvc7w>
    <xmx:0Gv_aCNaltJfAPB2MitTs2y7lWHOCSV8wagiMEnNUXOTIkbjFy9O_g>
    <xmx:0Gv_aO4afYdWPG_st492P_zrsG_yQ9DJKYL30lX3Kp_v_hT9lAT71Q>
    <xmx:0Gv_aLmMT0UQNeaxpUXe_CQTXSgk6Un3evoPgeSYhoNQqKFXiWCEAw>
    <xmx:0Gv_aIahjFCBCXZcJMxQ9Jinf2HlFASAj1oTjswnqBRPiWVLnRmHIqsu>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:55:43 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 27 Oct 2025 20:55:39 +0800
Message-ID: <20251027125538.798464-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102040-unusual-concur-90e9@gregkh>
References: <2025102040-unusual-concur-90e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3791; i=uwu@coelacanthus.name; h=from:subject; bh=bL/uWU2hpSVBwdMhFUODbVsAyoNHFnenx527gJhPC4o=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjP/ZpwL/fcm0UbrM9KXR/AbrvSfzvZXzIsM9Xsjti ykQUvnzQKGjlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAEzG4xchwml3dSbR2/QmP /A38O5OkWP17zu5RDr9m/O6cS+CPi8kVDP/0vddGz/7Gf9puDV9bWli1yJVvx8M3mEp/vK0dzbd f+BQ7AAU1SOc=
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
2.51.1


