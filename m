Return-Path: <stable+bounces-227487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPl8GoUMvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:59:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EE2D7A23
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1EA319F62C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F330377ED6;
	Fri, 20 Mar 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DO8zXwgz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20837701B
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996928; cv=none; b=UdKVKLumi9g44Qjua3UaeXKX9ayki7uV/jXU7U/VFeillYpbPF+HgyAsavnX2eHkznHpb63EO0bambbLaUVjsA5dAcKUiwi4VxwdKi+iEq+Of4lFJq303LXDydV6uj6ss2NOpy7+8rFYyLr4UTnwmWcxaSmjO8V6x8Qt3jICx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996928; c=relaxed/simple;
	bh=4/S5YwJtiRcOJLh0doDppzz03D/F2sOSKYaUGL9+H3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p2xtz+rQGMlYpoQGH31CwpIhUf+t/wjfE61E9GnHcxbkN48a0nBYBiWOvD6eHapBlgQBOM3/VB9jr0t7WnB3Jts7ahlyQJKdJv8ZOthlg1kHmkOKvjz6Xw0SVyaZPPwm+M9cUg8LGmQuWctMu7icAt1nmpJVvX1ad+eYIJ1rOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DO8zXwgz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aeb90532f6so4787725ad.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996925; x=1774601725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsaPvT56/j6vgEjoBK8KqcyeaZ1+Z9ul5l9Dxmc51yw=;
        b=DO8zXwgzUcijAeiQhvnEnhkT7V9/i8FA2FNsVfAg4ml69wm6/rsqew8uF3QVQcOfPg
         hCCMdjxrSfT9TpRY0b1mwr0BVwt8gbw7EVAJgWqdQGKmXgy/srXuubI8VIIoexg93hLQ
         TzkVDo8Y3XmOLWnVZIlww+NQAjXct2pQ5f74SnJKW+q0H5OL+TfKoxTyh5Eut6x9GOcr
         affs677YRsWTuwQPpNW9Zy45xN+vF+A7HZPgIbweW13gxTko/iQB1IGwzNS6OKRis/8/
         fHRAia3tDgSCVeDNlrqAOIs5t5RYvEgXDNux8MbwSq27P23/Qwkxk22t0650DL0qSggz
         V9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996925; x=1774601725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsaPvT56/j6vgEjoBK8KqcyeaZ1+Z9ul5l9Dxmc51yw=;
        b=UHe2HvuCQsBP7gJxewCD2QH/xFpaLy6nooq2oQ8KTu7fZftMFFAD9YfIu7ZWuBmCIw
         njBfnsisvahi4+4+BbeEzPtkAlk99d/9t4wU9OCfQQTyO2j+rkOmpFeTT4n0ve8vvf+U
         juffQIEfiToY8qDCH9mOJNqtpGrGtg5+v73qnWbOC0KmLDhibetAOMKgliIfduA4e5Do
         5wwcFgw77CEHoDjmAg+3bANF5dSXpmVnHe9vgKZolHzxvTR89rwACWk4SdmB8aVYuKcC
         OAc/inEin7Hb+Q6MqU3CwWA9tLs5rfKXbEjf1s0c/osHIis2oI8462OxgnD1romTrSVy
         23SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9/DxpCShdYs3/UcdrAQHE928vD4TDQ9XU+5XsqMpXM1DePzQfXKqApP7HvhDfwVQAXvksu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxconc0OCQaemPD9SiBSfyG6+p2QgRws2marNDjri6epSa2CuuY
	8CIkfMaQrAMq0UYtcrWl9Wi9I856f4j2v+l6Du/iX5KhjPyucl6/LiySJpf5UD4oiON305Fm64V
	2ya9htw==
X-Received: from plbmn16.prod.google.com ([2002:a17:903:a50:b0:2ae:6338:73ca])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244b:b0:2b0:775f:febf
 with SMTP id d9443c01a7336-2b0827e31acmr20889385ad.40.1773996925176; Fri, 20
 Mar 2026 01:55:25 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:47 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=5834;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=4/S5YwJtiRcOJLh0doDppzz03D/F2sOSKYaUGL9+H3w=; b=qmPTnpqjQMKy8j+UwaraSMVPgvdseTc5/s+eFxpFZgAomZWRtVZHUH3ig5ElyIv11IydUnMcg
 VKR1Ty7OGykDUepI5vS4nxNKI44aT8xMX2ariSqNui1PX+agKppBd6R
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-4-4886b578161b@google.com>
Subject: [PATCH 4/7] usb: gadget: f_ecm: Fix net_device lifecycle with device_move
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227487-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E03EE2D7A23
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

