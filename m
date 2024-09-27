Return-Path: <stable+bounces-78019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3989884AE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F8FB21AB4
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CA18C03A;
	Fri, 27 Sep 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5GbdQKk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C518C02A;
	Fri, 27 Sep 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440198; cv=none; b=ggiXDwqc9difoTnXmW6jQfVnY+qaWTPLpkxyHnnz+2OeUfEeXLtj9Et1RwdpbULEb646szB7Esbz06eckA6i8xe8LFJC7CiZV4klerwE6hUoN3oWVBR/H+vCXIADsLo3oLPYE8Kvnx56idG4EgoeDrE4EvRecomf4NVnmJq3cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440198; c=relaxed/simple;
	bh=5Vf/j5PTcMHsWyaHEEhZ5mYlncKJhSaatW/iTyLA/GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNcCjCvpYkdeYuTcIELbjVS70zNFSngnEVgW6ZD1g8MEKCRfJLCdSfUxpigFyVUD46QDcJysd5FtKXboPKK083Wq2G2hwHURAWrt99mlB+1S9gkNDyUl/eVwyp76T0xXRLTrN3SUEcRrSRnLno7NwvzmZWnn1bxCFXSBAK4n8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5GbdQKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4A8C4CEC6;
	Fri, 27 Sep 2024 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440197;
	bh=5Vf/j5PTcMHsWyaHEEhZ5mYlncKJhSaatW/iTyLA/GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5GbdQKkYZxa3dJpz39sN4eVWAnAsgd3Bh+DARNuRz+ec/2JxnPZgeq2QeMuaF1Zs
	 tFEyBYrae+HHSCqKEggrXe0YoEoVgq7WUuXaTu0Ekn4s9/fat2Pt8bPPspILxK8eJ8
	 hiGAjsWZjTfdoQo1Vxc34POJ7FzdoHiLhEJVjoBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	James Zhu <James.Zhu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 01/12] drm: Use XArray instead of IDR for minors
Date: Fri, 27 Sep 2024 14:24:04 +0200
Message-ID: <20240927121715.266510250@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Winiarski <michal.winiarski@intel.com>

[ Upstream commit 5fbca8b48b3050ae7fb611a8b09af60012ed6de1 ]

IDR is deprecated, and since XArray manages its own state with internal
locking, it simplifies the locking on DRM side.
Additionally, don't use the IRQ-safe variant, since operating on drm
minor is not done in IRQ context.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Acked-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240823163048.2676257-2-michal.winiarski@intel.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_drv.c | 63 ++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 93543071a5008..ae675a588a1df 100644
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
+static DEFINE_XARRAY_ALLOC(drm_minors_xa);
 
 /*
  * If the drm core fails to init for whatever reason,
@@ -101,26 +101,23 @@ static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
 static void drm_minor_alloc_release(struct drm_device *dev, void *data)
 {
 	struct drm_minor *minor = data;
-	unsigned long flags;
 
 	WARN_ON(dev != minor->dev);
 
 	put_device(minor->kdev);
 
-	if (minor->type == DRM_MINOR_ACCEL) {
+	if (minor->type == DRM_MINOR_ACCEL)
 		accel_minor_remove(minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_remove(&drm_minors_idr, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	else
+		xa_erase(&drm_minors_xa, minor->index);
 }
 
+#define DRM_MINOR_LIMIT(t) ({ typeof(t) _t = (t); XA_LIMIT(64 * _t, 64 * _t + 63); })
+
 static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
-	int r;
+	int index, r;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
 	if (!minor)
@@ -129,24 +126,17 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 	minor->type = type;
 	minor->dev = dev;
 
-	idr_preload(GFP_KERNEL);
 	if (type == DRM_MINOR_ACCEL) {
 		r = accel_minor_alloc();
+		index = r;
 	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		r = idr_alloc(&drm_minors_idr,
-			NULL,
-			64 * type,
-			64 * (type + 1),
-			GFP_NOWAIT);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
+		r = xa_alloc(&drm_minors_xa, &index, NULL, DRM_MINOR_LIMIT(type), GFP_KERNEL);
 	}
-	idr_preload_end();
 
 	if (r < 0)
 		return r;
 
-	minor->index = r;
+	minor->index = index;
 
 	r = drmm_add_action_or_reset(dev, drm_minor_alloc_release, minor);
 	if (r)
@@ -163,7 +153,7 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
+	void *entry;
 	int ret;
 
 	DRM_DEBUG("\n");
@@ -189,9 +179,12 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 	if (minor->type == DRM_MINOR_ACCEL) {
 		accel_minor_replace(minor, minor->index);
 	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, minor, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
+		entry = xa_store(&drm_minors_xa, minor->index, minor, GFP_KERNEL);
+		if (xa_is_err(entry)) {
+			ret = xa_err(entry);
+			goto err_debugfs;
+		}
+		WARN_ON(entry);
 	}
 
 	DRM_DEBUG("new minor registered %d\n", minor->index);
@@ -205,20 +198,16 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
 	minor = *drm_minor_get_slot(dev, type);
 	if (!minor || !device_is_registered(minor->kdev))
 		return;
 
 	/* replace @minor with NULL so lookups will fail from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
+	if (minor->type == DRM_MINOR_ACCEL)
 		accel_minor_replace(NULL, minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, NULL, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	else
+		xa_store(&drm_minors_xa, minor->index, NULL, GFP_KERNEL);
 
 	device_del(minor->kdev);
 	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
@@ -237,13 +226,12 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
 struct drm_minor *drm_minor_acquire(unsigned int minor_id)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_minor_lock, flags);
-	minor = idr_find(&drm_minors_idr, minor_id);
+	xa_lock(&drm_minors_xa);
+	minor = xa_load(&drm_minors_xa, minor_id);
 	if (minor)
 		drm_dev_get(minor->dev);
-	spin_unlock_irqrestore(&drm_minor_lock, flags);
+	xa_unlock(&drm_minors_xa);
 
 	if (!minor) {
 		return ERR_PTR(-ENODEV);
@@ -1071,7 +1059,7 @@ static void drm_core_exit(void)
 	unregister_chrdev(DRM_MAJOR, "drm");
 	debugfs_remove(drm_debugfs_root);
 	drm_sysfs_destroy();
-	idr_destroy(&drm_minors_idr);
+	WARN_ON(!xa_empty(&drm_minors_xa));
 	drm_connector_ida_destroy();
 }
 
@@ -1080,7 +1068,6 @@ static int __init drm_core_init(void)
 	int ret;
 
 	drm_connector_ida_init();
-	idr_init(&drm_minors_idr);
 	drm_memcpy_init_early();
 
 	ret = drm_sysfs_init();
-- 
2.43.0




