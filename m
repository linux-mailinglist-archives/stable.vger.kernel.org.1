Return-Path: <stable+bounces-233861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GASMIFZD1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135C3BBA05
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0083033D34
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DE3976A9;
	Wed,  8 Apr 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YziRtotv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54D364EB2
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649594; cv=none; b=IHkKHWCDERKPgpq/EcmwT+7lFkFEMvv7DB4zRb69Srg6WghscgOEVNDtFK0Z5pcMx4syl3ugHn5DnlxbqkO9txTLKB4Vy77Hx5AWS+srCC+TiGRNiGZIDEAqbwkm76DFtmGFR+H7OvDCTw2N2s4aIaUSWlCU7k4MNi6oP+cwyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649594; c=relaxed/simple;
	bh=AjG7XwmS3mSx9CjY8pmxO1oKMOTqyWnp0GdkdgNxzk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XRF4RaSYrHDry5R187uxhYyODH8KoW0BdcwK3j93HbPulOBYaKMziFpMoKaRse1hoUuNfL/rM8GQrJHorH5clWSIf63PY6RBobjuSkrn99+tzDR9AoAz3eu70YSbnGIENiQ4KJoVOuKw0M7IOMmOiaxITVwlad/5badaEeNypuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YziRtotv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6548BC19424;
	Wed,  8 Apr 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775649594;
	bh=AjG7XwmS3mSx9CjY8pmxO1oKMOTqyWnp0GdkdgNxzk0=;
	h=Subject:To:Cc:From:Date:From;
	b=YziRtotv4NVvgEIVzWoR97w/hGON7TqyUdMcXQAPx+8Dv8H6jisET+NZKBd+IwluD
	 4uRVuv6vb4ZxHMwZ46TdPsebCx0lPQ98UIaZEXqUAqqvnvhW4AnXGbxSMhwO3ULiOT
	 2LepkUrq3Y88N6ou8dbd/WhLWxmgz2FUEpxQu/f8=
Subject: FAILED: patch "[PATCH] usb: gadget: f_subset: Fix net_device lifecycle with" failed to apply to 5.10-stable tree
To: khtsai@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 13:59:42 +0200
Message-ID: <2026040842-anything-deflector-0ef7@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1135C3BBA05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06524cd1c9011bee141a87e43ab878641ed3652b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040842-anything-deflector-0ef7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06524cd1c9011bee141a87e43ab878641ed3652b Mon Sep 17 00:00:00 2001
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 20 Mar 2026 16:54:49 +0800
Subject: [PATCH] usb: gadget: f_subset: Fix net_device lifecycle with
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
the bound flag is used to indicate whether the network device is shared
and pre-registered during the legacy driver's bind phase.

Fixes: 8cedba7c73af ("usb: gadget: f_subset: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260320-usb-net-lifecycle-v1-6-4886b578161b@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_subset.c b/drivers/usb/gadget/function/f_subset.c
index 74dc6da5c767..6e3265b8a3a0 100644
--- a/drivers/usb/gadget/function/f_subset.c
+++ b/drivers/usb/gadget/function/f_subset.c
@@ -299,25 +299,22 @@ geth_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_gether_opts	*gether_opts;
+	struct net_device	*net __free(detach_gadget) = NULL;
 
 	gether_opts = container_of(f->fi, struct f_gether_opts, func_inst);
 
-	/*
-	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
-	 * configurations are bound in sequence with list_for_each_entry,
-	 * in each configuration its functions are bound in sequence
-	 * with list_for_each_entry, so we assume no race condition
-	 * with regard to gether_opts->bound access
-	 */
-	if (!gether_opts->bound) {
-		mutex_lock(&gether_opts->lock);
-		gether_set_gadget(gether_opts->net, cdev->gadget);
-		status = gether_register_netdev(gether_opts->net);
-		mutex_unlock(&gether_opts->lock);
-		if (status)
-			return status;
-		gether_opts->bound = true;
-	}
+	scoped_guard(mutex, &gether_opts->lock)
+		if (gether_opts->bind_count == 0 && !gether_opts->bound) {
+			if (!device_is_registered(&gether_opts->net->dev)) {
+				gether_set_gadget(gether_opts->net, cdev->gadget);
+				status = gether_register_netdev(gether_opts->net);
+			} else
+				status = gether_attach_gadget(gether_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = gether_opts->net;
+		}
 
 	us = usb_gstrings_attach(cdev, geth_strings,
 				 ARRAY_SIZE(geth_string_defs));
@@ -330,20 +327,18 @@ geth_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	subset_data_intf.bInterfaceNumber = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_subset_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	geth->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_subset_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	geth->port.out_ep = ep;
 
 	/* support all relevant hardware speeds... we expect that when
@@ -361,21 +356,19 @@ geth_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, fs_eth_function, hs_eth_function,
 			ss_eth_function, ss_eth_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
 	 * until we're activated via set_alt().
 	 */
 
+	gether_opts->bind_count++;
+	retain_and_null_ptr(net);
+
 	DBG(cdev, "CDC Subset: IN/%s OUT/%s\n",
 			geth->port.in_ep->name, geth->port.out_ep->name);
 	return 0;
-
-fail:
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_gether_opts *to_f_gether_opts(struct config_item *item)
@@ -418,7 +411,7 @@ static void geth_free_inst(struct usb_function_instance *f)
 	struct f_gether_opts *opts;
 
 	opts = container_of(f, struct f_gether_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
@@ -462,8 +455,16 @@ static void geth_free(struct usb_function *f)
 
 static void geth_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_gether_opts *opts;
+
+	opts = container_of(f->fi, struct f_gether_opts, func_inst);
+
 	geth_string_defs[0].id = 0;
 	usb_free_all_descriptors(f);
+
+	opts->bind_count--;
+	if (opts->bind_count == 0 && !opts->bound)
+		gether_detach_gadget(opts->net);
 }
 
 static struct usb_function *geth_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_gether.h b/drivers/usb/gadget/function/u_gether.h
index 2f7a373ed449..e7b6b51f69c1 100644
--- a/drivers/usb/gadget/function/u_gether.h
+++ b/drivers/usb/gadget/function/u_gether.h
@@ -15,17 +15,25 @@
 
 #include <linux/usb/composite.h>
 
+/**
+ * struct f_gether_opts - subset function options
+ * @func_inst: USB function instance.
+ * @net: The net_device associated with the subset function.
+ * @bound: True if the net_device is shared and pre-registered during the
+ *         legacy composite driver's bind phase (e.g., multi.c). If false,
+ *         the subset function will register the net_device during its own
+ *         bind phase.
+ * @bind_count: Tracks the number of configurations the subset function is
+ *              bound to, preventing double-registration of the @net device.
+ * @lock: Protects the data from concurrent access by configfs read/write
+ *        and create symlink/remove symlink operations.
+ * @refcnt: Reference counter for the function instance.
+ */
 struct f_gether_opts {
 	struct usb_function_instance	func_inst;
 	struct net_device		*net;
 	bool				bound;
-
-	/*
-	 * Read/write access to configfs attributes is handled by configfs.
-	 *
-	 * This is to protect the data from concurrent access by read/write
-	 * and create symlink/remove symlink.
-	 */
+	int				bind_count;
 	struct mutex			lock;
 	int				refcnt;
 };


