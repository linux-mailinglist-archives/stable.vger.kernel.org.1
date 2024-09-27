Return-Path: <stable+bounces-78006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AC988499
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671E91F22768
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731218BB91;
	Fri, 27 Sep 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJjBMFMy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3717B515;
	Fri, 27 Sep 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440161; cv=none; b=Wan66nZHiSix0i1dCbH9nWqJ9sjnuexsvobgimP9YPrj4P/xsfDbbJelDJ+lSSCx7cPoLhgS8erawZlASnzMW6FKEpw/SGtvurLEuZc4vc12o5hGLQSztAIL6wPpsFO1x9PvRfwdjIel8nCkV6ZmIx0gmI0O4YEswWhYAZEvpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440161; c=relaxed/simple;
	bh=fBlJbVwjG0us6YO54+UYFTPvxgaUohjn/GexFTjVZN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqwapHSDyI1TOAwQ74oNyUKHthOXgMRTmEDDWnE7ia6rdWcYLo4gqtq/dfTdbjrsShqBWqXxyC1Wdpy2MecXcyCczbLfJTmPqKjXa3p6dKaZg95v5r3qksb9/G50dujPWB4rGjhU5PnptP6OJifYKTmnxT0tFhezcIMkMJGbhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJjBMFMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F9C4CEC4;
	Fri, 27 Sep 2024 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440161;
	bh=fBlJbVwjG0us6YO54+UYFTPvxgaUohjn/GexFTjVZN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJjBMFMyzO0jD1bntUWLtjgPM3qFJ+GfwsQzvVVrsx75/cktQsLp4ZGTslgK4X3Lu
	 54IfZi8HwiTiZ6IZ8KzC240rqZgOczGbrHaJtP/oVrSdx6wW+M4SR3J6bVo0aSzqnK
	 JSABxb48C7V/0amg+zeQqxI9SrKiI8/GwFF96Ulw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	James Zhu <James.Zhu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 47/58] accel: Use XArray instead of IDR for minors
Date: Fri, 27 Sep 2024 14:23:49 +0200
Message-ID: <20240927121720.714672239@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Winiarski <michal.winiarski@intel.com>

[ Upstream commit 45c4d994b82b08f0ce5eb50f8da29379c92a391e ]

Accel minor management is based on DRM (and is also using struct
drm_minor internally), since DRM is using XArray for minors, it makes
sense to also convert accel.
As the two implementations are identical (only difference being the
underlying xarray), move the accel_minor_* functionality to DRM.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Acked-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240823163048.2676257-3-michal.winiarski@intel.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/drm_accel.c      | 110 +++------------------------------
 drivers/gpu/drm/drm_drv.c      |  66 ++++++++++----------
 drivers/gpu/drm/drm_file.c     |   2 +-
 drivers/gpu/drm/drm_internal.h |   4 --
 include/drm/drm_accel.h        |  18 +-----
 include/drm/drm_file.h         |   5 ++
 6 files changed, 47 insertions(+), 158 deletions(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 16c3edb8c46ee..aa826033b0ceb 100644
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
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 40cd4faca2b1e..a5f7b24324e30 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -55,7 +55,7 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
 MODULE_DESCRIPTION("DRM shared core routines");
 MODULE_LICENSE("GPL and additional rights");
 
-static DEFINE_XARRAY_ALLOC(drm_minors_xa);
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
@@ -106,18 +118,18 @@ static void drm_minor_alloc_release(struct drm_device *dev, void *data)
 
 	put_device(minor->kdev);
 
-	if (minor->type == DRM_MINOR_ACCEL)
-		accel_minor_remove(minor->index);
-	else
-		xa_erase(&drm_minors_xa, minor->index);
+	xa_erase(drm_minor_get_xa(minor->type), minor->index);
 }
 
-#define DRM_MINOR_LIMIT(t) ({ typeof(t) _t = (t); XA_LIMIT(64 * _t, 64 * _t + 63); })
+#define DRM_MINOR_LIMIT(t) ({ \
+	typeof(t) _t = (t); \
+	_t == DRM_MINOR_ACCEL ? XA_LIMIT(0, ACCEL_MAX_MINORS) : XA_LIMIT(64 * _t, 64 * _t + 63); \
+})
 
 static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	int index, r;
+	int r;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
 	if (!minor)
@@ -126,18 +138,11 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 	minor->type = type;
 	minor->dev = dev;
 
-	if (type == DRM_MINOR_ACCEL) {
-		r = accel_minor_alloc();
-		index = r;
-	} else {
-		r = xa_alloc(&drm_minors_xa, &index, NULL, DRM_MINOR_LIMIT(type), GFP_KERNEL);
-	}
-
+	r = xa_alloc(drm_minor_get_xa(type), &minor->index,
+		     NULL, DRM_MINOR_LIMIT(type), GFP_KERNEL);
 	if (r < 0)
 		return r;
 
-	minor->index = index;
-
 	r = drmm_add_action_or_reset(dev, drm_minor_alloc_release, minor);
 	if (r)
 		return r;
@@ -176,16 +181,12 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 		goto err_debugfs;
 
 	/* replace NULL with @minor so lookups will succeed from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_replace(minor, minor->index);
-	} else {
-		entry = xa_store(&drm_minors_xa, minor->index, minor, GFP_KERNEL);
-		if (xa_is_err(entry)) {
-			ret = xa_err(entry);
-			goto err_debugfs;
-		}
-		WARN_ON(entry);
+	entry = xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KERNEL);
+	if (xa_is_err(entry)) {
+		ret = xa_err(entry);
+		goto err_debugfs;
 	}
+	WARN_ON(entry);
 
 	DRM_DEBUG("new minor registered %d\n", minor->index);
 	return 0;
@@ -204,10 +205,7 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
 		return;
 
 	/* replace @minor with NULL so lookups will fail from now on */
-	if (minor->type == DRM_MINOR_ACCEL)
-		accel_minor_replace(NULL, minor->index);
-	else
-		xa_store(&drm_minors_xa, minor->index, NULL, GFP_KERNEL);
+	xa_store(drm_minor_get_xa(type), minor->index, NULL, GFP_KERNEL);
 
 	device_del(minor->kdev);
 	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
@@ -223,15 +221,15 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
  * minor->dev pointer will stay valid! However, the device may get unplugged and
  * unregistered while you hold the minor.
  */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id)
+struct drm_minor *drm_minor_acquire(struct xarray *minor_xa, unsigned int minor_id)
 {
 	struct drm_minor *minor;
 
-	xa_lock(&drm_minors_xa);
-	minor = xa_load(&drm_minors_xa, minor_id);
+	xa_lock(minor_xa);
+	minor = xa_load(minor_xa, minor_id);
 	if (minor)
 		drm_dev_get(minor->dev);
-	xa_unlock(&drm_minors_xa);
+	xa_unlock(minor_xa);
 
 	if (!minor) {
 		return ERR_PTR(-ENODEV);
@@ -1024,7 +1022,7 @@ static int drm_stub_open(struct inode *inode, struct file *filp)
 
 	DRM_DEBUG("\n");
 
-	minor = drm_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&drm_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 714e42b051080..f917b259b3342 100644
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
index 690505a1f7a5d..12acf44c4e240 100644
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
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index f4d3784b1dce0..8867ce0be94cd 100644
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
index ab230d3af138d..8c0030c773081 100644
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
-- 
2.43.0




