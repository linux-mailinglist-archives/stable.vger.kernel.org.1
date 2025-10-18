Return-Path: <stable+bounces-187737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80692BEC27B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2679219A5E76
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C26BA4A;
	Sat, 18 Oct 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrURCJoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23F1388
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746671; cv=none; b=PSAypdSBhLhKwF5HF/UtfHIin/JUcoeJ522Xy1e1KHKOgNb3IIfiLAfVXCtQ9ILeQA7Y9Ije4qZ2J9Vnj8m//SSV+ZvB6eNwCNDtwtKygdV/NBBunAaxB4gVrgIERO71E1ahkZqTL1TIZ37qNEGMINjSFNjOuhxOmNWW7YLS5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746671; c=relaxed/simple;
	bh=hJ2CYgTXoGvDdOnUuri/nJH0C1trYLUZlZhzk6F9OlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoLRVyBGGKgLsp/ZZ1KbvfgkVAbtMkRZSGA2Z2VaSANs+CE9Chr4m8bRtGz5/3ghQybubAbpMcNSWeZdK/UaTwj3jPr8AYW/gNBU76megyiX89XVljQNjTiCi3qmoHQo4Du+dD3bnJyn6uw6QthqT1SSGY38ANJjDPU4o51QCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrURCJoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D16C113D0;
	Sat, 18 Oct 2025 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760746671;
	bh=hJ2CYgTXoGvDdOnUuri/nJH0C1trYLUZlZhzk6F9OlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrURCJoCzeUz40U/zfSHSpEb8pz3gCzW80MpoGKTYoTYLwu1MxO6rFJND8oexkaON
	 JzFRnjvMugiLF+IiLrOek2epdh/GTl2Rt2dfq6FW1WfUCjUhcx9wTM3Xb1c7yvx3ZH
	 lUU0KHcgbFiRdZY7XuCPEmXJAYKf0WBQRTVg5atzWYVYR4cdEG1ghuzUX0KDsI5Ed8
	 VDKCIMun1KWIKRn9Xu+x9Kxqadf5qIjeE1Ghe27xUBMUNTAaDEZcuuMAdwOI/WR+GV
	 feEKf6k0eDLqtqVU58FDHAGYUNjV4V9BrXjyfMFWH6kEQEi8CWT+qTTUtS4LV/sG6z
	 zTfaStMcFqPnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:17:47 -0400
Message-ID: <20251018001748.76008-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018001748.76008-1-sashal@kernel.org>
References: <2025101617-yield-come-49f4@gregkh>
 <20251018001748.76008-1-sashal@kernel.org>
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


