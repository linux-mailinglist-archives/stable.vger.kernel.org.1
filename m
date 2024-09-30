Return-Path: <stable+bounces-78280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A198A77C
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FEB22931
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD81922FD;
	Mon, 30 Sep 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMMg6Qxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED061922ED;
	Mon, 30 Sep 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707420; cv=none; b=J5kt94pOkN3Xbclz5EC9cdukq1RZ7JTXdJaWywISc4jCsMBvddFnsk/TkuMXjqnR3tyjRRzwa/JnwkWg8hfNHisNjQIN81KxMXrp1vHBu5e0tPI1ZscEotW2EHrlDXYVGxXXjrURtqNVAdKe3N2qcXRq5PsjRvAnwyeUP3itHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707420; c=relaxed/simple;
	bh=Lf3DlLM0ulQPYWrCgpid6o0Au9IXV6Mh1ZN9rZ5jxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7YyueZjGkQACFmaHHrxwDu0RKL/gkgkf+01z/YgwIpywJogGCIbp6yWv37Tl9+e8istM8O3x+DQd5AIo/88zMQcDqQzc+NPyJO7ywfth3cg32m3t1W3Por59KY/Z25qa3dv4rDvM/W0Lu4qy6PZcuDh64V1cKFCNWKgMT+oJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMMg6Qxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC31C4CEC7;
	Mon, 30 Sep 2024 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707419;
	bh=Lf3DlLM0ulQPYWrCgpid6o0Au9IXV6Mh1ZN9rZ5jxA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMMg6Qxfq+T9fbX510IA6BUCIJEvZVow7d4ZQYUcmwDwsceYGWfegf1lCmsutk/Ht
	 G2DEpsEfHktjQ9W9zNIdbV+QKh/WpFLHN6TubX65Esm8OyWREjyo3VbE8s9jVzS3qz
	 9bYzwOpA3VnwYj/HFNJ2VR5s5Q3/rmguRAPlcZd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.11.1
Date: Mon, 30 Sep 2024 16:42:52 +0200
Message-ID: <2024093051-outsmart-scallop-582e@gregkh>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024093050-lemon-grab-faf2@gregkh>
References: <2024093050-lemon-grab-faf2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 34bd1d5f9672..df9c90cdd1c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 11
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 16c3edb8c46e..aa826033b0ce 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -8,7 +8,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
 #include <drm/drm_auth.h>
@@ -18,8 +18,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
 
-static DEFINE_SPINLOCK(accel_minor_lock);
-static struct idr accel_minors_idr;
+DEFINE_XARRAY_ALLOC(accel_minors_xa);
 
 static struct dentry *accel_debugfs_root;
 
@@ -117,99 +116,6 @@ void accel_set_device_instance_params(struct device *kdev, int index)
 	kdev->type = &accel_sysfs_device_minor;
 }
 
