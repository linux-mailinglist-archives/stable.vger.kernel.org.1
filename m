Return-Path: <stable+bounces-187801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA1BEC5C1
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B207D4E21E0
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3124DCFD;
	Sat, 18 Oct 2025 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4RkOMPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB8248F7F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755489; cv=none; b=UHOzK3yYSQQ87MUWvnswIAlY4O7Qe16TXk1cpj2BuJgnkyXkRgrlVKTPg7NMRGQwuTAGr4y56M5yrZK3ezFBZSuOqc7cV3d+9EBaeTSWwp6u211h91MjXJlJsbAbllSQQ+qHY148A7+VAR3by3owFINGbmTjTRylFb6tEbPGQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755489; c=relaxed/simple;
	bh=Y/eQaSwIxswG2gfZ4zFpaC5To0q4o3cAx10x5A+xYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGGrQKVH9SX0rBu6zIL6HC05LSzX0X8zv2HoPvRRiUfKu1NR4Oa34U0RoqCi+1luA8idDpuyOJOfDjOMnnQg6Lna5ZmFqHdhbg7/PEROHdUTnS4Fr30hXfFiIvmE+ENyS3XsxEsPq0VLhcBIN9ahOtrZMBDDPozbKQ2CKYyoO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4RkOMPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD0C116B1;
	Sat, 18 Oct 2025 02:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760755487;
	bh=Y/eQaSwIxswG2gfZ4zFpaC5To0q4o3cAx10x5A+xYK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4RkOMPeg3D+uhWy7VAS7dKISKQFSFWccUD8eIFrULPR68jFKe8cXrTIEeiFG8IkZ
	 QtL+nRfdXyBSAvJirT79iBpJMm4E2k62Cioddi8MnuBYZAHpAnFy3b4EdRp8/CSNm2
	 HAypSZPEfEzhO9NWEePbMGxh8Vl1JfV24n4e/RJCMM4JAHjPmNEJpZDkShvdPmocAT
	 jwzg+6d5yP3Djyt7mKHh0ssopuWFx7BFjdns9ohbKmHAAGM+gpVjKbB+QD3AHIFY0O
	 2Qx6whMESyTE/FewER6W9eQYxcuJaloDMpXl4LUPs3QKr/d8XMRuJVfSr6D53+fFYr
	 QweaJSE8j31FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 22:44:43 -0400
Message-ID: <20251018024444.228704-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018024444.228704-1-sashal@kernel.org>
References: <2025101656-perky-popcorn-f7b0@gregkh>
 <20251018024444.228704-1-sashal@kernel.org>
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


