Return-Path: <stable+bounces-242324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMThJmeK9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36164ABEB7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94423017253
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746F2D77E9;
	Fri,  1 May 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msvlSKVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9029D26B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633867; cv=none; b=sG2N7n+SBWUgljJ5PMaCKj+01PflS8gTim/nQr8fS4ucUp0/cH4rMcHp5k//fdlLoRmtorTgmiZTVOlZZfpvlvNpt8NKuqhvKZ+96tjfzZ3Smd0EwieG2+sxNVDA6is1y4pHqHhVV4/qulVOFQJhz0bHYb4MlkIZ2r+FRZR0aBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633867; c=relaxed/simple;
	bh=X2Z//I5a2Wk9IhDDWUqsm+CIldaZaTXzuHX7vSex+4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VS5MaqyvMeXn2CihsoiFaR8jzIT59pTnCiBN75LMwAfNFRQ/oh6TK8ryIG8yoibwwx97SYJ2n7NwotudotxToRJ1hKpAvxFPKuS73zqr8Yr88hlsIX0I/OUqgnzBVW9xCYSLKXB0Jnlj+ZYGF/Uo/IGfonavMGdKEMxN+FYfZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msvlSKVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E4FC2BCB4;
	Fri,  1 May 2026 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633866;
	bh=X2Z//I5a2Wk9IhDDWUqsm+CIldaZaTXzuHX7vSex+4U=;
	h=Subject:To:Cc:From:Date:From;
	b=msvlSKVpaursyuSdyGTWfVc1lGlulv+YidH/vs7Fc9hSMkjhE4IEPhEF3ujeVwDOw
	 zia5CF23jIQdWxhnNKsAoM7qY8ttZuMtNvhD7KV6UDsE6+WoM/Zdk4ojwj30oOvaxv
	 I7/KBDq6VesJ5HzwOLG+UYH8kCPhc/XFHK2GfCLo=
Subject: FAILED: patch "[PATCH] media: rc: igorplugusb: heed coherency rules" failed to apply to 6.12-stable tree
To: oneukum@suse.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:10:56 +0200
Message-ID: <2026050156-islamic-headphone-4de6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F36164ABEB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242324-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mess.org:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eac69475b01fe1e861dfe3960b57fa95671c132e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050156-islamic-headphone-4de6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eac69475b01fe1e861dfe3960b57fa95671c132e Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 11 Feb 2026 19:11:51 +0100
Subject: [PATCH] media: rc: igorplugusb: heed coherency rules

In a control request, the USB request structure
can be subject to DMA on some HCs. Hence it must obey
the rules for DMA coherency. Allocate it separately.

Fixes: b1c97193c6437 ("[media] rc: port IgorPlug-USB to rc-core")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 5ceb5ca44e23..3e10f6fe89f8 100644
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
 
+	ir->request = kzalloc_obj(*ir->request, GFP_KERNEL);
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
@@ -244,6 +249,7 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 	usb_free_urb(ir->urb);
 	rc_free_device(ir->rc);
 	kfree(ir->buf_in);
+	kfree(ir->request);
 }
 
 static const struct usb_device_id igorplugusb_table[] = {


