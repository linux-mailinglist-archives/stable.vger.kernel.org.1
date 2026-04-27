Return-Path: <stable+bounces-241410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIiqIGCV72leDAEAu9opvQ
	(envelope-from <stable+bounces-241410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B7476B4F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D273054C32
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B22DE709;
	Mon, 27 Apr 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9LJMXJ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8743BC680
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308866; cv=none; b=IzpucR+God+Dnoa9AaLP+Zud0Tr/tDz09zBj5GXNjpFtvoUOLSJBYT3Bl+LBZ7APFYa8pHtRe+7pIi1s/XXobQHU0scNkIARAVEe6e8j0h2t3pW67q8oo/2BcNHUDFyY8ekR7Ouui2DMCP5gbMPbudNq6zef1MeLYUCBT1aBqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308866; c=relaxed/simple;
	bh=rB/y/U838QleaSxtdF7u6FqgsYv0q/wsqRv+ucGE9+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJkmJZfYfuqHJ+TKmcJ5yeFZdm3n5JLu+Nl4jCb3mWrBmBwLPt/9POh7l16GGAnnAnSVTTAnB94FIYYSaBSop99BRGeu2yadgZdlIuFeLUX4aoG+nxQl75o4eEFftQs9vfhqZ5ddhMtLKncW/ODfSce1fsU7UyLd9h3oVW6ed5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E9LJMXJ/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8cc7a77eso4949246c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777308860; x=1777913660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfwyG9wCH4IXbRXGPqNFJpvUvoMfOAPRpknGO8Q2Gtw=;
        b=E9LJMXJ/JcFuIO+87QOb/d1XbmRbpu1jOFkkFE4Kklqvu+1r5wuPw+TA/W6EKvl3Ue
         glQilXGLIVRU2Ca5neihOcKWXJPEawA1bMDhVO611nvIXsQU1DW3Apqf8/EMEecO0x01
         qca0pVZeuR1B/95DJ8skYeGARpCKZfnznDONo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308860; x=1777913660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfwyG9wCH4IXbRXGPqNFJpvUvoMfOAPRpknGO8Q2Gtw=;
        b=MECcyiuvJvsDQ74EpmGgaFw7HprplqiPAuQFeIMLCGvLRRR+kt0qTlRz/rBToPYQ4r
         bD8hRCT9Zzwev2lBDVeSG8C5I0Mdg8UcNZISEr5Dx1QLRcH9ony0z6vDIN4/xe3Ya0rX
         SPaspo2YY+wVeKMc4ukVW71oE6hSDBGxpehTOry10r/RtrU/z7uVASKq5+Rhn7OutVTe
         nRRBv/hdggm9z9FBrOU/MZgH+3rADntGeLVoMSyC1YVy5tQRcik0QQtDZRSOB+/yzxzg
         DvJrztihQcInmLSjanaWw4Fbdyh/BZMnipP+dE2MOunff5tbCFQHg97sYvsq4GdthLnj
         rQOg==
X-Gm-Message-State: AOJu0Yxh3884dC1EAHLOB46BL/lTRwiaFDx+Vvt7kFPQKZaWnsPwniWJ
	heYN1PLWAl3zvz5J0YDOO0tiXnyLR+QPx997VISh3uDwprW5hRTiIWF2KnNKkbmXfWSIgPrWtQD
	J/jA=
X-Gm-Gg: AeBDiesDJnP9mml+o2rtNJBVa5rdM7dywVXQ21omG5fXeO7gwm4oARc5uccin15z3X6
	XRnX5hq4jQ6bnRDtWRiXNgsHRgoe6xlkxAJimEJrSuf1bzOnQLNSzs3UcxK8jpqAGLaWHPpBzDp
	1970X0vDoUguxuyGUEFwebtLBGxrat3QRUomaJ3gqgadXuibbWPeH50X5IZAhIVG8Rk3DLMpmRI
	ewyMbntW/3vr+YS3jReg/bH2w7DXPctyXUS3o/CtdhGUIHZ9Y/Wi19gIIlaW27XnRHZuflUoreQ
	Rqjl6sAKU4nylPcYMMooDSRXdEnQPeAgTA/lrcvQNOXUUuIEbIy+rBnjvdWTXQumPMaXa8fGUwS
	FS8ZPxZg9IBFUdgj8azL+RNnb4DNvNdRByqhRRp4tAMdcukR4H7j87ddN1zOZvybDLdbZGJYglG
	Hz+vkFGzaFTU/jgarDcbfvz+FSZCDGGs7j+AYqqXFovDXmXvPNlXrTyOrxuv2VVwhuPZo18Z8mv
	1AzdQToAUsNy4XamDl+XQ==
X-Received: by 2002:a05:7022:6885:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-12c73b34112mr17663532c88.16.1777308859861;
        Mon, 27 Apr 2026 09:54:19 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:389e:b840:2892:97c2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm67836446c88.10.2026.04.27.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:54:18 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6.6.y] driver core: Don't let a device probe until it's ready
Date: Mon, 27 Apr 2026 09:52:41 -0700
Message-ID: <20260427165241.368688-1-dianders@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <2026042755-pelican-cage-f353@gregkh>
References: <2026042755-pelican-cage-f353@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D70B7476B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241410-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,chromium.org:mid,android.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,harvard.edu:email]

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
index a192ce5bb8f9..289f5b15ef39 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3680,6 +3680,21 @@ int device_add(struct device *dev)
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
index 7e2fb159bb89..d371c3437dc6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -785,6 +785,26 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
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
index e5f1a773dc54..34a327f5797c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -602,6 +602,21 @@ struct device_physical_location {
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
@@ -693,6 +708,7 @@ struct device_physical_location {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -805,8 +821,36 @@ struct device {
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


