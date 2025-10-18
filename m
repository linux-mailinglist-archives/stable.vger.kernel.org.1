Return-Path: <stable+bounces-187775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A194ABEC40A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAE6A353924
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692F1F7586;
	Sat, 18 Oct 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxq+phXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1715624D
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752659; cv=none; b=cIN6rBDuLtVofnjHHNSq7NsAmLE6988+A/AvljKe1iDU9kYUW+4FsrNGnzpTHWMLSUufzd5KbtBaknK27wTnSykOq/DpxIJubX2YI6wwvJSgWuHOT109qO5zM2PNIahPJ2upBDrNLq/ZxvGrSAmUBuDBuCAOmSIWQb/IJ8xIyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752659; c=relaxed/simple;
	bh=fCzGNMJTB7NFVo8kVcOhZjVsU55c+coYszEnAsj6uKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGYeFipewwKGKR9p5LB34FsQT88V/Gqyo7yv1GMrRFoIAlHjY7CTG+yVLLXmP9MX4xVYvIW8NUxfyILrMELgk4IWehuL8Z198igOY4xRogOyXnpVNMQF1VV2spoXIMTXiWwgOGBBRjaFR6gn1KNz1BD4itNbQznfShEwucBj+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxq+phXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BEC4CEFE;
	Sat, 18 Oct 2025 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760752658;
	bh=fCzGNMJTB7NFVo8kVcOhZjVsU55c+coYszEnAsj6uKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sxq+phXl0jAFp1EMqyq2lnpY0sGjsTUezOh9Y8krKVqB1JOoQsKVfc2J5FO4IfUjE
	 iOPAJKYQtqtRPUnzZGpBNFNjZmSSsLyA3N0makJI/aGzP4fhxYvLIykcp+CR2G1xUz
	 pmyBs1qPvShUQNiKO5o8xsRmWKj5aU2mLn6s05sk3ihwGsdqAARFoDnN7mddzsSSVB
	 bLN0CMxhmGQPsrJxs1P0GUOlPV2QXg6ALPr+j3WGf+sTIlmKycrgegJVQB73ZzqhHq
	 SsgBQ+/O6nGuHD3VwrXkLled55/pkXsEmlIoqhJwvgbMqiVuWqjyoj6fdRL4WQbawZ
	 yWFPkfg/mSbUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 21:57:34 -0400
Message-ID: <20251018015735.165734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018015735.165734-1-sashal@kernel.org>
References: <2025101630-mundane-sixties-ade4@gregkh>
 <20251018015735.165734-1-sashal@kernel.org>
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
Stable-dep-of: 082289414360 ("usb: gadget: f_rndis: Refactor bind path to use __free()")
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


