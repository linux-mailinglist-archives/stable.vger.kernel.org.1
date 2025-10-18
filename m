Return-Path: <stable+bounces-187779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B9BEC4F8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB991AA8345
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A511F5437;
	Sat, 18 Oct 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li0zom0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FD19F41C
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753034; cv=none; b=POM6CoYTTxvks/CEoE635xX4hw8VyPmbmgRIFExQeTRwR9MsrfmsuIij0oafKKb4zQQsEuD2XVmBlFdSx0/a9inlWa4xZwcYLmjYFQKMtBHXm6xkEiybMju0VdxGhbxJu1GwsEzvxe67ucLbDYPjwm3XNDFB/REYS/pREzGvlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753034; c=relaxed/simple;
	bh=3D1PwEV0rqxDet+MVBYur4nI/0PxBkrMSse9mSSiBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYCr+jfdsAIwbMafjt8ov+C2lf361SalwsL2HN3okrFqxtJc+fghngEvQ3VK+5DROS3ab609HdNRsam33WKGDRlCkuOIvvZXQpz424ghGqLGyDxL7QEY0sFLZHQBSwTtVibc+ZDXe+QVSe+M0m4xVeLm7ERawDqz/nXqz01ldB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li0zom0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92519C4CEFE;
	Sat, 18 Oct 2025 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753034;
	bh=3D1PwEV0rqxDet+MVBYur4nI/0PxBkrMSse9mSSiBAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li0zom0MSnBMBmUux+9PlJLMP/79yjB4EHAXehhl6QsqVT1/bEss44D1+zWDTHmB/
	 EBSmgtBvCMzqjdWNma8vBOivBfgHskGe0e2K2BenrFjwX6gZkljCaRhmvcXWGVgcWu
	 UjKKGI9/mnnTDRckPimE9p7ebMldJqxTgHwSgDR+aBnOh0h0N8uEmKgxUtR3OBc5j5
	 TakpBnH6CMfvN9Fc7mRXpJFdy7BGKxI64M8OdKT3QUl0Dj+2+Y07Qilq7GQ5/ZjgdH
	 VM/TK9MYcuQWaE/53Px99/mHfTwHgLyvm1cUmjFuYMnqXGZJMA8BQFAFwSaJ+7OJgi
	 o5gCKKYThaGtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 22:03:49 -0400
Message-ID: <20251018020351.207730-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018020351.207730-1-sashal@kernel.org>
References: <2025101631-macaroni-reabsorb-72e7@gregkh>
 <20251018020351.207730-1-sashal@kernel.org>
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
index 77554f4446651..da4309f3cea3f 100644
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


