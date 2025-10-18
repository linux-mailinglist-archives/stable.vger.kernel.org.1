Return-Path: <stable+bounces-187761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35150BEC31D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538D04F3AA8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156A1B4F1F;
	Sat, 18 Oct 2025 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6LYlxbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540A13AD26
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748760; cv=none; b=EgexVnRH03vEGWQZbx1DIGSoMRKm7Cmn0RBbdcHuh9lDUCMQR2sUJhMuw7w2SrEH3dxiKJe4VEoPVgVDwsTtCMOSuU7VgxAs/GzPiqXD6uAZa/TY40+8F4mfGN9xunWLnjcnyCsuf88nzto6Ql0hkrAFLm1VOxUJFga7PMTr/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748760; c=relaxed/simple;
	bh=uBfWRqtLMLChV0coWmtWAfAFwAcHCU4TePMwQv78Et4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2lgN5HuUVcOGUq18Mo+WFd3qUlWzIVqsqwjN5bBngpTGvtcZ9WxoELRFtHFP/sUxWnOJbtA6QGWd1d3L2yTduWFNmJJtfV92iTnHzGBkbp9dPcDFb2/nbbe+rSBi4t6kPJEmFAZEO5OTxctaLdCXrSU6qoQlcnllniIlN7NYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6LYlxbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122E9C4CEE7;
	Sat, 18 Oct 2025 00:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748760;
	bh=uBfWRqtLMLChV0coWmtWAfAFwAcHCU4TePMwQv78Et4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6LYlxbx5MFRM0zpaTKgnAFPKQpeeMfuvnxNMbcjAXdEIADye8pTt6NS4e1dxzGGl
	 arHao0Rj5wW+Eifu7+DHf8VKRnmrDZPOW2ihiChCUTnryFT2hDjaxPJavWrma0OLTq
	 kxB45jIE+ihnZ4dUiSveIEWq4XZ+dXWHkLtkr8C2uyozkDe+9GcNIfvzJzMASogDTt
	 Z5YB9I77A1u3ECQ/UL9uU8exlqgJkPM1x3TcjhvFOZ1Zu/yUhSAUMxlLLAtbr8gL2C
	 /aGpOmJt6T0MPTw6+VxqHsFu1a9k+xn0dsCCQ8YOnvIiSfpmqDJhzRy1d+Eb4EyEE9
	 G7UYblxB/ApIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] usb: gadget: f_ecm: Refactor bind path to use __free()
Date: Fri, 17 Oct 2025 20:52:36 -0400
Message-ID: <20251018005236.98052-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018005236.98052-1-sashal@kernel.org>
References: <2025101641-spousal-accuracy-d282@gregkh>
 <20251018005236.98052-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit 42988380ac67c76bb9dff8f77d7ef3eefd50b7b5 ]

After an bind/unbind cycle, the ecm->notify_req is left stale. If a
subsequent bind fails, the unified error label attempts to free this
stale request, leading to a NULL pointer dereference when accessing
ep->ops->free_request.

Refactor the error handling in the bind path to use the __free()
automatic cleanup mechanism.

Fixes: da741b8c56d6 ("usb ethernet gadget: split CDC Ethernet function")
Cc: stable@kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250916-ready-v1-5-4997bf277548@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250916-ready-v1-5-4997bf277548@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ecm.c | 48 ++++++++++++-----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 549efc84dd832..123c03a085099 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -8,12 +8,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/etherdevice.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ecm.h"
@@ -678,6 +681,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_ecm_opts	*ecm_opts;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
@@ -711,7 +715,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->ctrl_id = status;
 	ecm_iad_descriptor.bFirstInterface = status;
 
@@ -720,24 +724,22 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->data_id = status;
 
 	ecm_data_nop_intf.bInterfaceNumber = status;
 	ecm_data_intf.bInterfaceNumber = status;
 	ecm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is *OPTIONAL* but we
@@ -746,20 +748,18 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ecm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ecm->notify_req)
-		goto fail;
-	ecm->notify_req->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ecm->notify_req->buf)
-		goto fail;
-	ecm->notify_req->context = ecm;
-	ecm->notify_req->complete = ecm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ecm;
+	request->complete = ecm_notify_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +778,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ecm_fs_function, ecm_hs_function,
 			ecm_ss_function, ecm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -788,20 +788,12 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	ecm->port.open = ecm_open;
 	ecm->port.close = ecm_close;
 
+	ecm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Ethernet: IN/%s OUT/%s NOTIFY/%s\n",
 			ecm->port.in_ep->name, ecm->port.out_ep->name,
 			ecm->notify->name);
 	return 0;
-
-fail:
-	if (ecm->notify_req) {
-		kfree(ecm->notify_req->buf);
-		usb_ep_free_request(ecm->notify, ecm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ecm_opts *to_f_ecm_opts(struct config_item *item)
-- 
2.51.0


