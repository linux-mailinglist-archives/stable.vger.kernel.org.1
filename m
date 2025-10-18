Return-Path: <stable+bounces-187743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E939BEC2B4
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A1B583DD1
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BB13774D;
	Sat, 18 Oct 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L096mS71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF3A92E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747371; cv=none; b=hTR0aFI0HPwrzAtTWNUT6sDiK09ylcpc5yneft8kUrEnmmFjw4NztZSto4o2pwvZ9+9zQRXQEYUZQ4up4mtTVCGXjbzgrhYChIqjK5JFVyMkmCMapTHBTLJLjQ+hF4Wc7pESOM4oul5pAN+NZ8asutIYg5fCet+LTY3Tj0pYcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747371; c=relaxed/simple;
	bh=DZwSzVOT9XEuiEVD6HduziIJq6KaQh1tkVR79/suXkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+aKGP/Lbjr+kF5Hfj7HpB5Rd4NLmkxeNrePi52iowESz70kFuJgkXWWHMOLO48+3JdriMwBBr35HRBo69i/1tMRUUFCPAkanarKIOa2JgAgCyU1ZdkZDJFfG23ddL6FGViOgpkTNzl3fVhL6Gmh8hVTuDFU6vBy90U3qC2jLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L096mS71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5E7C4CEF9;
	Sat, 18 Oct 2025 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760747371;
	bh=DZwSzVOT9XEuiEVD6HduziIJq6KaQh1tkVR79/suXkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L096mS71tp/5OXhkryYU92NYKaJje2O0OIel1kySnJ/VR0GdIjzDZhXzP3iVoVTqR
	 iGexQSCku0aNTWZeQm9E6kigT94NRNgQ1bYzPYcF9WOm0Llg1KsGjEbZ3GqnbT7b0g
	 8nvf8/T2vjEhD/NS3U7EV+hjKBiXao8y9cPuOSY2P/CfN5DklQXvVyZiZCTir9+dME
	 0bVUuCAsMo4uCRKu7iyB05IcArHWIO9mXeWEf5bUQb9UV3DyIEPptCmuWvGP4jgWoK
	 9YTp1pgUtqQMmVqvlPBN6CVa23ZRyIhdHLMyb7spVQGzIADyX0nyCZ3LDPonU58vZt
	 w9zp3u7vA6nzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Fri, 17 Oct 2025 20:29:26 -0400
Message-ID: <20251018002927.85194-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018002927.85194-1-sashal@kernel.org>
References: <2025101617-overbook-seventeen-a027@gregkh>
 <20251018002927.85194-1-sashal@kernel.org>
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


