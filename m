Return-Path: <stable+bounces-188184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEBBF25C6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0AA44F7DBC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F92284671;
	Mon, 20 Oct 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNCJYg5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C81F875A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977185; cv=none; b=LsjQTivS6NqZ3OZIgJIk24FLldU/qNOWYuAKjN5vJ/XVkTHH2vBFJsOuA8/usfJVQKO4h2SlX2Lpn/Fe6JG4OSOyMarPhzCFYg3PN0vJQ2Ypph3so5rhyRnMJs3ucjioDBhW/4kfDyB/XLkQ2XnfL55s/z6gpXsYbVxtQYqh90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977185; c=relaxed/simple;
	bh=rVqReRYlgyzo7sCfzgsQRJRtcKkkhyDR1cnCTiRcH1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/W7XvSq7NtC/cFHaMWFyy1ercLTWxIdx/l/rMZJiJlIFru8ty9X+4y6tDNNLU215/sXQeXivg3JoTERay2T6Md+AhHPI943yf2/useWCp+PJ9N31foXNwjMODsljWpgU0F6jQko3iGaPtsEMgft8Rat++9p21BrJO4IDGk+Ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNCJYg5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43DCC116B1;
	Mon, 20 Oct 2025 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977185;
	bh=rVqReRYlgyzo7sCfzgsQRJRtcKkkhyDR1cnCTiRcH1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNCJYg5el1EkCluLvz7QQkJr5SrsZitMSOi3F5dcOOJJ4x1Mv7DqLR+QF3lybnWPZ
	 s2Pkuisn1xEoVRZOAOiijhE7N0la5jbR+YMaS+c2MxC5ed6THVJEPO4bm2qQ63gxiy
	 ggfUCcSRYDp7y/EN60u960r6h2Q0y+wubYSxKNE7KsYGBF0LULg0phCdNyBmjnGtfv
	 u5i8FRZv+gK9FishvRRfjl9mcwaCauC5xpZWzYB0A4V+VNh9Ly4i0yw45cCI7q0Tt+
	 p9ISZlUP3ZBKMuo7ydyPYWCFu632S4ZlwaOhZRRJHUkCEidrU4grgzDbI1H0weDTFu
	 McOaPOR/psnDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Mon, 20 Oct 2025 12:19:41 -0400
Message-ID: <20251020161942.1835894-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020161942.1835894-1-sashal@kernel.org>
References: <2025101616-unhappily-flatware-0bd2@gregkh>
 <20251020161942.1835894-1-sashal@kernel.org>
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
index 35dc1009a703f..78f78dfbf92a9 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -17,6 +17,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -292,6 +293,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
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


