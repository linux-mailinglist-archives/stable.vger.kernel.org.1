Return-Path: <stable+bounces-189964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2AC0DA35
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851223B20F2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8C3019DC;
	Mon, 27 Oct 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="f/9/f01D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1WQZpmM1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89100301471
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568452; cv=none; b=HOgdJ3NUWiX6HkR69CzHp3VE4FB6CIBecPUh9ZIE2/wNDMm/2x2I2grbosA0XodC5dyaLLFSGSVZdOfnhNE8CJu4lf5CSJHUoBhCQH7gXcNsm74M55GkbsWG+5iQV8LZ3nWll0N/c90s84sCE4521DUfnu/GSX59u0qhqv8jkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568452; c=relaxed/simple;
	bh=Rl//pb9dmc4OdFNQWppAH6emDZg3xyb64YSeNrqUP9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k22zd2kQ8plCSb7q+n915rSciNLMoYfRenaPP3gUELkZ161lHaFWbV+QvJyu2NvRrSTSKeF1BIe5HGEPN8LuG0gLQ3cQ0qD0SX7rrhZqTGhTJjyot5xVv/GXhHTdsFAkJQm4LA1UHBLIiZTSRBxfH2CWYYbhZtu3fmeXp5inY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=f/9/f01D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1WQZpmM1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 985D1140031B;
	Mon, 27 Oct 2025 08:34:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 08:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761568448; x=1761654848; bh=s7br+LFw5VZqFQIeh2fSh
	apV68SL298l5ZikG02J+bM=; b=f/9/f01Dqwb1+/JmQVCGo+wGv69OOwi0QETsa
	pGkin+XCgA8ZQEUmxcaYdsnPbBEC4nzLztqshZ0uRJ4vePdF6u2pNpng418M6CRt
	0jknOi/mxRrKF3DtwB316do68E1A5HL/0x78DGhKY/PaFsXFKdKgW83FjIl9v21s
	GLLROajshMEI9qFCMBf/joEleowWkXy244K85IbYKF5tJQrM25DJxBtnLXAxurVw
	pGEsPZOdyATzfJmUxceUk29sLZA3fLHFojA1NEi/tHm0x31tOQP81jn8lBqMqYDO
	pSbVGEudggHSsoAPh18fARXgya3EP5UGKpy/nQQ39rGe1pnTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761568448; x=1761654848; bh=s
	7br+LFw5VZqFQIeh2fShapV68SL298l5ZikG02J+bM=; b=1WQZpmM1C0Q4OETJg
	mW2bbxNIox46TuwEbXFgKIemUj7wyrbUYMutQThqtPpcTbn/48WMR7IOxFLVoiY7
	qjN1So1HZ4xnrTnv04zF4nWmEu7VBKohu36eM7QCWVG14Ll66dBKtGjck8HY2cyd
	xPriGlr3V+d5OkVUi1Ke2eSPq2PZBKxExg2K6aQ5OzmMIKwSlGE3YaKtzH3cj6G9
	wibjm/QGmCJwFAMT607bk4wMGYhVT5NAz1j8oUTIgPJ+XNNIlELKhBk3J10NCQUQ
	58guzGqr7E5gIeV2arJqNZkSs7YlI0EQ8iCTX06BXKphKnowu45xMbittjF4AuNr
	ySNxQ==
X-ME-Sender: <xms:v2b_aPI8rKYogOcMHJ_bpHcXdtEC00B4d3M1TBzqXYZDyMslwQkCyg>
    <xme:v2b_aKBFXNwUOigi-xbT0vAlNvkCVnzpXm0g6Fv7FrinXhef_zUcG73pBWGbjEZFe
    ecD6YntNJmsMh3nHK-R1NjZ_LBH-NHcUHtEd7S_eb4BCPVoZAz8XYM>
X-ME-Received: <xmr:v2b_aAD4aUxuZwxv3h73g_FGxCfjImhW2p9qKbvJ13cJG0W8nKuaRzhvvLOX7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:v2b_aEDCj-NxQgJ0A1PaGyjvoA7aLws4eSqsIohXPzCIJpNn3DlZqw>
    <xmx:v2b_aDry0NQoBx1faYtOTjY35Op4hUlljCDY-vF46GaNPA9ee80oVw>
    <xmx:v2b_aGmYC_R1BYpW-tG0oweUUo2yNZtNDYial8zZQbanqf6vNpHaSA>
    <xmx:v2b_aLyC4zj7Jvvh8Ya9KNvPAZIxR6aMca9Q-Ap6fl0Rde8jVwkVmA>
    <xmx:wGb_aCRQLs8lAKyCfA1F30q2LMPIeASTtdg1MVH29DuU89-KDPvbYdOZ>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:34:06 -0400 (EDT)
From: Celeste Liu <uwu@coelacanthus.name>
To: stable@vger.kernel.org
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y] can: gs_usb: increase max interface to U8_MAX
Date: Mon, 27 Oct 2025 20:32:31 +0800
Message-ID: <20251027123230.661960-2-uwu@coelacanthus.name>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102038-outsource-awhile-6150@gregkh>
References: <2025102038-outsource-awhile-6150@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=uwu@coelacanthus.name; h=from:subject; bh=Rl//pb9dmc4OdFNQWppAH6emDZg3xyb64YSeNrqUP9s=; b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGjP9pcbdOiFjFMa2aJfM155X23sWyTi3THmnIGOfLM riuVp30/FVHKQuDGBeDrJgiS14Jy0/OS2e793Zs74KZw8oEMoSBi1MAJiL3nJFhh6oi/0SWQ/PO yV6RNWlrWFe0e4Vft2u3Ymi907wHKyc/YmSYGy314EqK/Qz/1E1LtszQS2E89LrGV+rCZYfbyQs qp0jxAAAInEcU
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
index ec28d504ca66..2cacea6b00f8 100644
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
+	struct gs_can *canch[];
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
2.51.1


