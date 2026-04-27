Return-Path: <stable+bounces-241417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMsSMMaZ72npDAEAu9opvQ
	(envelope-from <stable+bounces-241417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:15:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876F476F0D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BD5301A7FD
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A33E3153;
	Mon, 27 Apr 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cjL8LXDD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA703E2776
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310144; cv=none; b=VFMKfRY77b/xsWPIbSs/9HHfrDHkEVKoI5NuXnp0dH1hBvZx0ST4D36lBP/JMj36UPdT6DpTjqvyhqX0Wz0tdVxP1+AeyK5ACnHosSoghotDVPOHmmWsq1csM/keETNhtAg58ETSMxY7OhovGzsk+z8cPU+gloEt+xHVr5sgJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310144; c=relaxed/simple;
	bh=j94Sp88wr64RGPjPbs3uAClOhnCjPRRZ99ojrTz95p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRELfxfh/UTo94cNPm8JN1P8Xi6bIMS5LOADRySwajTdni7e5zwzJ8z09NHO8IPDeND+ZGr9beaxITu/Q9jTwHA0MuVqAF4i3UEIXrykbPJ/qxIXBbdq7PnUNIbcB4IeK1QD2prJvmIYD4nGr/N/6TxpYVx5309hMZlxV8unfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cjL8LXDD; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c637089ccso1277651c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777310141; x=1777914941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DWQJyz5+CC9eucJLahLMGXJL/P0B4vhuS9EqNEho/s=;
        b=cjL8LXDDzCqu1GE7mrGBkB4tRUsK55W/8Qvr8BZ+KF80t3vTcxxYIuRDuktZsMFj24
         P+vpjrsdjhZXgYZLgdgOMHgychAjh0tIy01Fe/oaNEMrxyWAS0vydttpFpi7qWCEvBmp
         O5U74XRxY5EwsC3Gy1UlhTmIQDB4khm19UIbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777310141; x=1777914941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DWQJyz5+CC9eucJLahLMGXJL/P0B4vhuS9EqNEho/s=;
        b=VY9hSHHZ1gfiJY01YmBriGHQgOYMd9TyhrhYmjue8B3Gs62BWuFRdX3Q1iFbsaDe24
         +0Icsf9KfGuCgD33hC+MNCf9ersUAGigHczQXhD88zwicSoO1RhUaBbpWPb9TaT1bk06
         fTQG7ThypRQUuF75cSJ9QRcTYB7JZpreXmrL92Yxs402Rnk1XeZtWJgQZzhowsImNV6E
         b7MdhPScpFbYdDFZiIukzbYGIzeJyVHJDgjL70feJoYShc4CyJUSZpsIOoizzUzZcVLP
         1VHp8dw3f/IuglwpPTaqeTL5Mawb4gvSd+g4G/0kikEoA2g0i4sIh56j3oropW2/GDlq
         Q+PQ==
X-Gm-Message-State: AOJu0YwCW0hCw1vTVyZbfLS3R5WkfnAAjuYkAbIMUZR8TRnRbzs6eCrr
	E9UjlS0kdtXFytgfS44FV/jBYOHdZRycwMXjWgXy6BQBKV6SYbTDZrQgiwKIHx/i/AGQXuisvcR
	8sNg=
X-Gm-Gg: AeBDievy98SMfWzFBa4ao05tZUE1raizzoM04ibPl3q5Q+JhIbVhnJnyBbGn0NZyJxp
	BWK74ELZl9aFyCtdOtQ8GnJNlOGWagPeu1U7cXYxtxty2OykHPvlIZ1lDnyTnZM49ZYHYKTVR7Z
	ETle4JAk+KhrAmhIebZKr2jnfJg4kXsH9DLt4kDWxIpgDgL2Srod/6nO5C6aWyUat3egaifg1Fz
	9pwmfHFJ4g/qvG/USUMfZ/UOsoH20hI6ZoObxLzMy9IdCKKRZ8oG7XSceci59JzksYntn+IMpfU
	XdRvG+Ec6m1bWx+K8mXO61BtWwYpFLmrTmRXvuvUCio5bXZ7rnOuVjH63uD2YdS53HusjMDTkF2
	yEWPSjG/uVcFbHUS85OQrRvb8oh0TPKpQBt8FWx2u1qoi5QDOOFCppComVfy+1YRb9C5imgBKwp
	2sr+eAWfzf4nAhGeL9jmTpNwE8UZ0nhwneGsH/rFNk4EoLCIB368Ccal4LrvoLoJ+Aszzth6DuZ
	cMDlbVZFOX40XGNFY3row==
X-Received: by 2002:a05:7022:382:b0:11a:4016:44a5 with SMTP id a92af1059eb24-12ddd54abadmr76264c88.24.1777310141401;
        Mon, 27 Apr 2026 10:15:41 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbe78e12fsm24622271c88.15.2026.04.27.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:15:40 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5.10.y] driver core: Don't let a device probe until it's ready
Date: Mon, 27 Apr 2026 10:15:33 -0700
Message-ID: <20260427171533.495665-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042758-bloated-spinning-0df5@gregkh>
References: <2026042758-bloated-spinning-0df5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6876F476F0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim,chromium.org:mid,samsung.com:email,harvard.edu:email]

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
 drivers/base/dd.c      | 12 ++++++++++++
 include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e162c0c49787..149882009eb5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3008,6 +3008,21 @@ int device_add(struct device *dev)
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
 	if (parent)
 		klist_add_tail(&dev->p->knode_parent,
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1e8318acf621..0398f2c985b3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -738,6 +738,18 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENODEV;
 
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
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 047a8f1ef8f2..ff7cae0431ab 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -385,6 +385,21 @@ struct dev_links_info {
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
@@ -470,6 +485,7 @@ struct dev_links_info {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -580,8 +596,36 @@ struct device {
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


