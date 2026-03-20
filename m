Return-Path: <stable+bounces-227490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iz7C9IMvWkS6QIAu9opvQ
	(envelope-from <stable+bounces-227490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09FC2D7A7C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A6031D11D8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7A377EC0;
	Fri, 20 Mar 2026 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEVhC4aw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF6378D8D
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996933; cv=none; b=r1wiueDF2bOls5mrhLa+s21sOYop4MQE5Igujvy8fKaO9XT3HWFRD5WxTM59YQfFfqX16o/1bKwKEuxeWfLAS5/TE0JXf2GUeSoBnLvCF2U2UbG4mECLXDigmsywFtY8tA79zaMFp5IxeYTMu5cR11PboHRzEhdBH/O9EcL+cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996933; c=relaxed/simple;
	bh=WVxp0ZIk0xYVRKf3pptNJWqovoLfJ9UKaReWVwYXoRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iFIGULv7D+VZeax051QABjHdwZaxeYw9C/UOZFsuPXylBu4YfM1koHSOEt3/kFPL8GUN9IViI3gV1HZeRRSEdjM7VPhAlE9KVAcoyh5l/F8XSm5PUiRh9m1/stXK3yGuZ1Vfjcly1W/TJPKxCWD11jTrAjHY+xIKMF+X5dVUuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEVhC4aw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so1830604a91.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996929; x=1774601729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3atbIaOInnERa/VoAz+UbgXjD5q1aDENcAUOzWrVcA=;
        b=bEVhC4awlShF1WmqjoI6zSEJSx2dXkmLUCt+YJmASCgduC4kLe2sBcqW9zcqiiwkfZ
         MCSzwC9ngh+/LPsMBlfnxX+3g/F/ZHooL43I06cR4gnt3a0EHHFRtrq3rtHVNF6+7l76
         LcWsFhGQNYBNpw7ij3oX7eczi13QaD1edVdU1wKIRvMq2bbm5UrwS278vvBbHSNjJVWE
         tYHfHBzQeZ77vAUl7YuZbYFAFUGK43KcDvDtptHTycHs4TN1IFsYNwW7XPHDTeO/nlZ2
         /vHfM7/hXiphn8cgMr5Rgok0Xfcui5ekuBzKvO/IxTJ/1v8nVQj0buXZrbu167FY9htp
         zCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996929; x=1774601729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3atbIaOInnERa/VoAz+UbgXjD5q1aDENcAUOzWrVcA=;
        b=GkNhTMqE2g0U+uhGVkK7tXFNUKILmb1SJCWD15cYw24Y34ninBZMDajHpRv9Xy/9gr
         eQyEpc+TirmfuQeyqV1//BpBq6QIgncWA7x2MrNLGITkgjQf6epVn+wzuimGtL+9TZ1d
         mzulDCP/JFh87MBtgDjYofLF9fBOWiMXZjqlPS5jCsbNxDvSw/vYklfdmMLtVffo03wX
         n7hZGOSbuGcUUg8OQ+TN83OLdkodxVVNSeFeRkr/lgNKWdcGjoxmDjCgqEBPkmJj0zjk
         /fWPPguT7PdNUa52xBznzHxBC06ulW1qr+5jestT03+mNBz5b6M9dm26u4ZQ3ApGj8SC
         atcA==
X-Forwarded-Encrypted: i=1; AJvYcCWA+9WyhqvGf1655xMWKTh/btGjKMOBE0uPKUk8SuhXT1lHSHHwN/o1QI0hcHoCBxcJ/DNOKvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj1vhHkbymv9763y3dnt2oZlK8MKnFfszQoIi6941FajDFobY
	V6ZigBMGJAjt5nyMwnu1qXXqpAD8IlmkcA5uRj5B4BDLeiQrMN2pKrZ9SngBcWUzEM89YuoqYWY
	0vO2v1g==
X-Received: from pjzg1.prod.google.com ([2002:a17:90a:e581:b0:359:fee7:eac2])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dcb:b0:34c:c514:ee1f
 with SMTP id 98e67ed59e1d1-35bd2bf4d56mr1966801a91.11.1773996929139; Fri, 20
 Mar 2026 01:55:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:49 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=6962;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=WVxp0ZIk0xYVRKf3pptNJWqovoLfJ9UKaReWVwYXoRI=; b=Gm9M57ASM4csFeNKTWED3B6hzlFROTR2MCxjFTnBBaRH7Cim2LsP4p6D8c4rZ8WLy7LIwR+EE
 QivIVHCuroPC8xdZHIGQRZnxB0eHFuqYdqbYpX0HkExsR5UpbnzzPNI
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-6-4886b578161b@google.com>
Subject: [PATCH 6/7] usb: gadget: f_subset: Fix net_device lifecycle with device_move
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Felipe Balbi <balbi@kernel.org>, David Lechner <david@lechnology.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227490-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.vger.kernel.org:query timed out,khtsai.google.com:query timed out];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D09FC2D7A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/usb/gadget/function/f_subset.c | 57 +++++++++++++++++-----------------
 drivers/usb/gadget/function/u_gether.h | 22 ++++++++-----
 2 files changed, 44 insertions(+), 35 deletions(-)

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

-- 
2.53.0.959.g497ff81fa9-goog