Fixes: fee562a6450b ("usb: gadget: f_ecm: convert to new function interface with backward compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_ecm.c | 37 ++++++++++++++++++++++++-------------
 drivers/usb/gadget/function/u_ecm.h | 21 +++++++++++++++------
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index e0c02121374e..e495bac4efeb 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -681,6 +681,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_ecm_opts	*ecm_opts;
+	struct net_device	*net __free(detach_gadget) = NULL;
 	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
@@ -688,18 +689,18 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	ecm_opts = container_of(f->fi, struct f_ecm_opts, func_inst);
 
-	mutex_lock(&ecm_opts->lock);
-
-	gether_set_gadget(ecm_opts->net, cdev->gadget);
-
-	if (!ecm_opts->bound) {
-		status = gether_register_netdev(ecm_opts->net);
-		ecm_opts->bound = true;
-	}
-
-	mutex_unlock(&ecm_opts->lock);
-	if (status)
-		return status;
+	scoped_guard(mutex, &ecm_opts->lock)
+		if (ecm_opts->bind_count == 0 && !ecm_opts->bound) {
+			if (!device_is_registered(&ecm_opts->net->dev)) {
+				gether_set_gadget(ecm_opts->net, cdev->gadget);
+				status = gether_register_netdev(ecm_opts->net);
+			} else
+				status = gether_attach_gadget(ecm_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = ecm_opts->net;
+		}
 
 	ecm_string_defs[1].s = ecm->ethaddr;
 
@@ -790,6 +791,9 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	ecm->notify_req = no_free_ptr(request);
 
+	ecm_opts->bind_count++;
+	retain_and_null_ptr(net);
+
 	DBG(cdev, "CDC Ethernet: IN/%s OUT/%s NOTIFY/%s\n",
 			ecm->port.in_ep->name, ecm->port.out_ep->name,
 			ecm->notify->name);
@@ -836,7 +840,7 @@ static void ecm_free_inst(struct usb_function_instance *f)
 	struct f_ecm_opts *opts;
 
 	opts = container_of(f, struct f_ecm_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
@@ -906,9 +910,12 @@ static void ecm_free(struct usb_function *f)
 static void ecm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_ecm		*ecm = func_to_ecm(f);
+	struct f_ecm_opts	*ecm_opts;
 
 	DBG(c->cdev, "ecm unbind\n");
 
+	ecm_opts = container_of(f->fi, struct f_ecm_opts, func_inst);
+
 	usb_free_all_descriptors(f);
 
 	if (atomic_read(&ecm->notify_count)) {
@@ -918,6 +925,10 @@ static void ecm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	kfree(ecm->notify_req->buf);
 	usb_ep_free_request(ecm->notify, ecm->notify_req);
+
+	ecm_opts->bind_count--;
+	if (ecm_opts->bind_count == 0 && !ecm_opts->bound)
+		gether_detach_gadget(ecm_opts->net);
 }
 
 static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_ecm.h b/drivers/usb/gadget/function/u_ecm.h
index 77cfb89932be..7f666b9dea02 100644
--- a/drivers/usb/gadget/function/u_ecm.h
+++ b/drivers/usb/gadget/function/u_ecm.h
@@ -15,17 +15,26 @@
 
 #include <linux/usb/composite.h>
 
+/**
+ * struct f_ecm_opts - ECM function options
+ * @func_inst: USB function instance.
+ * @net: The net_device associated with the ECM function.
+ * @bound: True if the net_device is shared and pre-registered during the
+ *         legacy composite driver's bind phase (e.g., multi.c). If false,
+ *         the ECM function will register the net_device during its own
+ *         bind phase.
+ * @bind_count: Tracks the number of configurations the ECM function is
+ *              bound to, preventing double-registration of the @net device.
+ * @lock: Protects the data from concurrent access by configfs read/write
+ *        and create symlink/remove symlink operations.
+ * @refcnt: Reference counter for the function instance.
+ */
 struct f_ecm_opts {
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


