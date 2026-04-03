Return-Path: <stable+bounces-233128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN4zO4gPz2lysgYAu9opvQ
	(envelope-from <stable+bounces-233128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:53:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BBC38FB70
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3C13058E0C
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202725DB12;
	Fri,  3 Apr 2026 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pz9c4HMB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709724A078
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177505; cv=none; b=RrSb8+vhV9GyB7FRNnkkCDCvVvx8ntgkzQ603kcyzan9r0sDF/W+cZhUYpiMBdeRpLTW80P4o4damkP00Iu0U4HSBabGTEfi8XORvPC6lpJvYaM5fV5v+cq79TZ/RfhcAei8/9CdDu47RE9iSAYfL8OHyI2op9e9O7UlehRDY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177505; c=relaxed/simple;
	bh=KnJo6R0iyyoFy+tL/8ZQZh458HxfnzrOB+hwzmicJNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzjuqL8BO3ivI9GWBxJfGND7ZliyT1CpCH8CVZaw25DIwoQavV3Y1KyyT2vRnnu7kj166QHCCIM4ZfbLZyTyYWMawDVzYFX3OnLm2OsRRO4AX6MCun2eTbspoVDzuvGOyISXE3xz0gGajAb+1xb05opTDwdFEb3DoXEP340wuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pz9c4HMB; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12776bebe9fso3556437c88.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 17:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177499; x=1775782299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSIiwaCtYR5157C3DMqOicVwO2x1esOFHTqM3gbjMuc=;
        b=Pz9c4HMBtkVaD/KsFdLKohY7pQSJXDN+zD6U5N09UXf5m/tXWlnF4wyrwt2yj3nXtW
         xK5MV/SwK7A/yMk3GKTUlECvv7hWI4E6AHr0bhfaTI2WQL7o93M7b0oROXTY2Wl6b+ut
         c2GVxDgDe2yZb7Ro/610JlPjiUz5Zx0Untemo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177499; x=1775782299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSIiwaCtYR5157C3DMqOicVwO2x1esOFHTqM3gbjMuc=;
        b=fhYCpq2SeZXUSZ0cA+bjEHp+Dzs4QEomKokg1Jr6w0E0vyEnEfOAgrkNWdmJnV4iBf
         RaNUk0PQOvoHzmGqmWLaLPm3ICEezOJIurp8uFJeir1NEV4hJWPf5cFxNJrnjEDYJrF+
         ZRDNAUWv3DUuS3TrW09R6/oD3MpCwpEo8sXYdJnK2U/3ni3LPBWey1IKwNTwZ6xU9eGU
         Gcui2FpBJc8Ynp6LNYtFLkXESIJWrrj6jmA8uMqto2wxgEN7VXxXUnkgLfMECSNMnrjV
         V+kkkh1mzuDwI0L4UrtfKiLpli1OudAWwtS+olKCw8Vmsh21da/rR1C6mCSntJhwoa3h
         XmOw==
X-Forwarded-Encrypted: i=1; AJvYcCXpxedRyozcb1EkzDQO8j1ZDZZ+uGr3lwh6O9D/CNgN2phTCwRh7lhtcFDAMDfXhMdR/UXUlH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQi3wQlwAQIIXlluTbDykDy6sCma6QHpVdiJIgYNFxeJ9CaY3s
	NvCddb5uuJ9cHw+UCNs7IQ7c9OuOfflicmGIhPamXwdGdLctVXxW/qfjaQRlVkdIiA==
X-Gm-Gg: ATEYQzwoyRlBYxIDGwmV7bAk2hRu7vpO9Gyz32+sfPCqNLKZLJh/vsMeX5xUNqcLPDP
	rfghzrT0ehxiDAmfZ+0ycMLnAAo1nEG3TAF0+blbYQjFyjwM7NuYefcU+ExTYsAzI7nY7uAY/kh
	e/7qGgm5WvtRSM0bPB7on7iui33A+YrEzkSKpMa3ordSFNdtpTEjUBbe7p0AwILEhEmODjcAd4R
	E8D15DIs/CWfUVP3WkGljbnliNjtxb9Qjmmea71ysVAqc74J5/jVgP4ygMG1er1o9jKJo5SrZla
	GbFl6/q6FAxmkt4DQO+PoXq1Bdi1F4jbxu38jFQh+cWmX7brYvZaPiNa94P3c9nOHFvbAjPz5jG
	2p9LwPIq2KJfCdjlotVqIxnXtA4E4Xdkmfk+G2rsIhyz9mkFdN38FkxKe84K/j2qq8tRCNSlula
	91+UdQfy9FIsBG4XLyMKiBI4WLW8rmozPuMnynSY0SkIngdJbJiJWvKkQz8MKeq8496Xe7FPziO
	eEtHPFtJd0=
X-Received: by 2002:a05:7022:401:b0:12a:b932:81d2 with SMTP id a92af1059eb24-12bfb745cecmr660075c88.21.1775177498569;
        Thu, 02 Apr 2026 17:51:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:36 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] driver core: Don't let a device probe until it's ready
