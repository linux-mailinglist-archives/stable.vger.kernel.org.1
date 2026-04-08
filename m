Return-Path: <stable+bounces-234379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P5uMumd1mkEGwgAu9opvQ
	(envelope-from <stable+bounces-234379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4A3C0BAB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC54B303236C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B63D564E;
	Wed,  8 Apr 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLCXt97e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB873D4134;
	Wed,  8 Apr 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672706; cv=none; b=WYStBz4AD8oDk+4M7xiJBiArQGkA/skBWfKeKWjj89zDBtHfHpXa3I/j/bK/BhGBPdj4WjlPzFAC5Rl0QtWFP5D0MeCmP9SWMqT6oLcvYD9YL9S0nohcmgKMpKRpumEcDRA/ki9uSODtNHvQoTn1u4GF6C8wWMQ+ciHuvlDS+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672706; c=relaxed/simple;
	bh=pq408kuXVjbvhDINshqMRt4oWCr/h9fqJ0rv7UyDNyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9hmt9c1bfey/Dhwx/oZWU7bhM48DdTPEFx/p7jWsdsAz8ymjUKrOkOCD/Q5JKjXusMYwCsC7ncNYYPxtgDwIWDPEO981RNul5thpwQj9FP6eVtvSLqJpYRRNxMzHM9Uf/62EXkKMil+YmwQ99AEGOge4PE9nRLAcW7/QmUU21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLCXt97e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D15C19421;
	Wed,  8 Apr 2026 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672706;
	bh=pq408kuXVjbvhDINshqMRt4oWCr/h9fqJ0rv7UyDNyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLCXt97euzDargsXUQN5O6622LSr0y7dCcqBOh3Wx5twrgOqdwDwMGYWOwkfTeYh8
	 TNibAjn0aRTKMTs7p/8r66zC7541CmwhFwrkGF6Ia+r9NStnSfAmjv70JwGMSiJzmt
	 E7olGu8bmfSgDHnU2CWnf9EjkuKWcPfPKBTee0kM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Tugrul Kukul <tugrul.kukul@est.tech>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Pavel Machek (CIP)" <pavel@denx.de>,
	Ron Economos <re@w6rz.net>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/160] vfio: Create vfio_fs_type with inode per device
Date: Wed,  8 Apr 2026 20:03:18 +0200
Message-ID: <20260408175917.326372651@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234379-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nvidia.com,intel.com,redhat.com,google.com,est.tech,broadcom.com,denx.de,w6rz.net,fedoraproject.org,kernel.org,microchip.com,googlemail.com,shazbot.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4A4A3C0BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Pavel Machek (CIP) <pavel@denx.de>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/device_cdev.c |  7 ++++++
 drivers/vfio/group.c       |  7 ++++++
 drivers/vfio/vfio_main.c   | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h       |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f8..bb1817bd4ff31 100644
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
index 54c3079031e16..4cd857ff0259b 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -285,6 +285,13 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
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
index 6dfb290c339f9..ec4fbd993bf00 100644
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
index 5ac5f182ce0bb..514a7f9b3ef4b 100644
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
2.53.0




