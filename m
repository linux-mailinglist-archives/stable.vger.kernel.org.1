Return-Path: <stable+bounces-212635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLfRBWI8emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:42:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38BA6030
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3C331A008E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793D3033C4;
	Wed, 28 Jan 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwobSF5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70A28D8DB;
	Wed, 28 Jan 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616183; cv=none; b=eWOUKoYyB5W8o76aJn27ZuQjLmMiwFa59gSV/oruMLoQVDjFnEtv8sV+D4q7Dh0tlRJNOZV8OUiuEJ3acPj/DuSZ2A682j/jhKHyMLtU+V0v5L5izSkagFZlcSFkTR5Ru07DPIOVh9VXRqtoa2S2Utx9CCWId4Xjer7BenA32w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616183; c=relaxed/simple;
	bh=SsUZZ0zDHDTW2fmBDNSh4HBwyi326TekLnkD0+oKmBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL2DTFjk8jDx9j/YCeZb8vKy9xxNe5y1V9jb1igOzMATCrnUOuZCYlWNAaiA59htP/mTK3dCU3QRsdLaAjcFZZEkDhErHOrTRX+MWvoimTDO7uWh+nvupbyPVSbOo8VtWTdungX+GmGDtm3XCG07HbQ/VE/fsbRj8H4Ki8a0oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwobSF5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFFFC4CEF1;
	Wed, 28 Jan 2026 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616183;
	bh=SsUZZ0zDHDTW2fmBDNSh4HBwyi326TekLnkD0+oKmBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwobSF5h6cIKZg/j5aB0cc1tztgEUx3P42wPJoU0BWgZ+pCBUUGX9Lyjrz65T/SsY
	 kuidxT2kA3OtYeivTJIV82R/EvCDygWcpJpsFaFHPJexbTgndaOL6PkCic1Bh9ewf9
	 ZMgnaMLCpWI4gOfJCUrQjaVaqM6EKZtrr5HkopYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18 207/227] can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
Date: Wed, 28 Jan 2026 16:24:12 +0100
Message-ID: <20260128145351.886110838@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212635-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: AB38BA6030
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 0ce73a0eb5a27070957b67fd74059b6da89cc516 upstream.

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In ems_usb_open(), the URBs for USB-in transfers are allocated, added to
the dev->rx_submitted anchor and submitted. In the complete callback
ems_usb_read_bulk_callback(), the URBs are processed and resubmitted. In
ems_usb_close() the URBs are freed by calling
usb_kill_anchored_urbs(&dev->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in ems_usb_close().

Fix the memory leak by anchoring the URB in the
ems_usb_read_bulk_callback() to the dev->rx_submitted anchor.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260116-can_usb-fix-memory-leak-v2-1-4b8cb2915571@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ems_usb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -486,11 +486,17 @@ resubmit_urb:
 			  urb->transfer_buffer, RX_BUFFER_SIZE,
 			  ems_usb_read_bulk_callback, dev);
 
+	usb_anchor_urb(urb, &dev->rx_submitted);
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
 		netdev_err(netdev,
 			   "failed resubmitting read bulk urb: %d\n", retval);
 }



