Return-Path: <stable+bounces-187771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5BBEC371
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E2F6E82A7
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C181DD0EF;
	Sat, 18 Oct 2025 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrf7mzhi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494114B08A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750613; cv=none; b=CWwU7pGGhQFNIsZFflenUd4c0xVmP5tYdQOYA5HEaRQY1LG6iE5OI7xoQvsX9u3DQOuC87GQvKlsqOQyT5oR7waEMIsn8dEFWv2BpRrVpLiPpGXArJaD56uxnRf/2XIkXEs35bTqyS6orIXJ2AtB481lrNjiJ5aj0/dt5dpkDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750613; c=relaxed/simple;
	bh=H6Hci13iZF919WTZ1GD2H0ExRZWxpKiCwBuYu5+zqdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGYmVr7FFavnW68yjY23qIG8CyN/EzmovSpS2hKjtvmqn9wCUp7Jb48WZiVkZs8ZsTw+AfLa7fS8B0vKIzT6ZDkKrsijxgWqGUzr3yulvXQjwopw4NKpH7jRjWYZyiEcvMRN6bJ82c0n+Ut1QCYpeDauWikZeU5ETnvr4TOO+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrf7mzhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57576C4CEE7;
	Sat, 18 Oct 2025 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760750613;
	bh=H6Hci13iZF919WTZ1GD2H0ExRZWxpKiCwBuYu5+zqdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrf7mzhiMHcclPQ6HIT8bmTare20DQZf/nIpMZUMCL4asAtuVLqyvob95Ks+cvRl0
	 Jfts3CKB7FSUS7x+jUVTzM5gXXMZwbubg8A/1JyDQrpXFIhuSDEljBerHkLGmv5Xz8
	 IxREaNQ7D2gfjYDPvpRlXrnbb+CNedTtroV6TNOkpUzf/nbdr04NJOiHzzyQpzzYYD
	 RTHrd4CTUpAWowx/6tb6U3ZgbB1fhd39S7ZRmnNr063pK6+mr3M/xs3FCi7VHPMU+A
	 Gz+w5gL11ufYa7Qrp9xLe2qMrCmUInEIBSFEPcoL+52KltkCVjc+0+k56e0N4t4M9O
	 Ihs8de5ecVfQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] usb: gadget: f_acm: Refactor bind path to use __free()
Date: Fri, 17 Oct 2025 21:23:28 -0400
Message-ID: <20251018012328.141282-3-sashal@kernel.org>
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
index cb523f118f041..c84826c7cdc70 100644
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
 		"acm ttyGS%d: %s speed IN/%s OUT/%s NOTIFY/%s\n",
@@ -698,14 +702,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
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


