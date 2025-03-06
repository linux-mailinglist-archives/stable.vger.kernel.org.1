Return-Path: <stable+bounces-121177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA7AA5431A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 07:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD78416EBF3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FD1A5BA8;
	Thu,  6 Mar 2025 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIakNPIH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC11A0BE0;
	Thu,  6 Mar 2025 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243873; cv=none; b=pUeX/oCTOBe5hWAxHJOnFI8k/SfpVvaGqM/ytPnFtHBHVNIPQj+93gEXK+JKjF14jQiW/dkGlRz1X2R7kJ3hQxDZk3Xa+T0mDtEyRZpo9BA1ngBrBcKa+MgGzM8UL8xnDQLk6IgWbhyZ23z5gGA9XG/jA3idHAZI9vJL4vFr08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243873; c=relaxed/simple;
	bh=48fyZdr8LwCW3XqX4inBDjw6e7KJXj02tbZfat8AGiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgu0JunHUsHsyiTV8QBWEsswG6y4w+xMXQQ1x6OZMyQ1xDT9yWD52vYvrS8Gp3FkIVYcn2gBjKj8igrAqQ9xidGLzKXi7ujanRAd0og0UqEVM3OEOqYnvt0AiK4mLKCiEte7Lho0YBbYpoH0CdFLKyiVxz7h2p15wRecli9iO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIakNPIH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso487229a91.1;
        Wed, 05 Mar 2025 22:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741243871; x=1741848671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5KXdFHm+WLhg5HazhkZYKY/D4ntZshhlZ1/ip2PDg0=;
        b=FIakNPIHSbdST+KfQ/aWZwTbNCFHWNoWm3mkmhrgzv9jCfaGGXzTU5aLbUzRn2QCDu
         CwZ0UEnntIsMgJd76eKykMlTQuj5XTK6PJF02shePksu/l9Ap5ce1UC3Ebi7c1tUvvUU
         JQulwvXBtOc2Th26IC/N7UtyVmFTOb5P9s/1hvveTqD9HyrlNE9zedcto1bILchFhe5n
         zaMfobH8EqjhYMj3XPI7hRXl+Z3VDzbsSfyAb7sHJ5zTK41DXRVd7raNE1p4edKBgAm7
         d8DUAQ6l00yveFIx0NY8lMw4WKGDsZzBBiKPe8aQ7VQHZSGWocx9CYKSwh1HKVB2NPY0
         +xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243871; x=1741848671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5KXdFHm+WLhg5HazhkZYKY/D4ntZshhlZ1/ip2PDg0=;
        b=bWOtN761mRUP0FGzX+rkbyK3tiHoj50l8S9b+Ob4b8tb+5eeeBh6GqXSLWv0Z5LO2n
         VrswL4otvoSlMISKjpXsDEcnCThl71qeP41/B2lGMkt1qzRnKGqLVTwmFq1FiC/efc7D
         WM6Osb6e3MX/n7mNIrrgiH3vKprty/LLjywIMsDOMeRa/0afmKBVNdJxpBZBgwOK1wt1
         b0acMOjaKHvcIutl7abAcrslF19k2gDI/o0XFYz45sY5xUd9uuSxi2yCzN9JdysftTd5
         JKXjZtl7Sam3azlCnrravIkIOWhxQdqSYCFk4oapzb/TPrtRiEm2PDReCFLSoV9eBTvK
         RB/g==
X-Forwarded-Encrypted: i=1; AJvYcCUeqmibX9rrAQ1rZVWphhekNzw8WquKc+tUCdiF2z0ALNWZYqFLQz4qnnsFJLtHl6GOBpgkbx1+dpli0Qg=@vger.kernel.org, AJvYcCVj2DGG83zLKpVtHwdV0L6qJunOs/adK0x6V/8Z8jd0Z9vphcux9S6F3oYiZhpykKueJpg7Rlql@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjRqmt4W1iecWt4oQiEAXJRqVDJXPpuJjUB6QDfJqMMu1Rdku
	cnN+5W05HqWNywW6kdUiDl/kFJMrs1lFn6Mr6uprsgy7OOXE0Z1gClU/Zw==
X-Gm-Gg: ASbGncto2klVG58x2UNT20fAIS3fGegZwUu0BpTtiX7QsYWW4FYX26UYv9K3tR+bY5Q
	8c8XkN+axHsYeT/ueWwimZkjEYJ7z5u3LWqZ4oMvXGGdxfKv6KIzMtZVNiHTQITUWIfPr8IE96H
	lbQENvo1KbNlMm5flDk/eN5YOuEyl2Df4IuZqgEG1ua+5EN0so7UcVqX6oDqBhjAzB/i5j5b9Qt
	jXcTjhgwQwSFbRQ5UfHBj6YLoycizPB2OTTifc+mYsEWRjkda2uiGOvEavTkrTzY1/US+PScvqG
	5IpwF4MRgjJiVHjf9dg8c4WzdMvmXtGFAPfbaBCNpC1E4xfMg8eHF0KFVBOqpHv5b1b8
