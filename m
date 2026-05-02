Return-Path: <stable+bounces-242572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGA8L4pd9Wm+KgIAu9opvQ
	(envelope-from <stable+bounces-242572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A14B0A94
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D278E30177A1
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD018E02A;
	Sat,  2 May 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF8+SWGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B329CE1
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687944; cv=none; b=fS2SQkt/0BGrYQzmy51f/a5RGpdEG5G2/4kCtjRMNDHXMZXeSKyjtW+QMOL8iFdInoMCafsDg++8FvJ0MpzVQr0Q/zwZvw4BH+SbfiZwHx6VCM7bacF25OpSWgG016ZGuV3FvgFIYOZiIVdfstXZtmue4U5gNb59pj8FdSSNyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687944; c=relaxed/simple;
	bh=atoGxdPsFlWXGcFHo+pEw1E6jcec5yewRHJvdSydrSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RguENfTFuYud3eFDl/hs4fDIXbIO2OYPU62fUN3REyKZ+dKwKgns+mYOoE69OGtUQz0JeL//KWf//Lw82b9OU8RDDikxmt41YpfQwMNQAK5Y+vPMyQ8R36+nKTo66Umm7g/DCJNP1xwboN5sv6NXaaYjXCLjQhVnndXSSvD5hFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF8+SWGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245CCC2BCB4;
	Sat,  2 May 2026 02:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777687943;
	bh=atoGxdPsFlWXGcFHo+pEw1E6jcec5yewRHJvdSydrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF8+SWGOjtMhV0eSKqeqHDUhVqiuMzp0ysXzW1rPPJCF8+IS9FPpQ6gbKfeSpyln0
	 FcKjo14K5nNO1wU0kyPsW8RH9FST67gJvJOIj4ULCBYqo+SDzhVhudqhpL24oavqAc
	 w3bOHvSSakXz0YAjGLKh+swrh6jrRxz29UvzhbDwxtoKStJitGJs8deiQVFnDh9swA
	 wMmecTn1W1rP26EEAHeR0/IZolErNjEBOSMijji/TDfpeYxcW6u8UeBf3HqS77SNI5
	 /231TSoqSs1oRzp0IBC86OsdLUPQX3cVcy/QDataazwf4IBhHT3fcSwkOMpB/O6ECF
	 pYfdh94xxd7YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: rc: igorplugusb: heed coherency rules
Date: Fri,  1 May 2026 22:12:21 -0400
Message-ID: <20260502021221.4166866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050125-qualifier-whole-b10c@gregkh>
References: <2026050125-qualifier-whole-b10c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 239A14B0A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242572-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mess.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]

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
[ replaced kzalloc_obj() with kzalloc(sizeof(*ir->request), GFP_KERNEL) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/igorplugusb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 3e9988ee785f0..2ac19f283f4b9 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
 #include <media/rc-core.h>
@@ -34,7 +35,7 @@ struct igorplugusb {
 	struct device *dev;
 
 	struct urb *urb;
-	struct usb_ctrlrequest request;
+	struct usb_ctrlrequest *request;
 
 	struct timer_list timer;
 
@@ -123,7 +124,7 @@ static void igorplugusb_cmd(struct igorplugusb *ir, int cmd)
 {
 	int ret;
 
-	ir->request.bRequest = cmd;
+	ir->request->bRequest = cmd;
 	ir->urb->transfer_flags = 0;
 	ret = usb_submit_urb(ir->urb, GFP_ATOMIC);
 	if (ret)
@@ -165,13 +166,17 @@ static int igorplugusb_probe(struct usb_interface *intf,
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
-	ir->request.wLength = cpu_to_le16(sizeof(ir->buf_in));
+	ir->request->bRequest = GET_INFRACODE;
+	ir->request->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
+	ir->request->wLength = cpu_to_le16(sizeof(ir->buf_in));
 
 	ir->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ir->urb)
@@ -223,6 +228,7 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	rc_free_device(ir->rc);
 	usb_free_urb(ir->urb);
 	del_timer(&ir->timer);
+	kfree(ir->request);
 
 	return ret;
 }
@@ -236,6 +242,7 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	usb_kill_urb(ir->urb);
 	usb_free_urb(ir->urb);
+	kfree(ir->request);
 }
 
 static const struct usb_device_id igorplugusb_table[] = {
-- 
2.53.0


