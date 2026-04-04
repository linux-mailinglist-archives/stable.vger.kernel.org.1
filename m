Return-Path: <stable+bounces-233251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D2GOUdW0GkA6gYAu9opvQ
	(envelope-from <stable+bounces-233251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 02:07:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A731E399382
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B06302C31F
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29804199FB0;
	Sat,  4 Apr 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGsuYDxl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD57DA66
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261244; cv=none; b=C3Zi8279YiLIsYaew5O5co/39ptjguAkQBUBfEzPWE4ZdrTbfbJinlJxBb2ykwDPT1kfwtIYKYPkWzrE7BmS9AYZSn1XhOK0tAVnauJDGgHYRfPNk2kslVGT4lly6KLMMt0wPQ3xyngOeDEMehc9BoNjplgJL9JyojwHvYRspzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261244; c=relaxed/simple;
	bh=III6jfoTjxrvqqvxvqPImVr6gqYLV5UXkESYuPeEMdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KufL1VuUiFLKKc1VnoZu/VAaLEg0gDgyTfjYpIeZWEVFWO8cOKRHy1aMjj2wiZHbV1o4d4IjIhlH4+8jYAcJD6x6m/063gIq6SHptDXR+jDXWlrql+akutVZdbTH4vs4Rn+HIb1OR0hQVR1Q4AQKGjL+RaXidh83aVN1daMJdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jGsuYDxl; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2cb3cb2fc7bso1005549eec.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261242; x=1775866042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJEW8I+GJiIRTdX3t2bIsrL+T4N6bIAtJLVhOniwR48=;
        b=jGsuYDxls1mCr6U9W1qnEUv/bjrBffGsxMbgJ3W8AZM7FK5xP4NZX4hhUCrydWOIjf
         nMQHargI5bR7MySGSGo0JzqBibjBNBSdt1LSNeO5beeuh9nXJ3U6jt28yyGyXJoIUC8P
         sRZ9IMlfs5VrykiwdUvVxKW42TSF/UwQWDErI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261242; x=1775866042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJEW8I+GJiIRTdX3t2bIsrL+T4N6bIAtJLVhOniwR48=;
        b=e//ywksNN2qmdJ66we5G1Asavsm5dEynQD7ye+AOuxO8ZSwwAexu48UsgrytS/1ULU
         GDRZC9tRVb+S5uxHn6AV3C7O/9afL9uhqu7SQ8J0q6NFNtWFSr9ls66k8fADgrOMCHI9
         8B1j+UnOS5Iqzx18u0xwlWxQRHLxlwh7wrhffwAOthI+TKTDF64ZVhU6g/gc1s23e2rO
         BCKvGMZuRmR4hKgR5xxJAH+FC9DT+crEXQbIvAeEdr6yuzd7SOh8t+XQ4RbmJ/I441co
         ZXa9czhUa5QuybOrAWZ5Pwbobeqgw+VsprWY7FGsnqMy8lZPvZECmGWxPYlUP321cqod
         GtdA==
X-Forwarded-Encrypted: i=1; AJvYcCUFW4T/8Fm18KFgn5ItjfE9e3Z9vhwERiLwhjHHURxmLiOcxC+pZXqEULne7WeuOq19W9xhnNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeFbBVj6VWITmruEAchq/jou+2nM0yng+zd/Eef2U/9qQryM5
	RCfsffpQb/2hVDRtXzivnvn2DcrJbQExr780zaMHGmZY8amjYAGigVkZGrfda6hM2g==
X-Gm-Gg: AeBDietj1oinit13rMh2M6APnPm1ylZoGf3yr3TF08H47D3dnETtBkcLUofKmsqfC8x
	vZY1EfJsjJ3fCsoS3M7aPgsbRxxDRXtN1pHKx4mJUDmO5aYufNBP5pDhMHXwKhqJju1MpmjV/6d
	iRY0TdrtbLBJsHkzD2AttY/ICkBfjtY8gf+45KTWJnZ/aW7dGZW/g0mNKcqE0FHef/ErXowXq4W
	wJWwjX72efkV26dQQiphxZcPP6yqERXuBjRjl+fPYTt/CvdJ8ZMMcTATSwZCbbOwBVDLCYzffNd
	nROJ2Y2GfytMTkSBy5ZoMG5rSXVBpXRIZ74YmblNScH2w32BKsRcvL/+evmYzvsOAimJUrn2GcN
	OHXamWzsZF/rCekj5DCDYVq88NofOTl4h13pI8oP6YGOuCKISWqdpJMrq5v/Q66+tcOllQpBtvy
	916knBVj/5B1OeD8epCaFuxHSU6l6EpYIwdJ9I+kNri2hpXQgulRmj4MHQyf3n/UEE5DxvF3uYw
	N71C4Rg0Ww=
X-Received: by 2002:a05:7301:1f01:b0:2c5:704f:7142 with SMTP id 5a478bee46e88-2cbf920f3c9mr1937248eec.2.1775261242319;
        Fri, 03 Apr 2026 17:07:22 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:21 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] driver core: Don't let a device probe until it's ready
Date: Fri,  3 Apr 2026 17:04:55 -0700
Message-ID: <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233251-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: A731E399382
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
v3: https://lore.kernel.org/r/20260403005005.30424-1-dianders@chromium.org/

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

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

 drivers/base/core.c    | 13 +++++++++++++
 drivers/base/dd.c      | 12 ++++++++++++
 include/linux/device.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 09b98f02f559..f07745659de3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The moment the device was linked into the bus's "klist_devices" in
+	 * bus_add_device() then it's possible that probe could have been
+	 * attempted in a different thread via userspace loading a driver
+	 * matching the device. "ready_to_prove" being unset would have
+	 * blocked those attempts. Now that all of the above initialization has
+	 * happened, unblock probe. If probe happens through another thread
+	 * after this point but before bus_probe_device() runs then it's fine.
+	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
+	 * will notice (under device_lock) that the device is already bound.
+	 */
+	dev_set_ready_to_probe(dev);
+
 	bus_probe_device(dev);
 
 	/*
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 37c7e54e0e4c..8ec93128ea98 100644
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
+	 * "ready_to_probe".
+	 */
+	if (!dev_ready_to_probe(dev))
+		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n");
+
 	dev->can_match = true;
 	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
 		drv->bus->name, __func__, drv->name);
diff --git a/include/linux/device.h b/include/linux/device.h
index e65d564f01cd..5eb0b22958e4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -458,6 +458,21 @@ struct device_physical_location {
 	bool lid;
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
@@ -553,6 +568,7 @@ struct device_physical_location {
  * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  * @dma_iommu: Device is using default IOMMU implementation for DMA and
  *		doesn't rely on dma_ops structure.
+ * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -675,8 +691,34 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
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
 /**
  * struct device_link - Device link representation.
  * @supplier: The device on the supplier end of the link.
-- 
2.53.0.1213.gd9a14994de-goog


