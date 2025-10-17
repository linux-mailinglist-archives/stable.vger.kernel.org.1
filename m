Return-Path: <stable+bounces-187731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70300BEC0F2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E5D6E7773
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7977311C3B;
	Fri, 17 Oct 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWh88uuN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918F2E62A4
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745514; cv=none; b=QFmqRB76QGvd2Eo4LjBRpP5vOEumGh8xHe72aU9rd+REalXfwSpR5zH3NFmrQNxK23HekMhuV7SbD2f4sib2zuY3lHGyQ4iji3mBKQzTxVawhoripRiRr3ki0/jQ2rh7Y1tSBo7eL2yzy6pgmaVa+t4IHncQoYoYXbO4uie1ORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745514; c=relaxed/simple;
	bh=cLf29FvVp8iEP82y9/tGC1DwY2FRMeXmUp+QzHJHjuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD5fyexC/s1ZBTmTsLddb6WqphVMS5xWt1pymL0o7nHSsQnyB+FVZq0lp8DITvC2j4fqW4jO0zuvcNQK1P9O+rVdsWeYBGIxX61ndvhaZRhlCFovt414bp1lMQtJE7WuxiLUHu3s/ybFTj9ZPw4lh/5AOnQX8060RJopCo7Lm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWh88uuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FB8C113D0;
	Fri, 17 Oct 2025 23:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745514;
	bh=cLf29FvVp8iEP82y9/tGC1DwY2FRMeXmUp+QzHJHjuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWh88uuNPEdFDe1CxYZsBUTOp466OcHOJhyhgPCknLQX0db8g6L7zCuhLZU5qt1BP
	 vDaYFVGOzfeSpQAio6sDlMxyzzFp7wTfm+keWO0j3/CiWF3cyGPv69B9hkW9fMHStz
	 6mWLiQUHhA0iLo0UBqVo4aiWlkLMf9TRa+kPmQjh53afGtokwWP2bxZsLZajLDflbB
	 qSiV6xSV1mfFpmgDUwkOBNRSrFez97o6pAD96d4cCKpJldyP9EHrsqtBn43VZOSeKE
	 PPrT8Ckt1AH3wODWTA2pWbeuctFc1JqH4mzkXXZ6iE/UQgzOmkOIp7n8ogIKo8DIJl
	 8ApPWc0s1gNQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 19:58:25 -0400
Message-ID: <20251017235826.62546-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017235826.62546-1-sashal@kernel.org>
References: <2025101602-unvarying-unmade-9abc@gregkh>
 <20251017235826.62546-1-sashal@kernel.org>
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


