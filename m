Return-Path: <stable+bounces-241414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bx8IaiX72mLDAEAu9opvQ
	(envelope-from <stable+bounces-241414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:06:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C0476D65
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38CA3060C80
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C2374E5C;
	Mon, 27 Apr 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJ5fqQx1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC753112AB
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309316; cv=none; b=kTq4lafItipKn8EAkhizl9h99FAIbrNgfdKH/9N29QMHoBRwOUEeaybsYQm581OqaJiYiC04yKxV3TSvc066G+lz8nGjEti2F8xhoe39CuApyqI0225puEw5U+5N0u/GX6VxIeZXvN9FzoFxssnD8L7fAWi7fQ/a6ihxgaUl+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309316; c=relaxed/simple;
	bh=XMLHwem3OhnOh14PxXQnAshflKk5lWw7Wt/jnfG6Z9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFTrzBW9ViQExEIHJ2SzAp441DWivVHEeLo1HQeFQFEKQmc1+uKYpmGSZllzflrZ/wbQnTaKYS7XfrUl5wVeV1dOKkWkx0vHz5UUfVDBeJevMb7F/FlxnfNWKP7/lsfjr08h1zTuA0jv+hiDptZP2ITteUPDb/babkNJXxPys4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJ5fqQx1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2e221a71e19so10161201eec.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777309313; x=1777914113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaIkPN4AkUZEgMhAkntC/7LxJFbB7uDIzvc/cZttwzc=;
        b=KJ5fqQx1NLYPYfbNq/wsFIJxH3BYHHXIABD2375DfyeRJYGD/F59p3bRC2VNJ9yY/t
         a+7JdxtBiejew5D6PewM4/jlWeWSlxdOwEEXlr3se+/0/D6HK0jqyX5JeFtN7iIAfwLk
         R2bAltD5ApZ/Nwr8EFv1XQS1hQT/NQwK76ur8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309313; x=1777914113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaIkPN4AkUZEgMhAkntC/7LxJFbB7uDIzvc/cZttwzc=;
        b=gAGVNozTZYe7V/n7QcPdXo5u0BAVKPScxqT0l8oez+U4rGknjmyF2/MtgJHdCzC+BB
         T0i4fUy3/Zp0LhFu9QOr8Ailox0T5GPD0sc57NB5TmyONUP033BwLoXRJDWFnfdeUcUL
         6h6PmpeKKHQEY5oBV+02Ec8Dv0mjP/g14cgV122Qr6/kDILGXC7yJ2Rf6XarftXXvDKu
         nLpu6NixoeOqC35KCEAehWDBC3oB4vtrR9Oy2519mdsj5gEgm2NphnMZg7tmyeTvzPZw
         rAhu3RIJL+hfKEPh0TCFBxQsUGpF0PhwoYfhdkeLWCVUJbDLPi2Z0ygvmaT7eekLsU4T
         27Vg==
X-Gm-Message-State: AOJu0Yy0l/eGiSoGH4QlImLqDZCmYWNHpfJBm+L7HY5o8bfm5E2471Jx
	L+R30MgeSVFlCu99KlsD2laPyeAnI7xD1yVYM2TSdcbFpSEii0lD+131+OSCu2NLFysc3YOIudT
	a8Jg=
X-Gm-Gg: AeBDieulqCLSIsNNyQZfRuJfltNgE+u2PHd9/EeCorcbajXRoCMctsxdN/ROgm+Z/UN
	XJlLVWRk2UlOmLs8/3dx6PF0Zl3LhazdLFoEIfX2XKC2mcDhcci25X9QoWw7dhu38N/LR5OpKO6
	Kpr106RGzTPiY5ZrJEcU9k9S1UAs9LnDJaq+8lu29X2bPbXPviKv5scMxMNZw4nK8b5HtVxCtLE
	/v4gKs0l91R0wsBLs994sYx6pRgT9Qw3DbzxeKJJ+8vYF2rMNTKi0Jg4YA/x5lrThB97VQ18doo
	Nq/yteqFpfjFPqZTwvPe176zQALLba0aUDh7R/+r3rwJ+mVeE7HHW9UFMH/G7Zpqlh9rnoKuYSu
	EtHqtJ+UEOiqyZk7qdsUBFS2Thu1pP3gFU7jvlWcVJ2hUMnt2z+yG3I6xpldL5+UmhVUe7jfN22
	1HZpSYX27KYIGDks1halgChD1dCpmQ7gv42uSP8R9ey0tVlQCy4tgOTPLr325IGTSuKk8EVBE+a
	v5fb3YNnow8pq1JkWBeWg==
X-Received: by 2002:a05:7301:1e8c:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-2e46c48a953mr23521814eec.10.1777309310879;
        Mon, 27 Apr 2026 10:01:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm43623141eec.2.2026.04.27.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:01:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5.15.y] driver core: Don't let a device probe until it's ready
Date: Mon, 27 Apr 2026 10:01:34 -0700
Message-ID: <20260427170134.468158-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042757-heave-drainage-0380@gregkh>
References: <2026042757-heave-drainage-0380@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D45C0476D65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241414-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harvard.edu:email,msgid.link:url,android.com:url,chromium.org:email,chromium.org:dkim,chromium.org:mid,samsung.com:email,linuxfoundation.org:email]

The moment we link a "struct device" into the list of devices for the
bus, it's possible probe can happen. This is because another thread
can load the driver at any time and that can cause the device to
probe. This has been seen in practice with a stack crawl that looks
like this [1]:

  really_probe()
  __driver_probe_device()
  driver_probe_device()
  __driver_attach()
  bus_for_each_dev()
  driver_attach()
  bus_add_driver()
  driver_register()
  __platform_driver_register()
  init_module() [some module]
  do_one_initcall()
  do_init_module()
  load_module()
  __arm64_sys_finit_module()
  invoke_syscall()

