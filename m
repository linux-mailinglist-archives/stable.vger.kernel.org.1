Return-Path: <stable+bounces-60491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E19343F4
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C44028448E
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67D18A954;
	Wed, 17 Jul 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRvrmgrk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B65187355
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252029; cv=none; b=WvCHYkipp0n/iD5f4VVnMGu3T6oVfSU5VY1aDcTS0gPCzQ6sAlyeZr9bOUHFyrlqyH6hdky8WlCgrrnQ9GBBXRPQGNQ9Cf2veiArPPoq9V9PTXuESFY0+P8ehOobFYidJJ+k1UwZXi+7Aaz6hLdeewluAPo8Krm3BSap4Se1c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252029; c=relaxed/simple;
	bh=w58AnK/9cYSCW/0hjde3wNFPdaQA6i/Jsz5cMviAgzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzW+4R7il/MW1Jk9J1FyFjwPGjK7AyJmss4/M25lPxnYZ/RUfaRHbXv7fXw0LXcKYpaiyoznAq3T0zuxfMbfqqijVdvbL9zU2NU5UuhwKZ/G4d6/dbj7FPb5/zs5/bGg+NZrzzBh0NLOOmpXo3L9t/GrUJAltzd6EesxNMhy61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRvrmgrk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650ab31aabdso2237967b3.3
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721252026; x=1721856826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFqYg+YWN8lw8m2oONz34aZr3QiDMRuKYi+jOTj3Buo=;
        b=DRvrmgrkuU5VYNQVRbyN5Gb1OlDqrMhzaEelelm5PKy4gze9dkdTPl9M1uYTNNtHp7
         xvxu3d6eIDBgmoatlw1dpAaIK7VcHbx3Ya5h5ciiM0EHP1bg0BFDLW4uEVl0RLU5NeTW
         gvYKfI9myeK9Rewfqc72DRjW60FefLA0Tpgnf/V/Albp9gizM9ZQ7zE5SojyIb8M/3XQ
         G3SitEmXzu3tXVb8tTUgfcC76kkLH4oGswJnXMfqXVvf235/fKECZKvsRTX682/raFIk
         VbzAzpePrf8R4itZuZ5USwRH+GMKpGSTwnfvn+ZGSY8CA4RPzMwiml+Wl8gIsdmOlL3H
         yr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252026; x=1721856826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFqYg+YWN8lw8m2oONz34aZr3QiDMRuKYi+jOTj3Buo=;
        b=V2dymnPfj7addMbubgJBrXk8tMbI5ZvtrTD0J2IMR6ZZSX80rcA7uNPgdyR7r7P0Kv
         wrE/J0i4pkWf7tFrjkeo7j8bmw8msRnuaSBZYOCEFw4cFsJRtRskTNeracQwQNK6tqsf
         +jALjgC8hGaSZcM6+xA8nyoFpd9KkcNxb5TyB5KjVrjPmw6coj4m6gDCE2uIzlo+Mi8P
         l5gv5i2uIkHgMDd/Cm0yXrgSnTjm/CzJh0in49ivVtfSYsT8LH5X97ruldEupBRIerhP
         1eJQre343v9PrtqSMN6WMbRljJbh5qj+/YSLLei7hEEg8X2FLhwQZ2QXyfJjYzf9/wZM
         c6GQ==
X-Gm-Message-State: AOJu0Yw0LP07sAfHYqaXZzywdsEHhGiQ6CiHNubKsWUaDwmjIzIz1mR5
	QTiS/7cODCQfWnYIY9DtA8gXheD3iy/i5nyN8bmphY0Ty5ujtVzn0tSj6Hb9Hr147akIEL094Gu
	D+sR5Uec3y9JOD1ICKUVvh+4Ypewb1re8vtKoC6krz5BzdNaD9Uan/YPQWmq6adm1MID4raOO9b
	Lz6aann8NWavKai5M5I96HJzW7nj3HqFTGIiasmNt0jB4BXysKPgkmozzEgu+6EIni7AWstA==
X-Google-Smtp-Source: AGHT+IEvWAa/WVkj4a7IeqojFpVPagMimkl7uCbjdcqjK6SqV8Cb7d3Zi1aZGbLEHZostrBZpYlyRysM4WfF8ysd/RDf
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:6605:b0:62c:f01d:3470 with
 SMTP id 00721157ae682-66604d73884mr354997b3.6.1721252025952; Wed, 17 Jul 2024
 14:33:45 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:37 -0700
In-Reply-To: <20240717213339.1921530-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717213339.1921530-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717213339.1921530-2-axelrasmussen@google.com>
Subject: [PATCH 6.9 1/3] vfio: Create vfio_fs_type with inode per device
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
index e97d796a54fb..a5a62d9d963f 100644
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
index 8b1a29820409..000a6cab2d31 100644
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


