Return-Path: <stable+bounces-227489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hn9JqULvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:56:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0E2D792B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E86830186A9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E383793A9;
	Fri, 20 Mar 2026 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMNDPWHv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D0378D65
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996933; cv=none; b=JlO21Fsb+bZfgt2yBNOLTJ5KgJNSQZVJpRJ+DdQHoUMyTiN9L1QqbVluYIBiUtDRQioVJs8fJ6ZcNHprutW88tegnUoplQdxUbfdBb/S2ri2+AKw+7CPr7U3NHJoDdcctbbpWQLXAYrEcxJfZHszWyHe9dB2LOWeIP9RwRQarxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996933; c=relaxed/simple;
	bh=cPeN1vUKjquyCNuYv+KhJlm53tGodtnOjIR6zLwHcWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2pa8hEspU+E1EJ7UV3KXQD/CcEtWHu3rINXZ62FK1UnFsKg7qkAubmbDQ6kKb4l3IUHCiMjpukgePhDogOigTpytu9bn4AU0qohoI+un6FTqKysxd7mIn40rByInTO4sUldZVtPRZPgy6Hm7XNOzNKikGsvwIItag8PJqiS3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMNDPWHv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b04293b16cso24055365ad.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996931; x=1774601731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+r6IZRTjAuqtqKkL9NYRrlxIcvlXL5N8kxFoBUFnCk=;
        b=oMNDPWHv7S6s+UsYL+wxhHq2mcRvWFfNp9QznXXvn49FopPvS7QiDGAflRx735afPt
         89bTM/55pyBlQQntLfoZAvY7pQ6j/yZ5RjPdIPGK1CqReBIrM6yrOapNem4fvNfd8fH8
         UxzPF9yBls9iR5YtHazkPjrV0XOu9Y/woG0Rrx1UKjBLKc6dkyx+grze8XAeJw+7/cjx
         PsATQDUAX6/FKUILgTrUhRb019dCx6xIKMZybnRr5/ggNifVfM9jB3bNLxbYFLjeGoUY
         0ln46ii8pGzypM1Q1sdnHbv2xSEm01UdV6mUGMQXorkTd9os/prge5lw5FEyuC/L2EYE
         LobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996931; x=1774601731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+r6IZRTjAuqtqKkL9NYRrlxIcvlXL5N8kxFoBUFnCk=;
        b=GRtrUunqMVqZ6ffT1k1MYPnd9S4LeinK4hic+IyOt+4MK7jew4z2eRsZV1GmxSD11q
         BbOqvuU3/UjHf8zpAeeMnldBSs31jFKBNszR2696A6lQQwlMbFhtd1/AmB56pwjX7VgN
         yFU2i19rGffiLKAyDsx8pld+/ZxWwogw29Wbq1Ow/aVFIAfP8z8mKlIYhda1KXQf7h0Z
         KwBLNnfqhp/Nay7+//y73IUAqtmv7JD9XiQ4PDAV/P+MQJbbFVC0HSCvxYo+72+EbRam
         e/aX73rmGyrRDrYRCgfuQOUwxHSOhuQohycRnr6evMKi6IuiQHhumthrJt9kOk8hUxPC
         tm7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGmbWHhpbOTLzNHPYBorz2kTi8g69CjDGxmmGWu+r2iIRR8QGpJXoBMwWvuSWjJA2r/UzhAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbtPgYs1tJMojcvOMxCXRgRYujRgyDec1p24Ii5r1zJ19u151
	lDhqM2g5W7VY1nz3swVqIHNWyIrDYpY9GWZFT3B9zM4KQ7PMp+zMS1L4DqzEu1LCJ4oSspSCmIS
	vVydA6w==
X-Received: from pliy14.prod.google.com ([2002:a17:903:3d0e:b0:2ae:5344:9e72])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:2ae:b9cd:d2df
 with SMTP id d9443c01a7336-2b0827a797amr23492035ad.34.1773996931063; Fri, 20
 Mar 2026 01:55:31 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:50 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=7379;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=cPeN1vUKjquyCNuYv+KhJlm53tGodtnOjIR6zLwHcWM=; b=RIX8Pw9NlPIBE4VKtmrY5ajDc9rdW4WzWxkwZJbeAJQUk/Q/hGXLBiEZYwMBcLMkOUDsbThHR
 dypca3ELtsHBW/YW1Om4xFxztBIxL97VBNgCaMme5HNH74THPYA6vvQ
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-7-4886b578161b@google.com>
Subject: [PATCH 7/7] usb: gadget: f_rndis: Fix net_device lifecycle with device_move
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227489-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 62B0E2D792B
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
the borrowed_net flag is used to indicate whether the network device is
shared and pre-registered during the legacy driver's bind phase.

Fixes: f466c6353819 ("usb: gadget: f_rndis: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_rndis.c | 42 +++++++++++++++++++++--------------
 drivers/usb/gadget/function/u_rndis.h | 31 +++++++++++++++++++-------
 2 files changed, 48 insertions(+), 25 deletions(-)

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

-- 
2.53.0.959.g497ff81fa9-goog


