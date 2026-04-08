Return-Path: <stable+bounces-233874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMPZEfFF1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:11:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5B3BBCDD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F152300A113
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C83B27DA;
	Wed,  8 Apr 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9el2Lts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F133ACF04
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650284; cv=none; b=GLbyVrskwNqLsWhrsLXmfswH5UQzGeDoYGumS/r2xyjjfzXmsW2nKUzF4TWE3Vda12/9n/6+YvmH8teiDFUUirwsPBaVahQv5JQWwwdLtmAWYxdXcQxWPPw1Jgd9PYfGGA9K1yjUAyITmlXlz7jX6RRTdUtX0DQr89ZHFY7u3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650284; c=relaxed/simple;
	bh=syLAGjCCFXygczqgzOteTXFHXiJ+ur5EAd7mv3j6CjU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LauUuHW/miV6ss39qQ19B+mnuU496MgJCCwW3fBTABHEFOIzUQG0909TU7KGV+8oBrAFSiz9diXX1tH9QyYC2ItqKXTx676SODj8+2NFdj+f8rS1+tjmunPnv/Dx2m7VnKg01NcCJQj55YwU55Ooe5LUbXHe3Whsi+M/nZIzHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9el2Lts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F65C19421;
	Wed,  8 Apr 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775650284;
	bh=syLAGjCCFXygczqgzOteTXFHXiJ+ur5EAd7mv3j6CjU=;
	h=Subject:To:Cc:From:Date:From;
	b=j9el2LtsT83zIpInYvK9sy7/dJHoSzLlVNINn489/Up5Vr9SV9nvXNdyW76HUhYYD
	 4KTue9F7moIdWuK8u4xcXhepnHKrFBlLPn/FlqGDFEpWYRRw4obol8T147LUQwuFxY
	 VSgH9L3UPrcCTPZ62TCe3NE14eOuB/HvfhR1W/2Q=
Subject: FAILED: patch "[PATCH] usb: gadget: f_eem: Fix net_device lifecycle with device_move" failed to apply to 6.6-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 14:11:21 +0200
Message-ID: <2026040821-electable-unskilled-9042@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233874-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: ACB5B3BBCDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d9270c9a8118c1535409db926ac1e2545dc97b81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040821-electable-unskilled-9042@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d9270c9a8118c1535409db926ac1e2545dc97b81 Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 20 Mar 2026 16:54:48 +0800
Subject: [PATCH] usb: gadget: f_eem: Fix net_device lifecycle with device_move

The net_device is allocated during function instance creation and
registered during the bind phase with the gadget device as its sysfs
parent. When the function unbinds, the parent device is destroyed, but
the net_device survives, resulting in dangling sysfs symlinks:

console:/ # ls -l /sys/class/net/usb0
lrwxrwxrwx ... /sys/class/net/usb0 ->
/sys/devices/platform/.../gadget.0/net/usb0
console:/ # ls -l /sys/devices/platform/.../gadget.0/net/usb0
ls: .../gadget.0/net/usb0: No such file or directory

Use device_move() to reparent the net_device between the gadget device
tree and /sys/devices/virtual across bind and unbind cycles. During the
final unbind, calling device_move(NULL) moves the net_device to the
virtual device tree before the gadget device is destroyed. On rebinding,
device_move() reparents the device back under the new gadget, ensuring
proper sysfs topology and power management ordering.

To maintain compatibility with legacy composite drivers (e.g., multi.c),
the bound flag is used to indicate whether the network device is shared
and pre-registered during the legacy driver's bind phase.

