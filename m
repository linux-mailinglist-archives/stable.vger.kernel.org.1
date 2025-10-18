Return-Path: <stable+bounces-187763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695FBEC33E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5FF4F034B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED31A9FB9;
	Sat, 18 Oct 2025 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GopAcMU3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E8155C82
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749379; cv=none; b=DRU3t5XDVaNbc/HuJgOxTV7N1j+tnP5g1+ny7PaVMk5ByiEkXlBYzseYFvdO/K2rfn1gxQ2a/+MWIBN18TdOlUNPZ20rC3qVPyVjQqAmN/Rs8Lke6CG+B8EBV7A0dPFOnu3NPZ4BmLAgDiHzd16jDpQ/vnKgWZyY3EKlDSreTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749379; c=relaxed/simple;
	bh=maK0yvhhKjoc2kxlZVsfDmX+XuMS9D6GncZMdmPXZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuBLaYeyyQoEd1UnfE6ocSJsQzlgthTbWYLJEHqIUfj2EAddnncNc5V+ESjiAj7bx1LGEtktcnJEV5gcEa8n7Rt4AYJ5E20+vPEUzya31W4VRgX6W+aygSWjJ7mMROvpsghttvK3m389rP6EqhzkKmEuzZgHaxYdMNHVcppYskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GopAcMU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B7C4CEFE;
	Sat, 18 Oct 2025 01:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760749378;
	bh=maK0yvhhKjoc2kxlZVsfDmX+XuMS9D6GncZMdmPXZXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GopAcMU3qWhkJCiS4qzlL6jkWzZjUysbiInOc4OfMbdv80oBFTZZjvt1ORJ2QYGct
	 Rc+vTfGDOjWtII3+pH9wGV9KxnA0yUwoB5mC3oTdVKasiuOskEVxICGKNe+JEBpCoa
	 lLlwujoOTvbBsINLY+LLfRuMsQA5OwiMykUcxBe1DAd8Oa8roZFulrtjAF8z/GRcpQ
	 sPLSTUfUvva8Sfvml5qCwudZHlEoPOCDucLaPuBBTaOj7k0GrfJh5+vLYF1fIHLFp1
	 Y6Ce1bU/EgWY6U58FKhT5AxxW3Q7s0mJSwWgFP8Iej1q+KiG7iGEC00s/NNPuXQPVX
	 WzSyG18qmVE+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 21:02:54 -0400
Message-ID: <20251018010255.104362-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018010255.104362-1-sashal@kernel.org>
References: <2025101641-passcode-sanitizer-19b3@gregkh>
 <20251018010255.104362-1-sashal@kernel.org>
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


