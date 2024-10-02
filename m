Return-Path: <stable+bounces-79231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032E98D738
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FE21C2238E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5761D0436;
	Wed,  2 Oct 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFnhGjxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AB1D0412;
	Wed,  2 Oct 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876834; cv=none; b=AgP0RnTvBOZirFw7mWV22pFBQB3xGiz1qdH5T/5UjHhqUVQ5mMG/ozXgioxbUyXTFJNjEbflYA7xXxSS1gndr3AyZ5ftnBbanrLg1DvoKbIGKeAORyFK1tJwSD6QKDtLMi78/VMmCgazJ0iVEEGjR7nDdUs0R/SCAft9EJLiPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876834; c=relaxed/simple;
	bh=E4/bkMvEKNn+CEYFUxOGm6amHXI1MBEzR2t+8P/eFsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBc6S5JfrMfZ3hZVvdnhaYsgwoi3Go75Jw/I8pUvBvyqgEjx590TopfYXUOu9/n+01WH7qIzsSQrUrkqanuSR2q09ezPmP62qd5n+vHpN5DUWYoxcU4icLJrRNTlS7zHTDM2Dn6tR6mGj99tt3oAJ3CEHJpNrrYkMT9dMiVIh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFnhGjxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC457C4CEC2;
	Wed,  2 Oct 2024 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876834;
	bh=E4/bkMvEKNn+CEYFUxOGm6amHXI1MBEzR2t+8P/eFsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFnhGjxF3vCbqXrpFEwi30yuq/F17CTNFoq/PTSbwsxbCIMABEU9g1nbgQEinzDWd
	 +055x4R1j0xFVL1kvH65h79TA2boN4o4Rq3nv7f2XNdTnqT1Q0N52Wm+wmZQ2y6BGB
	 l/nMlDLC0wj9qyMlIUCdXNZHylDv7TCA5ql5lFwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.11 576/695] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
Date: Wed,  2 Oct 2024 14:59:34 +0200
Message-ID: <20241002125845.504565968@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Mätje <stefan.maetje@esd.eu>

commit 75b3189540578f96b4996e4849b6649998f49455 upstream.

Remove the CAN_CTRLMODE_3_SAMPLES announcement for CAN-USB/3-FD devices
because these devices don't support it.

The hardware has a Microchip SAM E70 microcontroller that uses a Bosch
MCAN IP core as CAN FD controller. But this MCAN core doesn't support
triple sampling.

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20240904222740.2985864-2-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/esd_usb.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2023 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -1116,9 +1116,6 @@ static int esd_usb_3_set_bittiming(struc
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= ESD_USB_3_BAUDRATE_FLAG_LOM;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= ESD_USB_3_BAUDRATE_FLAG_TRS;
-
 	baud_x->nom.brp = cpu_to_le16(nom_bt->brp & (nom_btc->brp_max - 1));
 	baud_x->nom.sjw = cpu_to_le16(nom_bt->sjw & (nom_btc->sjw_max - 1));
 	baud_x->nom.tseg1 = cpu_to_le16((nom_bt->prop_seg + nom_bt->phase_seg1)
@@ -1219,7 +1216,6 @@ static int esd_usb_probe_one_net(struct
 	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
 	case ESD_USB_CANUSB3_PRODUCT_ID:
 		priv->can.clock.freq = ESD_USB_3_CAN_CLOCK;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		priv->can.bittiming_const = &esd_usb_3_nom_bittiming_const;
 		priv->can.data_bittiming_const = &esd_usb_3_data_bittiming_const;