Fixes: b29002a15794 ("usb: gadget: f_eem: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260320-usb-net-lifecycle-v1-5-4886b578161b@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index 0142a0e487ee..ac37d7c1d168 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2009 EF Johnson Technologies
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -251,24 +252,22 @@ static int eem_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_eem_opts	*eem_opts;
+	struct net_device	*net __free(detach_gadget) = NULL;
 
 	eem_opts = container_of(f->fi, struct f_eem_opts, func_inst);
-	/*
-	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
-	 * configurations are bound in sequence with list_for_each_entry,
-	 * in each configuration its functions are bound in sequence
-	 * with list_for_each_entry, so we assume no race condition
-	 * with regard to eem_opts->bound access
-	 */
-	if (!eem_opts->bound) {
-		mutex_lock(&eem_opts->lock);
-		gether_set_gadget(eem_opts->net, cdev->gadget);
-		status = gether_register_netdev(eem_opts->net);
-		mutex_unlock(&eem_opts->lock);
-		if (status)
-			return status;
-		eem_opts->bound = true;
-	}
+
+	scoped_guard(mutex, &eem_opts->lock)
+		if (eem_opts->bind_count == 0 && !eem_opts->bound) {
+			if (!device_is_registered(&eem_opts->net->dev)) {
+				gether_set_gadget(eem_opts->net, cdev->gadget);
+				status = gether_register_netdev(eem_opts->net);
+			} else
+				status = gether_attach_gadget(eem_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = eem_opts->net;
+		}
 
 	us = usb_gstrings_attach(cdev, eem_strings,
 				 ARRAY_SIZE(eem_string_defs));
@@ -279,21 +278,19 @@ static int eem_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	eem->ctrl_id = status;
 	eem_intf.bInterfaceNumber = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &eem_fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	eem->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &eem_fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	eem->port.out_ep = ep;
 
 	/* support all relevant hardware speeds... we expect that when
@@ -309,16 +306,14 @@ static int eem_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, eem_fs_function, eem_hs_function,
 			eem_ss_function, eem_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	eem_opts->bind_count++;
+	retain_and_null_ptr(net);
 
 	DBG(cdev, "CDC Ethernet (EEM): IN/%s OUT/%s\n",
 			eem->port.in_ep->name, eem->port.out_ep->name);
 	return 0;
-
-fail:
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static void eem_cmd_complete(struct usb_ep *ep, struct usb_request *req)
@@ -597,7 +592,7 @@ static void eem_free_inst(struct usb_function_instance *f)
 	struct f_eem_opts *opts;
 
 	opts = container_of(f, struct f_eem_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
@@ -640,9 +635,17 @@ static void eem_free(struct usb_function *f)
 
 static void eem_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_eem_opts *opts;
+
 	DBG(c->cdev, "eem unbind\n");
 
+	opts = container_of(f->fi, struct f_eem_opts, func_inst);
+
 	usb_free_all_descriptors(f);
+
+	opts->bind_count--;
+	if (opts->bind_count == 0 && !opts->bound)
+		gether_detach_gadget(opts->net);
 }
 
 static struct usb_function *eem_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_eem.h b/drivers/usb/gadget/function/u_eem.h
index 3bd85dfcd71c..78ef55815219 100644
--- a/drivers/usb/gadget/function/u_eem.h
+++ b/drivers/usb/gadget/function/u_eem.h
@@ -15,17 +15,26 @@
 
 #include <linux/usb/composite.h>
 
+/**
+ * struct f_eem_opts - EEM function options
+ * @func_inst: USB function instance.
+ * @net: The net_device associated with the EEM function.
+ * @bound: True if the net_device is shared and pre-registered during the
+ *         legacy composite driver's bind phase (e.g., multi.c). If false,
+ *         the EEM function will register the net_device during its own
+ *         bind phase.
+ * @bind_count: Tracks the number of configurations the EEM function is
+ *              bound to, preventing double-registration of the @net device.
+ * @lock: Protects the data from concurrent access by configfs read/write
+ *        and create symlink/remove symlink operations.
+ * @refcnt: Reference counter for the function instance.
+ */
 struct f_eem_opts {
 	struct usb_function_instance	func_inst;
 	struct net_device		*net;
 	bool				bound;
+	int				bind_count;
 
-	/*
-	 * Read/write access to configfs attributes is handled by configfs.
-	 *
-	 * This is to protect the data from concurrent access by read/write
-	 * and create symlink/remove symlink.
-	 */
 	struct mutex			lock;
 	int				refcnt;
 };