As a result of the above, it was seen that device_links_driver_bound()
could be called for the device before "dev->fwnode->dev" was
assigned. This prevented __fw_devlink_pickup_dangling_consumers() from
being called which meant that other devices waiting on our driver's
sub-nodes were stuck deferring forever.

It's believed that this problem is showing up suddenly for two
reasons:
1. Android has recently (last ~1 year) implemented an optimization to
   the order it loads modules [2]. When devices opt-in to this faster
   loading, modules are loaded one-after-the-other very quickly. This
   is unlike how other distributions do it. The reproduction of this
   problem has only been seen on devices that opt-in to Android's
   "parallel module loading".
2. Android devices typically opt-in to fw_devlink, and the most
   noticeable issue is the NULL "dev->fwnode->dev" in
   device_links_driver_bound(). fw_devlink is somewhat new code and
   also not in use by all Linux devices.

Even though the specific symptom where "dev->fwnode->dev" wasn't
assigned could be fixed by moving that assignment higher in
device_add(), other parts of device_add() (like the call to
device_pm_add()) are also important to run before probe. Only moving
the "dev->fwnode->dev" assignment would likely fix the current
symptoms but lead to difficult-to-debug problems in the future.

Fix the problem by preventing probe until device_add() has run far
enough that the device is ready to probe. If somehow we end up trying
to probe before we're allowed, __driver_probe_device() will return
-EPROBE_DEFER which will make certain the device is noticed.

In the race condition that was seen with Android's faster module
loading, we will temporarily add the device to the deferred list and
then take it off immediately when device_add() probes the device.

Instead of adding another flag to the bitfields already in "struct
device", instead add a new "flags" field and use that. This allows us
to freely change the bit from different thread without worrying about
corrupting nearby bits (and means threads changing other bit won't
corrupt us).

[1] Captured on a machine running a downstream 6.6 kernel
[2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel

Cc: stable@vger.kernel.org
Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260406162231.v5.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
(cherry picked from commit a2225b6e834a838ae3c93709760edc0a169eb2f2)
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/base/core.c    | 15 ++++++++++++++
 drivers/base/dd.c      | 20 +++++++++++++++++++
 include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4fc62624a95e..dde0f54bba0c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3409,6 +3409,21 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The moment the device was linked into the bus's "klist_devices" in
+	 * bus_add_device() then it's possible that probe could have been
+	 * attempted in a different thread via userspace loading a driver
+	 * matching the device. "ready_to_probe" being unset would have
+	 * blocked those attempts. Now that all of the above initialization has
+	 * happened, unblock probe. If probe happens through another thread
+	 * after this point but before bus_probe_device() runs then it's fine.
+	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
+	 * will notice (under device_lock) that the device is already bound.
+	 */
+	device_lock(dev);
+	dev_set_ready_to_probe(dev);
+	device_unlock(dev);
+
 	bus_probe_device(dev);
 
 	/*
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0bd166ad6f13..daa5ef3f38e9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -740,6 +740,26 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 	if (dev->driver)
 		return -EBUSY;
 
+	/*
+	 * In device_add(), the "struct device" gets linked into the subsystem's
+	 * list of devices and broadcast to userspace (via uevent) before we're
+	 * quite ready to probe. Those open pathways to driver probe before
+	 * we've finished enough of device_add() to reliably support probe.
+	 * Detect this and tell other pathways to try again later. device_add()
+	 * itself will also try to probe immediately after setting
+	 * "ready_to_probe".
+	 */
+	if (!dev_ready_to_probe(dev))
+		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n");
+
+	/*
+	 * Set can_match = true after calling dev_ready_to_probe(), so
+	 * driver_deferred_probe_add() won't actually add the device to the
+	 * deferred probe list when dev_ready_to_probe() returns false.
+	 *
+	 * When dev_ready_to_probe() returns false, it means that device_add()
+	 * will do another probe() attempt for us.
+	 */
 	dev->can_match = true;
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
diff --git a/include/linux/device.h b/include/linux/device.h
index 89864b918546..58211946b132 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -372,6 +372,21 @@ struct dev_links_info {
 	enum dl_dev_state status;
 };
 
+/**
+ * enum struct_device_flags - Flags in struct device
+ *
+ * Each flag should have a set of accessor functions created via
+ * __create_dev_flag_accessors() for each access.
+ *
+ * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
+ *		initialization that probe could be called.
+ */
+enum struct_device_flags {
+	DEV_FLAG_READY_TO_PROBE = 0,
+
+	DEV_FLAG_COUNT
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -462,6 +477,7 @@ struct dev_links_info {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -576,8 +592,36 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+
+	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
+#define __create_dev_flag_accessors(accessor_name, flag_name) \
+static inline bool dev_##accessor_name(const struct device *dev) \
+{ \
+	return test_bit(flag_name, dev->flags); \
+} \
+static inline void dev_set_##accessor_name(struct device *dev) \
+{ \
+	set_bit(flag_name, dev->flags); \
+} \
+static inline void dev_clear_##accessor_name(struct device *dev) \
+{ \
+	clear_bit(flag_name, dev->flags); \
+} \
+static inline void dev_assign_##accessor_name(struct device *dev, bool value) \
+{ \
+	assign_bit(flag_name, dev->flags, value); \
+} \
+static inline bool dev_test_and_set_##accessor_name(struct device *dev) \
+{ \
+	return test_and_set_bit(flag_name, dev->flags); \
+}
+
+__create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
+
+#undef __create_dev_flag_accessors
+
 /**
  * struct device_link - Device link representation.
  * @supplier: The device on the supplier end of the link.
-- 
2.54.0.545.g6539524ca2-goog


