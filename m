Return-Path: <stable+bounces-187770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5431BEC36E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FA04E4B23
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9581D7999;
	Sat, 18 Oct 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkHHBeL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887814B08A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750612; cv=none; b=q1aAnh+BjGOFdzgldSUsPTZhJK4d+QXsu7VdSBE8SNaJf/8/+X9JVl4liIxw9Urrl719Uu08up9ovm/6QOfvgEz2QTcC1VlJMdhCc/xZcQsPTMNxg2o6wGm44+VLJ3q7H4ZXCA5P7QdlvYLs3Ig6DhLwfoNRLx+pSfG3RUtglao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750612; c=relaxed/simple;
	bh=EI2Kc0SXQr6F9ZPMrvDaonjVUQw9KDemB7HDEaM4PfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8q7iAFyYB1LI+76RSQVffz8tOJ60u3CUab459sPPYKt935ExlCF8i9XmwAXsAQ4TyK2av3BY76T8ADBIhDozNatNjGE4kdDaQZWLjZo441eNrgHsGZcld5O76vTLbc2YgRpyDibC0BfIhq9YUsT5vzBFilWKttL098TYoNZ6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkHHBeL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88945C4CEFE;
	Sat, 18 Oct 2025 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760750612;
	bh=EI2Kc0SXQr6F9ZPMrvDaonjVUQw9KDemB7HDEaM4PfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkHHBeL8+DuBao5Y0dNJnRte5dPiKe74AuK83jTKgFB6v7MKdAJ7SEzXrxQQ8CYZl
	 TZnQuIUTkyC4opTFefzF4iYo34R47CQlcIA3JzCrPiZlROozkWAH8kw1GkYK3eBA+a
	 J+eJnRGGO0a6kICXL5CcI3JPFNMAX7HTH1HLp2ra/W0qjLyhNbyPLUIGexe6aLaX0n
	 L4CSTnFz4Q9NXyGzhLHvyOznLcaJ+JCSu9vGyzvPLrh1uKdmgtkr3GZvX0R+TWoid/
	 cGEw/O6SxOQmur7c/P/wdjopDEuKhukzAOASjzP95fb0j7wVxrx2pbLtRa0OxKWjF2
	 Su7BxG5YdU7PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 21:23:27 -0400
Message-ID: <20251018012328.141282-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018012328.141282-1-sashal@kernel.org>
References: <2025101615-womb-deskbound-19cd@gregkh>
 <20251018012328.141282-1-sashal@kernel.org>
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


