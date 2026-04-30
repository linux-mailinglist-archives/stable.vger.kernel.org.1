Return-Path: <stable+bounces-242149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE9qLid582mt4AEAu9opvQ
	(envelope-from <stable+bounces-242149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:45:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 244784A50F3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B293064671
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7333C513;
	Thu, 30 Apr 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHwHwWAa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E0257824
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563672; cv=none; b=QcMY0lftdzUmkR530dEshMujRFT8e7A5WZTgBoDZed8Jdlflr+JVqQMbcyAz6dFGuWWra8avAnZWBSFl3lUXLLh7s+usp9V+3/hXbJnpO4lkBVCtFMm6jRZFUOFQ/QwhkUMhyj+x6q4DMh43X1K95PK1siuvRexVSnD42CWsv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563672; c=relaxed/simple;
	bh=Xm4FEazpY1d55SvwIO4bAfwbtbgoqCSlA2mZfkuu6ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyfF2kUdf+MyuknQpbTihdxp+ue8HRpOxWiAXIDJcXNuEy+5quSnuZht/jevsF2klhllTI6399wk6gQijM865ef7ot73DRwTsNnIFOdCzkn7Twf7GVsR54SOKpMlhPSCH6K4ayxRVf7oFXcFJK+1ZG2k7x3KS3XjvBYWY/kiUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHwHwWAa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-448528f4e69so718003f8f.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563669; x=1778168469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qcWerMpQDAoEvXfjALo/ClX/15Aw2GMj+ACfo5gS4o=;
        b=aHwHwWAaCoqjJWYHakRJooqk4nJBci8A10SPT0rsLMKx8g8v7tGp8AcCEhOtkTWJNq
         /xuj+H+HcWFVrOj5Ha/frPdio4ZenFVDcyj3yK6EGao5xsd3MnCauMhurCsKXCa97ZgP
         9GfJIEcX8HOKu9Q/ABhEeWM9E5LIONCmsH9EFfEikWZTYyHFFQO9sQOUeAsYei/sjF90
         GidGxx9kkThrZknRegz8xpCPuhgv8jZ4S9ueoi9L17Oh5Y6rkvYkrZwGnFvX/l3Ozldt
         MZyevrZ9f3y/Ibicvi5euzuEB1xN/EVl42kNPLGk+EF7XS5RtUnOkLf6opkm3T8vU9jd
         il/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563669; x=1778168469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qcWerMpQDAoEvXfjALo/ClX/15Aw2GMj+ACfo5gS4o=;
        b=On1EeR7jiANDZl5qgIApyYm95Q1tON/CP1D1kWY4hxye7HCEpw/fFXMzaji+hq5AyO
         kFH6NklSmrO9nJfrqSv0E+5eM503Jf/j1J/rjCLB+FdUbNry0FjwzKRv4o9JEZaircnN
         vMhaNLW2Xq7ONksyvyMMZWdmzaLSWynxWnDiHricYUVjGLwjyOSky9uKYk0GLIjcfKfr
         nShK5WTyHiP6iMO2lSK9lNXVsksYLq+zzol34cNcg/g/BWeOAdJiN/T76ArTii4Uyzrp
         WicXvf/td0xLmHRsRgM94M3KcCJMBbvLzxML4RxHB8L8NTFvVWFTtGoT5xcpA/mE+KUu
         4NZw==
X-Forwarded-Encrypted: i=1; AFNElJ+J7NB+U3JmSqWfURSsklXYpynOQqv0vkX+IV/enceo5kad5nQH2ZK6Gvyrt1Ak+Sxp6ZbtGaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUp67YyUO2g+W6Ad/0FG14k7GU1sE2bhMxCtHFQiFUsTyq8yL
	HeOnA/TV4nazS6W0XsujEOEMWFKeQCoa2/R+YiD6z0dqy7xK1mjKAe2r
X-Gm-Gg: AeBDiet7Ws2DPdCYQ/qQTjTpAigA6kJWE1fGBCsBshfU8F82O/f3neiVBP0NZC49esD
	oqu4CrbfJSE7zosBOThSAFRZwzmkUSIv2UPl48SczJbHftEfztYT5ug3H5ZuZhgNV9dTimNwzOn
	1idkHHPVje36SD8ARBQaaYyVrOPMyiQMqkxyXQWgpQyVCzw/iGdrbz+p8HPtN6a0taktBZv/r5b
	YaWR0kA1IGsnWEhFHBMk3wsbZOizmUVAk26GNYunkDKZKdM4EZEz7RwHGqNUz5eOSU4UL+dK1Jw
	nlpHIHmlpbZofwL4SnMldmnRYXoB8aenh5XW00YpsDp3S0EjFOFn5IEvwksBjoelsRY4QEkjAno
	zQnAwxi+7yEemebI7a91bzpezD+HyLfwKoOWic9ZfSvMiS/SvzvsglH1ic5jM6yKHtRZ4jyi/aS
	fJefCiGPP5LNhscBgyIBhHS+yrfCAObHZUEkhC11VjY4O7Tw2Y9O180PJzlGMz+ahScKNjj3lpN
	8MmozpQ6dkPyGsKW39kbaNfMoN5WYtQBoQ7dw==
X-Received: by 2002:a05:6000:2601:b0:43e:a73e:cc8a with SMTP id ffacd0b85a97d-4493ec61acdmr6469160f8f.36.1777563668561;
        Thu, 30 Apr 2026 08:41:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449c576d0a2sm3593443f8f.31.2026.04.30.08.41.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:41:08 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 18:41:04 +0300
Message-ID: <20260430154104.61633-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 244784A50F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242149-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


