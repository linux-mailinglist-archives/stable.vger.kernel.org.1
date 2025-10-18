Return-Path: <stable+bounces-187751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E70BEC2D7
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5091AA5896
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEED19E98D;
	Sat, 18 Oct 2025 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJa02Cui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37C288D0
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748117; cv=none; b=TNLmnqt7ND04u4i0gIkr04nS6BfojB6MHpDKEJ71iP588tOLWq3boib1H0lqGuKA2ctVN10eyUtvM87EjocGUGbAiUm70gzw2gUX5SK4JItCwvjrDw76TDLdib5Dht176lI277R0REGKkeN+idwnEPfFf4thmX7pIWfitnuzabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748117; c=relaxed/simple;
	bh=HJYZOCNyoDw/0r6MPYf0TFLOUQTGWA0hPCH6n9JvaKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJaEU6b76DdhGtxvHRvUAsdhSLWDcd+2SaadUnQSx/10BWbLp1MYr2zCnvpSlO+HHWTyQH7f3BNeUJ6V+/NcOpFxBrOJeXZzhKQeohSMn3n764Zun7RrmfGYC7lL03i5YB/N6aYQk9UEl2nXsjATwUmGo6743kEA3OCEzY7YcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJa02Cui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449E5C113D0;
	Sat, 18 Oct 2025 00:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748116;
	bh=HJYZOCNyoDw/0r6MPYf0TFLOUQTGWA0hPCH6n9JvaKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJa02Cui2KoSpu3RQA7yr6M6q6D1hkpxkusfTqpih69jLkOeDUcIKgDqy3TSgyL+I
	 kGXnvN248fBBrtYwuIG7VttCl9bI9sNw4ByqU3/8eeCNU+CZDyIVBvUosL5DA3uqJ7
	 9M5IDL35XjD4owXwwgjGNsNqMiPZTNFxC9VvBKX/5nybihJUDhjT8w3OxlmxJnQv1w
	 DTwtarQfvM+ZREGaZnw2MVqiCj+jkT9WAlgB9n51IsyFo/+xYWfTChHVpsZc3eSniT
	 wM8t1un4UnpV67bjwCnsnDzlA4WUZ+xVZM/x0I3BSYyow9OhVu4AeULBKoHQdjIhp6
	 t+d+JPw+A/7Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] usb: gadget: f_acm: Refactor bind path to use __free()
Date: Fri, 17 Oct 2025 20:41:52 -0400
Message-ID: <20251018004152.92074-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018004152.92074-1-sashal@kernel.org>
References: <2025101618-margarita-stunt-1be5@gregkh>
 <20251018004152.92074-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit 47b2116e54b4a854600341487e8b55249e926324 ]

After an bind/unbind cycle, the acm->notify_req is left stale. If a
subsequent bind fails, the unified error label attempts to free this
stale request, leading to a NULL pointer dereference when accessing
ep->ops->free_request.

Refactor the error handling in the bind path to use the __free()
automatic cleanup mechanism.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
Call trace:
 usb_ep_free_request+0x2c/0xec
 gs_free_req+0x30/0x44
 acm_bind+0x1b8/0x1f4
 usb_add_function+0xcc/0x1f0
 configfs_composite_bind+0x468/0x588
 gadget_bind_driver+0x104/0x270
 really_probe+0x190/0x374
 __driver_probe_device+0xa0/0x12c
 driver_probe_device+0x3c/0x218
 __device_attach_driver+0x14c/0x188
 bus_for_each_drv+0x10c/0x168
 __device_attach+0xfc/0x198
 device_initial_probe+0x14/0x24
 bus_probe_device+0x94/0x11c
 device_add+0x268/0x48c
 usb_add_gadget+0x198/0x28c
 dwc3_gadget_init+0x700/0x858
 __dwc3_set_mode+0x3cc/0x664
 process_scheduled_works+0x1d8/0x488
 worker_thread+0x244/0x334
 kthread+0x114/0x1bc
 ret_from_fork+0x10/0x20

Fixes: 1f1ba11b6494 ("usb gadget: issue notifications from ACM function")
Cc: stable@kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250916-ready-v1-4-4997bf277548@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250916-ready-v1-4-4997bf277548@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_acm.c | 42 +++++++++++++----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index f616059c5e1e4..a1adfd077c15b 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -11,12 +11,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_serial.h"
 
 
@@ -612,6 +615,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 	struct usb_ep		*ep;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	/* REVISIT might want instance-specific strings to help
 	 * distinguish instances ...
@@ -629,7 +633,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->ctrl_id = status;
 	acm_iad_descriptor.bFirstInterface = status;
 
@@ -638,40 +642,38 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->data_id = status;
 
 	acm_data_interface_desc.bInterfaceNumber = status;
 	acm_union_desc.bSlaveInterface0 = status;
 	acm_call_mgmt_descriptor.bDataInterface = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.in = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.out = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->notify = ep;
 
 	/* allocate notification */
-	acm->notify_req = gs_alloc_req(ep,
-			sizeof(struct usb_cdc_notification) + 2,
-			GFP_KERNEL);
-	if (!acm->notify_req)
-		goto fail;
+	request = gs_alloc_req(ep,
+			       sizeof(struct usb_cdc_notification) + 2,
+			       GFP_KERNEL);
+	if (!request)
+		return -ENODEV;
 
-	acm->notify_req->complete = acm_cdc_notify_complete;
-	acm->notify_req->context = acm;
+	request->complete = acm_cdc_notify_complete;
+	request->context = acm;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -688,7 +690,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, acm_fs_function, acm_hs_function,
 			acm_ss_function, acm_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	acm->notify_req = no_free_ptr(request);
 
 	dev_dbg(&cdev->gadget->dev,
 		"acm ttyGS%d: IN/%s OUT/%s NOTIFY/%s\n",
@@ -696,14 +700,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 		acm->port.in->name, acm->port.out->name,
 		acm->notify->name);
 	return 0;
-
-fail:
-	if (acm->notify_req)
-		gs_free_req(acm->notify, acm->notify_req);
-
-	ERROR(cdev, "%s/%p: can't bind, err %d\n", f->name, f, status);
-
-	return status;
 }
 
 static void acm_unbind(struct usb_configuration *c, struct usb_function *f)
-- 
2.51.0