-/**
- * accel_minor_alloc() - Allocates a new accel minor
- *
- * This function access the accel minors idr and allocates from it
- * a new id to represent a new accel minor
- *
- * Return: A new id on success or error code in case idr_alloc failed
- */
-int accel_minor_alloc(void)
-{
-	unsigned long flags;
-	int r;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	r = idr_alloc(&accel_minors_idr, NULL, 0, ACCEL_MAX_MINORS, GFP_NOWAIT);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-
-	return r;
-}
-
-/**
- * accel_minor_remove() - Remove an accel minor
- * @index: The minor id to remove.
- *
- * This function access the accel minors idr and removes from
- * it the member with the id that is passed to this function.
- */
-void accel_minor_remove(int index)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	idr_remove(&accel_minors_idr, index);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-}
-
-/**
- * accel_minor_replace() - Replace minor pointer in accel minors idr.
- * @minor: Pointer to the new minor.
- * @index: The minor id to replace.
- *
- * This function access the accel minors idr structure and replaces the pointer
- * that is associated with an existing id. Because the minor pointer can be
- * NULL, we need to explicitly pass the index.
- *
- * Return: 0 for success, negative value for error
- */
-void accel_minor_replace(struct drm_minor *minor, int index)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	idr_replace(&accel_minors_idr, minor, index);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-}
-
-/*
- * Looks up the given minor-ID and returns the respective DRM-minor object. The
- * refence-count of the underlying device is increased so you must release this
- * object with accel_minor_release().
- *
- * The object can be only a drm_minor that represents an accel device.
- *
- * As long as you hold this minor, it is guaranteed that the object and the
- * minor->dev pointer will stay valid! However, the device may get unplugged and
- * unregistered while you hold the minor.
- */
-static struct drm_minor *accel_minor_acquire(unsigned int minor_id)
-{
-	struct drm_minor *minor;
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	minor = idr_find(&accel_minors_idr, minor_id);
-	if (minor)
-		drm_dev_get(minor->dev);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-
-	if (!minor) {
-		return ERR_PTR(-ENODEV);
-	} else if (drm_dev_is_unplugged(minor->dev)) {
-		drm_dev_put(minor->dev);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return minor;
-}
-
-static void accel_minor_release(struct drm_minor *minor)
-{
-	drm_dev_put(minor->dev);
-}
-
 /**
  * accel_open - open method for ACCEL file
  * @inode: device inode
@@ -227,7 +133,7 @@ int accel_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int retcode;
 
-	minor = accel_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&accel_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -246,7 +152,7 @@ int accel_open(struct inode *inode, struct file *filp)
 
 err_undo:
 	atomic_dec(&dev->open_count);
-	accel_minor_release(minor);
+	drm_minor_release(minor);
 	return retcode;
 }
 EXPORT_SYMBOL_GPL(accel_open);
@@ -257,7 +163,7 @@ static int accel_stub_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int err;
 
-	minor = accel_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&accel_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -274,7 +180,7 @@ static int accel_stub_open(struct inode *inode, struct file *filp)
 		err = 0;
 
 out:
-	accel_minor_release(minor);
+	drm_minor_release(minor);
 
 	return err;
 }
@@ -290,15 +196,13 @@ void accel_core_exit(void)
 	unregister_chrdev(ACCEL_MAJOR, "accel");
 	debugfs_remove(accel_debugfs_root);
 	accel_sysfs_destroy();
-	idr_destroy(&accel_minors_idr);
+	WARN_ON(!xa_empty(&accel_minors_xa));
 }
 
 int __init accel_core_init(void)
 {
 	int ret;
 
-	idr_init(&accel_minors_idr);
-
 	ret = accel_sysfs_init();
 	if (ret < 0) {
 		DRM_ERROR("Cannot create ACCEL class: %d\n", ret);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1c7631f22c52..5a95eb267676 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1208,7 +1208,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	int err;
 	struct hci_dev *hdev;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(sizeof(struct btintel_data));
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 259a917da75f..073ca9caf52a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -554,12 +554,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	}
 
 	if (value == prev)
-		return;
+		goto cpufreq_policy_put;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	amd_pstate_update_perf(cpudata, min_perf, des_perf,
 			       max_perf, fast_switch);
+
+cpufreq_policy_put:
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy)
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 93543071a500..c734e6a1c4ce 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -34,6 +34,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
 #include <drm/drm_cache.h>
@@ -54,8 +55,7 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
 MODULE_DESCRIPTION("DRM shared core routines");
 MODULE_LICENSE("GPL and additional rights");
 
-static DEFINE_SPINLOCK(drm_minor_lock);
-static struct idr drm_minors_idr;
+DEFINE_XARRAY_ALLOC(drm_minors_xa);
 
 /*
  * If the drm core fails to init for whatever reason,
@@ -83,6 +83,18 @@ DEFINE_STATIC_SRCU(drm_unplug_srcu);
  * registered and unregistered dynamically according to device-state.
  */
 
+static struct xarray *drm_minor_get_xa(enum drm_minor_type type)
+{
+	if (type == DRM_MINOR_PRIMARY || type == DRM_MINOR_RENDER)
+		return &drm_minors_xa;
+#if IS_ENABLED(CONFIG_DRM_ACCEL)
+	else if (type == DRM_MINOR_ACCEL)
+		return &accel_minors_xa;
+#endif
+	else
+		return ERR_PTR(-EOPNOTSUPP);
+}
+
 static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
 					     enum drm_minor_type type)
 {
@@ -101,25 +113,31 @@ static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
 static void drm_minor_alloc_release(struct drm_device *dev, void *data)
 {
 	struct drm_minor *minor = data;
-	unsigned long flags;
 
 	WARN_ON(dev != minor->dev);
 
 	put_device(minor->kdev);
 
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_remove(minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_remove(&drm_minors_idr, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	xa_erase(drm_minor_get_xa(minor->type), minor->index);
 }
 
+/*
+ * DRM used to support 64 devices, for backwards compatibility we need to maintain the
+ * minor allocation scheme where minors 0-63 are primary nodes, 64-127 are control nodes,
+ * and 128-191 are render nodes.
+ * After reaching the limit, we're allocating minors dynamically - first-come, first-serve.
+ * Accel nodes are using a distinct major, so the minors are allocated in continuous 0-MAX
+ * range.
+ */
+#define DRM_MINOR_LIMIT(t) ({ \
+	typeof(t) _t = (t); \
+	_t == DRM_MINOR_ACCEL ? XA_LIMIT(0, ACCEL_MAX_MINORS) : XA_LIMIT(64 * _t, 64 * _t + 63); \
+})
+#define DRM_EXTENDED_MINOR_LIMIT XA_LIMIT(192, (1 << MINORBITS) - 1)
+
 static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 	int r;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
@@ -129,25 +147,14 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 	minor->type = type;
 	minor->dev = dev;
 
-	idr_preload(GFP_KERNEL);
-	if (type == DRM_MINOR_ACCEL) {
-		r = accel_minor_alloc();
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		r = idr_alloc(&drm_minors_idr,
-			NULL,
-			64 * type,
-			64 * (type + 1),
-			GFP_NOWAIT);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
-	idr_preload_end();
-
+	r = xa_alloc(drm_minor_get_xa(type), &minor->index,
+		     NULL, DRM_MINOR_LIMIT(type), GFP_KERNEL);
+	if (r == -EBUSY && (type == DRM_MINOR_PRIMARY || type == DRM_MINOR_RENDER))
+		r = xa_alloc(&drm_minors_xa, &minor->index,
+			     NULL, DRM_EXTENDED_MINOR_LIMIT, GFP_KERNEL);
 	if (r < 0)
 		return r;
 
-	minor->index = r;
-
 	r = drmm_add_action_or_reset(dev, drm_minor_alloc_release, minor);
 	if (r)
 		return r;
@@ -163,7 +170,7 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
+	void *entry;
 	int ret;
 
 	DRM_DEBUG("\n");
@@ -186,13 +193,12 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 		goto err_debugfs;
 
 	/* replace NULL with @minor so lookups will succeed from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_replace(minor, minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, minor, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
+	entry = xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KERNEL);
+	if (xa_is_err(entry)) {
+		ret = xa_err(entry);
+		goto err_debugfs;
 	}
+	WARN_ON(entry);
 
 	DRM_DEBUG("new minor registered %d\n", minor->index);
 	return 0;
@@ -205,20 +211,13 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
 	minor = *drm_minor_get_slot(dev, type);
 	if (!minor || !device_is_registered(minor->kdev))
 		return;
 
 	/* replace @minor with NULL so lookups will fail from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_replace(NULL, minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, NULL, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	xa_store(drm_minor_get_xa(type), minor->index, NULL, GFP_KERNEL);
 
 	device_del(minor->kdev);
 	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
@@ -234,16 +233,15 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
  * minor->dev pointer will stay valid! However, the device may get unplugged and
  * unregistered while you hold the minor.
  */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id)
+struct drm_minor *drm_minor_acquire(struct xarray *minor_xa, unsigned int minor_id)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_minor_lock, flags);
-	minor = idr_find(&drm_minors_idr, minor_id);
+	xa_lock(minor_xa);
+	minor = xa_load(minor_xa, minor_id);
 	if (minor)
 		drm_dev_get(minor->dev);
