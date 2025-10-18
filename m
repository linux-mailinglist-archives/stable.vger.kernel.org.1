Return-Path: <stable+bounces-187757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C5BEC311
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 098884EE432
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431D19DF66;
	Sat, 18 Oct 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZyYwxj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE972602
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748757; cv=none; b=qoNMZCDiLzGj8hV0tub1Al2axY96Af2A/49U07Sr/pucrMNCwLAWLFmMWlYiN67JuOOWOoc4+4a8mB4P2+iX4MPr0VcgjMsE4xtQdFiseH3dhrdI4Tc82CLEgFo9c8QFT9s7/wt4g/qCMtmmllLTBHbvPhqIrUbbLhuJxjcvnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748757; c=relaxed/simple;
	bh=pSqka0ojg+JIVDNRa3a7MNmBJfFW9h1BTwVgnkS6jCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOeAQ9fHHcWOV/wpiJIWe6E90bF7EVhvmALzkx99munlE04LycgqmR/r3JX2Efbgta3ksqnnwqUG/Xp5odl6W4tx6T5XIE80QG1BO8gfsKC/A63rk1JrOsp9Nc26AHxf+csrR5Zm3Noq7Kv+9DJEH3Dowws3f9qIjgYT2zBRq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZyYwxj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2EBC113D0;
	Sat, 18 Oct 2025 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748756;
	bh=pSqka0ojg+JIVDNRa3a7MNmBJfFW9h1BTwVgnkS6jCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZyYwxj1g1bmyRMU2NtEhJuUEZ8PppNRZZlc8OOJL8+8gTd6wLn5RBVCPdteQuAcU
	 oN8nVdQxMrWxL4ckcDa/fcNcvlwXe5xC61CeWgNwOzytlO3uP/0Ui3gDAAY0984mDT
	 wyDvdhezu8H8BVVzjNXQlTdr6EvIZ62B891s3oLHoPNfD01yp7PxVm9Y5RmGPrl9l/
	 s7eqibOrWqTjdJNUnRtq/bzbUAwQw1kSwpSpZuXWQqxJMP4ejunpiESIbmeCqxI2vT
	 pxKGxVPB7WjlfPzaTVv9KWavtKkShkciPXAesb+/TDTMunUk5vjMt93FyU1k7b11yi
	 9RlPSpGmSg3dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:52:32 -0400
Message-ID: <20251018005233.97995-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018005233.97995-1-sashal@kernel.org>
References: <2025101615-stiffen-concave-05cc@gregkh>
 <20251018005233.97995-1-sashal@kernel.org>
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


