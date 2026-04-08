Return-Path: <stable+bounces-233862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGJfLqFE1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCC3BBBB2
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFEF7300E614
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196EA3BADAB;
	Wed,  8 Apr 2026 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+YLX3CS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03983BB9E6
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649603; cv=none; b=sBhci+KpsAbDbC9KuYATARaNBdLRSBfQMqHWDRLgCeKrbnhHHnCXvvxB1PlczS+F5J7D2xIxK45/RFdYIm8djc+jg6FQAm+PwLVCQsdiZ7aJtiCTRqVGRzcwspbSnWXsX9AgnEUb/KVA9090MEWvIhYdppA6O0fgDcUcUJzQirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649603; c=relaxed/simple;
	bh=HPyaQZB4Q+hgmkAzasES69at6m/LjN/83GIynTEYRvs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jYnr/m+qHspetYyIGmvUC5kJXy+NSBHuXkLRwJyNuw4Ce9ua9rGqoEKiciPm5NCZ/Fm5EyM2z/PY651ttPUXWwrqtbrS+JGRrO/QX7GtwST5TQb6hqCd/1GpMpA9N1+iR7zd1fbbXNBYpiafZ/Z9FKnnEE/bbaXSMUBP7dvvgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+YLX3CS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8EDC19421;
	Wed,  8 Apr 2026 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775649603;
	bh=HPyaQZB4Q+hgmkAzasES69at6m/LjN/83GIynTEYRvs=;
	h=Subject:To:Cc:From:Date:From;
	b=B+YLX3CSvKgBIEn7b4lJputnwhFVDKd6ZukbEefPVxBAC617oSsVwkgAbn0vlwvdk
	 EuTqQz3L6Ez2s4zFlkON3pWlWsaAcOhs3VtKc9eTs/fg4WkwREqGc65Drr8c2hXNu9
	 1UGfH/QTnnrd4udo+gRUfJ48X1K+cpckr3CMgsig=
Subject: FAILED: patch "[PATCH] usb: gadget: f_rndis: Fix net_device lifecycle with" failed to apply to 5.15-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 14:00:01 +0200
Message-ID: <2026040801-boss-gambling-561e@gregkh>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,msgid.link:server fail,gregkh:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-233862-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CFCC3BBBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e367599529dc42578545a7f85fde517b35b3cda7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040801-boss-gambling-561e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e367599529dc42578545a7f85fde517b35b3cda7 Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 20 Mar 2026 16:54:50 +0800
Subject: [PATCH] usb: gadget: f_rndis: Fix net_device lifecycle with
 device_move

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
the borrowed_net flag is used to indicate whether the network device is
shared and pre-registered during the legacy driver's bind phase.

Fixes: f466c6353819 ("usb: gadget: f_rndis: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260320-usb-net-lifecycle-v1-7-4886b578161b@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 521b4619d6be..7de1c5f8e326 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -666,6 +666,7 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 
 	struct f_rndis_opts *rndis_opts;
 	struct usb_os_desc_table        *os_desc_table __free(kfree) = NULL;
+	struct net_device		*net __free(detach_gadget) = NULL;
 	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_rndis(c))
@@ -683,21 +684,18 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
 		rndis_iad_descriptor.bFunctionSubClass = rndis_opts->subclass;
 		rndis_iad_descriptor.bFunctionProtocol = rndis_opts->protocol;
-	}
 
