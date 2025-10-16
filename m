Return-Path: <stable+bounces-185962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACDBE25CA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587A419C84E7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4503176E6;
	Thu, 16 Oct 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAaRtWAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B32FF669
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606762; cv=none; b=p06aSSAMVQgYhMYIt9wlE1LWQgsS4CN5v61EvRTSJgX7fYng1l28y0+b5VpvpP8mzQCtacCMR6f3hx3BvYUDcwakIZDhu7ZWkcANbH4Fhc9B2s5mEFEpHOcgqh2/h25pgf7FcGDCotbof+lxr1Qo+mwKDO2aH09UOfz0ph1rB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606762; c=relaxed/simple;
	bh=IXmcZAPb+syKP5rR54UKRTtRtUDje+2PwCNFNkth1Tc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ey8iZ527FjMx94RIAM7Rwy1fETQX0phc6rCB8AXybOxK/QBj2shAH7Y/WNE3g1ctwjiY6KtjUwwwfLzAE4FDqa3eyOLrNvUmqykx7lCYiMSxM3EoP5vZDDjaM9mqRQAlY2U0U4CyMY/Sw4Z3+14ast4TkShaGXz+PMjocBmwVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAaRtWAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EECFC4CEF1;
	Thu, 16 Oct 2025 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606762;
	bh=IXmcZAPb+syKP5rR54UKRTtRtUDje+2PwCNFNkth1Tc=;
	h=Subject:To:Cc:From:Date:From;
	b=pAaRtWACFXScBz1pqmqT+KuEO5aqidp57oQSKyi1SKl8zCxt8A5cAoYhd/JoXt/TB
	 drg6OpUFwKedDYpQZ11C62tDHezdhJlqCraTUO3CxgUjKD1RCvjO9Un38mPlX+U5HX
	 tK1prNJIsoHYDSsnRlf/olUYxKGQYg3cEBOjpXCc=
Subject: FAILED: patch "[PATCH] usb: gadget: Introduce free_usb_request helper" failed to apply to 5.10-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:25:44 +0200
Message-ID: <2025101644-scoured-unarmored-e328@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 201c53c687f2b55a7cc6d9f4000af4797860174b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101644-scoured-unarmored-e328@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 201c53c687f2b55a7cc6d9f4000af4797860174b Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Tue, 16 Sep 2025 16:21:33 +0800
Subject: [PATCH] usb: gadget: Introduce free_usb_request helper

Introduce the free_usb_request() function that frees both the request's
buffer and the request itself.

This function serves as the cleanup callback for DEFINE_FREE() to enable
automatic, scope-based cleanup for usb_request pointers.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250916-ready-v1-2-4997bf277548@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250916-ready-v1-2-4997bf277548@google.com

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f2079476088..3aaf19e77558 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -293,6 +294,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * free_usb_request - frees a usb_request object and its buffer
+ * @req: the request being freed
+ *
+ * This helper function frees both the request's buffer and the request object
+ * itself by calling usb_ep_free_request(). Its signature is designed to be used
+ * with DEFINE_FREE() to enable automatic, scope-based cleanup for usb_request
+ * pointers.
+ */
+static inline void free_usb_request(struct usb_request *req)
+{
+	if (!req)
+		return;
+
+	kfree(req->buf);
+	usb_ep_free_request(req->ep, req);
+}
+
+DEFINE_FREE(free_usb_request, struct usb_request *, free_usb_request(_T))
+
+/*-------------------------------------------------------------------------*/
+
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
 #define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */


