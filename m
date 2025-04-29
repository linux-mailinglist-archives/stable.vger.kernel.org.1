Return-Path: <stable+bounces-138971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48BAA3D2A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EC94E22C9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECB2DFA3F;
	Tue, 29 Apr 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkEBkYVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10222DFA37;
	Tue, 29 Apr 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970638; cv=none; b=dakdekKseU61yd5DZ/BMunPgy/SELRDoeAuUANVIHo3KcB6U6N/gTb3SkJF3mIdtti2KXAvsODHWeaWEzznRasPLf41eiqu/rT7ZV1PFVlBuBQry99BViWTaJiPSdExzli6Js9bsNolhL1PomCQUNpuotBJdzc+wTY1JanVwpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970638; c=relaxed/simple;
	bh=Npbl+QI1MDCN5CY0PRjmfL2N2DnPjQWFWKHVTAbxeU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQxUicD8I+ttwflU5eoZEIm0c2WZr4xWnXtDdEsqJppv46oQxf+NIiN28lc/9LpD9STy+Vyt9xVbGwW0THjlrcHqj4I3Jx8hruEN7busG9Twm6eTyy0tRlya+wu1y+rzpbPdvm/auRDNwnZN7KgEqESAl6ltQlQWjFjXLiu9fRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkEBkYVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE7FC4CEE3;
	Tue, 29 Apr 2025 23:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970637;
	bh=Npbl+QI1MDCN5CY0PRjmfL2N2DnPjQWFWKHVTAbxeU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkEBkYVqhjG5UYaRKzDHxkdA7hCbg08nqF9TR40FPIYTxaAa55wSckYSSDWtYdv67
	 FDlkuq/L8Rkx9dNWzrJ5sBlyOKOaBrTL5MPMO/1xshMvWFzAqOMMKXOTJpTDML/yv1
	 6d1fAXGZyPXwyMY9MLYqFyw8Fzt41T9w5bbifDNBxlwJOixIjCGDf2s0oxoFDX2zJU
	 OcWFoChgYWDL1urjG/xoc8YmV5ajc+A6lBKgKTnxrMttTSWWnGP3QRr3qIlDffM2Wo
	 KsHpLHo7BisfyW04+RATFLEA2Swrac9qi1hDvMrql+Kui0AK3q6C877CdFwHZtBokz
	 qZOwq5xrv+UdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [PATCH AUTOSEL 6.14 15/39] driver core: fix potential NULL pointer dereference in dev_uevent()
Date: Tue, 29 Apr 2025 19:49:42 -0400
Message-Id: <20250429235006.536648-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 18daa52418e7e4629ed1703b64777294209d2622 ]

If userspace reads "uevent" device attribute at the same time as another
threads unbinds the device from its driver, change to dev->driver from a
valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
when fetching the pointer, and take bus' drivers klist lock to make sure
driver instance will not disappear while we access it.

Use WRITE_ONCE() when setting the driver pointer to ensure there is no
tearing.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250311052417.1846985-3-dmitry.torokhov@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/base.h | 13 ++++++++++++-
 drivers/base/bus.c  |  2 +-
 drivers/base/core.c | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb203cf8370bc..123031a757d91 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *bus_to_subsys(const struct bus_type *bus);
 struct subsys_private *class_to_subsys(const struct class *class);
 
 struct driver_private {
@@ -182,8 +183,18 @@ void device_driver_detach(struct device *dev);
 
 static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
 {
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
 	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	WRITE_ONCE(dev->driver, (struct device_driver *)drv);
 }
 
 int devres_release_all(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6b9e65a42cd2e..c8c7e08040249 100644
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
index 4a23dc8e2cdaf..e65728e99ae42 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2624,6 +2624,35 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
+/*
+ * Try filling "DRIVER=<name>" uevent variable for a device. Because this
+ * function may race with binding and unbinding the device from a driver,
+ * we need to be careful. Binding is generally safe, at worst we miss the
+ * fact that the device is already bound to a driver (but the driver
+ * information that is delivered through uevents is best-effort, it may
+ * become obsolete as soon as it is generated anyways). Unbinding is more
+ * risky as driver pointer is transitioning to NULL, so READ_ONCE() should
+ * be used to make sure we are dealing with the same pointer, and to
+ * ensure that driver structure is not going to disappear from under us
+ * we take bus' drivers klist lock. The assumption that only registered
+ * driver can be bound to a device, and to unregister a driver bus code
+ * will take the same lock.
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
@@ -2655,8 +2684,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Add "DRIVER=%s" variable if the device is bound to a driver */
+	dev_driver_uevent(dev, env);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
-- 
2.39.5


