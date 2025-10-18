Return-Path: <stable+bounces-187750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CEBEC2D6
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E301AA5A86
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803F19D8BC;
	Sat, 18 Oct 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvx9T64e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67243288D0
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748116; cv=none; b=S/SGjEzaJqGldAmq+Yn/A1Pvw5wVoK9iS34bDTl5uHbnpmVxtr7v4b4Vz+zwr+QSNBxWenb1BCAMYoQUXZf3tiKvxGb4s5RlE9M9WwzZWH+Bw4JsZRc32QFRhjnReBGZcK+1SdaEbg+3xkxRMxXMOkQ3RMa4mgAuo2X/MLTgTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748116; c=relaxed/simple;
	bh=pSqka0ojg+JIVDNRa3a7MNmBJfFW9h1BTwVgnkS6jCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP+bzNpNptaL+BJOzjTgeXnyVklI4LSitRNvZx4rzjKsWm5iuHUCVMq+sy08yOHI5oWMbkzzMtMgyf0bVPetU8DqTQpgp+hpc5g1Ig3Qk6SYvY0u9CFQpUMtArSpZQXY2WN9ACAsfcAg3tjBt3f8YUUebyZLz27IhU+86ARZe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvx9T64e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7435EC4CEF9;
	Sat, 18 Oct 2025 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748116;
	bh=pSqka0ojg+JIVDNRa3a7MNmBJfFW9h1BTwVgnkS6jCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cvx9T64eoLaJwMT6SEmOehbaqG9sxypFyr440gXPFuCLlxBlzCRIsrGtZMSHSdFM0
	 BGy0JH1nCDrMZdE3oqPIIaxs4pqPjEG7Ku/WGu3AAEAHFvpJt3I8j7/Sp1k3JHrieW
	 1yNBrBsaRUD9ZX5UH7kHyaO/+3v6FXwxkkuN5KvGaeIIgzuaTkxgWIHLUM5J0i7opr
	 hQv29JbYRSGTyQY62RvgZYaQqPyQj/XsiTZ+a+tVoSOcPaX08LFQdo16uxrSzYoITp
	 zwceGPJWbulTFVs56hiupSI9gUu/dvW4x99iyXY/oJkVcDD2qreixG7krNKYt8gyI2
	 QYtFqI/RCdfMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:41:51 -0400
Message-ID: <20251018004152.92074-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018004152.92074-1-sashal@kernel.org>
References: <2025101618-margarita-stunt-1be5@gregkh>
 <20251018004152.92074-1-sashal@kernel.org>
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
Stable-dep-of: 47b2116e54b4 ("usb: gadget: f_acm: Refactor bind path to use __free()")
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


