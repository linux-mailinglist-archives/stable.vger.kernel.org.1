Return-Path: <stable+bounces-188044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E684BF12CC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FF83AEE41
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600333126AD;
	Mon, 20 Oct 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="wuI+Sltx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+0KG7rh"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36242FD7B2
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963146; cv=none; b=qkuDMsIJgWyoopOuOY6wqvHHDLPYty3lYncutlTqbU0kMzjjVTbc3WUoJK9jQbA2EKzYcI3hCdrKd224O+/iHVaxf4gOV1KHr6SGK/C9F7axICFepyecc9ub+bzd27Xuj8h5rOJ86wl8CWBTAIZA8BsJ/U2QCbaL0ie+AuXeLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963146; c=relaxed/simple;
	bh=Nu7Gs/CwDtCZIt/xiKl+hDBm2H9N19Wurl9kZRgbdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+j2ITScEuF+Nxgry9MWxw266yx3O4VL6IcHbQbLSgZElTdPkqxIfBIdOEEtOmmpSWJxV92ebZkIHt+dPvLt5Hodr08EM/kF9pUkQbUNsIPS/mxMkFpy7Wh49qCsdhtespvTGp35gT+DMl7rru7cqgRrUHM/h8S//HAiyKOGvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=wuI+Sltx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+0KG7rh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 613781D000DC;
	Mon, 20 Oct 2025 08:25:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 08:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1760963138; x=1761049538; bh=VW40ojzBg5EEbNKXl+//H
	Ge3cPHgdj2jDGzut4Ncr4Q=; b=wuI+SltxJufoUl6tPxzhBCVWxqT9j5LdQOitA
	cV4g1CsXh81P5eKZo7xilInTFB7SxMZVrI8uRd8dH2GDURszTCudZBRlyD4984Bu
	6BzlSFYu5kEajKecHwdqWCT+9uNU720bDfmGN9Kw3xC2EpbvEXuJ/K/MZzU24i5S
	ToFIjoVOa83KNwgUFBUSCoc5Vrn6KEJtE+8TBQIh69Y+HT6uU8JtEbxYZ8QAvITc
	VIYyZQZbgU5G53UAthLmH9lIwc9SXJUMxe6eM6dHB7xFnNN4lLk6+Hq+OS5U01zK
	2RJ/ilHPGxBn8DGXhlouZisFfEkfs/2yuG0YRlNwdtcIoyOHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760963138; x=1761049538; bh=V
	W40ojzBg5EEbNKXl+//HGe3cPHgdj2jDGzut4Ncr4Q=; b=s+0KG7rh2D8ijOnpu
	aeWhMmmTcuUiFPO/787A1MR6czzKBt97BicdH8WN9labFNgXEQ40ieRHKKFZpYkq
	igCLH7+6dj2/n8oyNYAKZleNlMX3oyZjWeUaqDYEzbjqYUzuMb8dSN/YsGvyMCRd
	YH7nQY+3dErVLKHLXQY5lcpONillWy6FRgiRaRBA8Fqy14jU07OPlwQu7YSMk2DU
	Aw9m+9QNJDZgNfj57tqK9F1l6OOCQnixQu4D5Btr8jSGnaa9phs3JUzupf7r1lIu
	ENVPaeYPF9gIhXxiX0CPiYpTnV5DV3l6o2KTpDWSpstbGEBl83HvY/rM7FzUP4yd
	LJbpA==
X-ME-Sender: <xms:Qir2aD6sSjufFLdtBH_ErB5bnTKFli3jIEA5CKqDfIXBYU90XwBItw>
    <xme:Qir2aPzw3_3GzYOI7nsHOF1R6XNvJRuQipvfJ0jCMvEt9lvq1Rn3TEUGfSw4VyqLR
    Z6i7_QIZ_Y96x1VUGvwtR2uE1glAqFf-i_cXuWLivAHzWahRQlEbA>
X-ME-Received: <xmr:Qir2aCyWPp69aBToldE49VhNGgUr3MIQADAz143DNn1ApDD9ZhaUHf5I-ynxJA>
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
X-ME-Proxy: <xmx:Qir2aPyiwrm0lZXxWsmasJzeUPEk6MVUrYe-RI3_jy3rQYlYB1LahQ>
    <xmx:Qir2aEaKs_P61x6nvnSIZd-afjvEPpV1U2xYJZosRWlm_MU1q5dKcw>
    <xmx:Qir2aIUdMUKIxz-rN2LngsglgfQFaQ0ILCbfh3NiJgM0eYl6ilr4WA>
    <xmx:Qir2aKhXRDJZahB-C7mXG-gTXd2Uw3VUZvhHSFUsl7P3Nkw3pvONdA>
    <xmx:Qir2aEDQ5sIqlPPAGZlXMQJ2ghgyuUMGG1DJNXtRTJs3XKdN2WmUkQAv>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 08:25:37 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 20 Oct 2025 20:25:30 +0800
Message-ID: <20251020122529.1518396-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <2025102039-detoxify-trustee-aa22@gregkh>
References: <2025102039-detoxify-trustee-aa22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797; i=uwu@coelacanthus.name; h=from:subject; bh=Nu7Gs/CwDtCZIt/xiKl+hDBm2H9N19Wurl9kZRgbdes=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjG9alktfbBe+q/Nv8yzxh5y/GZ4pVv/YJfv3W/mrh Rmdpnad4rc7SlkYxLgYZMUUWfJKWH5yXjrbvbdjexfMHFYmkCEMXJwCMJFNkQx/OLr/9Od6bdsy e9uKlZq3JZb2cv/JapLVyO37Yh9pt9LBi+GvoOBvNq2Ly0u/1T6OKjJr2RsqLSDfrhK90vnyvPU duQH8APp1Sl8=
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
index 7dc4fb574e45..33800bb75064 100644
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
+	struct gs_can *canch[] __counted_by(channel_cnt);
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
2.51.1.dirty