Date: Thu,  2 Apr 2026 17:49:47 -0700
Message-ID: <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233128-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harvard.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,android.com:url]
X-Rspamd-Queue-Id: 51BBC38FB70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
to freely change the bit from different thread without holding the
device lock and without worrying about corrupting nearby bits.

[1] Captured on a machine running a downstream 6.6 kernel
[2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel

Cc: stable@vger.kernel.org
Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1: https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid
v2: https://lore.kernel.org/r/20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid

As of v2 this feels like a very safe change. It doesn't change the
ordering of any steps of probe and it _just_ prevents the early probe
from happening.

I ran tests where I turned the printout "Device not ready_to_probe" on
and I could see the printout happening, evidence of the race occurring
from other printouts, and things successfully being resolved.

I kept Alan and Rafael's Reviewed-by tags in v3 even though I changed
the implementation to use "flags" as per Danilo's request. This didn't
seem like a major enough change to remove tags, but please shout if
you'd like your tag removed.

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

 drivers/base/core.c    | 13 +++++++++++++
 drivers/base/dd.c      | 12 ++++++++++++
 include/linux/device.h | 15 +++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 09b98f02f559..8d4028a2165f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The moment the device was linked into the bus's "klist_devices" in
+	 * bus_add_device() then it's possible that probe could have been
+	 * attempted in a different thread via userspace loading a driver
+	 * matching the device. "DEV_FLAG_READY_TO_PROBE" being unset would have
+	 * blocked those attempts. Now that all of the above initialization has
+	 * happened, unblock probe. If probe happens through another thread
+	 * after this point but before bus_probe_device() runs then it's fine.
+	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
+	 * will notice (under device_lock) that the device is already bound.
+	 */
+	set_bit(DEV_FLAG_READY_TO_PROBE, &dev->flags);
+
 	bus_probe_device(dev);
 
 	/*
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 37c7e54e0e4c..3aead51173f8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -848,6 +848,18 @@ static int __driver_probe_device(const struct device_driver *drv, struct device
 	if (dev->driver)
 		return -EBUSY;
 
+	/*
+	 * In device_add(), the "struct device" gets linked into the subsystem's
+	 * list of devices and broadcast to userspace (via uevent) before we're
+	 * quite ready to probe. Those open pathways to driver probe before
+	 * we've finished enough of device_add() to reliably support probe.
+	 * Detect this and tell other pathways to try again later. device_add()
+	 * itself will also try to probe immediately after setting
+	 * "DEV_FLAG_READY_TO_PROBE".
+	 */
+	if (!test_bit(DEV_FLAG_READY_TO_PROBE, &dev->flags))
+		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n");
+
 	dev->can_match = true;
 	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
 		drv->bus->name, __func__, drv->name);
diff --git a/include/linux/device.h b/include/linux/device.h
index e65d564f01cd..5b7ace5921aa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -458,6 +458,18 @@ struct device_physical_location {
 	bool lid;
 };
 
+/**
+ * enum struct_device_flags - Flags in struct device
+ *
+ * Should be accessed with thread-safe bitops.
+ *
+ * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
+ *		initialization that probe could be called.
+ */
+enum struct_device_flags {
+	DEV_FLAG_READY_TO_PROBE,
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -553,6 +565,7 @@ struct device_physical_location {
  * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  * @dma_iommu: Device is using default IOMMU implementation for DMA and
  *		doesn't rely on dma_ops structure.
+ * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -675,6 +688,8 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
 #endif
+
+	unsigned long		flags;
 };
 
 /**
-- 
2.53.0.1213.gd9a14994de-goog


