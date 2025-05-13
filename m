Return-Path: <stable+bounces-144168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB309AB5581
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E621B46654
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E451268699;
	Tue, 13 May 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZY80PM9d"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EB347C7
	for <stable@vger.kernel.org>; Tue, 13 May 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141476; cv=none; b=cXPGAad2VLfoRpXFucq8o2W0NVLIOyVfqT71uN4LTTwRF4ekKQ4vFzoZiz9WlWudxQvhMVJsNFWkJOiBaAk7g16aB5bX+zaahpdIRHdVEdKBJ46NZ8iiErzrzMFc7rvbb7PJXMq/t3GKyI8dxwPQTRzGz5bG5Az2IfBFkGobKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141476; c=relaxed/simple;
	bh=OYSWvsk8j58fMudxqBNhaL/Rh7NSGIrU9RsZNFRlllo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qb7crFGOlEGowUl5Y1X3dOIG71pM3U0j+19ddO6lER2S0lwdkScSrTeTBUKSz4IO7wK7mc0cLZ6thZ5DnpnGPJBjpggIw88cCfarMfAlSAyOgl4gn1ESoZC/kBPRtEsDNJNk0Gi60gM2MrXtgHOhA2GwNVqgh2eyCHWraCGjFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZY80PM9d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6EE73201DB10
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:04:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EE73201DB10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747141474;
	bh=XUdWjenqRovr531P6T+uIRTKDS6pZGhdWmCxxIBL7Hk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZY80PM9dXZ4ZZvOlsgoDABEbYSDtFKWzZmIsz2OniGymU/HE8QCy9wMutXBSIc+1N
	 waqze21/iv8Z+3tqAOIwa45JqiSaLPfDWq9R6nCxMPBFMzD4qb6sXoKuib+PkB6WpP
	 opQN5Cj6zrJmCYIOuCc+reXoHaO9RsPzkdd/8miQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] uio_hv_generic: Fix sysfs creation path for ring buffer
Date: Tue, 13 May 2025 18:34:26 +0530
Message-Id: <20250513130426.1636-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025051209-overturn-supreme-26f1@gregkh>
References: <2025051209-overturn-supreme-26f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On regular bootup, devices get registered to VMBus first, so when
uio_hv_generic driver for a particular device type is probed,
the device is already initialized and added, so sysfs creation in
hv_uio_probe() works fine. However, when the device is removed
and brought back, the channel gets rescinded and the device again gets
registered to VMBus. However this time, the uio_hv_generic driver is
already registered to probe for that device and in this case sysfs
creation is tried before the device's kobject gets initialized
completely.

Fix this by moving the core logic of sysfs creation of ring buffer,
from uio_hv_generic to HyperV's VMBus driver, where the rest of the
sysfs attributes for the channels are defined. While doing that, make
use of attribute groups and macros, instead of creating sysfs
directly, to ensure better error handling and code flow.

Problematic path:
vmbus_process_offer (A new offer comes for the VMBus device)
  vmbus_add_channel_work
    vmbus_device_register
      |-> device_register
      |     |...
      |     |-> hv_uio_probe
      |           |...
      |           |-> sysfs_create_bin_file (leads to a warning as
      |                 the primary channel's kobject, which is used to
      |                 create the sysfs file, is not yet initialized)
      |-> kset_create_and_add
      |-> vmbus_add_channel_kobj (initialization of the primary
                                  channel's kobject happens later)

Above code flow is sequential and the warning is always reproducible in
this path.

Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
Cc: stable@kernel.org
Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250502074811.2022-2-namjain@linux.microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit f31fe8165d365379d858c53bef43254c7d6d1cfd)
---
 drivers/hv/hyperv_vmbus.h    |   6 +++
 drivers/hv/vmbus_drv.c       | 100 ++++++++++++++++++++++++++++++++++-
 drivers/uio/uio_hv_generic.c |  39 ++++++--------
 include/linux/hyperv.h       |   6 +++
 4 files changed, 128 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 787b15068641..855be6a44095 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -486,4 +486,10 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
 
 #endif /* CONFIG_HYPERV_TESTING */
 
+/* Create and remove sysfs entry for memory mapped ring buffers for a channel */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma));
+int hv_remove_ring_sysfs(struct vmbus_channel *channel);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c54d759b0738..234d19739185 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1774,6 +1774,27 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR_RO(subchannel_id);
 
