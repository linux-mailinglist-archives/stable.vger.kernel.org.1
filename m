Return-Path: <stable+bounces-185964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960ECBE25D5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C37E3B8D18
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24551317702;
	Thu, 16 Oct 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/cpV9yW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C53176ED
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606768; cv=none; b=XE/5D8oDJGVh1WO5wfrAJKqFw5Yfogbwzd8Ii9/p+SAkU2v+LNlcHzsrL6B5MZnoQzB3DZm8/QziswPxJ/XpTndJoGm/d/sRpaWKDbXn/SLxejzUz+5r7hMau6xNL8G6YY+4XYWpjwwCUdivCrwZWadtq+v6E9Ipi1+CIhlhaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606768; c=relaxed/simple;
	bh=hPzCQHrXm7lTGRsVT2g2V4vX1+o2XwQBkD0opqMuzRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FDAy5ox3+yR3jCzM0vEPLR4LsY9rX6Z2zq4KmfWCmdSckA7ughY7KxDjOWr0hfZwmzVMi6tteP8i6P6qeNbh8FoKc2ccEKpGOMRR+PI+VF6RF+cAp25a0shkONF2x4EEOcuybpgDx1m4Uu71auUAEw0HNYJUj64311FAqhiA3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/cpV9yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3688C116B1;
	Thu, 16 Oct 2025 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606768;
	bh=hPzCQHrXm7lTGRsVT2g2V4vX1+o2XwQBkD0opqMuzRU=;
	h=Subject:To:Cc:From:Date:From;
	b=B/cpV9yWxx0kQOHyF4BxM9XhrV6qig1C26yM7crWG0NSDMgMtzJlhWxZi5Mu6Xe+e
	 RU5JMcLgVBcEY1uq92prCtEgJ9XCrqWJ+JiFtnVxXhVA2kzH4qpmDhEKfbRLsbl8W7
	 jNRilRHHdnC4JQYSCVdKMWI4d6MM7hRdq8838SP8=
Subject: FAILED: patch "[PATCH] usb: gadget: Introduce free_usb_request helper" failed to apply to 5.4-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:25:45 +0200
Message-ID: <2025101645-fever-premiere-e9fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 201c53c687f2b55a7cc6d9f4000af4797860174b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101645-fever-premiere-e9fb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