-	spin_unlock_irqrestore(&drm_minor_lock, flags);
+	xa_unlock(minor_xa);
 
 	if (!minor) {
 		return ERR_PTR(-ENODEV);
@@ -1036,7 +1034,7 @@ static int drm_stub_open(struct inode *inode, struct file *filp)
 
 	DRM_DEBUG("\n");
 
-	minor = drm_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&drm_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -1071,7 +1069,7 @@ static void drm_core_exit(void)
 	unregister_chrdev(DRM_MAJOR, "drm");
 	debugfs_remove(drm_debugfs_root);
 	drm_sysfs_destroy();
-	idr_destroy(&drm_minors_idr);
+	WARN_ON(!xa_empty(&drm_minors_xa));
 	drm_connector_ida_destroy();
 }
 
@@ -1080,7 +1078,6 @@ static int __init drm_core_init(void)
 	int ret;
 
 	drm_connector_ida_init();
-	idr_init(&drm_minors_idr);
 	drm_memcpy_init_early();
 
 	ret = drm_sysfs_init();
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 714e42b05108..f917b259b334 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -364,7 +364,7 @@ int drm_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int retcode;
 
-	minor = drm_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&drm_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 690505a1f7a5..12acf44c4e24 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -81,10 +81,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
 void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				 uint32_t handle);
 
-/* drm_drv.c */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id);
-void drm_minor_release(struct drm_minor *minor);
-
 /* drm_managed.c */
 void drm_managed_release(struct drm_device *dev);
 void drmm_add_final_kfree(struct drm_device *dev, void *container);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da57947130cc..e01b1332d245 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 */
 	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
 
+	/*
+	 *  Problems seen with concurrent commands
+	 */
+	NVME_QUIRK_QDEPTH_ONE			= (1 << 6),
+
 	/*
 	 * Set MEDIUM priority on SQ creation
 	 */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0533f3f64cb..7990c3f22ecf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2563,15 +2563,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	else
 		dev->io_sqes = NVME_NVM_IOSQES;
 
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
+	if (dev->ctrl.quirks & NVME_QUIRK_QDEPTH_ONE) {
 		dev->q_depth = 2;
-		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
-			"set queue depth=%u to work around controller resets\n",
-			dev->q_depth);
 	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
 		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
 		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
@@ -3442,6 +3435,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
+		.driver_data = NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
@@ -3576,7 +3571,12 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
-		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
+		/*
+		 * Fix for the Apple controller found in the MacBook8,1 and
+		 * some MacBook7,1 to avoid controller resets and data loss.
+		 */
+		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
+				NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3cffa6c79538..7c0cea2c828d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
 	{}
 };
@@ -2128,6 +2129,21 @@ void rapl_remove_package(struct rapl_package *rp)
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms use per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1 CLX-AP platform has per-DIE package energy counter
+ *	2.2 Other platforms that uses MSR RAPL are single die systems so the
+ *          package energy counter can be considered as per-PKG/per-DIE,
+ *          here it is considered as per-DIE.
+ *	2.3 New platforms that use TPMI RAPL doesn't care about the
+ *	    scope because they are not MSR/CPU based.
+ */
+#define rapl_msrs_are_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 /* caller to ensure CPU hotplug lock is held */
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
 							 bool id_is_cpu)
@@ -2135,8 +2151,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	struct rapl_package *rp;
 	int uid;
 
-	if (id_is_cpu)
-		uid = topology_logical_die_id(id);
+	if (id_is_cpu) {
+		uid = rapl_msrs_are_pkg_scope() ?
+		      topology_physical_package_id(id) : topology_logical_die_id(id);
+		if (uid < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return NULL;
+		}
+	}
 	else
 		uid = id;
 
