Return-Path: <stable+bounces-187767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DEBEC365
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2021235315F
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0051D618C;
	Sat, 18 Oct 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URoBXc6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E0524F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750544; cv=none; b=DE6/He0Gk29oISYxwVdNvPjHt59dCxdkkf087XSZhsL53R0jarV9iGIvloyQ2ymUvFp/PT+SIuPpQSBMA10JKXTM7ecPdpjF9DegbjAQhizftMgmc0MOhmoAfefguBMjHX0E6ZtoKZiAxkd7FMAgVjYzR/LKQehVrVOvo4wySkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750544; c=relaxed/simple;
	bh=XEX3e6S1qGIi1x6U5ptj+UmjLO3iIqZrxNz1jJqWx54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii2tp1yBZoH36oogZt4YdViNTJ2AGOqrEbD8X+rgvOVk9Pp008TskSvcZhZjtBY+JFqehZSbHuxEAaXA+lV1hij95sFPAzjbHKCrYVGrOE1AK7m7YSrbnbS5FT4cBTpmReT+9VTIIngsFTRWlf1trhRg6X23HVY9+PzevWGnhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URoBXc6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D589C4CEFE;
	Sat, 18 Oct 2025 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760750542;
	bh=XEX3e6S1qGIi1x6U5ptj+UmjLO3iIqZrxNz1jJqWx54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URoBXc6yo0jmBGOSzAulWyt8SbGxPmZrO4CAKLxvfhW9PMKqqakAshhxKuW2P2gK8
	 YyDkojABFuzHTtco6xytk0VxHFTlQ5QsOby2L9KnMNp5hdWhgZtPl8J9iQ7xMCKP/M
	 QjOFaQVw00EJ8pomtg9hgdo057X3noX0DFmd0DLiG0vBuvaClHRR38N/5H3t3k091b
	 HUfXlPyaGZ1Pke3kuZghnyXcXn0ORNhbDNQXMafKl17uUMSPjllzbZ5zsHQ+/C5G0m
	 cXB+Y3zgRwTxAlYKjlk9CTvxF5X5cqKuW506hT8Wvo/dovxKHNYVq3AHt6O/V46ZTG
	 qHhTzXg/KdgpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 21:22:16 -0400
Message-ID: <20251018012217.128900-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018012217.128900-1-sashal@kernel.org>
References: <2025101658-deafening-erasable-d73e@gregkh>
 <20251018012217.128900-1-sashal@kernel.org>
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


