Return-Path: <stable+bounces-189979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A6C0DF42
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3BE3A64C7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4F259CBF;
	Mon, 27 Oct 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="pxuC7F6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgC5RXlm"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A479258ED7
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570726; cv=none; b=H40vdexPV+a8uBdQOJqdPhw/NAm4wzzT++KPXC1/SqnJKfq3Ks/Ih8rw9Gtspf3uBarIm6TQAeR1XIgd4MgEz3kIpY4AMSgDCKuhjUuVM4Wld1Q1DJoOKh4LSAp79sxHkWPJkZqLDRB56XpYBswNLimNZbSGBpzXAelN+VEa/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570726; c=relaxed/simple;
	bh=tnepCqvpX8jqBsy8Mvsm8IV+6MnlxKMR5b3Y7rAU8F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DetxnqNytTy/EI890DsqEjYDjQiSE2dkBl6ZHQrRZA0TXhnTJofcMveInANmOwKzUW05TXzg7fXU1xYn7/lJkFuC+K1WTB7b11VuSM8fKx8u7t7gA5qIAgP4vugg5g2DR8eZtFKruqT1/XF8ad5M6OV9PIJuWxZKz/Na4PaqnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=pxuC7F6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mgC5RXlm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D91FEC032E;
	Mon, 27 Oct 2025 09:12:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761570723; x=1761657123; bh=JhVlbX+qB5wtnQirBlu5/
	OS3IdpDcag3iKQf2XS0kks=; b=pxuC7F6YAYLt9T5uuaiqHwYG9h6yD8ac/NSxj
	j8tgigp8GDLuKp1JZc1DpLK4RocUTPlAaHoGab9szle/JTJdHnZS/s3ZQvXftzSR
	NHeXhG8cvkrhL3z4sHFksFa2STZyqpiYVlF8NymkhLVXQ0GxsIb/HpNSO9MFw86a
	p/uLE+sBfMyrtPXoS4Mnjwq9tZBT//Wj6w05lvhEF7ER1BZSfTwTN0paLDu4rq3T
	haxM24LlwYnx49nxWfpIp5JVqSz+mNdVQL8b14MWrchwFYSKfzu/iPsVEBwmvi3i
	ittOo/AL9iKkzvm67o8g7EbwVrxsDTuGGiYwdRUUW0ugAblzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761570723; x=1761657123; bh=J
	hVlbX+qB5wtnQirBlu5/OS3IdpDcag3iKQf2XS0kks=; b=mgC5RXlmbl6TXezXR
	4pEK2lZrNm3Nx2CX5v7Gzg/2cLYwO9OYd6h7ecG5ngBO7PGpGQQ4r6I6BOa5ThHT
	yPWOelkP+f6NTMvLT7+mHJQLz58ZpN8nUVg42nepyZDretZLxSMd3zLBdXdXcVkd
	MF0fxanYpJTT2JitesLQUH6ZstqucF/CUdC7atf2udpI8OrAxs49DCqgPcks1rN5
	MvPEmmRVOG1uUPOnDWwwMMUkzaFnjMPXlJENdIW2fEWZuF3llpfNZ35MAXdWzlO3
	jQDQ+0Z5KNK4LCUyqr8t/fqMFhw4ogidzm0XgJqJFxKe5/jOHyfoGrLVMGBXHsM+
	FDhLw==
X-ME-Sender: <xms:om__aBNLXxlKFUvszmqpKtibcInNbpymWVi_Ur-VvnYxuLQagKlqug>
    <xme:om__aK3vtjVZuACuC1mwku3VK--AEyvizgdhWO82FHrwYAO9Lx7iOg08frtbua8hQ
    hCry7Ie5DA_u6RYj-ENmQU3zaG6mjinDZERiaiM4An6SLWZdR_S6Lg>
X-ME-Received: <xmr:om__aIkNyNY7TLiXFglLeGTlQzEzysO7blK-SA6oz3vDR5Kv1a4U8EXzm_akBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheektdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:om__aJUDRP38Cw971WgQhuHuAecSYlwCujimNyUQ-VMfqGXYba5MWQ>
    <xmx:o2__aGshn6mlFdChg6cmVvOGCnMU8EIKFfEqoJbmbotRxOWtMT61NA>
    <xmx:o2__aEa2Z81Y5cPwwZu_mHiHWZRrDmSdkNc7vCm-gZXKLcoqbdUHvg>
    <xmx:o2__aNXHrLUZyupybC1ygA-oJRf-QNDsHP7iddviHqXkFJljxmQx7Q>
    <xmx:o2__aEGEqge6zjlnWSXKHXTbSBdPivLOUnbvkVt0CrSoatD65-pswdBL>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 09:12:01 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 27 Oct 2025 21:11:57 +0800
Message-ID: <20251027131156.875878-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102041-mounting-pursuit-e9d3@gregkh>
References: <2025102041-mounting-pursuit-e9d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=uwu@coelacanthus.name; h=from:subject; bh=tnepCqvpX8jqBsy8Mvsm8IV+6MnlxKMR5b3Y7rAU8F4=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjP/5c0wPL9166fO3i0+fNDbfzX3MP/eHVHmbtizDw bTbXcxMt453lLIwiHExyIopsuSVsPzkvHS2e2/H9i6YOaxMIEMYuDgFYCIHbjMynHFYfHjduvkT vimayNSJF0pVcGxYdDD3N1fCNT8Bg9kfmBkZvlaoyTN3KHQ5PWrJXeSRV/58y+djhzc/StJ+k1U i6+zGDwCaiEvC
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
index 1a24c1d9dd8f..17ea2be8abee 100644
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


