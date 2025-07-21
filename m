Return-Path: <stable+bounces-163588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3CB0C588
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD96D1AA3106
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E422D97B6;
	Mon, 21 Jul 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMesimr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CF2BE04F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105894; cv=none; b=KX9Rpz2wy/IrT0nJ/BwllRRYLTXfBxQzUGUDPz78Bm+jXjiZR5iYyHDlhDYbkac2I9BdGPs2tWvd44+nUtLmArkvinprNnVbinjl4NwIehD/QxFb09ZZuvpgX4H1IH4LmNbdbOHnrdJGlPWWzpa4+pvygVHoQ9gpKLkhBy20KNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105894; c=relaxed/simple;
	bh=azq5D/XbCgaWhNuJtTjQJ6lLBte+xEA+lvnD9tCvwcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1edVceW5yJ45rMPtQ16ad+6R1yim+SutxGNY/UmyTniQbednC9agPlVZAJvTmNbUnPNfP4gEtVF8kf6YrYL78Ouo9goeYfqg02lAbTDLSd+R+FLNRFYiTIhslhw6nse/8LNdou2qwrtlSK5a4ASlhzikDLey77X01LI3kN/evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMesimr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54DCC4CEF4;
	Mon, 21 Jul 2025 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105893;
	bh=azq5D/XbCgaWhNuJtTjQJ6lLBte+xEA+lvnD9tCvwcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMesimr8VvtbnQRoGq8nN5BYc40L9ZVUz3M9vBkYjyDkdF0TVngk9xeWgiNGcyOqf
	 P59/EvzG923bqWQV/Fne79Y0dqCXg97kzVeVSmBcgKgrT6G2d/GbDwyyM/wXBkMZJf
	 a/znwPXmAIU4ItBta8+0+skvaAHDovPdLs9XqlZFoKWecIRgJmNJer6VpdVcso08zO
	 UYZmNT60vewQHnoTwRk5Nuoj6rrd53ctqUh+nJDOySUXDr9+5ixNuIuFPWlu0uYkth
	 vDWDplTYTr7OBXUpzjZJbUFFsCOuJlZnrSKm3E97Cw4V2CGRxLPA1TcMaQh8Ojc1DW
	 J9oFnB4qSHykQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Drew Hamilton <drew.hamilton@zetier.com>,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: musb: fix gadget state on disconnect
Date: Mon, 21 Jul 2025 09:51:27 -0400
Message-Id: <20250721135127.840100-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721135127.840100-1-sashal@kernel.org>
References: <2025072132-slum-strum-0148@gregkh>
 <20250721135127.840100-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Hamilton <drew.hamilton@zetier.com>

[ Upstream commit 67a59f82196c8c4f50c83329f0577acfb1349b50 ]

When unplugging the USB cable or disconnecting a gadget in usb peripheral mode with
echo "" > /sys/kernel/config/usb_gadget/<your_gadget>/UDC,
/sys/class/udc/musb-hdrc.0/state does not change from USB_STATE_CONFIGURED.

Testing on dwc2/3 shows they both update the state to USB_STATE_NOTATTACHED.

Add calls to usb_gadget_set_state in musb_g_disconnect and musb_gadget_stop
to fix both cases.

Fixes: 49401f4169c0 ("usb: gadget: introduce gadget state tracking")
Cc: stable@vger.kernel.org
Co-authored-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Drew Hamilton <drew.hamilton@zetier.com>
Link: https://lore.kernel.org/r/20250701154126.8543-1-drew.hamilton@zetier.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 78b12b034cd6f..b941a45124359 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1909,6 +1909,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	schedule_delayed_work(&musb->irq_work, 0);
@@ -2017,6 +2018,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.39.5


