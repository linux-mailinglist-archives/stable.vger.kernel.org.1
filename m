Return-Path: <stable+bounces-242523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB30A5EX9Wl8IQIAu9opvQ
	(envelope-from <stable+bounces-242523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:13:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0404AFBDD
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9DD305931D
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E1425CF7;
	Fri,  1 May 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAWa+ORq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E260425CC3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669584; cv=none; b=qgJszbUOtMaUxMWNe/LMB15hWa/aJe87pgCEta4EFEK60xjtOxesDgmBADxmSovB26oVPDEgcMjN+6xibqcRXdIxHrMymagFn9JzrcPcowy3tGLeetJJl3f0iyBdkoedm/kEXh+e5PP0M6UAqvBXA0Y+r8bi2TPkjmkL1PR/RMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669584; c=relaxed/simple;
	bh=RKECSSadus905GI5gso77btvGese57/h8veEqGIo8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoZaovCTKz22pf7uFF7/UvBYHecsjWRsLyLR7vhzTHRDhP1kIpwTQukP7xhfpcnoCzp7/hAtTnEu/gDX9Kaf3zTF40CgJdrWVg6dXHEBvN/2peHzbrrmGCswCYTzB6v9iS2EZCQJ90QTsW8xxm93yVXYc2Bl2fKO9dMJGTtIhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAWa+ORq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A1C2BCB4;
	Fri,  1 May 2026 21:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777669584;
	bh=RKECSSadus905GI5gso77btvGese57/h8veEqGIo8ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAWa+ORqrx3gbtbCnc9Aq/tNxsCs7UEbe6qXHRYxC9xAP6AqCt1X5JqA5D+9k/HmG
	 0Af4+6F21k1cOB1A5sP5oNMd0IXzVeA02vM5C+pX5RNfLn40NskwW/ebM24B1buhg7
	 BM8TD62RHmFrBQg9Oruqn5CuYu9vX7oESqo1qJdy7bwljyksku/pXvNAjJnDY5qneZ
	 mg0PSLMdJrGoUFe65lulmadxx3Cl40CjIVANaAbg6oUteos9pmE6IWJKA5d2IHP8vS
	 m+VXSkobFiu3QELeeb6WpnfWo3AFuxvRSSAhS1XUc6zc3XnTLTEr7C+t/ZhPU13yQz
	 QEomCTKSJb/PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: rc: igorplugusb: heed coherency rules
Date: Fri,  1 May 2026 17:06:21 -0400
Message-ID: <20260501210621.4038633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050153-gazing-hangup-580c@gregkh>
References: <2026050153-gazing-hangup-580c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD0404AFBDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242523-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

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
index 1464ef9c55bcd..f3616607d4f52 100644
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


