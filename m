Return-Path: <stable+bounces-187729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E803BEC084
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B993B7F83
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55F30CD9F;
	Fri, 17 Oct 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6RMVqnh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0423081C0
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744598; cv=none; b=hFTBLRldK2alI/WGpX69quo4skBgFpvdM1g+fCidwR8LKi6npFPv6blctVMd3paeB+U/PqevxT7v+8G5JRTlf0CGtZtwpVIfKEdnz7cios1xI9B/X2zKBIxmSP2pLGxLdO/XkOwlSMxc7vyHhhUqncr6MLo44t4lqT887kQS9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744598; c=relaxed/simple;
	bh=NiXHEOUw9cHmuNoAF/cxI06Okn52diJDXj9JE+D+GF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAsy0/XUn9gmmSPLnm2Q9dPWYQ1uwYSk0rnEteqYXxPw4vzRqDBSlV4imCPlJO9Qg4c0RkJT77xfp0GPysu9KIy0LGxGLyHkzwSlCsm98uvroK92yFyguqDNi5uqTULmBfPnn43nPXMhT+z4jMpkDfp2c5sPy0Lgnc/q59GY8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6RMVqnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F8AC4CEF9;
	Fri, 17 Oct 2025 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760744597;
	bh=NiXHEOUw9cHmuNoAF/cxI06Okn52diJDXj9JE+D+GF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6RMVqnhvv4vcHml7cvGpdVBgnJZK57ZaeZI+qUFw615NfAHMbwNi5D5StjqPCH6U
	 u/PtB7Z91vs5h0/d3zBy/j2hjTbunQRxUbwlhPIdxW0EezPQcydWGxUVBeUgQSyO+s
	 xobYWGwjeNmdd7aIM4u8eQjgnBETCTfq1ofuepGpywLefOrtUY28OqN4NcPutFcOye
	 zmKHi5MbTkehDqTYZ9HxmTn9dtX9TqVGHdTwqlMdJgBozh7c4t9+TJ9n8+y9hGmVzm
	 oY2vb6mhloGdjBZAZzziLE+AHwTpgHbODevgyfDvqmTsHxgxPkDm73J5SXLFaNeIOH
	 1UKDe8upWVATg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 19:43:13 -0400
Message-ID: <20251017234314.52983-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017234314.52983-1-sashal@kernel.org>
References: <2025101601-custard-enchilada-decc@gregkh>
 <20251017234314.52983-1-sashal@kernel.org>
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
index 0f20794760887..3aaf19e775580 100644
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
-- 
2.51.0


