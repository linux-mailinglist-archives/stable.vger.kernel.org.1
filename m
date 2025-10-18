Return-Path: <stable+bounces-187773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B3BEC3F2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324974E7003
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258601DE881;
	Sat, 18 Oct 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfstHA/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEA5464F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752181; cv=none; b=qrUXIvz30TMXXxZhL9jnhUdrtqO5nwBx0wJ6lEWgJP/o/8IfcUBQ9kvRoeyHGzjXl7oQ9sVXSztwFdwJSwp+gYi9bycMYWuQFF0nRipbUFBtNtlOfa9eNXrAuRt21X5oHrMPFNSRzZrVq/MEYnzEr+LnQYi+enbT4Gk0ORiieqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752181; c=relaxed/simple;
	bh=ok+ymueAsvzhtYVwxHCWyEtQ0PhC8+CKwr69NbPgPZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKnpDQvzxN2VNNOVGmk0pyGY0WS0B3V6G2h/7l4wQ4anj4Bn49yUNOUd1Voen1Qtw2T5nOzqkk1hMYS6bD1fdrtfV4imeclmeUz9nX4hpFS1CimG2NXFmN0c7/+ZHdmeKejzdWZ/9XTc0I3OJoB6eTb92OAwxz6X1QX7HlPJoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfstHA/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B33DC4CEFE;
	Sat, 18 Oct 2025 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760752181;
	bh=ok+ymueAsvzhtYVwxHCWyEtQ0PhC8+CKwr69NbPgPZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfstHA/Zs16HN5uABAQjovsjY/BnDImEohV5Y5naxgZO3fGFD95buvOHDcTNq6M+Q
	 52EzuFy5ag7GbA4felq4N4yNjUt7VsqT3U/X1EmiDiD/aaQgbHKmDD1cAOoTOb2gSt
	 FUwOvbGjWbUn5038VjGYsFqZeq+YdtbMPviqj0LxmXMiTdzyHNwTV0zL3RD5a9yMd1
	 e8U2+PeweXFU2K2/5MRzrr8Ed0EYMO50Cgvl3o3M/0Qvx0FCe0EZuuu95HoUxHBRqY
	 gkihK2yn+mfpuoy89ekQPLkSZMUex0P72UjgCLTRrXXzlUSyLHZOKHDH45jCJ3nJ8k
	 Nn1f8PBMYYSGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 21:49:36 -0400
Message-ID: <20251018014938.159273-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018014938.159273-1-sashal@kernel.org>
References: <2025101600-epidemic-bleak-5192@gregkh>
 <20251018014938.159273-1-sashal@kernel.org>
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
Stable-dep-of: 42988380ac67 ("usb: gadget: f_ecm: Refactor bind path to use __free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/usb/gadget.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 9a4d800cdc1e3..2cae3af9742d3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -290,6 +291,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
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


