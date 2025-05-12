Return-Path: <stable+bounces-143146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4EAB32A6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8C37AEAAA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00135949;
	Mon, 12 May 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCdkCEzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F9433A0
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040608; cv=none; b=nmc5kwvN/tfedERfSKvyamMI1ZKcMsEoJJqqVi64UyLDVBglMy7AJTuPtQzvSxX53Tjeoy9vWkI05o4seanRIBK4glC41cLI5c5g2ZB+9iPYVFaR84xPkVVfqbZSSCzmOKG+/K7orAX3IArAT8F0htIlEX4ckBuaRN/qiEUsa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040608; c=relaxed/simple;
	bh=73NZq0QHXZSRidBF9RhNeZAzycL8P+IoBU/bBt2z6r0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d6/3huQu9yH5VOx84r7KUB+c6shQenWhk3op6zFn7vJJFJ2m5En3qco4PyJ9YcKAF4PNQLwseWEZlmkXpabLDh6YMxKhQZylYuwNFLv2ko0Gp5dW90ISF9YeRkqpXzGP9ft+IRfpoBQoi2yHqYRKEEeWRM8oqoFgpRoZ2Imf/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCdkCEzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A549AC4CEE7;
	Mon, 12 May 2025 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040608;
	bh=73NZq0QHXZSRidBF9RhNeZAzycL8P+IoBU/bBt2z6r0=;
	h=Subject:To:Cc:From:Date:From;
	b=NCdkCEzbeNrf1vzzfTAGB25KzYOshUuVPdis9uFqQDA2N6GqAWi7SuDPsx5vrFXg9
	 oJjUOR8IOELCXB1C5SCjB76fZ3pwrrgdibom11LXzIher9BkuzkUUEEl1q1BMhWUh/
	 PT5Pv0PAxjoiT22hXzqy0+2+qQG1lsLcp07Ciq/E=
Subject: FAILED: patch "[PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer" failed to apply to 5.4-stable tree
To: namjain@linux.microsoft.com,decui@microsoft.com,gregkh@linuxfoundation.org,mhklinux@outlook.com,ssengar@linux.microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:03:13 +0200
Message-ID: <2025051213-regretful-conceded-2379@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f31fe8165d365379d858c53bef43254c7d6d1cfd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051213-regretful-conceded-2379@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f31fe8165d365379d858c53bef43254c7d6d1cfd Mon Sep 17 00:00:00 2001
From: Naman Jain <namjain@linux.microsoft.com>
Date: Fri, 2 May 2025 13:18:10 +0530
Subject: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer

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

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 29780f3a7478..0b450e53161e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -477,4 +477,10 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
 
 #endif /* CONFIG_HYPERV_TESTING */
 
+/* Create and remove sysfs entry for memory mapped ring buffers for a channel */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma));
+int hv_remove_ring_sysfs(struct vmbus_channel *channel);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8d3cff42bdbb..0f16a83cc2d6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1802,6 +1802,27 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR_RO(subchannel_id);
 
+static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
+				       const struct bin_attribute *attr,
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
@@ -1821,6 +1842,11 @@ static struct attribute *vmbus_chan_attrs[] = {
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
@@ -1841,9 +1867,24 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
+static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *attr, int idx)
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
 static const struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
-	.is_visible = vmbus_chan_attr_is_visible
+	.bin_attrs = vmbus_chan_bin_attrs,
+	.is_visible = vmbus_chan_attr_is_visible,
+	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
 };
 
 static const struct kobj_type vmbus_chan_ktype = {
@@ -1851,6 +1892,63 @@ static const struct kobj_type vmbus_chan_ktype = {
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
index 1b19b5647495..69c1df0f4ca5 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -131,15 +131,12 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 	vmbus_device_unregister(channel->device_obj);
 }
 
-/* Sysfs API to allow mmap of the ring buffers
+/* Function used for mmap of ring buffer sysfs interface.
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
-static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    const struct bin_attribute *attr,
-			    struct vm_area_struct *vma)
+static int
+hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
 {
-	struct vmbus_channel *channel
-		= container_of(kobj, struct vmbus_channel, kobj);
 	void *ring_buffer = page_address(channel->ringbuffer_page);
 
 	if (channel->state != CHANNEL_OPENED_STATE)
@@ -149,15 +146,6 @@ static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
 			       channel->ringbuffer_pagecount << PAGE_SHIFT);
 }
 
-static const struct bin_attribute ring_buffer_bin_attr = {
-	.attr = {
-		.name = "ring",
-		.mode = 0600,
-	},
-	.size = 2 * SZ_2M,
-	.mmap = hv_uio_ring_mmap,
-};
-
 /* Callback from VMBUS subsystem when new channel created. */
 static void
 hv_uio_new_channel(struct vmbus_channel *new_sc)
@@ -178,8 +166,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 	/* Disable interrupts on sub channel */
 	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
-
-	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
 		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
 		vmbus_close(new_sc);
@@ -350,10 +337,18 @@ hv_uio_probe(struct hv_device *dev,
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
 
@@ -375,7 +370,7 @@ hv_uio_remove(struct hv_device *dev)
 	if (!pdata)
 		return;
 
-	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	hv_remove_ring_sysfs(dev->channel);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 675959fb97ba..d6ffe01962c2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1002,6 +1002,12 @@ struct vmbus_channel {
 
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


