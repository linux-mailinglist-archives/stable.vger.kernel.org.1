Return-Path: <stable+bounces-242185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LBfMuOX82nO5AEAu9opvQ
	(envelope-from <stable+bounces-242185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567EF4A6A72
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91960300B1B5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8D47A0B6;
	Thu, 30 Apr 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCODzT6c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26C213E89
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571809; cv=none; b=Glw4pUNKSgbbDBp58HY8smSPzjA16GOsXxlKZlnRFfS0MYwPysDjd/fAECjOuo0Ye7dj6H0QrvdOyfOGqZ5e3+CB8uGxbNdxpqoddkJeicKzvlcoCfJjpW+vwpXPwElluPqDdfJdjB1FZn+uuQqmmgwF6f+WAt523spqMC8dUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571809; c=relaxed/simple;
	bh=9spNfy5mYjSbXGFonhvO2PAbckrLShrX0goMofh2LrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+qedN1bEsX0OmjJJbcgVfYo/ZoBPhADTyMz9q1CZy6Iq/+JwJzAyh7sbrOHfq1NQPF/dML7XzbZbKvPn+ORPk2KH8kHtCyAWQb1nH3Gpny/y//vsBC99lCQQfjX5HYfCmLAyKtF0MElMwV/T8nlrrKOuMJb3nthtarW2hkFDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCODzT6c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba840146so10272495e9.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777571806; x=1778176606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOoGOmEGcJMWKqKQxy0dOYEQAgzeeW+X/nrMaPWt9b8=;
        b=DCODzT6cG8ZbkdYIYnd8xZU64MNmg7P/I84rKCEpAstL+kA28g47aJb65zBSQrOBkU
         aUBaZMyDdmUs2P6LuR/p4q+m3TMU3Xqg4bFccGXL9RKjhvtgltS42ccdtBfrJjLwZ0Co
         CcZlsfTkUglbOlJWw+tJhRiGLX2zuncsRExIjkZzovqon7CpGrLP/Oamonp3a6hGuMrM
         VbJYhuTVejPnnG76CysWPD95wI8YxDvyFQkcQRvXAKJiBGybbZVCRL88oeLb++mZ67AA
         VCd/vmZ9+Oe3Yn6CqajQD+MQXb76UslgzdsYl/QikzzFNYe0T328CMUYWBJ8IhtEgdRi
         4PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571806; x=1778176606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOoGOmEGcJMWKqKQxy0dOYEQAgzeeW+X/nrMaPWt9b8=;
        b=JTYhmbzaDExi2TpNGmdtRUiAJWhcLCu1SUjlLcRUtiVOsbM7VkgCIzCeo68SyHAtPB
         qJ7a/youDodonnBwnrMCdI85vhxkrGhxLf2BMldYWaxf4Zn90354VsE+q/9lV6147fbu
         dXeMQUPMVDmB61H+l6nrYwG4675XwXfySfXb8xFWPw6+2G41MMWssn+gSjgy07hItMzU
         xp/lKDD1xHpvtuNBjlT6FwJwNoQ6yST+Q+TIf5w7NgwabgwR4lr6e+oo54uecAThLK/A
         7qSNP/vv+MS/8EuaDbBQ9PkQoXNADdcYn+89WROyuvbeu8hiS5Ih8LI6+wCf4jUHsxyN
         VtFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CMo1AfvBRj/1FBTQhrmoot0UUJw1M+OUZZ9i50znZFeWdp9xsdkNvmAsk9E+BoCIBq67EpLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2b9IPyu6Z4ZCVhzEF017P/6cxbtEzOq45ssRuxHd3x2rvvcP
	4jcZ01097n/qIxQbUOG/+pzc/fgCGinc/mSsKhoKOWm0/SzWx9ZEu/Xi
X-Gm-Gg: AeBDievkbLfM0+/WqB+JUv8gu1t4jqVF/ZUFr8+z3CMkWC4aGR7awtPhp2N7ZNd2nc6
	4VCME7WtSBbmCfbbwS3+uxWfGCNbmk8Lt8w5+xlW+UqZk24LDNZVNOtnyYzRnZLEl0SwOXuoemu
	f+rImAuTOy3tnCcg9a4UXAkDGrt1Y6CkzqT3UyqJc3HvGjZxid2KXJVbkXYAsA/qisuMzVr6QvQ
	CK9hDsNifGS6Z1WMmfeNYhWlWarQbmcOLD1j7+8lJ+nD4q3e5jv6xz96atUinYtgDMjLP0Mgib2
	q3R9F+yrSKqI1+zlD+W2X4fYZl0F5zZLQCgG/8H8LGV1/jjAZixEIIatXd2rI7hphuJfYZVl3m9
	mSFIgb9G+cT6XWlBkccdnbDOPbG6Sgalo7+31uS8DWFdYGCKw+MVli0L8nUEOIWnjvexza+YbST
	qaPwsVupgZC3pgkemtNWUPaxgm0+Pr1VI3LW5RziVjxIxBXq2FQAmVlrq/N8aiouRDFLU22yH2Z
	Nin1shKuKbqeDuoHYsdCe11JvUd4nbe/mEaIA==
X-Received: by 2002:a05:600c:1991:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-48a8445fc76mr58580445e9.27.1777571806038;
        Thu, 30 Apr 2026 10:56:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:f9d2:9c9e:9a42:5d91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d1a4186sm1109915e9.11.2026.04.30.10.56.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 10:56:45 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: linux-usb@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	balbi@kernel.org,
	gregkh@linuxfoundation.org,
	w@1wt.eu,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: [PATCH v2] usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind
Date: Thu, 30 Apr 2026 20:56:43 +0300
Message-ID: <20260430175643.67120-1-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 567EF4A6A72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242185-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ideasonboard.com,kernel.org,linuxfoundation.org,1wt.eu,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v2: fix From/Signed-off-by to use real name and email address.
    Drop paulelder@kernel.org (address bounced).
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


