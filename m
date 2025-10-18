Return-Path: <stable+bounces-187789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5023BEC51B
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E9C19A734C
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F0202960;
	Sat, 18 Oct 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSEk5jOp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C04146D45
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753906; cv=none; b=cEvHLoIb9xQwi4bMx/H5Ph5zibD+YsfB94Uw82nJg98Q4nMju6CAM9n0cCKhM34Qpp15kJ8BUbWb9KzGlh1qlzjivZdWmZeuHTdSF7fY/qFjBJff+RUKMU2PfksTf+s4qus2JrBY7z05P85nyT1a+RCQkW3r/C2mhRYzEHqTrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753906; c=relaxed/simple;
	bh=gojRVBCWaYjo42mVCX3RIw5bD+PZzRHW4mIcMLueHjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7pKkDyiBFj9102Z1JVJAokvGJNBW4wvt2IcVW8QELh2WhHWzdaRu3Cu88FKrFh7wU7ybGrXU0CAFDWlzvzGtGMYQ77Xhs1jW284C5THvmL7vJCtF7V7pZXLt/Y7LMzhBUgtNDEAjv/4tX8mvpdiQyJ8WurZ1MhKVgiX5W9hnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSEk5jOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD2C4CEFE;
	Sat, 18 Oct 2025 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760753906;
	bh=gojRVBCWaYjo42mVCX3RIw5bD+PZzRHW4mIcMLueHjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSEk5jOpAgJJvW3F7gL69YNKdR/3G2jsyAqzbRKWwehYwb/BpiTPw+CeNb3FIcn90
	 0Vxt5aoGKTdaFPHZhOWkBPX6fjBIjZiEoxNoRHNbI3lKWEYwlouCsQovxJQ8zex8s+
	 YF3BH0Dy8ttclQU+4zERWkodlBm+LrK/RxIJbAcNIbbTz0tiTP/KlN0BywCfYkd66N
	 Me02cKKcoD+H6wrYbZJBt+S3L/m+rrP6ZMZGB3pl+601v4b+HBDQN9CcY1FXiExh4O
	 vxdp5/W6ATeyDeyA6XdSRRs5iHZdUtsQB+XOK2oyRrwy8SemWjeK0kQdWG7058iNYx
	 TbXqMyKf+nICQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 22:18:21 -0400
Message-ID: <20251018021822.214718-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018021822.214718-1-sashal@kernel.org>
References: <2025101631-subscript-pruning-bc19@gregkh>
 <20251018021822.214718-1-sashal@kernel.org>
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


