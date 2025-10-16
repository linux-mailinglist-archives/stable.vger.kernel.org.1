Return-Path: <stable+bounces-185963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EBBE25CF
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD714E7693
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1631618F;
	Thu, 16 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ju4nzSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC892E62AD
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606765; cv=none; b=YmxiazgM0GUSqVGk+4qd1LIlEQS1p/+AHKBfrjfOf2RcgGol3bvkJqIYjGyUXS8CKopnCNHm9R8IFcZg/QtujvqCvo4Tybz5gahKMWmrwoqElKvqqBdQUvdBi/2I/NHCVz3+JyriimHjCP3zn5FxhtJbsssBXnlTLun0tSwL+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606765; c=relaxed/simple;
	bh=JvogsPioWSg/ooisp2ITT4mXp5JcUiTuAkFeJzOLUD0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gPaDptOxGB0IdviZQnhFPmjW3NHRUlK5nHB7d1Zljnzv2SVeDKV09YbCElzundjB/W0hKlkPnQ6r8hwmA2DaPTUnXOtv2gOK/w/WDGl5pac6zraLAiVNWq/9CxMEmb+jrOacxA1X2/kGgOn/tZC7hPWespRExuoEtbrVBPm4d7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ju4nzSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D39C113D0;
	Thu, 16 Oct 2025 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606765;
	bh=JvogsPioWSg/ooisp2ITT4mXp5JcUiTuAkFeJzOLUD0=;
	h=Subject:To:Cc:From:Date:From;
	b=0ju4nzSrD8YxqYXZvGD2yL06jRqJ6rnJGP9OT/XgLglky+/GZGaudE5YYHlEAXF0c
	 UFgRfa8JZGfXlF5YYIxjatickzV0Smofh9LaTFTEH2ZZG+qgE5AWH83prilAgjiUIB
	 +c3hc/ZcNou6VtLLVAypF4WJCMveqE6BoJN8IRFc=
Subject: FAILED: patch "[PATCH] usb: gadget: Introduce free_usb_request helper" failed to apply to 6.1-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:25:44 +0200
Message-ID: <2025101644-evoke-acutely-da83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 201c53c687f2b55a7cc6d9f4000af4797860174b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101644-evoke-acutely-da83@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


