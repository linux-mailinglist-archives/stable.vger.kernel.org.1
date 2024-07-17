Return-Path: <stable+bounces-60498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5F9344C3
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BC1283866
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144D5579F;
	Wed, 17 Jul 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtsjuEEN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E24D8AF
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255077; cv=none; b=ikqJblOgVqaYjCzckIqQuTVfIcp5GUnUwBkTfFV3cK33WRqEwpzOKkEELxQ6cnWY2V0F26FpJnUoeuyqYYqWVWR15pFgHW0Ah40I8tdzAOEc7r1N3dcKBb7eO/zpS31AH70SJSgeeZBHtPrKULP+L5F9oirnWU9TiGkt5JJWgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255077; c=relaxed/simple;
	bh=U735gPL/j4/gNkZpIZj10CDDwOkKG7qvXtx9agyPju4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tsd809rhnvHnJp4zlBKGD6dUbpnD3g+BKUsQ2KFbUZ5DAx3s1ks2OEUwMF90fm6fWxqY9ZOIX+mBt5asphLAVY++hs9mllohSfmMYD2zkiuXu500T58t8QOEP3rsh/xMG9ou/KTZtcFbE9MxR6OQ3N+LHcqQivVTf631Xsy9WVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtsjuEEN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654c14abdcfso5098477b3.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255074; x=1721859874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLfk3WKZqMTvBKd64i6B/HOksUTK2sb8iIXkimCFQM=;
        b=WtsjuEENOZRIG63ydjGdZH+zB/mTTX1FrMa9aMXn2ie9UHAG3qWCZPUzTUjPMfpkwJ
         43NSXBom3kriptX3ASUiy9wcPhe0vUp+2pLqp/PXwI/xMek25DqAx9rwPI+6rrC9Ti9f
         GWI6ObXEKI6RdBkmqfb4ftJs8cZJiVooKSmOStegocIEM7dLvZJzKc2pBQM+mxDCWdUc
         m/nQKj5NzX6KILVFoTXBl/XzkpnAp9BSdI79izn7cDz078MUueR09jmECbazG7uAXVGG
         8nqu/h88psSMNGDj/tiR645QamqOeNDdnHbCqIVBSufQ3RauhRmOpBpcRqNB4j0Y4Dgb
         k5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255074; x=1721859874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLfk3WKZqMTvBKd64i6B/HOksUTK2sb8iIXkimCFQM=;
        b=skvZ5fzyFki3/zz9HbUR7uyYS3vLGX8Fu8d01ZrAQdcQ3+4HqhT4t8S7o59Z17zNGp
         Fb1nTJ7+ohMrjMZ9kro742ri+No3Onb2UqjTQnwdbhTfe00wFPRQ+lU+1cWFWWQHF8SR
         JMCQqU/ZJUM/EVhEbQ+epd69hfh4gRE227E+4/YuwvlmrIQxPVEaVgDTv2btEDMSF91z
         oIdlMXtiGF0OaW5mINa5MQO/oWPwaOo8Alw/mSpx8knyccSYKjqysTzYgjF6cnviBi2T
         8Lg+2YxL8MA90bQfHhDznmG6wknV0ya9mFnDAM8pmECYTbUluXJucA74eq0sglNMJCH7
         KyTQ==
X-Gm-Message-State: AOJu0YzAG4lPhvsVVJ1pPpydigZ4JOXCFBTFVtVlByQ6s9vV7GdY1rpM
	hFQIaXcpaYOQoIiVVWVQ4zFuwfdAnjJebTMlJ6E7UmWetlJCyjZk40iAK6Nzci7HJ2Htwb5OvC+
	x/JmlJR1EiXpSjni7HyAIsTUi1hCfe95I1wMWNlV9n2sZHNdvbyUssTTeaIwtc/Xw+lgDLlZ3Ty
	cUAv0S7JnE2t2V1p864KU3noGt6hd9gua4o3Nwhogw4Cf5IbiFbz334J4QdrFfomYzHI32mA==
X-Google-Smtp-Source: AGHT+IGCouqY3qXBhAPrZ6wvEyo1BAsuREg2PdFRGGE6O0pnpk9sCyfzUe+hPFbHoZJIUAjhm0fj6BPI5AYV1WJqT77p
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:120c:b0:e02:f35c:d398 with
 SMTP id 3f1490d57ef6-e05ff371065mr23222276.0.1721255073882; Wed, 17 Jul 2024
 15:24:33 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:27 -0700
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717222429.2011540-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-2-axelrasmussen@google.com>
Subject: [PATCH 6.6 1/3] vfio: Create vfio_fs_type with inode per device
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@redhat.com>

commit b7c5e64fecfa88764791679cca4786ac65de739e upstream.

By linking all the device fds we provide to userspace to an
address space through a new pseudo fs, we can use tools like
unmap_mapping_range() to zap all vmas associated with a device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240530045236.1005864-2-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 drivers/vfio/device_cdev.c |  7 ++++++
 drivers/vfio/group.c       |  7 ++++++
 drivers/vfio/vfio_main.c   | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h       |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f..bb1817bd4ff3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -39,6 +39,13 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 
 	filep->private_data = df;
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	return 0;
 
 err_put_registration:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429c6191..ded364588d29 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -286,6 +286,13 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	 */
 	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
 			 "(%s:%d)\n", current->comm, task_pid_nr(current));
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 40732e8ed4c6..a205d3a4e379 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -22,8 +22,10 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -43,9 +45,13 @@
 #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC	"VFIO - User Level meta-driver"
 
+#define VFIO_MAGIC 0x5646494f /* "VFIO" */
+
 static struct vfio {
 	struct class			*device_class;
 	struct ida			device_ida;
+	struct vfsmount			*vfs_mount;
+	int				fs_count;
 } vfio;
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -186,6 +192,8 @@ static void vfio_device_release(struct device *dev)
 	if (device->ops->release)
 		device->ops->release(device);
 
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
 	kvfree(device);
 }
 
@@ -228,6 +236,34 @@ struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(_vfio_alloc_device);
 
+static int vfio_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, VFIO_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type vfio_fs_type = {
+	.name = "vfio",
+	.owner = THIS_MODULE,
+	.init_fs_context = vfio_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static struct inode *vfio_fs_inode_new(void)
+{
+	struct inode *inode;
+	int ret;
+
+	ret = simple_pin_fs(&vfio_fs_type, &vfio.vfs_mount, &vfio.fs_count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	inode = alloc_anon_inode(vfio.vfs_mount->mnt_sb);
+	if (IS_ERR(inode))
+		simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+
+	return inode;
+}
+
 /*
  * Initialize a vfio_device so it can be registered to vfio core.
  */
@@ -246,6 +282,11 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	init_completion(&device->comp);
 	device->dev = dev;
 	device->ops = ops;
+	device->inode = vfio_fs_inode_new();
+	if (IS_ERR(device->inode)) {
+		ret = PTR_ERR(device->inode);
+		goto out_inode;
+	}
 
 	if (ops->init) {
 		ret = ops->init(device);
@@ -260,6 +301,9 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return 0;
 
 out_uninit:
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+out_inode:
 	vfio_release_device_set(device);
 	ida_free(&vfio.device_ida, device->index);
 	return ret;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 5ac5f182ce0b..514a7f9b3ef4 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -64,6 +64,7 @@ struct vfio_device {
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
 	void (*put_kvm)(struct kvm *kvm);
+	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
 	u8 iommufd_attached:1;
-- 
2.45.2.993.g49e7a77208-goog