+static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
+				       struct bin_attribute *attr,
+				       struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
+
+	/*
+	 * hv_(create|remove)_ring_sysfs implementation ensures that mmap_ring_buffer
+	 * is not NULL.
+	 */
+	return channel->mmap_ring_buffer(channel, vma);
+}
+
+static struct bin_attribute chan_attr_ring_buffer = {
+	.attr = {
+		.name = "ring",
+		.mode = 0600,
+	},
+	.size = 2 * SZ_2M,
+	.mmap = hv_mmap_ring_buffer_wrapper,
+};
 static struct attribute *vmbus_chan_attrs[] = {
 	&chan_attr_out_mask.attr,
 	&chan_attr_in_mask.attr,
@@ -1793,6 +1814,11 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
+static struct bin_attribute *vmbus_chan_bin_attrs[] = {
+	&chan_attr_ring_buffer,
+	NULL
+};
+
 /*
  * Channel-level attribute_group callback function. Returns the permission for
  * each attribute, and returns 0 if an attribute is not visible.
@@ -1813,9 +1839,24 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
+static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int idx)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
+	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
+		return 0;
+
+	return attr->attr.mode;
+}
+
 static struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
-	.is_visible = vmbus_chan_attr_is_visible
+	.bin_attrs = vmbus_chan_bin_attrs,
+	.is_visible = vmbus_chan_attr_is_visible,
+	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
 };
 
 static struct kobj_type vmbus_chan_ktype = {
@@ -1823,6 +1864,63 @@ static struct kobj_type vmbus_chan_ktype = {
 	.release = vmbus_chan_release,
 };
 
+/**
+ * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding to ring buffers for a channel.
+ * @channel: Pointer to vmbus_channel structure
+ * @hv_mmap_ring_buffer: function pointer for initializing the function to be called on mmap of
+ *                       channel's "ring" sysfs node, which is for the ring buffer of that channel.
+ *                       Function pointer is of below type:
+ *                       int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+ *                                                  struct vm_area_struct *vma))
+ *                       This has a pointer to the channel and a pointer to vm_area_struct,
+ *                       used for mmap, as arguments.
+ *
+ * Sysfs node for ring buffer of a channel is created along with other fields, however its
+ * visibility is disabled by default. Sysfs creation needs to be controlled when the use-case
+ * is running.
+ * For example, HV_NIC device is used either by uio_hv_generic or hv_netvsc at any given point of
+ * time, and "ring" sysfs is needed only when uio_hv_generic is bound to that device. To avoid
+ * exposing the ring buffer by default, this function is reponsible to enable visibility of
+ * ring for userspace to use.
+ * Note: Race conditions can happen with userspace and it is not encouraged to create new
+ * use-cases for this. This was added to maintain backward compatibility, while solving
+ * one of the race conditions in uio_hv_generic while creating sysfs.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma))
+{
+	struct kobject *kobj = &channel->kobj;
+
+	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
+	channel->ring_sysfs_visible = true;
+
+	return sysfs_update_group(kobj, &vmbus_chan_group);
+}
+EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
+
+/**
+ * hv_remove_ring_sysfs() - remove ring sysfs entry corresponding to ring buffers for a channel.
+ * @channel: Pointer to vmbus_channel structure
+ *
+ * Hide "ring" sysfs for a channel by changing its is_visible attribute and updating sysfs group.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int hv_remove_ring_sysfs(struct vmbus_channel *channel)
+{
+	struct kobject *kobj = &channel->kobj;
+	int ret;
+
+	channel->ring_sysfs_visible = false;
+	ret = sysfs_update_group(kobj, &vmbus_chan_group);
+	channel->mmap_ring_buffer = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
+
 /*
  * vmbus_add_channel_kobj - setup a sub-directory under device/channels
  */
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index a2c7abf8c289..a54003e8318d 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -129,15 +129,12 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 	vmbus_device_unregister(channel->device_obj);
 }
 
-/* Sysfs API to allow mmap of the ring buffers
+/* Function used for mmap of ring buffer sysfs interface.
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
-static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *attr,
-			    struct vm_area_struct *vma)
+static int
+hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
 {
-	struct vmbus_channel *channel
-		= container_of(kobj, struct vmbus_channel, kobj);
 	void *ring_buffer = page_address(channel->ringbuffer_page);
 
 	if (channel->state != CHANNEL_OPENED_STATE)
@@ -147,15 +144,6 @@ static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
 			       channel->ringbuffer_pagecount << PAGE_SHIFT);
 }
 
-static const struct bin_attribute ring_buffer_bin_attr = {
-	.attr = {
-		.name = "ring",
-		.mode = 0600,
-	},
-	.size = 2 * HV_RING_SIZE * PAGE_SIZE,
-	.mmap = hv_uio_ring_mmap,
-};
-
 /* Callback from VMBUS subsystem when new channel created. */
 static void
 hv_uio_new_channel(struct vmbus_channel *new_sc)
@@ -176,8 +164,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 	/* Disable interrupts on sub channel */
 	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
-
-	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
 		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
 		vmbus_close(new_sc);
@@ -351,10 +338,18 @@ hv_uio_probe(struct hv_device *dev,
 		goto fail_close;
 	}
 
-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
+	/*
+	 * This internally calls sysfs_update_group, which returns a non-zero value if it executes
+	 * before sysfs_create_group. This is expected as the 'ring' will be created later in
+	 * vmbus_device_register() -> vmbus_add_channel_kobj(). Thus, no need to check the return
+	 * value and print warning.
+	 *
+	 * Creating/exposing sysfs in driver probe is not encouraged as it can lead to race
+	 * conditions with userspace. For backward compatibility, "ring" sysfs could not be removed
+	 * or decoupled from uio_hv_generic probe. Userspace programs can make use of inotify
+	 * APIs to make sure that ring is created.
+	 */
+	hv_create_ring_sysfs(channel, hv_uio_ring_mmap);
 
 	hv_set_drvdata(dev, pdata);
 
@@ -376,7 +371,7 @@ hv_uio_remove(struct hv_device *dev)
 	if (!pdata)
 		return;
 
-	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	hv_remove_ring_sysfs(dev->channel);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3e7fc9054789..8807fa7fd424 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1065,6 +1065,12 @@ struct vmbus_channel {
 
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
+
+	/* function to mmap ring buffer memory to the channel's sysfs ring attribute */
+	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct vm_area_struct *vma);
+
+	/* boolean to control visibility of sysfs for ring buffer */
+	bool ring_sysfs_visible;
 };
 
 #define lock_requestor(channel, flags)					\
-- 
2.34.1


