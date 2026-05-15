Return-Path: <stable+bounces-248422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GNkG7dWB2pVzQIAu9opvQ
	(envelope-from <stable+bounces-248422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:24:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F353B554F4A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4F13289B64
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0E3B19DE;
	Fri, 15 May 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXHhb3Gc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF663E009B;
	Fri, 15 May 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861691; cv=none; b=lshWVz5QuYFN6r5p128CldBBHlJucOvV+fHkQnjh0ZY4bp0DyZpkZ+dpmjKZHAW0m67Qc7DxvB61hOOhEqpejFkXbv2U6CKLx0U9fPuL1UsPbBmJblrcGkENbo2Lfr4uQ8tUzYNyFG3bXaMoo2EhtOzCGKRTZtud3jRH33hPY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861691; c=relaxed/simple;
	bh=fxr+r+XTVSPkDEzI0bAxcrh3hdlsvaHUECl2182CExU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUs7p6IGXKRgNjEaRPnRWqcIgixqLsbacY7uiVSklDfM2aoQD01OyC3axvo3Sl6MTlGJ5PJIanUsuJL7mhIUCB/xbuC8Gu4FHQmJrdenhJ+E6lJLKiYQQeH9BC0ADO+nSWd2TAKqNGBbhx0OeHWC53/37UdDqOwwwDZGpPKjHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXHhb3Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4B1C2BCB0;
	Fri, 15 May 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861691;
	bh=fxr+r+XTVSPkDEzI0bAxcrh3hdlsvaHUECl2182CExU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXHhb3GcTqnLoBvR164a0dplGUmBP7MDuVA1kZSSK1+S0uXuDsrb9vHvwsLOzKmNQ
	 jhm0UPlH2SPqMWk7mHtr5S7JGvz0pkV9FaoW9S7m7CBYw/XSvQeue6SOI9EVoMzLdO
	 Mqb9D8Xw4yXqUj8+RD4tBhuZVpIZbeKtRhQOx8iA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 384/474] media: rc: igorplugusb: heed coherency rules
Date: Fri, 15 May 2026 17:48:13 +0200
Message-ID: <20260515154723.345202069@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F353B554F4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248422-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,mess.org:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/igorplugusb.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -34,7 +34,7 @@ struct igorplugusb {
 	struct device *dev;
 
 	struct urb *urb;
-	struct usb_ctrlrequest request;
+	struct usb_ctrlrequest *request;
 
 	struct timer_list timer;
 
@@ -122,7 +122,7 @@ static void igorplugusb_cmd(struct igorp
 {
 	int ret;
 
-	ir->request.bRequest = cmd;
+	ir->request->bRequest = cmd;
 	ir->urb->transfer_flags = 0;
 	ret = usb_submit_urb(ir->urb, GFP_ATOMIC);
 	if (ret && ret != -EPERM)
@@ -164,13 +164,17 @@ static int igorplugusb_probe(struct usb_
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
@@ -228,6 +232,7 @@ fail:
 	usb_free_urb(ir->urb);
 	rc_free_device(ir->rc);
 	kfree(ir->buf_in);
+	kfree(ir->request);
 
 	return ret;
 }
@@ -243,6 +248,7 @@ static void igorplugusb_disconnect(struc
 	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
 	kfree(ir->buf_in);
+	kfree(ir->request);
 }
 
 static const struct usb_device_id igorplugusb_table[] = {



