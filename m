Return-Path: <stable+bounces-227649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOhsMcILvmlQFwMAu9opvQ
	(envelope-from <stable+bounces-227649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:08:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203A2E3023
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9BBA301DD93
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3B3002D1;
	Sat, 21 Mar 2026 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkdYJcwT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4892C17A0
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062522; cv=none; b=vD7b0471R3TdedcwJgUQlkeAkbdU1UW8b2Y61PTs7VkRp9U2TLACyhFqkWOJvgYxo+GnkPz9mJId1DNL8QiXgZD6uwGK8pgrrmxW4nI5iZjgUP8HlxWNa47GQyDN8uWB0CTjptfnjTu+RPNWBwTJaPhZm1qznl5eB7f+76LeGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062522; c=relaxed/simple;
	bh=ncTIMNASHjpZ6B39V82ZgctoszodwVhtazh6QmPsAfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTYpyX3wZia3x7AWOhy/PP64pFl+fUYuFP4r03rvBROcrHlTAsRDNs62lNpPGt4XRvlYStLfAIXrDkuB0juS6mniqAdcT0XIbgcdlWz8isn3NACRMJMZzFT8UXPF1uEdpXIIUKFFIJN8tsGr/FAYgivjnMKbJdWCRgpMIx+0MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WkdYJcwT; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c0bb213b16so4437333eec.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774062520; x=1774667320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+aAzcKE9DLWpX+pM5zZXoXrAxmtKIn1qCJ1uOuKGc=;
        b=WkdYJcwTRK+jzRGBrxZ+wqXNOcG8jVOkmZVEbTsqvfzl8cEcLdQKK3ACMwFGl0Sco2
         jwygnsk3Z6vl48HvubQkpiM2lanAhhJemAzPZwHMtDCuYMCH3Sc7WeJZetUNjzFhK7tQ
         yyj+9JIant3B9x+J6YFhm/nF4oOjZlJPb1YNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774062520; x=1774667320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/+aAzcKE9DLWpX+pM5zZXoXrAxmtKIn1qCJ1uOuKGc=;
        b=PrB0b7GqmczZdo6raWPUu1r2IsVDXfrnteKYM7/1N/nRpD6BPD65I/m0zqh24qVpUr
         ElQ2xcW35tt3GzxGPZLUv0ypTxHNybqT5aJJqR3rwv2P3PsllD2P4J7y5nK/x5Yn6u7v
         R/4mcsVlDWQmch2sD3sP7czfkyhasYNrirVQ5svVOZL/9Ue+syWgwGFwoHx0oy6cT7q+
         IJ+JPlJZoiPuCItHA7mdQWCUGgDM8vrrH0NZf/kNdbxGVhCMZGKC5ShYd6Jo8dBL+iFU
         5zHmjRfaMyg2wIgkMJx2J4rteezjwjVQVHOUTrVcOD4/iCtkSsyHqt4UYGuHPZyo3PNN
         l7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWjrhd3hSTH/A5G5ud5HLFnnHFloWC9UPe8H/JLBl4xOTAAZqdWuI9RO2/wRTjGSTv62oCyKaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoZWSJ8I9t1VFIDudKRNcWtZH8yMpelIRrmRCdbHiMWjbnfl9
	coZw14wbRK5Q4RkW2NaWzrGjfhuLCdE/qegH1USLM5XXKxS6IQP+5cbApsxWWTDl+g==
X-Gm-Gg: ATEYQzyWfDAE4uSC+gL3dvE4qxGPNH3oiBCQwsofPA36Ef9OF4YYYxRq2AYX44PYHDB
	jtQhVNhYMzBoK8cBo1cbS3ro9m8I26Th11E2lcna9J1tj+xhwUePKzRSxsF0Kmyx5WQTqtWtLNt
	Ebp8JTZEwUU54f2WufDmuxfPIB4+h6p0x9L38VIkzewhrHqKvSdGl2hj30a3kUyWPAr1gTKrSwq
	U4XCl2WCgUE5cwPntyx8bfKfsqpqq0A3hC6kSpb+629kj7S59bSTKv3JdO4VRvmZ3LzEfXUV13b
	/oEhriN2jSvoYjJXTsPn5MQ7JDJIW69gqN98AIqyCWa3aEGEZThr1LN4FZ1kyV+B5i2jyKsh0p6
	E87ltSrZCKHFKtOWM8sKdYrqYM8E157I6h4OCIyKbUD30OnpHdfPzUFRYxUhR0tuea4eFZQaeBZ
	eh0cxcEIZMU2S7KBE0uWNQS+sDE6nDB7da36Rzvdp9cc0FoK7PcdteiGR+lUf0mygl4a9CNHGZ1
	CORUiQ=
X-Received: by 2002:a05:7300:7496:b0:2be:e92:7f33 with SMTP id 5a478bee46e88-2c1097ecb50mr3430566eec.35.1774062519477;
        Fri, 20 Mar 2026 20:08:39 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5b58:b8db:c8fc:9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29d28csm7236852eec.19.2026.03.20.20.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:08:37 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] driver core: Don't link the device to the bus until we're ready to probe
