Return-Path: <stable+bounces-188046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B789BF12F7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F453E4079
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542E2F6573;
	Mon, 20 Oct 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="s8SxGfA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7F/7USS"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6930FC35
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963189; cv=none; b=KaEJ8clLfQWm6d9PCIV4uIcKWTUFc1NQgEzu04hbja5zWzRroYiMFzC5tKh7FXYmIDXA3lRRKkXVOD/cahSFvo+w+Ob2TCVT/+pmX3EC8L7smq2p4ynU1YZO2fotjV5kT9k9Ij1CoaCD1GUEuZD+/8k/oS4tRG8SaSxZZC6C/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963189; c=relaxed/simple;
	bh=4aK1YOWKpWPou/s67grAY+Rt0f89zfIVMNSYmwlCDr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0N8U2M6AQQNQnjzrjWbhFApXX/DnciJ0LPF7vw7XX43OMwVXxyVUlZkJ4mxrjtPnsXsf5fFQooDVc/SJ3LlZSZFjAFPIQUet5M1umJPMagCo4Rl5w0ndrHRzGBQagzaiChxd8/u6cfduBllTNvrS0n3sBuy3rWhDgYwU2IhC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=s8SxGfA1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7F/7USS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 05DB01D00028;
	Mon, 20 Oct 2025 08:26:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1760963182; x=1761049582; bh=icqRWrpCgId7sSL9KtZ7u
	un8+R7a0Uv/cLLpYhjJ8eo=; b=s8SxGfA1h25VXRZWRtU5qGGXpAeMAdqa1MJz+
	9nNWFsO1/qMtBRrxCOdriK6FmMcZi7iPOaw6v8LfGGtWNnRsz59jaonP6KLuty9v
	5EoqwK6w5YpUddb/jhxf2jqbvH2UPeEK+yu4HzBSA1H2w1aFMQcpiHD+2if1aW63
	pAoe4/t+fvowKDR/v0BUOtkWjhiiCQa9LNfInkd/gpJ94TdisSu5Drnm93RcaNzY
	Rq3buWbdU6+/cBBa+8wZoKe4SqHabGVL80yVi0/sDDarQjsOq+qwEu4tOxcAN45J
	+k1FLccN4Nlqr5NxTbY09ValBLdTvZFMse3C7kF8rFNJlUEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760963182; x=1761049582; bh=i
	cqRWrpCgId7sSL9KtZ7uun8+R7a0Uv/cLLpYhjJ8eo=; b=a7F/7USSGZ7vmmTiP
	rmHuxce+K5/2QXXAsqIgF+dg5fR3f2kEbWTxzfVnnCyhKzSBC/j2UpwipHYmxHND
	3lhsbz3CgluUc6a4yJdz7pn3a60GN2b7BnPe7Mjy92h1wVbJXO46PUGyUJeA3+7I
	nysu5IiSldtWV2kX3g5RuTB6FEpfBAzpcfTwKclbd6W9L8l7CxeiuwZNEeZETQIt
	Bpe9BAVr5aS4PdeOqf79b+ooCGV0rTOxEeFj36W5H/Fl8eWBK9S4VU8fL444at7W
	PnJH+aeiXTG6A8lCc7nnAZT1dLQ73VoVdYBbMxf+n6FU9aFnIaZcejfrtIDLyrzk
	fYL2Q==
X-ME-Sender: <xms:bir2aEZrG0m_cVJ_kgSPSjxU9D5ECAzBOKAV7mOYIp8LXQ60dLfXng>
    <xme:bir2aGR3wnbMDPycxafoxSsQ63QkTEeSeKUDV65OhTFOWTHktS0ROHBSLXWvT_83W
    Te5XBBaIYSAz4EVtqd85nHkQiy27AtEyZsas70XolJTRv9h1Zlhn6c>
X-ME-Received: <xmr:bir2aHRAU7PwNTtjXx-bF_YaBXgd2JnLU-bCGUsFBTqNITQrlDxXG1_tAA45bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejkedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bir2aKTT667tTDYLuTvgADHIz-x6Qb7BY9uWyB2PFsaoVvQlbuJZXQ>
    <xmx:bir2aM4x1OI5CScOomtgvjVWnjU0H_B1PSt52lzumsbMOzUoEGbzmA>
    <xmx:bir2aG2i_MpE71oYi51XiQPHxedm_dj46fqNrDM4ia-qzyTvujzzDw>
    <xmx:bir2aHBeNAAj_sXhwhOr9vG5j08AEHWTW_tVnOUEHwHyttv31hLCbw>
    <xmx:bir2aCiHioUL4k83wYaKB9ic4FXzX6KpUOoooTNv8paCJtdVqgn4x090>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 08:26:21 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 20 Oct 2025 20:26:17 +0800
Message-ID: <20251020122616.1518745-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <2025102038-outsource-awhile-6150@gregkh>
References: <2025102038-outsource-awhile-6150@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; i=uwu@coelacanthus.name; h=from:subject; bh=4aK1YOWKpWPou/s67grAY+Rt0f89zfIVMNSYmwlCDr8=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjG9aGX/CMgsCLCSm/St8YL/oIedXJvs0kb5gG6Y+s fVhe+N8lnWUsjCIcTHIiimy5JWw/OS8dLZ7b8f2Lpg5rEwgQxi4OAVgIgLbGf6Z/78iKLn32fqv 93a//F6+f3XQuricB/OD7Y7fXS58/OnjToZ/OofY7iyLMVb68fHHVv91O+q7RN1rbtxfWDs50/H esYfVrAAmP08I
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
 drivers/net/can/usb/gs_usb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec28d504ca66..df89bfb8ef3c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -277,10 +277,6 @@ struct gs_host_frame {
 #define GS_MAX_TX_URBS 10
 /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
 #define GS_MAX_RX_URBS 30
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
 
 struct gs_tx_context {
 	struct gs_can *dev;
@@ -318,14 +314,15 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -550,7 +547,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -653,7 +650,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1374,17 +1371,19 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(typeof(parent->channel_cnt))) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(typeof(parent->channel_cnt)));
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
@@ -1445,7 +1444,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 
-- 
2.51.1.dirty


