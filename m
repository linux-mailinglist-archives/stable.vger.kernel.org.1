Return-Path: <stable+bounces-242496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKfjECH79GnFGwIAu9opvQ
	(envelope-from <stable+bounces-242496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:12:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C036B4AF10A
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73CE93014115
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439AF407580;
	Fri,  1 May 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAeIwT7r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063723EF67E
	for <stable@vger.kernel.org>; Fri,  1 May 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662745; cv=none; b=ow5bUDC8uUiNUCKK4b96Uu/oFMKnC+wDbd/E9XgoUzw2Hopwc3ppmkemPPn1nifwS2xFnUZNHQFhYxonA+3MLsGepxvYvEclIgcAIa3hWV1jf9rvzaJlw0joFF7Ll3c9Pbu+m/mLgPHg3Y8Bhb6r71DoYh0kRRS5GJZ0UJDCrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662745; c=relaxed/simple;
	bh=xxQIGiuyb3/2hAiLuroRYQ/bTsFnN7OYMdV1eqt7iJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acziPAJr/xmqI6AsxbDYIp+H+wD5tyx5WDHogEzq7vhbtLX0yWJExamqN4E0PoMj6FUaiyEkO8+WE2iMfYmsRl0anMsmrFwnXCvEPgFykizgvZZ/L8M+EwxW/0IwI955rWKRNRj0GDjVX7cePuSOKg4kJp7uK7JTsLOLNJRkQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAeIwT7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D213C2BCB4;
	Fri,  1 May 2026 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777662744;
	bh=xxQIGiuyb3/2hAiLuroRYQ/bTsFnN7OYMdV1eqt7iJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAeIwT7r2nNOfdkTf1RpyMluw55p2C8r6yVrLXALsxoI8TbHwINS7PBuPSFWdg/2z
	 SM/WXLo53C2jUYBM7jmbTVcd6Yba4YmN7z72RpYXASiNLMpy1wNtzRGb/an5H59jtl
	 nmNQtY/HtPIJWDxLNFY9CU5K1FfXbSdicr0kOigFqkq8J0uttm2ceX7yfyJkE7grfW
	 BE0284WVd/0yVfoR0qkNL0VnVBz+abPaVvJAYwAJvVO20YA4SaWdsOm+37MqrCG50p
	 m7nn6YdvVAsvG/CurFfVlZEXdGO9MgTDIahNvnKVXHhlJAFN7B2tcSFOIFJCZPInNU
	 3/UV+ukwyl0bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: rc: igorplugusb: heed coherency rules
Date: Fri,  1 May 2026 15:12:22 -0400
Message-ID: <20260501191222.3975247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050130-repaint-elevate-1042@gregkh>
References: <2026050130-repaint-elevate-1042@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C036B4AF10A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242496-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mess.org:email]

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit eac69475b01fe1e861dfe3960b57fa95671c132e ]

In a control request, the USB request structure
can be subject to DMA on some HCs. Hence it must obey
the rules for DMA coherency. Allocate it separately.

Fixes: b1c97193c6437 ("[media] rc: port IgorPlug-USB to rc-core")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ replaced kzalloc_obj(*ir->request, GFP_KERNEL) with kzalloc(sizeof(*ir->request), GFP_KERNEL) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/igorplugusb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index e034c93d57cf0..e7e31776453c1 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -34,7 +34,7 @@ struct igorplugusb {
 	struct device *dev;
 
 	struct urb *urb;
-	struct usb_ctrlrequest request;
+	struct usb_ctrlrequest *request;
 
 	struct timer_list timer;
 
@@ -122,7 +122,7 @@ static void igorplugusb_cmd(struct igorplugusb *ir, int cmd)
 {
 	int ret;
 
-	ir->request.bRequest = cmd;
+	ir->request->bRequest = cmd;
 	ir->urb->transfer_flags = 0;
 	ret = usb_submit_urb(ir->urb, GFP_ATOMIC);
 	if (ret && ret != -EPERM)
@@ -164,13 +164,17 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	if (!ir)
 		return -ENOMEM;
 
+	ir->request = kzalloc(sizeof(*ir->request), GFP_KERNEL);
+	if (!ir->request)
+		goto fail;
+
 	ir->dev = &intf->dev;
 
 	timer_setup(&ir->timer, igorplugusb_timer, 0);
 
-	ir->request.bRequest = GET_INFRACODE;
-	ir->request.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
-	ir->request.wLength = cpu_to_le16(MAX_PACKET);
+	ir->request->bRequest = GET_INFRACODE;
+	ir->request->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
+	ir->request->wLength = cpu_to_le16(MAX_PACKET);
 
 	ir->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ir->urb)
@@ -228,6 +232,7 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	usb_free_urb(ir->urb);
 	rc_free_device(ir->rc);
 	kfree(ir->buf_in);
+	kfree(ir->request);
 
 	return ret;
 }
@@ -243,6 +248,7 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
 	kfree(ir->buf_in);
+	kfree(ir->request);
 }
 
 static const struct usb_device_id igorplugusb_table[] = {
-- 
2.53.0


