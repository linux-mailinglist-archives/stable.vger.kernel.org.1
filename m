Return-Path: <stable+bounces-227488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GwgF5YMvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:00:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4012D7A3A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5A631ACD29
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B6375ACB;
	Fri, 20 Mar 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKBmJvk5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6D378818
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996929; cv=none; b=k7P5v3wvJCYImGbGLY79rC0x0KBoGtCjMt1mIV18ah1exvwq5AF5R3mBgLkeMEPhMtHqZdq0f5JK09tbbNXswyrodFxKnkeCip/vsoAhx+21QmsYa/qu1tjjJgTuIBlWj1AxUZCa3IjIIgnKtxOd7wZnH2OSxO0krI8gIMl0GUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996929; c=relaxed/simple;
	bh=8Njy/qbquNmaOZrR9Dys5UbmmfgjiArh2foGQuEn5lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q2hNS+by4jFkcoDxPWpOMiqOt7PaVVf4R9WpB81YgO6oCioquQcRanvZtMdb2e4HJd8i4uSAodtajRPwWXkOVsRo4x9TXozA7P5sSWPQM1DXpQrjXPDEYbAWbARAdpVcZFQOTPCTrM8sGTi5n2ltUEvit62RbvSlDtcxUZAerMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKBmJvk5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6c364372so1849999b3a.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996927; x=1774601727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjDg7JCk+pqnl8F+5J0HenZUvt6BOdkz3K2TWkqBMpM=;
        b=MKBmJvk5GNzCypyMEmueOPKxhKiTnjtJXIn9z5QRIPMBl05LgvYuYXePwxT9l2H9H0
         RTa8/92RjsEmTFGZaGQWW2agEBWbOrLqanhA8dssCw7qF8aCece0+SgX+0diTTOqtD2O
         nwvp2Pc6htScUAZGv/h/Dg0dc3DQgirohD51zSK4/xPr/cyEbnBBd7XO/xlVD/hd/33S
         1EaxsNAe4oBhH7jTmNdrVc06cX9jURL8wHwKF2HCPuFYDvFJmCn29FIFH+PIVuGO+YCB
         ZH3vidQsbY6bjhVEyZcNvJ2N4/JQ8iIOIK4dHEpLr141NmFvqQZ3jkLvtybWf0ErKske
         WeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996927; x=1774601727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjDg7JCk+pqnl8F+5J0HenZUvt6BOdkz3K2TWkqBMpM=;
        b=sKGK05NgZFlgfxRnZi68PW7m/VIi6h/t9hF+C2BFw9G6ufGQ1rORtTGdnzQvI5a80T
         Kn7xnwT+06BaXYpTy/GZjPOpOC7YNjp6zjPdixb9WVCiR3wgQPPy4sBvNdqgc1BkaVSE
         xfRwBL0q8UuNN2guQH75sT0Bqf+J47KuZc+uJ3t4DSuiyt0PT42wT7v6Zqy2OYJBWOhE
         jjw1nuyzJkIkNakqH4I4rY6QWomyVOu/G1ZIqWKXsSKq7MYi3+sQCSFHx/ZQTSKuvxvB
         WFqUjDiSvHgZ4KnnNAT4kDrU9lrhaAxRwdzCWA/qhJigf4sapJRIboFICMDZJtQLdEAq
         t/qw==
X-Forwarded-Encrypted: i=1; AJvYcCXAUR7MmM4S6PGUoE/L5Y9Va+XRoXBcmSgawFc1Eig/Xqkv2SzdVa1ZgLoXLZvibyjoBO0j5Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Hi7T47XbfQyGSY5jcAGLHJFJaqx0OMaJlgjexIR2PhI9pQo0
	VU6HA+IcadAkgV4JT0LuhXlKh32P2T4sksUplanPiTeL+86/81dBtJ1dC3fALMTyhv04E7Rrhj4
	fryT0Fw==
X-Received: from pfbhj14.prod.google.com ([2002:a05:6a00:870e:b0:829:93d2:8904])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c9:b0:81b:1a87:9eb9
 with SMTP id d2e1a72fcca58-82a8c28c9demr1967028b3a.25.1773996927088; Fri, 20
 Mar 2026 01:55:27 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:48 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=6882;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=8Njy/qbquNmaOZrR9Dys5UbmmfgjiArh2foGQuEn5lg=; b=E8QjYOUgJgOM5Csmdy3sfsUw7fR/ax73QypTpx0yWOL5oaRfrzPbG+B6eo8WWGLrRSydEQTzD
 td56bvoO1zoAmv559X5ky+kPrJtsCsyo/FVxVwR+52mmxLE6gjgugWX
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-5-4886b578161b@google.com>
Subject: [PATCH 5/7] usb: gadget: f_eem: Fix net_device lifecycle with device_move
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
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227488-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF4012D7A3A
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

Fixes: b29002a15794 ("usb: gadget: f_eem: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_eem.c | 59 +++++++++++++++++++------------------
 drivers/usb/gadget/function/u_eem.h | 21 +++++++++----
 2 files changed, 46 insertions(+), 34 deletions(-)

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

-- 
2.53.0.959.g497ff81fa9-goog