-	/*
-	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
-	 * configurations are bound in sequence with list_for_each_entry,
-	 * in each configuration its functions are bound in sequence
-	 * with list_for_each_entry, so we assume no race condition
-	 * with regard to rndis_opts->bound access
-	 */
-	if (!rndis_opts->bound) {
-		gether_set_gadget(rndis_opts->net, cdev->gadget);
-		status = gether_register_netdev(rndis_opts->net);
-		if (status)
-			return status;
-		rndis_opts->bound = true;
+		if (rndis_opts->bind_count == 0 && !rndis_opts->borrowed_net) {
+			if (!device_is_registered(&rndis_opts->net->dev)) {
+				gether_set_gadget(rndis_opts->net, cdev->gadget);
+				status = gether_register_netdev(rndis_opts->net);
+			} else
+				status = gether_attach_gadget(rndis_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = rndis_opts->net;
+		}
 	}
 
 	us = usb_gstrings_attach(cdev, rndis_strings,
@@ -796,6 +794,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	rndis->notify_req = no_free_ptr(request);
 
+	rndis_opts->bind_count++;
+	retain_and_null_ptr(net);
+
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
 	 * until we're activated via set_alt().
@@ -812,11 +813,11 @@ void rndis_borrow_net(struct usb_function_instance *f, struct net_device *net)
 	struct f_rndis_opts *opts;
 
 	opts = container_of(f, struct f_rndis_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
-	opts->borrowed_net = opts->bound = true;
+	opts->borrowed_net = true;
 	opts->net = net;
 }
 EXPORT_SYMBOL_GPL(rndis_borrow_net);
@@ -874,7 +875,7 @@ static void rndis_free_inst(struct usb_function_instance *f)
 
 	opts = container_of(f, struct f_rndis_opts, func_inst);
 	if (!opts->borrowed_net) {
-		if (opts->bound)
+		if (device_is_registered(&opts->net->dev))
 			gether_cleanup(netdev_priv(opts->net));
 		else
 			free_netdev(opts->net);
@@ -943,6 +944,9 @@ static void rndis_free(struct usb_function *f)
 static void rndis_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_rndis		*rndis = func_to_rndis(f);
+	struct f_rndis_opts	*rndis_opts;
+
+	rndis_opts = container_of(f->fi, struct f_rndis_opts, func_inst);
 
 	kfree(f->os_desc_table);
 	f->os_desc_n = 0;
@@ -950,6 +954,10 @@ static void rndis_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	kfree(rndis->notify_req->buf);
 	usb_ep_free_request(rndis->notify, rndis->notify_req);
+
+	rndis_opts->bind_count--;
+	if (rndis_opts->bind_count == 0 && !rndis_opts->borrowed_net)
+		gether_detach_gadget(rndis_opts->net);
 }
 
 static struct usb_function *rndis_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_rndis.h b/drivers/usb/gadget/function/u_rndis.h
index a8c409b2f52f..4e64619714dc 100644
--- a/drivers/usb/gadget/function/u_rndis.h
+++ b/drivers/usb/gadget/function/u_rndis.h
@@ -15,12 +15,34 @@
 
 #include <linux/usb/composite.h>
 
+/**
+ * struct f_rndis_opts - RNDIS function options
+ * @func_inst: USB function instance.
+ * @vendor_id: Vendor ID.
+ * @manufacturer: Manufacturer string.
+ * @net: The net_device associated with the RNDIS function.
+ * @bind_count: Tracks the number of configurations the RNDIS function is
+ *              bound to, preventing double-registration of the @net device.
+ * @borrowed_net: True if the net_device is shared and pre-registered during
+ *                the legacy composite driver's bind phase (e.g., multi.c).
+ *                If false, the RNDIS function will register the net_device
+ *                during its own bind phase.
+ * @rndis_interf_group: ConfigFS group for RNDIS interface.
+ * @rndis_os_desc: USB OS descriptor for RNDIS.
+ * @rndis_ext_compat_id: Extended compatibility ID.
+ * @class: USB class.
+ * @subclass: USB subclass.
+ * @protocol: USB protocol.
+ * @lock: Protects the data from concurrent access by configfs read/write
+ *        and create symlink/remove symlink operations.
+ * @refcnt: Reference counter for the function instance.
+ */
 struct f_rndis_opts {
 	struct usb_function_instance	func_inst;
 	u32				vendor_id;
 	const char			*manufacturer;
 	struct net_device		*net;
-	bool				bound;
+	int				bind_count;
 	bool				borrowed_net;
 
 	struct config_group		*rndis_interf_group;
@@ -30,13 +52,6 @@ struct f_rndis_opts {
 	u8				class;
 	u8				subclass;
 	u8				protocol;
-
-	/*
-	 * Read/write access to configfs attributes is handled by configfs.
-	 *
-	 * This is to protect the data from concurrent access by read/write
-	 * and create symlink/remove symlink.
-	 */
 	struct mutex			lock;
 	int				refcnt;
 };


