Return-Path: <stable+bounces-187753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 952A4BEC302
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83EBE4EE0BD
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865435975;
	Sat, 18 Oct 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF0v+vTO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE1354AF8
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748330; cv=none; b=YxtctraE79tMsdWjS4XDApdkTtpGqw6LcdL6ANZ9OTYgDI2ijEDkVzfpQcIKaj3DsflSyU9D/569FCwAzViSHI5GBW+Iz3+BzI9Wg3s8a158NEEX4AEacffArSCPmIzt8cEMEDK/BeqGnk5ywNHN7xz8VVJEHdSSt0P78CfNaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748330; c=relaxed/simple;
	bh=Mkpa/dpiwDctdnB5YCOFMG6c5+/KlIZJJFIxXbPwC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etk0Y9IcmEfie95wi00Szp0M9eI+sg8j+SlMWufKnBuRpGE/IUOBlwrqpgOwCwHeXjLrak6b7yFDS51el+EJyYYh+/IgSRmrv18X3hLxe6b5cRuk83hXZj1E4386YApQkbPHmQKtz0QgpFtLp8idPy7nauuHT+k4PdOVzR1v/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF0v+vTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A0C4CEF9;
	Sat, 18 Oct 2025 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748329;
	bh=Mkpa/dpiwDctdnB5YCOFMG6c5+/KlIZJJFIxXbPwC7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FF0v+vTO0YwBG/1HlKWvytteJoEzxMcNiVgRXrwuXW2rFiqulxbiVi32ulSEjnMtK
	 j/foLSPZtQEaSIXsiTKrW64sAQC9oR8jL1eJu9Wtc65J7YwJ9YPgOba/G+n4pvtlc8
	 eXI6zRqhkl8qEV385MqjK/3SxTSM6SCC0QT2GsXdvAsUgzS/CEhiQQbm01D45nIcdd
	 JP4ls6B+mK71XQ1CUKN1pgMi7PE1/T7PFLZed0TaXoP5fzE18s/aLi27PeT9jpUfgn
	 4JTWOuLqSEGU4uUw4/l+DbIN1YxOz8VETM4t+VxpruljgecYunupzzdaAehzjrmJIe
	 t9bqDq5hWo+7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:45:25 -0400
Message-ID: <20251018004526.94714-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018004526.94714-1-sashal@kernel.org>
References: <2025101640-mastiff-grimace-b0aa@gregkh>
 <20251018004526.94714-1-sashal@kernel.org>
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


