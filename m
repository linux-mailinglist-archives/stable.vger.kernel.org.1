Return-Path: <stable+bounces-185947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47FBE2560
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03334F9C59
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B530FC33;
	Thu, 16 Oct 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPa+r4ZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4362FF66E
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606372; cv=none; b=uc2SHp0VbAb/o/ZlTtYu+BXxnGGN8ECnivL47k1EoaR9sWdJwa4Rg/1rl/m7Hhx+nzRHiy+kNBk2bx4an/93tDTi5ATUT3BkEQGJ7Q7UkG1KVgoezP0OR8Ixy+wal7lBxEqXulbhCUWB3H5Gb5BTPivPIsGNcCd1B/VLhnN5Bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606372; c=relaxed/simple;
	bh=tuEHE+y5a1xh/qu7SBAc9/kGHQ6zLMYRG0/lCYgki70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oa9qAN4Sc3CQtF8BpDfZ4k59zjuJqbPnctcqTiw9IogmhLHnyCrHbdHGa5DWWK0kgQC42u2l0eHERkWeJaBcEWpCMt7iAiMfaeFptFo2ccd6VhnLgWExi1pKuAhWwjAyIrYkD0nikDwMed251WqQNzwX9hP1YOI5O7oNVdezOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPa+r4ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1100DC4CEF1;
	Thu, 16 Oct 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606371;
	bh=tuEHE+y5a1xh/qu7SBAc9/kGHQ6zLMYRG0/lCYgki70=;
	h=Subject:To:Cc:From:Date:From;
	b=zPa+r4ZAkRD9Iw4c9XN0TF6p9IZHMMhWiMAdffwpUvLWfQ0gBAMKbbu+JAbRddxqq
	 RzheI9JqVUoZZ0URefqsXYZNG8haRIJS7Ym19KaadPwBi3UzZkKYYSfbWrs8IeDKow
	 k8WMP3smgiNzVGLZxv/LFQp0dv74vj+WdS6MEJpo=
Subject: FAILED: patch "[PATCH] usb: gadget: f_acm: Refactor bind path to use __free()" failed to apply to 5.4-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:19:17 +0200
Message-ID: <2025101617-starlit-nape-9f4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 47b2116e54b4a854600341487e8b55249e926324
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101617-starlit-nape-9f4c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47b2116e54b4a854600341487e8b55249e926324 Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Tue, 16 Sep 2025 16:21:35 +0800
Subject: [PATCH] usb: gadget: f_acm: Refactor bind path to use __free()

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

diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 7061720b9732..106046e17c4e 100644
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
 
 
@@ -613,6 +616,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 	struct usb_ep		*ep;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	/* REVISIT might want instance-specific strings to help
 	 * distinguish instances ...
@@ -630,7 +634,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->ctrl_id = status;
 	acm_iad_descriptor.bFirstInterface = status;
 
@@ -639,43 +643,41 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 
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
 
 	acm_iad_descriptor.bFunctionProtocol = acm->bInterfaceProtocol;
 	acm_control_interface_desc.bInterfaceProtocol = acm->bInterfaceProtocol;
 
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
@@ -692,7 +694,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, acm_fs_function, acm_hs_function,
 			acm_ss_function, acm_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	acm->notify_req = no_free_ptr(request);
 
 	dev_dbg(&cdev->gadget->dev,
 		"acm ttyGS%d: IN/%s OUT/%s NOTIFY/%s\n",
@@ -700,14 +704,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
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