Date: Fri, 20 Mar 2026 20:06:58 -0700
Message-ID: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227649-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5203A2E3023
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

Practically speaking, in the case this happened
device_links_driver_bound() got called for the device before
"dev->fwnode->dev" was assigned. This prevented
__fw_devlink_pickup_dangling_consumers() from being called which meant
that other devices waiting on our driver's sub-nodes were stuck
deferring forever.

Fix the problem by adjusting where we link the device. Notably:
* Make sure we assign the dev->fwnode->dev before we link the device,
  since that needs to happen before a device probes.
* Make sure we link the device _before_ sending the UEVENT, as
  described in commit 2023c610dc54 ("Driver core: add new device to
  bus's list before probing").

[1] Captured on a machine running a downstream 6.6 kernel

Cc: stable@vger.kernel.org
Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is a super tricky area of code, and I don't have a lot of
confidence that I got this exactly right. If you think I should do
something different, please yell!

Notably:
* I don't know 100% for sure what happens if probe runs at the same
  time as (or before) the call to `bus_notify(dev,
  BUS_NOTIFY_ADD_DEVICE)`. Presumably we're at least no worse off than
  we were before this patch.
* I haven't dug into whether there could be other types of race
  conditions with a driver trying to probe the device at the same time
  we call bus_probe_device().

I can try to dig into those things, but I also figured that people on
the mailing lists would know this code a whole lot better than I do.

Feel free to consider this RFC patch as a bug report and post a
totally different solution. I won't be offended! :-)

I have only done very minimal testing with this patch so far (the
system doesn't seem to blow up with this patch). I'm kicking off tests
for the weekend, but I figured I'd post this up in parallel.

 drivers/base/base.h |  1 +
 drivers/base/bus.c  | 16 ++++++++++++++--
 drivers/base/core.c | 24 ++++++++++++++++++------
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 1af95ac68b77..d4933ba7b651 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -166,6 +166,7 @@ static inline void auxiliary_bus_init(void) { }
 struct kobject *virtual_device_parent(void);
 
 int bus_add_device(struct device *dev);
+void bus_link_device(struct device *dev);
 void bus_probe_device(struct device *dev);
 void bus_remove_device(struct device *dev);
 void bus_notify(struct device *dev, enum bus_notifier_event value);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index bb61d8adbab1..573c22ebb5b7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -510,7 +510,6 @@ EXPORT_SYMBOL_GPL(bus_for_each_drv);
  *
  * - Add device's bus attributes.
  * - Create links to device's bus.
- * - Add the device to its bus's list of devices.
  */
 int bus_add_device(struct device *dev)
 {
@@ -545,7 +544,6 @@ int bus_add_device(struct device *dev)
 	if (error)
 		goto out_subsys;
 
-	klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
 	return 0;
 
 out_subsys:
@@ -557,6 +555,20 @@ int bus_add_device(struct device *dev)
 	return error;
 }
 
+/**
+ * bus_link_device - Make a device findable in the list of devices
+ * @dev: device being linked
+ *
+ * - Add the device to its bus's list of devices.
+ */
+void bus_link_device(struct device *dev)
+{
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (sp)
+		klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
+}
+
 /**
  * bus_probe_device - probe drivers for a new device
  * @dev: device to probe
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791f9e444df8..6ff4725d677a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3663,12 +3663,6 @@ int device_add(struct device *dev)
 		devtmpfs_create_node(dev);
 	}
 
-	/* Notify clients of device addition.  This call must come
-	 * after dpm_sysfs_add() and before kobject_uevent().
-	 */
-	bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
-	kobject_uevent(&dev->kobj, KOBJ_ADD);
-
 	/*
 	 * Check if any of the other devices (consumers) have been waiting for
 	 * this device (supplier) to be added so that they can create a device
@@ -3680,12 +3674,30 @@ int device_add(struct device *dev)
 	 * But this also needs to happen before bus_probe_device() to make sure
 	 * waiting consumers can link to it before the driver is bound to the
 	 * device and the driver sync_state callback is called for this device.
+	 *
+	 * Because a bus may be probed the moment bus_link_device() is called,
+	 * this must happen before bus_link_device().
 	 */
 	if (dev->fwnode && !dev->fwnode->dev) {
 		dev->fwnode->dev = dev;
 		fw_devlink_link_device(dev);
 	}
 
+	/*
+	 * The moment we link the bus in, it's possible for another thread
+	 * (one registering a new driver) to notice it and start probing.
+	 * At the same time, we need to link the bus before the uevent is
+	 * sent announcing the device or user programs might try to access
+	 * the device before it has been added to the bus.
+	 */
+	bus_link_device(dev);
+
+	/* Notify clients of device addition.  This call must come
+	 * after dpm_sysfs_add() and before kobject_uevent().
+	 */
+	bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
+	kobject_uevent(&dev->kobj, KOBJ_ADD);
+
 	bus_probe_device(dev);
 
 	/*
-- 
2.53.0.959.g497ff81fa9-goog


