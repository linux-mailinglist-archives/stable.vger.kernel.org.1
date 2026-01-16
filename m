Return-Path: <stable+bounces-210098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498ACD38602
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C819B307F609
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F343A4AAA;
	Fri, 16 Jan 2026 19:36:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5E3A1E6D
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592161; cv=none; b=lBXWhzO7K2QouET3ttN34MgppVtM4sjj6gCmJv4b2gQW50H0OrtaCwDRhxRbADdPxCPWkuznS6mVcfyBtnncWNomgMRcptczk25Gz3bjx4Ok55TuqYwb/FukOffXYpKzClYc4NpjmjNeixtAdSmlU3yE6wCFV/WaTbXCpK6Me9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592161; c=relaxed/simple;
	bh=qXFHomxH6ThdcsyxaPXbrxn3x7sls0MHEmxaTfhx8Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5yWwWf03IFPx5IL8ovXAOXvnvzEmUf1qLf0nrO4TEVa6M4GjFK0jTGjFqibMI5U4XXr96X4/D2iw/3Z0zjnHEPpwd0uNHn517Z8xC5cQNwYXajXXmuBZEjo338x0ZsJvwm9BdsHkZNsf+MvVkKfsOfNWCfaWe1cMgNmnWqTXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbi-000804-HJ; Fri, 16 Jan 2026 20:35:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbg-000yK8-1X;
	Fri, 16 Jan 2026 20:35:39 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 82DB54CEEE2;
	Fri, 16 Jan 2026 19:35:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 16 Jan 2026 20:35:17 +0100
Subject: [PATCH can v2 4/5] can: mcba_usb: mcba_usb_read_bulk_callback():
 fix URB memory leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-can_usb-fix-memory-leak-v2-4-4b8cb2915571@pengutronix.de>
References: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
In-Reply-To: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Sebastian Haas <haas@ems-wuensche.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
 Olivier Sobrie <olivier@sobrie.be>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=qXFHomxH6ThdcsyxaPXbrxn3x7sls0MHEmxaTfhx8Qg=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpapMHCftZMBpsm3ESnrHH0MdA0TlDQ10hv5vs/
 ElSzJ5jvE6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWqTBwAKCRAMdGXf+ZCR
 nMCxB/0RdQkP6n9H89T6X8F1MT5cpnIgin4Pkrqum/PeTcHw+cu03O8YnDBiKeJNqR9IGF0yyDT
 i4YP+5ekic9dNcfqOdlpGYuvGvbcZaGl3PjUhkFFPViJbvE0rj8bp2Lyt7PIaNIgPJPA5a4mGXf
 pVKpgGQQ8F2knWY0SywzhQA5b3BvGszQT4vjUg4uoOZ0030FS8KHCfXdOP52EGV68HOTZcYGW2z
 sE2HqlkzNQ0636GKuM2lQC/SaDM7c8B+y/5/73IZUOoshkntN0LiRH0+JyRZ9+lHQoSe64N52RI
 uBbuYAvP3/c6w3e4u8ZYJ2porzp3dZm8YyqMzrsth16vPrrP
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In mcba_usb_probe() -> mcba_usb_start(), the URBs for USB-in transfers are
allocated, added to the priv->rx_submitted anchor and submitted. In the
complete callback mcba_usb_read_bulk_callback(), the URBs are processed and
resubmitted. In mcba_usb_close() -> mcba_urb_unlink() the URBs are freed by
calling usb_kill_anchored_urbs(&priv->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in usb_kill_anchored_urbs().

Fix the memory leak by anchoring the URB in the
mcba_usb_read_bulk_callback()to the priv->rx_submitted anchor.

Fixes: 51f3baad7de9 ("can: mcba_usb: Add support for Microchip CAN BUS Analyzer")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/mcba_usb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 41c0a1c399bf..04170326dc7e 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -608,11 +608,17 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, MCBA_USB_RX_BUFF_SIZE,
 			  mcba_usb_read_bulk_callback, priv);
 
+	usb_anchor_urb(urb, &priv->rx_submitted);
+
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!retval)
+		return;
+
+	usb_unanchor_urb(urb);
 
 	if (retval == -ENODEV)
 		netif_device_detach(netdev);
-	else if (retval)
+	else
 		netdev_err(netdev, "failed resubmitting read bulk urb: %d\n",
 			   retval);
 }

-- 
2.51.0


