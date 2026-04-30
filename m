Return-Path: <stable+bounces-242144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFDcOnF182mt4AEAu9opvQ
	(envelope-from <stable+bounces-242144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:29:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D08364A4C77
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE2D23017520
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AB2FD675;
	Thu, 30 Apr 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyzOHaYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595B2F5A34
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562830; cv=none; b=WtEpRbWJVE5e/kpK+ElvsS/CijzFnq5qL35UXM7MpOfzzCJQuXbEI4qvTEC0YDCPFDXOSwmgAo2uqS6a6tMhmu0yA5MPV2w4W42hm2jFpLO2y2Z8x9G/3GFw9tJY4BXzqfI3IxCc/jFdkHrC1htulbYvmhBUcfUHblrlvocAUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562830; c=relaxed/simple;
	bh=Xm4FEazpY1d55SvwIO4bAfwbtbgoqCSlA2mZfkuu6ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z12H3xmKIZsF14nh+pN2Sv3dJxLT31yIvO3tOrRXrKfUFx3aKVE0+hgipMu6/vrAFnF2BCxBTMyU3rze8oYKJqfGguwrnAtdybt648138GCad336RW6aXy85/+GNfE51ECDyM3q/14LsFt02UdZFhPobbM+Og5+drNQRs3sAMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyzOHaYK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso10158425e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562825; x=1778167625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qcWerMpQDAoEvXfjALo/ClX/15Aw2GMj+ACfo5gS4o=;
        b=ZyzOHaYK3fcy7RzZmnbI9g0DNZyCJhYVJ2zS+Vx8x4t+24fSw7Edm7RXLxoRnuYsTZ
         FFNQmxAjSJZgT8AwFJXc40Vx6HEdoQBOnbM2JhHHIyXaiIp1awILrm+bHbKCxc1M4e4n
         bmuBPvq4NShYRbj1Pf0OgUrEL84/hRt7n751ma8G4XNUbuCuvxu+SOZ5HwMgego2zszl
         hdt9/VOHcJDudX3AN5+ohUuRnhrQHKkCPjDYK/+b1qM+kq6R55uI+vSb3Wn7J9qDcG9g
         17k2O3hTsKRObYXir5g6O7Fml58ulwknxvlxR5uDGBvgjql9VOGv5IyKkkR++NrGeoqR
         RP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562825; x=1778167625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qcWerMpQDAoEvXfjALo/ClX/15Aw2GMj+ACfo5gS4o=;
        b=NGn8voAHyRCxAD4Y0HzWlj5JHf2nvIfzIUe/ptGBIzNFhvqLfXr5fZzQM7uD67Gkdu
         TWmBq9gBSnJunBadu76Fl9fEfLrd14pq3Et1EHArY/2d8h6GgFse0tPMZTPpW6Y7a5yJ
         nhbXAN1IpyWaqj5qVIBO/z27exSIPOYqTUjkhBIpHNCR0GLvy46aOZuJ0UnGsebeEWWd
         f+RnANegCesi0i5qGQcFSaMfFqmQ16aSCpVn+MAUematxGZrOCouA0dc1GnwkxVN2R+T
         Jg3+qQXu/RNkNoJ73ZVD4BHEzayI9WOQL7Hs6SITtHPTnSBq9QQe6PBajRyMVDtdqPUJ
         x/yg==
X-Forwarded-Encrypted: i=1; AFNElJ/GtbsKqE6N95uN6oH+AOLECuUj4rvjnMIpVjlkSGwmGlbVMa4GG7lgXB2cuWEygBHXsO77PAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuUwDiZ7BAyFsfcxqWfJB4glf5sFuKZ93YciQIV2E9kT7OvS4
	7VubTDEMsayB6FaRzi5Bkj7HB/Skli517x8VgC8PkhuQrzBLehW8JJmg
X-Gm-Gg: AeBDietAgmGw2ogtJzqotI+yut/l/eaMQtD8zFDMi47g8+IJoPREvAfaP6RnAhShtDg
	H7/y/Bum1qcmGLz8QDaBMJO8L3lxz5a4Htg8EVuGHRSG8EYNohwmshtV8NONqq7S1dkZhyWLTDr
	9fDtFm4M1R3JfHaJMrAJexEFNLVvAN8EX9bZ4/ZH0tk/MARYm5iwseIC8+MDiAbutMy3BscPJbo
	OySbLtfu1GE0oBsIIiz1958HO74b9ZNBl+teTg056BGvAzSVFTVWpgju3brml9owhQRPDhuvuCL
	nEUWUO8hEeFsL4Fq8KBeV7z7uR24QyED3rbW4or0eZ/6rC68BjbD2dT5JPg+GS3JwLtnrNzu0dk
	3v1+9+WGMF92DIowAIpuuh/ipwxMf5Nc7w1PyHua9fBokcBstvOkB6i7uT1ViMkr5nzerEvhbjx
	+nibopFb/PV1UjD00dum12kgWRsTUPItHX743FA7xttzKYU3/poDrnfkWmml7Lvw/1OGLk9n4H0
	/mwEtY7Abts2FmQvjb7oj7TOnomndtqGxI40I6Ri6F8bi5f
X-Received: by 2002:a05:600c:3e10:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48a84456732mr55948825e9.12.1777562824666;
        Thu, 30 Apr 2026 08:27:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c71f2sm109433045e9.5.2026.04.30.08.27.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:27:04 -0700 (PDT)
From: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
X-Google-Original-From: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
To: linux-usb@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	paulelder@kernel.org,
	balbi@kernel.org,
	gregkh@linuxfoundation.org,
	w@1wt.eu,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>
Subject: [PATCH] usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind
Date: Thu, 30 Apr 2026 18:27:02 +0300
Message-ID: <20260430152702.60771-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D08364A4C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242144-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

uvc_function_bind() walks &opts->extension_units twice without holding
opts->lock:

  - directly, for the iExtension string-descriptor fixup loop;
  - indirectly, four times via uvc_copy_descriptors() (once per speed),
    where the helper iterates uvc->desc.extension_units (which aliases
    &opts->extension_units) to size and emit XU descriptors.

The configfs side (uvcg_extension_make / uvcg_extension_drop, in
drivers/usb/gadget/function/uvc_configfs.c) takes opts->lock around its
list_add_tail / list_del operations.  A privileged userspace process
that holds the configfs subtree open and writes the gadget UDC name
to bind the function while concurrently rmdir()'ing an extensions
subdir can race uvcg_extension_drop() against the bind-time list walks
and dereference a freed struct uvcg_extension.

Hold opts->lock from the start of the XU string-descriptor fixup
through the last uvc_copy_descriptors() call, releasing on the
descriptor-error path via a new error_unlock label that drops the
lock before falling through to the existing error label.  This
matches the locking discipline of the configfs callbacks and removes
the only remaining unsynchronised reader of the XU list during bind.

Reachability: only privileged processes that can mount configfs and
write to gadget UDC files can trigger the race, so this is a
correctness fix rather than a security boundary.

Fixes: 0525210c9840 ("usb: gadget: uvc: Allow definition of XUs in configfs")
Cc: stable@vger.kernel.org
Signed-off-by: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
---
 drivers/usb/gadget/function/f_uvc.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 8d404d883..73dc7e428 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -768,6 +768,16 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
+	/*
+	 * Hold opts->lock across both the XU string-descriptor fixup below and
+	 * the descriptor-copy block further down.  Without this, configfs
+	 * uvcg_extension_drop() (which takes opts->lock) can race with the
+	 * list_for_each_entry() walks here and inside uvc_copy_descriptors(),
+	 * leading to a UAF on a freed struct uvcg_extension.  See
+	 * drivers/usb/gadget/function/uvc_configfs.c::uvcg_extension_drop().
+	 */
+	mutex_lock(&opts->lock);
+
 	/*
 	 * XUs can have an arbitrary string descriptor describing them. If they
 	 * have one pick up the ID.
@@ -785,7 +795,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 				 ARRAY_SIZE(uvc_en_us_strings));
 	if (IS_ERR(us)) {
 		ret = PTR_ERR(us);
-		goto error;
+		goto error_unlock;
 	}
 
 	uvc_iad.iFunction = opts->iad_index ? cdev->usb_strings[opts->iad_index].id :
@@ -799,14 +809,14 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* Allocate interface IDs. */
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_iad.bFirstInterface = ret;
 	uvc_control_intf.bInterfaceNumber = ret;
 	uvc->control_intf = ret;
 	opts->control_interface = ret;
 
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_streaming_intf_alt0.bInterfaceNumber = ret;
 	uvc_streaming_intf_alt1.bInterfaceNumber = ret;
 	uvc->streaming_intf = ret;
@@ -817,30 +827,32 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	if (IS_ERR(f->fs_descriptors)) {
 		ret = PTR_ERR(f->fs_descriptors);
 		f->fs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->hs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_HIGH);
 	if (IS_ERR(f->hs_descriptors)) {
 		ret = PTR_ERR(f->hs_descriptors);
 		f->hs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ss_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER);
 	if (IS_ERR(f->ss_descriptors)) {
 		ret = PTR_ERR(f->ss_descriptors);
 		f->ss_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
 	if (IS_ERR(f->ssp_descriptors)) {
 		ret = PTR_ERR(f->ssp_descriptors);
 		f->ssp_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
+	mutex_unlock(&opts->lock);
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
@@ -872,6 +884,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	return 0;
 
+error_unlock:
+	mutex_unlock(&opts->lock);
 v4l2_error:
 	v4l2_device_unregister(&uvc->v4l2_dev);
 error:
-- 
2.43.0


