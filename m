Return-Path: <stable+bounces-188186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A8BF25D5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 400BF4F7F8B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E92848A0;
	Mon, 20 Oct 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv7XiE+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268627B4F9
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977238; cv=none; b=fgcZX/eXBx1u3JPjQSXl2uf+puPqEVsyNXIJd0bwrIiaNUB+kOtsumb2fm4KPvRp5UtndN9/OXY5a/BZFEnGmOuQfVFuv9nf05ajv40Y3Ekoaht+y9WdRQnCqOu/XpU0ILRi2osJ7RC8q48ryJfqeewBhFZR9VHoih/RrW5rG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977238; c=relaxed/simple;
	bh=eJ1987uoupGpndMEekt856GsolyRIAw8KvweEChthtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw94uv/RQdc/tWugNwDM28DvoKkF/IOYSaa2Lk2qgPJKVzPmQOfbiQPB25FrNCEHktWXUcNiBnMfQDu3pIQwUfvDTl5EZmTu9hCb7tPsQu4qn2dFyrzgxPxquXVuLFGNc0PTdcrFNWJbwb8I/sqMhZp2e7mBSb3+4ub2eUmRaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv7XiE+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9796AC116B1;
	Mon, 20 Oct 2025 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977238;
	bh=eJ1987uoupGpndMEekt856GsolyRIAw8KvweEChthtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yv7XiE+aRtdvVPdlfyPWE0TomfQI1YeWBlbY+7QXd8VHOOqF91gVCmzC998tCdUvA
	 Gkc0/gsSx7ZWZLp6knmoUq9wewHneTMntWgXQst4XRyQE7FNFVDxe3cztx11+dfNod
	 0FJeju7fgb1Snvn0X1eG1BAG16S/Oo/zNy7wzblt+fGCFmvZlVWBofGzCF9zcsFf1h
	 oMidcaqK+NC5i9fzDQen1dUEwaq7CkqybljRdAnQl7v1cs3s4WgMTn0mjZS/a8Fm9T
	 /XnInBvGCW9UIckcmk9BL6o0xeVKI8G0Dn5gNOlNKgvCsAB/H1aomc9QNeHKiS3P33
	 hnamSWcLUWF8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] usb: gadget: Introduce free_usb_request helper
Date: Mon, 20 Oct 2025 12:20:32 -0400
Message-ID: <20251020162033.1836288-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020162033.1836288-1-sashal@kernel.org>
References: <2025101658-ajar-suggest-f20a@gregkh>
 <20251020162033.1836288-1-sashal@kernel.org>
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