@@ -2168,9 +2190,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 		return ERR_PTR(-ENOMEM);
 
 	if (id_is_cpu) {
-		rp->id = topology_logical_die_id(id);
+		rp->id = rapl_msrs_are_pkg_scope() ?
+			 topology_physical_package_id(id) : topology_logical_die_id(id);
+		if ((int)(rp->id) < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
 		rp->lead_cpu = id;
-		if (topology_max_dies_per_package() > 1)
+		if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..34e46ef308ab 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -754,7 +754,7 @@ static struct urb *usbtmc_create_urb(void)
 	if (!urb)
 		return NULL;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
+	dmabuf = kzalloc(bufsize, GFP_KERNEL);
 	if (!dmabuf) {
 		usb_free_urb(urb);
 		return NULL;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..8e327fcb222f 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -118,6 +118,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 732f9b13ad5d..d60eda7f6eda 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -171,3 +171,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index f4d3784b1dce..8867ce0be94c 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -51,11 +51,10 @@
 
 #if IS_ENABLED(CONFIG_DRM_ACCEL)
 
+extern struct xarray accel_minors_xa;
+
 void accel_core_exit(void);
 int accel_core_init(void);
-void accel_minor_remove(int index);
-int accel_minor_alloc(void);
-void accel_minor_replace(struct drm_minor *minor, int index);
 void accel_set_device_instance_params(struct device *kdev, int index);
 int accel_open(struct inode *inode, struct file *filp);
 void accel_debugfs_init(struct drm_device *dev);
@@ -73,19 +72,6 @@ static inline int __init accel_core_init(void)
 	return 0;
 }
 
-static inline void accel_minor_remove(int index)
-{
-}
-
-static inline int accel_minor_alloc(void)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline void accel_minor_replace(struct drm_minor *minor, int index)
-{
-}
-
 static inline void accel_set_device_instance_params(struct device *kdev, int index)
 {
 }
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..8c0030c77308 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -45,6 +45,8 @@ struct drm_printer;
 struct device;
 struct file;
 
+extern struct xarray drm_minors_xa;
+
 /*
  * FIXME: Not sure we want to have drm_minor here in the end, but to avoid
  * header include loops we need it here for now.
@@ -434,6 +436,9 @@ static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 
 void drm_file_update_pid(struct drm_file *);
 
+struct drm_minor *drm_minor_acquire(struct xarray *minors_xa, unsigned int minor_id);
+void drm_minor_release(struct drm_minor *minor);
+
 int drm_open(struct inode *inode, struct file *filp);
 int drm_open_helper(struct file *filp, struct drm_minor *minor);
 ssize_t drm_read(struct file *filp, char __user *buffer,
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 12cdff640492..0a8883a93e83 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -61,8 +61,8 @@ static noinline int nft_socket_cgroup_subtree_level(void)
 	struct cgroup *cgrp = cgroup_get_from_path("/");
 	int level;
 
-	if (!cgrp)
-		return -ENOENT;
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
 
 	level = cgrp->level;
 
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 4422cec81e3c..04bd605fdce3 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -321,6 +321,8 @@ int acp_init(struct acp_chip_info *chip)
 		pr_err("ACP reset failed\n");
 		return ret;
 	}
+	if (chip->acp_rev >= ACP70_DEV)
+		writel(0, chip->base + ACP_ZSC_DSP_CTRL);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_init, SND_SOC_ACP_COMMON);
@@ -336,6 +338,9 @@ int acp_deinit(struct acp_chip_info *chip)
 
 	if (chip->acp_rev != ACP70_DEV)
 		writel(0, chip->base + ACP_CONTROL);
+
+	if (chip->acp_rev >= ACP70_DEV)
+		writel(0x01, chip->base + ACP_ZSC_DSP_CTRL);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_deinit, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 87a4813783f9..c095a34a7229 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -103,6 +103,8 @@
 #define ACP70_PGFSM_CONTROL			ACP6X_PGFSM_CONTROL
 #define ACP70_PGFSM_STATUS			ACP6X_PGFSM_STATUS
 
+#define ACP_ZSC_DSP_CTRL			0x0001014
+#define ACP_ZSC_STS				0x0001018
 #define ACP_SOFT_RST_DONE_MASK	0x00010001
 
 #define ACP_PGFSM_CNTL_POWER_ON_MASK            0xffffffff

