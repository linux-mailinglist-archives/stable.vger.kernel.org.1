Return-Path: <stable+bounces-187747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE9BEC2D3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AB21AA57FA
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7298157480;
	Sat, 18 Oct 2025 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+WYCrqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63605288D0
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748112; cv=none; b=S+FRL/yyhuFap/x08lGlAENhUfdHZd6c010zqeVCzWpfbexZxbDryPv+GQ7KkJ7rEd4g5OwlQ0qGuy+6axEsLN/FHhAbVp3Iq815dvkKFuALn0/LKFiD6FGsKPL23YOtBoIjLPDMZLznlNgPltxsInQ8UAC9fN88tss0F5OleSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748112; c=relaxed/simple;
	bh=koU/PCRUMhyT83Fa8fvc2ok7m8JKZOIPIKB83t2t56s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScwUBmh8gyLZsTjKXN9ED1gvnX3Dx/x+w33j1XD6AJfVZlQ7OVg91R1WEUZvYF1gRfLNmEjJdS4HOD9bLkSDViJkxLIb0NJuq+/epPSGuWSsI7+X63APjufl4eN0JBib7guo7TJEmUF7P8LnwzCVmgXw4XwU9fGZolVfpqXecbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+WYCrqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62329C4CEF9;
	Sat, 18 Oct 2025 00:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748111;
	bh=koU/PCRUMhyT83Fa8fvc2ok7m8JKZOIPIKB83t2t56s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+WYCrqDg1/c4yRV5Jh4L7kg7y6YZwAUQ7PwEMQktuoqDujXRGnCdfVnQjXgkTRAZ
	 r0R64iCeh1i6h3cJvC+X54uZs0V7lxhAnyx3SBTAZfxRg33F/p8w3l1YzemIPfwMFp
	 bOV3bAtV2EXOQfDMUc+k0Yk5muQS9PJZvzipupUELy0lQqfmWyloxSTlCAMfchzKhq
	 lOpdgNofpb3M7CYDY04BU//RCHqGabb2zuhR2+Ml7EB8eyIwnVwLdWsVakRIcBVebG
	 yio/s1t0scugio/Pv0Sb0e+uEBGwq8Dqnxs5IHhxIBp4YTOswJe9Fgt8yfPphkkXD+
	 KlAVFf7/qGbhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:41:47 -0400
Message-ID: <20251018004148.92008-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018004148.92008-1-sashal@kernel.org>
References: <2025101602-clumsily-lived-dd4b@gregkh>
 <20251018004148.92008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit 201c53c687f2b55a7cc6d9f4000af4797860174b ]

Introduce the free_usb_request() function that frees both the request's
buffer and the request itself.

This function serves as the cleanup callback for DEFINE_FREE() to enable
automatic, scope-based cleanup for usb_request pointers.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250916-ready-v1-2-4997bf277548@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250916-ready-v1-2-4997bf277548@google.com
Stable-dep-of: 75a5b8d4ddd4 ("usb: gadget: f_ncm: Refactor bind path to use __free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/usb/gadget.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7bd39747026e4..aa831e16c3d39 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -291,6 +292,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
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
-- 
2.51.0


