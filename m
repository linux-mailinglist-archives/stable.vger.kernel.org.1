Return-Path: <stable+bounces-231239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBUuG1CLymn09gUAu9opvQ
	(envelope-from <stable+bounces-231239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74F35D073
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661293085307
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C733A3E67;
	Mon, 30 Mar 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GacCgKhW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343663A7845
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880984; cv=none; b=Je5nhiavgcTXElXiELN7LLVnnaLXoDSKRgDwOtEfEnurKWugO7q8T76hgVxd36bsUpVbXXYB/ZAt2t7+NPbY7cahPlZNrsx1fzr3KxH+3YZKrfPI07hZP+r2uVasquQCJWP+Ct8039mon6tcQGKYFfYZG7hHg9xNvNFJY/9wEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880984; c=relaxed/simple;
	bh=8LQZSocESOF3veZ/bfrXbhh0O+so24+/tbM7fVlpCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oD4td+4HtaGqiFoCu+t59Xfov/JZR+S0+wgXP79b/Zfxy33jLs7HeQ2BLUOcKuiIVD9accElyfRBWS3XGXWT4q7p2QrIROuE/RZlFMj26ppoIaYBcc9xsW0UvX4qCX/zq72QY6DAemZ9onsEkY7MoQXbMKlzTwhq/a95aqHBAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GacCgKhW; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12a80c36350so4865124c88.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774880980; x=1775485780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACJ6Cr/IS11gucQGUIuPydXkCtkwKZa4TuMCqVkix8k=;
        b=GacCgKhWonS2gcGcaXAZZX+ebDO0j0yGDMq9nmNMC9EUn3LJ2Q+oApqFXR4gjhpVAR
         gnhsKC6VorgLcx2XgFYJV+hibTrNWzJQQie4IDrC9n1Orq5U44pyvMQnvCOWiDH0gffL
         idNXzwflqAVPdaAhWJm05Xol6ad3ZC3m98uXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880980; x=1775485780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACJ6Cr/IS11gucQGUIuPydXkCtkwKZa4TuMCqVkix8k=;
        b=AE8WNbLJEs9GbqBfq9GWE00cSKO367PXJWkFzkiaen1NCWJBInkdq9qAzkFt7cwDUV
         p9idcSd8R+wUEA4UnIG3Vq312YF8Iy4VhEQW4Kwb+4IMMhKjd5jWYx9csJ9k6n7a+i7V
         NVva6x/F4CzT4TWQ5nlV5uaUqVJINDNsct87xpos9050K0Pb9Zh88FYfVhjNsc1hDnmT
         gd563mvlwH8ECbu8lSyKLmZUpJE8qmvcKqIXVZgrJNnMKqhWD03t/emGUzBiU8J/VZjb
         BS1riW+h6qKHodMTu8N9TS+3nuY4VUkfdubAK1dbwfakGkXQj9CwH2rDz9DykyEiyd4B
         xkKw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1GDv9P+sXixAEd9cQCy1DOG+4ggrI4D1FkPHXDfPb9BXrBVRRw6IBMqZQDDcqS1/hLZ7K8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPsVwoEnYk8A26rePiNdN9Y0OeCFoSvlhPpeW3wFtgwrzxbn+
	67IgBHI6jec78Gz6tT/aoNGy8BQyJDz6dCxApFuWIw2bhWWk8laEH2b8CktQO+Zg9CxPDfFd5iY
	FWis=
X-Gm-Gg: ATEYQzyOjMqHQPJX/ruT3TmqxwXH3E6rt3vsOglV9Im/+renlaUlwEmf/jrjO9O3Y6L
	imCf+N3XpHA7MfxiBbOnAXC0Ad7fC/Tcfi0hSR/NFkcUYseGW386+XKwIc76b0l3UeTbuLCZyn+
	YnSwBBZeDFk+Bj4H9xhP+M5IRgq8gfduUAXqNA/53gy8C0TvsCQsE35j1bNh702NtImA5ba0p26
	M1YTk2Uuwh6KDuF7/YM3W7gMzS+ncB4PHGxy2ULhcLRA1MDz7H2vTsgHolB7gg0UkBqlIoz2hzo
	8uG7EP7RxKRyoomhozUvhAujpwAjMnrArBnE/79trIZHdXj6hDXXoG4JjBKkjbpCC6+gSgFczWe
	sgnPqwiYR6qcPO8CPd9NBi+v7MrCA+KlPql66flcmVJOnGua2yr985XFETiy2dhv8arsFlydctG
	qSzml55ey0kt8fRc+dQ0IHHhcI5k/hACPW+M3NoSTZAnlRFnUEVCp+CvwqNxtA3TPZsXz7Kqsea
	Wr1MEpwyD8=
X-Received: by 2002:a05:7022:628c:b0:128:d471:8c1 with SMTP id a92af1059eb24-12ab2890739mr6624565c88.17.1774880980067;
        Mon, 30 Mar 2026 07:29:40 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:f4ab:830d:18d1:e45b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm10665132c88.4.2026.03.30.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:29:38 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver core: Don't let a device probe until it's ready
Date: Mon, 30 Mar 2026 07:28:41 -0700
Message-ID: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231239-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,android.com:url]
X-Rspamd-Queue-Id: BD74F35D073
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

[1] Captured on a machine running a downstream 6.6 kernel
[2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel

Cc: stable@vger.kernel.org
Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1: https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid

This v2 feels like a very safe change. It doesn't change the ordering
of any steps of probe and it _just_ prevents the early probe from
happening.

I ran tests where I turned the printout "Device not ready_to_probe" on
and I could see the printout happening, evidence of the race occurring
from other printouts, and things successfully being resolved.

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

 drivers/base/core.c    | 15 +++++++++++++++
 drivers/base/dd.c      | 12 ++++++++++++
 include/linux/device.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 09b98f02f559..4caa3fd1ecdb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3688,6 +3688,21 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The moment the device was linked into the bus's "klist_devices" in
+	 * bus_add_device() then it's possible that probe could have been
+	 * attempted in a different thread via userspace loading a driver
+	 * matching the device. "ready_to_probe" being false would have blocked
+	 * those attempts. Now that all of the above initialization has
+	 * happened, unblock probe. If probe happens through another thread
+	 * after this point but before bus_probe_device() runs then it's fine.
+	 * bus_probe_device() -> device_initial_probe() -> __device_attach()
+	 * will notice (under device_lock) that the device is already bound.
+	 */
+	device_lock(dev);
+	dev->ready_to_probe = true;
+	device_unlock(dev);
+
 	bus_probe_device(dev);
 
 	/*
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 37c7e54e0e4c..a1762254828f 100644
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
+	if (!dev->ready_to_probe)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready_to_probe");
+
 	dev->can_match = true;
 	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
 		drv->bus->name, __func__, drv->name);
diff --git a/include/linux/device.h b/include/linux/device.h
index e65d564f01cd..e2f83384b627 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -553,6 +553,8 @@ struct device_physical_location {
  * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  * @dma_iommu: Device is using default IOMMU implementation for DMA and
  *		doesn't rely on dma_ops structure.
+ * @ready_to_probe: If set to %true then device_add() has finished enough
+ *		initialization that probe could be called.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -675,6 +677,7 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
 #endif
+	bool			ready_to_probe:1;
 };
 
 /**
-- 
2.53.0.1018.g2bb0e51243-goog