X-Google-Smtp-Source: AGHT+IE7eCrq9SK2Pfac4zWn9MHIncypmmcfKGX3e+Q1kyeVbtOCbySVTeP+/it0zVCScV4mu6y9OA==
X-Received: by 2002:a17:90b:2502:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-2ff570d8b87mr5799087a91.9.1741243870499;
        Wed, 05 Mar 2025 22:51:10 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:423c:abab:b1b0:64e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e823b98sm2402982a91.46.2025.03.05.22.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:51:09 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] driver core: fix potential NULL pointer dereference in dev_uevent()
Date: Wed,  5 Mar 2025 22:50:52 -0800
Message-ID: <20250306065055.1220699-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306065055.1220699-1-dmitry.torokhov@gmail.com>
References: <20250306065055.1220699-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If userspace reads "uevent" device attribute at the same time as another
threads unbinds the device from its driver, change to dev->driver from a
valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
when fetching the pointer, and take bus' drivers klist lock to make sure
driver instance will not disappear while we access it.

Use WRITE_ONCE() when setting the driver pointer to ensure there is no
tearing.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: addressed Rafael's feedback by introducing device_set_driver()
helper that does WRITE_ONCE() to prevent tearing. 

I added Cc: stable however I do not think we need to worry too much
about backporting it to [very] old kernels: the race window is very
small, and in real life we do not unbind devices that often.

I believe there are more questionable places where we read dev->driver
pointer, those need to be adjusted separately.

 drivers/base/base.h | 18 ++++++++++++++++++
 drivers/base/bus.c  |  2 +-
 drivers/base/core.c | 34 +++++++++++++++++++++++++++++++---
 drivers/base/dd.c   |  7 +++----
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8cf04a557bdb..ed2d7ccc7354 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *bus_to_subsys(const struct bus_type *bus);
 struct subsys_private *class_to_subsys(const struct class *class);
 
 struct driver_private {
@@ -179,6 +180,23 @@ int driver_add_groups(const struct device_driver *drv, const struct attribute_gr
 void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
+static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
+{
+
+	/*
+	 * Majority (all?) read accesses to dev->driver happens either
+	 * while holding device lock or in bus/driver code that is only
+	 * invoked when the device is bound to a driver and there is no
+	 * concern of the pointer being changed while it is being read.
+	 * However when reading device's uevent file we read driver pointer
+	 * without taking device lock (so we do not block there for
+	 * arbitrary amount of time). We use WRITE_ONCE() here to prevent
+	 * tearing so that READ_ONCE() can safely be used in uevent code.
+	 */
+	// FIXME - this cast should not be needed "soon"
+	WRITE_ONCE(dev->driver, (struct device_driver *)drv);
+}
+
 int devres_release_all(struct device *dev);
 void device_block_probing(void);
 void device_unblock_probing(void);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6b9e65a42cd2..c8c7e0804024 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  * NULL.  A call to subsys_put() must be done when finished with the pointer in
  * order for it to be properly freed.
  */
-static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
+struct subsys_private *bus_to_subsys(const struct bus_type *bus)
 {
 	struct subsys_private *sp = NULL;
 	struct kobject *kobj;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9f4d4868e3b4..27fe69d06765 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2623,6 +2623,34 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
+/*
+ * Try filling "DRIVER=<name>" uevent variable for a device. Because this
+ * function may race with binding and unbinding device from a driver we need to
+ * be careful. Binding is generally safe, at worst we miss the fact that device
+ * is already bound to a driver (but the driver information that is delivered
+ * through uevents is best-effort, it may become obsolete as soon as it is
+ * generated anyways). Unbinding is more risky as driver transitioning to NULL,
+ * so READ_ONCE() should be used to make sure we are dealing with the same
+ * pointer, and to ensure that driver structure is not going to disappear from
+ * under us we take bus' drivers klist lock. The assumption that only registered
+ * driver can be bound to a device, and to unregister a driver bus code will
+ * take the same lock.
+ */
+static void dev_driver_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (sp) {
+		scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
+			struct device_driver *drv = READ_ONCE(dev->driver);
+			if (drv)
+				add_uevent_var(env, "DRIVER=%s", drv->name);
+		}
+
+		subsys_put(sp);
+	}
+}
+
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
@@ -2654,8 +2682,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Add "DRIVER=%s" variable if the device is bound to a driver */
+	dev_driver_uevent(dev, env);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -3696,7 +3724,7 @@ int device_add(struct device *dev)
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..b526e0e0f52d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -550,7 +550,7 @@ static void device_unbind_cleanup(struct device *dev)
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
@@ -629,8 +629,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	}
 
 re_probe:
-	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	device_set_driver(dev, drv);
 
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
@@ -1014,7 +1013,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 		if (ret == 0)
 			ret = 1;
 		else {
-			dev->driver = NULL;
+			device_set_driver(dev, NULL);
 			ret = 0;
 		}
 	} else {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


