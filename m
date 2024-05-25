Return-Path: <stable+bounces-46143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5F8CEF7B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA43281A2D
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594E5A4D5;
	Sat, 25 May 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IjG0EDN/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EF6166E;
	Sat, 25 May 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648690; cv=none; b=H8lNP082AYQTjs8SO2yS9o50S3Yrl/fHvnFJTCipglo7wO1fvqrfDUiPV5FFgKb75ysBk0KToCXlG7LuWzZ2eHeypZAMMYzzoXgv7go+9v0yuo45t8uwDmPMgzarfA5uzf+DvSXrmTWTvuXxvYhuLhUKG7h16aB1yp/W3jKPP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648690; c=relaxed/simple;
	bh=9d156cmneLncJECuV1aaz/KRmoNreqiK/MwRvfoYrbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krR+VuaKU1KAjfJdBaEMZ/Ez5zM4OHoz8VYXAXbA42A4x+stY+0+wCt8PPOWAf5b1nEQcPbLfidzD7a+yX0Wyh89wGZz9tQbyQASLLMG4tsG/T/mhEwJQfcMjWiV/kAENH8m3+AffQdr+mMYwdbai0sqT/v4jq6QMAzj1x6dBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IjG0EDN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE385C3277B;
	Sat, 25 May 2024 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648690;
	bh=9d156cmneLncJECuV1aaz/KRmoNreqiK/MwRvfoYrbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjG0EDN/nPvYTQSDiwKy88T5s4EjpNzKrwdrTQNiGkBDNCeZ2a4zhClzRZFP9L5GQ
	 pBUnGYacYS44LcbHIF9YssxRlcWXIHXZmkWsbze6s/wxbVPxPm21QX6vZfl0GdW46b
	 BfZFbB59VEkbBhGUnLNyIgBb268eIvKGFfzUDgL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.8.11
Date: Sat, 25 May 2024 16:51:21 +0200
Message-ID: <2024052521-cozily-music-b500@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024052520-riding-silencer-2453@gregkh>
References: <2024052520-riding-silencer-2453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..f0025d1c3d5a 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -101,6 +101,16 @@ Description:
 		devices that support receiving integrity metadata.
 
 
+What:		/sys/block/<disk>/partscan
+Date:		May 2024
+Contact:	Christoph Hellwig <hch@lst.de>
+Description:
+		The /sys/block/<disk>/partscan files reports if partition
+		scanning is enabled for the disk.  It returns "1" if partition
+		scanning is enabled, or "0" if not.  The value type is a 32-bit
+		unsigned integer, but only "0" and "1" are valid values.
+
+
 What:		/sys/block/<disk>/<partition>/alignment_offset
 Date:		April 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index cf1eeefdfc32..a92e10ec402e 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -67,8 +67,8 @@ arg4:
     will be performed for all tasks in the task group of ``pid``.
 
 arg5:
-    userspace pointer to an unsigned long for storing the cookie returned by
-    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
+    userspace pointer to an unsigned long long for storing the cookie returned
+    by ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
 
 In order for a process to push a cookie to, or pull a cookie from a process, it
 is required to have the ptrace access mode: `PTRACE_MODE_READ_REALCREDS` to the
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9d23144bf985..87fdc258d102 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -450,7 +450,7 @@ pages of all memory cgroups except ``/having_care_already``.::
     # # further filter out all cgroups except one at '/having_care_already'
     echo memcg > 1/type
     echo /having_care_already > 1/memcg_path
-    echo N > 1/matching
+    echo Y > 1/matching
 
 Note that ``anon`` and ``memcg`` filters are currently supported only when
 ``paddr`` :ref:`implementation <sysfs_context>` is being used.
diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index abe768088377..638762442336 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -97,7 +97,6 @@ class KernelInclude(Include):
         # HINT: this is the only line I had to change / commented out:
         #path = utils.relative_path(None, path)
 
-        path = nodes.reprunicode(path)
         encoding = self.options.get(
             'encoding', self.state.document.settings.input_encoding)
         e_handler=self.state.document.settings.input_encoding_error_handler
diff --git a/Makefile b/Makefile
index 01acaf667e78..ce6b03cce386 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 8
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae68..d0471f469f7d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,9 +345,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	struct bdev_handle *handle;
 	int ret = 0;
 
-	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
-		return -EINVAL;
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
@@ -503,8 +501,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 			goto out_unregister_bdi;
 
 		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && !(disk->flags & GENHD_FL_NO_PART) &&
-		    !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		if (get_capacity(disk) && disk_has_partscan(disk))
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
 
 		bdev_add(disk->part0, ddev->devt);
@@ -1047,6 +1044,12 @@ static ssize_t diskseq_show(struct device *dev,
 	return sprintf(buf, "%llu\n", disk->diskseq);
 }
 
+static ssize_t partscan_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1060,6 +1063,7 @@ static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
+static DEVICE_ATTR(partscan, 0444, partscan_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1106,6 +1110,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
+	&dev_attr_partscan.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5f5ed5c75f04..eac887755f4f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -584,10 +584,7 @@ static int blk_add_partitions(struct gendisk *disk)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return 0;
-
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return 0;
 
 	state = check_partition(disk);
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d6f14c8e20be..e029687e5732 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5367,7 +5367,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
 
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 7270d4d22207..5b7c80b99ae8 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -421,7 +421,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 0df6c55eb326..6b10124e21b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1050,7 +1050,12 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
-	dsc_cfg->num_slices_v = pic_height/slice_height;
+	if (slice_height > 0) {
+		dsc_cfg->num_slices_v = pic_height / slice_height;
+	} else {
+		is_dsc_possible = false;
+		goto done;
+	}
 
 	if (target_bandwidth_kbps > 0) {
 		is_dsc_possible = decide_dsc_target_bpp_x16(
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 7b550d7d96b6..1ff9818b4c84 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -550,17 +550,15 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 
 /**
  * ice_vc_isvalid_q_id
- * @vf: pointer to the VF info
- * @vsi_id: VSI ID
+ * @vsi: VSI to check queue ID against
  * @qid: VSI relative queue ID
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vf *vf, u16 vsi_id, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
 {
-	struct ice_vsi *vsi = ice_find_vsi(vf->pf, vsi_id);
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
-	return (vsi && (qid < vsi->alloc_txq));
+	return qid < vsi->alloc_txq;
 }
 
 /**
@@ -1318,7 +1316,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	 */
 	q_map = vqs->rx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1340,7 +1338,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1445,7 +1443,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		q_map = vqs->tx_queues;
 
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1471,7 +1469,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1527,7 +1525,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_rx++;
@@ -1541,7 +1539,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_tx++;
@@ -1698,7 +1696,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		    qpi->txq.headwb_enabled ||
 		    !ice_vc_isvalid_ring_len(qpi->txq.ring_len) ||
 		    !ice_vc_isvalid_ring_len(qpi->rxq.ring_len) ||
-		    !ice_vc_isvalid_q_id(vf, qci->vsi_id, qpi->txq.queue_id)) {
+		    !ice_vc_isvalid_q_id(vsi, qpi->txq.queue_id)) {
 			goto error_param;
 		}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index f001553e1a1a..8e4ff3af86c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -94,9 +94,6 @@ ice_vc_fdir_param_check(struct ice_vf *vf, u16 vsi_id)
 	if (!(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_FDIR_PF))
 		return -EINVAL;
 
-	if (vsi_id != vf->lan_vsi_num)
-		return -EINVAL;
-
 	if (!ice_vc_isvalid_vsi_id(vf, vsi_id))
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 502518cdb461..6453c92f0fa7 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -328,7 +328,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
 	struct sk_buff_head rxq;
-	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
 	struct sk_buff *skb;
@@ -336,24 +335,17 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
+	ks8851_wrreg16(ks, KS_ISR, status);
 
 	netif_dbg(ks, intr, ks->netdev,
 		  "%s: status 0x%04x\n", __func__, status);
 
-	if (status & IRQ_LCI)
-		handled |= IRQ_LCI;
-
 	if (status & IRQ_LDI) {
 		u16 pmecr = ks8851_rdreg16(ks, KS_PMECR);
 		pmecr &= ~PMECR_WKEVT_MASK;
 		ks8851_wrreg16(ks, KS_PMECR, pmecr | PMECR_WKEVT_LINK);
-
-		handled |= IRQ_LDI;
 	}
 
-	if (status & IRQ_RXPSI)
-		handled |= IRQ_RXPSI;
-
 	if (status & IRQ_TXI) {
 		unsigned short tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 
@@ -365,20 +357,12 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
 		spin_unlock(&ks->statelock);
-
-		handled |= IRQ_TXI;
 	}
 
-	if (status & IRQ_RXI)
-		handled |= IRQ_RXI;
-
 	if (status & IRQ_SPIBEI) {
 		netdev_err(ks->netdev, "%s: spi bus error\n", __func__);
-		handled |= IRQ_SPIBEI;
 	}
 
-	ks8851_wrreg16(ks, KS_ISR, handled);
-
 	if (status & IRQ_RXI) {
 		/* the datasheet says to disable the rx interrupt during
 		 * packet read-out, however we're masking the interrupt
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 21b6c4d94a63..6d31061818e9 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -174,6 +174,7 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 initialized;
 };
 
 struct ax88179_int_data {
@@ -1673,6 +1674,18 @@ static int ax88179_reset(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179_net_reset(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+
+	if (ax179_data->initialized)
+		ax88179_reset(dev);
+	else
+		ax179_data->initialized = 1;
+
+	return 0;
+}
+
 static int ax88179_stop(struct usbnet *dev)
 {
 	u16 tmp16;
@@ -1692,6 +1705,7 @@ static const struct driver_info ax88179_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1704,6 +1718,7 @@ static const struct driver_info ax88178a_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1716,7 +1731,7 @@ static const struct driver_info cypress_GX3_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1729,7 +1744,7 @@ static const struct driver_info dlink_dub1312_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1742,7 +1757,7 @@ static const struct driver_info sitecom_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1755,7 +1770,7 @@ static const struct driver_info samsung_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1768,7 +1783,7 @@ static const struct driver_info lenovo_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1781,7 +1796,7 @@ static const struct driver_info belkin_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop	= ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1794,7 +1809,7 @@ static const struct driver_info toshiba_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1807,7 +1822,7 @@ static const struct driver_info mct_info = {
 	.unbind	= ax88179_unbind,
 	.status	= ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop	= ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1820,7 +1835,7 @@ static const struct driver_info at_umc2000_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1833,7 +1848,7 @@ static const struct driver_info at_umc200_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1846,7 +1861,7 @@ static const struct driver_info at_umc2000sp_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index a35409eda0cf..67518291a8ad 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -132,7 +132,7 @@ static int scp_elf_read_ipi_buf_addr(struct mtk_scp *scp,
 static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 {
 	int ret;
-	size_t offset;
+	size_t buf_sz, offset;
 
 	/* read the ipi buf addr from FW itself first */
 	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
@@ -144,6 +144,14 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 	}
 	dev_info(scp->dev, "IPI buf addr %#010zx\n", offset);
 
+	/* Make sure IPI buffer fits in the L2TCM range assigned to this core */
+	buf_sz = sizeof(*scp->recv_buf) + sizeof(*scp->send_buf);
+
+	if (scp->sram_size < buf_sz + offset) {
+		dev_err(scp->dev, "IPI buffer does not fit in SRAM.\n");
+		return -EOVERFLOW;
+	}
+
 	scp->recv_buf = (struct mtk_share_obj __iomem *)
 			(scp->sram_base + offset);
 	scp->send_buf = (struct mtk_share_obj __iomem *)
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb164005..58ea1e1391ce 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -48,6 +49,25 @@ static struct kgdb_io		kgdboc_earlycon_io_ops;
 static int                      (*earlycon_orig_exit)(struct console *con);
 #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -99,10 +119,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +160,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4062a486b9e6..579d90efc281 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1718,7 +1718,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1743,8 +1742,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	dep->resource_index = 0;
 
 	if (!interrupt) {
-		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
-			mdelay(1);
+		mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0717cfcd9f8c..191f86da283d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -28,6 +28,7 @@
 #define TPS_REG_MODE			0x03
 #define TPS_REG_CMD1			0x08
 #define TPS_REG_DATA1			0x09
+#define TPS_REG_VERSION			0x0F
 #define TPS_REG_INT_EVENT1		0x14
 #define TPS_REG_INT_EVENT2		0x15
 #define TPS_REG_INT_MASK1		0x16
@@ -604,11 +605,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
@@ -617,7 +618,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	 * a plug event. Therefore, we need to check
 	 * for pr/dr status change to set TypeC dr/pr accordingly.
 	 */
-	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
 	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 
@@ -636,49 +637,67 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
+	int intev_len = TPS_65981_2_6_INTEVENT_LEN;
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
+	u32 version;
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_read32(tps, TPS_REG_VERSION, &version);
+	if (ret)
+		dev_warn(tps->dev, "%s: failed to read version (%d)\n",
+			 __func__, ret);
+
+	if (TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DH ||
+	    TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DK)
+		intev_len = TPS_65987_8_INTEVENT_LEN;
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, intev_len);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, intev_len);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, intev_len);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 89b24519463a..9b23e9017452 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -253,4 +253,15 @@
 #define TPS_PTCC_DEV				2
 #define TPS_PTCC_APP				3
 
+/* Version Register */
+#define TPS_VERSION_HW_VERSION_MASK            GENMASK(31, 24)
+#define TPS_VERSION_HW_VERSION(x)              TPS_FIELD_GET(TPS_VERSION_HW_VERSION_MASK, (x))
+#define TPS_VERSION_HW_65981_2_6               0x00
+#define TPS_VERSION_HW_65987_8_DH              0xF7
+#define TPS_VERSION_HW_65987_8_DK              0xF9
+
+/* Int Event Register length */
+#define TPS_65981_2_6_INTEVENT_LEN             8
+#define TPS_65987_8_INTEVENT_LEN               11
+
 #endif /* __TPS6598X_H__ */
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca..8be92fc1d12c 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -275,8 +275,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	struct ucsi_dp *dp = container_of(work, struct ucsi_dp, work);
 	int ret;
 
-	mutex_lock(&dp->con->lock);
-
 	ret = typec_altmode_vdm(dp->alt, dp->header,
 				dp->vdo_data, dp->vdo_size);
 	if (ret)
@@ -285,8 +283,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	dp->vdo_data = NULL;
 	dp->vdo_size = 0;
 	dp->header = 0;
-
-	mutex_unlock(&dp->con->lock);
 }
 
 void ucsi_displayport_remove_partner(struct typec_altmode *alt)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 410f5af62354..c69174675caf 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -84,13 +84,6 @@ struct erofs_dev_context {
 	bool flatdev;
 };
 
-struct erofs_fs_context {
-	struct erofs_mount_opts opt;
-	struct erofs_dev_context *devs;
-	char *fsid;
-	char *domain_id;
-};
-
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 24788c230b49..a2fa74558570 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -370,18 +370,18 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-static void erofs_default_options(struct erofs_fs_context *ctx)
+static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
+	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	sbi->opt.max_sync_decompress_pages = 3;
+	sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(&ctx->opt, XATTR_USER);
+	set_opt(&sbi->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(&ctx->opt, POSIX_ACL);
+	set_opt(&sbi->opt, POSIX_ACL);
 #endif
 }
 
@@ -426,17 +426,17 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
 #ifdef CONFIG_FS_DAX
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		set_opt(&ctx->opt, DAX_ALWAYS);
-		clear_opt(&ctx->opt, DAX_NEVER);
+		set_opt(&sbi->opt, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(&ctx->opt, DAX_NEVER);
-		clear_opt(&ctx->opt, DAX_ALWAYS);
+		set_opt(&sbi->opt, DAX_NEVER);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -451,7 +451,7 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
 	struct erofs_device_info *dif;
 	int opt, ret;
@@ -464,9 +464,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(&ctx->opt, XATTR_USER);
+			set_opt(&sbi->opt, XATTR_USER);
 		else
-			clear_opt(&ctx->opt, XATTR_USER);
+			clear_opt(&sbi->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -474,16 +474,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(&ctx->opt, POSIX_ACL);
+			set_opt(&sbi->opt, POSIX_ACL);
 		else
-			clear_opt(&ctx->opt, POSIX_ACL);
+			clear_opt(&sbi->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->opt.cache_strategy = result.uint_32;
+		sbi->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -505,27 +505,27 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			kfree(dif);
 			return -ENOMEM;
 		}
-		down_write(&ctx->devs->rwsem);
-		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
-		up_write(&ctx->devs->rwsem);
+		down_write(&sbi->devs->rwsem);
+		ret = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+		up_write(&sbi->devs->rwsem);
 		if (ret < 0) {
 			kfree(dif->path);
 			kfree(dif);
 			return ret;
 		}
-		++ctx->devs->extra_devices;
+		++sbi->devs->extra_devices;
 		break;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	case Opt_fsid:
-		kfree(ctx->fsid);
-		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->fsid)
+		kfree(sbi->fsid);
+		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
 	case Opt_domain_id:
-		kfree(ctx->domain_id);
-		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->domain_id)
+		kfree(sbi->domain_id);
+		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->domain_id)
 			return -ENOMEM;
 		break;
 #else
@@ -582,8 +582,7 @@ static const struct export_operations erofs_export_ops = {
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct erofs_sb_info *sbi;
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
@@ -591,19 +590,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &erofs_sops;
 
-	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
-
-	sb->s_fs_info = sbi;
-	sbi->opt = ctx->opt;
-	sbi->devs = ctx->devs;
-	ctx->devs = NULL;
-	sbi->fsid = ctx->fsid;
-	ctx->fsid = NULL;
-	sbi->domain_id = ctx->domain_id;
-	ctx->domain_id = NULL;
-
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
 		sb->s_blocksize = PAGE_SIZE;
@@ -707,9 +693,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -719,19 +705,19 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *new_sbi = fc->s_fs_info;
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (ctx->fsid || ctx->domain_id)
+	if (new_sbi->fsid || new_sbi->domain_id)
 		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
 
-	if (test_opt(&ctx->opt, POSIX_ACL))
+	if (test_opt(&new_sbi->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->opt = ctx->opt;
+	sbi->opt = new_sbi->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -762,12 +748,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 
 static void erofs_fc_free(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	erofs_free_dev_context(ctx->devs);
-	kfree(ctx->fsid);
-	kfree(ctx->domain_id);
-	kfree(ctx);
+	if (!sbi)
+		return;
+
+	erofs_free_dev_context(sbi->devs);
+	kfree(sbi->fsid);
+	kfree(sbi->domain_id);
+	kfree(sbi);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -779,38 +768,35 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx;
+	struct erofs_sb_info *sbi;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
 		return -ENOMEM;
-	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
-	if (!ctx->devs) {
-		kfree(ctx);
+
+	sbi->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
+	if (!sbi->devs) {
+		kfree(sbi);
 		return -ENOMEM;
 	}
-	fc->fs_private = ctx;
+	fc->s_fs_info = sbi;
 
-	idr_init(&ctx->devs->tree);
-	init_rwsem(&ctx->devs->rwsem);
-	erofs_default_options(ctx);
+	idr_init(&sbi->devs->tree);
+	init_rwsem(&sbi->devs->rwsem);
+	erofs_default_options(sbi);
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b43ca3b9d2a2..6ee8e7d7383c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -233,6 +233,19 @@ static inline unsigned int disk_openers(struct gendisk *disk)
 	return atomic_read(&disk->part0->bd_openers);
 }
 
+/**
+ * disk_has_partscan - return %true if partition scanning is enabled on a disk
+ * @disk: disk to check
+ *
+ * Returns %true if partitions scanning is enabled for @disk, or %false if
+ * partition scanning is disabled either permanently or temporarily.
+ */
+static inline bool disk_has_partscan(struct gendisk *disk)
+{
+	return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
+		!test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+}
+
 /*
  * The gendisk is refcounted by the part0 block_device, and the bd_device
  * therein is also used for device model presentation in sysfs.
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2cfd8d862639..f9db2d1ca5d3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1665,6 +1665,15 @@ struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
 } __packed;
 
+/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
+ * 7.8.2 LE Read Buffer Size command
+ * MAX_LE_MTU is 0xffff.
+ * 0 is also valid. It means that no dedicated LE Buffer exists.
+ * It should use the HCI_Read_Buffer_Size command and mtu is shared
+ * between BR/EDR and LE.
+ */
+#define HCI_MIN_LE_MTU 0x001b
+
 #define HCI_OP_LE_READ_BUFFER_SIZE	0x2002
 struct hci_rp_le_read_buffer_size {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe9e1524d30f..8504e10f5170 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -706,6 +706,7 @@ struct hci_conn {
 	__u16		handle;
 	__u16		sync_handle;
 	__u16		state;
+	__u16		mtu;
 	__u8		mode;
 	__u8		type;
 	__u8		role;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 18f97b228869..9a369bc14fd5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -909,11 +909,37 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
+	switch (type) {
+	case ACL_LINK:
+		if (!hdev->acl_mtu)
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	case ISO_LINK:
+		if (hdev->iso_mtu)
+			/* Dedicated ISO Buffer exists */
+			break;
+		fallthrough;
+	case LE_LINK:
+		if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+			return ERR_PTR(-ECONNREFUSED);
+		if (!hdev->le_mtu && hdev->acl_mtu < HCI_MIN_LE_MTU)
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
+		if (!hdev->sco_pkts)
+			/* Controller does not support SCO or eSCO over HCI */
+			return ERR_PTR(-ECONNREFUSED);
+		break;
+	default:
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	bt_dev_dbg(hdev, "dst %pMR handle 0x%4.4x", dst, handle);
 
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
@@ -944,10 +970,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
+		conn->mtu = hdev->acl_mtu;
 		break;
 	case LE_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
+		conn->mtu = hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case ISO_LINK:
 		/* conn->src should reflect the local identity address */
@@ -959,6 +987,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		else if (conn->role == HCI_ROLE_MASTER)
 			conn->cleanup = cis_cleanup;
 
+		conn->mtu = hdev->iso_mtu ? hdev->iso_mtu :
+			    hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
@@ -966,9 +996,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 					(hdev->esco_type & EDR_ESCO_MASK);
 		else
 			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
+
+		conn->mtu = hdev->sco_mtu;
 		break;
 	case ESCO_LINK:
 		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
+		conn->mtu = hdev->sco_mtu;
 		break;
 	}
 
@@ -1011,7 +1044,7 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 
 	handle = hci_conn_hash_alloc_unset(hdev);
 	if (unlikely(handle < 0))
-		return NULL;
+		return ERR_PTR(-ECONNREFUSED);
 
 	return hci_conn_add(hdev, type, dst, role, handle);
 }
@@ -1317,8 +1350,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		bacpy(&conn->dst, dst);
 	} else {
 		conn = hci_conn_add_unset(hdev, LE_LINK, dst, role);
-		if (!conn)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(conn))
+			return conn;
 		hci_conn_hold(conn);
 		conn->pending_sec_level = sec_level;
 	}
@@ -1494,8 +1527,8 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EADDRINUSE);
 
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(conn))
+		return conn;
 
 	conn->state = BT_CONNECT;
 
@@ -1538,8 +1571,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	BT_DBG("requesting refresh of dst_addr");
 
 	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(conn))
+		return conn;
 
 	if (hci_explicit_conn_params_set(hdev, dst, dst_type) < 0) {
 		hci_conn_del(conn);
@@ -1586,8 +1619,8 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add_unset(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
-		if (!acl)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(acl))
+			return acl;
 	}
 
 	hci_conn_hold(acl);
@@ -1655,9 +1688,9 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
 		sco = hci_conn_add_unset(hdev, type, dst, HCI_ROLE_MASTER);
-		if (!sco) {
+		if (IS_ERR(sco)) {
 			hci_conn_drop(acl);
-			return ERR_PTR(-ENOMEM);
+			return sco;
 		}
 	}
 
@@ -1847,8 +1880,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 				       qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
-		if (!cis)
-			return ERR_PTR(-ENOMEM);
+		if (IS_ERR(cis))
+			return cis;
 		cis->cleanup = cis_cleanup;
 		cis->dst_type = dst_type;
 		cis->iso_qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
@@ -1983,14 +2016,8 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 			      struct bt_iso_io_qos *qos, __u8 phy)
 {
 	/* Only set MTU if PHY is enabled */
-	if (!qos->sdu && qos->phy) {
-		if (hdev->iso_mtu > 0)
-			qos->sdu = hdev->iso_mtu;
-		else if (hdev->le_mtu > 0)
-			qos->sdu = hdev->le_mtu;
-		else
-			qos->sdu = hdev->acl_mtu;
-	}
+	if (!qos->sdu && qos->phy)
+		qos->sdu = conn->mtu;
 
 	/* Use the same PHY as ACL if set to any */
 	if (qos->phy == BT_ISO_PHY_ANY)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0f56ad33801e..c19d78e5d205 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -954,6 +954,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 	BT_DBG("%s acl mtu %d:%d sco mtu %d:%d", hdev->name, hdev->acl_mtu,
 	       hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
 
+	if (!hdev->acl_mtu || !hdev->acl_pkts)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -1263,6 +1266,9 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
 
+	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -2342,8 +2348,8 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		if (!conn) {
 			conn = hci_conn_add_unset(hdev, ACL_LINK, &cp->bdaddr,
 						  HCI_ROLE_MASTER);
-			if (!conn)
-				bt_dev_err(hdev, "no memory for new connection");
+			if (IS_ERR(conn))
+				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 		}
 	}
 
@@ -3154,8 +3160,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 						      BDADDR_BREDR)) {
 			conn = hci_conn_add_unset(hdev, ev->link_type,
 						  &ev->bdaddr, HCI_ROLE_SLAVE);
-			if (!conn) {
-				bt_dev_err(hdev, "no memory for new conn");
+			if (IS_ERR(conn)) {
+				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 				goto unlock;
 			}
 		} else {
@@ -3343,8 +3349,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	if (!conn) {
 		conn = hci_conn_add_unset(hdev, ev->link_type, &ev->bdaddr,
 					  HCI_ROLE_SLAVE);
-		if (!conn) {
-			bt_dev_err(hdev, "no memory for new connection");
+		if (IS_ERR(conn)) {
+			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
 	}
@@ -3821,6 +3827,9 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mtu,
 	       hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
 
+	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -5912,8 +5921,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			goto unlock;
 
 		conn = hci_conn_add_unset(hdev, LE_LINK, bdaddr, role);
-		if (!conn) {
-			bt_dev_err(hdev, "no memory for new connection");
+		if (IS_ERR(conn)) {
+			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
 
@@ -7042,7 +7051,7 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	if (!cis) {
 		cis = hci_conn_add(hdev, ISO_LINK, &acl->dst, HCI_ROLE_SLAVE,
 				   cis_handle);
-		if (!cis) {
+		if (IS_ERR(cis)) {
 			hci_le_reject_cis(hdev, ev->cis_handle);
 			goto unlock;
 		}
@@ -7151,7 +7160,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		if (!bis) {
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
-			if (!bis)
+			if (IS_ERR(bis))
 				continue;
 		}
 
@@ -7223,7 +7232,7 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
 				     HCI_ROLE_SLAVE);
 
-	if (!pa_sync)
+	if (IS_ERR(pa_sync))
 		goto unlock;
 
 	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fa6c2e95d554..6d217df75c62 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1264,7 +1264,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return -ENOTCONN;
 	}
 
-	mtu = iso_pi(sk)->conn->hcon->hdev->iso_mtu;
+	mtu = iso_pi(sk)->conn->hcon->mtu;
 
 	release_sock(sk);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5761d37c5537..3f7a82f10fe9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3905,13 +3905,12 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
-static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
-					struct l2cap_cmd_hdr *cmd,
-					u8 *data, u8 rsp_code, u8 amp_id)
+static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
+			  u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan = NULL, *pchan;
+	struct l2cap_chan *chan = NULL, *pchan = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3924,7 +3923,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
-		goto sendresp;
+		goto response;
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -4011,17 +4010,15 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
-	l2cap_chan_put(pchan);
-
-sendresp:
 	rsp.scid   = cpu_to_le16(scid);
 	rsp.dcid   = cpu_to_le16(dcid);
 	rsp.result = cpu_to_le16(result);
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
+	if (!pchan)
+		return;
+
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
 		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -4044,7 +4041,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		chan->num_conf_req++;
 	}
 
-	return chan;
+	l2cap_chan_unlock(pchan);
+	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 }
 
 static int l2cap_connect_req(struct l2cap_conn *conn,
@@ -6242,7 +6241,7 @@ static int l2cap_finish_move(struct l2cap_chan *chan)
 	BT_DBG("chan %p", chan);
 
 	chan->rx_state = L2CAP_RX_STATE_RECV;
-	chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+	chan->conn->mtu = chan->conn->hcon->mtu;
 
 	return l2cap_resegment(chan);
 }
@@ -6309,7 +6308,7 @@ static int l2cap_rx_state_wait_f(struct l2cap_chan *chan,
 	 */
 	chan->next_tx_seq = control->reqseq;
 	chan->unacked_frames = 0;
-	chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
+	chan->conn->mtu = chan->conn->hcon->mtu;
 
 	err = l2cap_resegment(chan);
 
@@ -6849,18 +6848,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
-	switch (hcon->type) {
-	case LE_LINK:
-		if (hcon->hdev->le_mtu) {
-			conn->mtu = hcon->hdev->le_mtu;
-			break;
-		}
-		fallthrough;
-	default:
-		conn->mtu = hcon->hdev->acl_mtu;
-		break;
-	}
-
+	conn->mtu = hcon->mtu;
 	conn->feat_mask = 0;
 
 	conn->local_fixed_chan = L2CAP_FC_SIG_BREDR | L2CAP_FC_CONNLESS;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e0ad30862ee4..71d36582d4ef 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -126,7 +126,6 @@ static void sco_sock_clear_timer(struct sock *sk)
 /* ---- SCO connections ---- */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
-	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
 	if (conn) {
@@ -144,9 +143,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
+	conn->mtu = hcon->mtu;
 
-	if (hdev->sco_mtu > 0)
-		conn->mtu = hdev->sco_mtu;
+	if (hcon->mtu > 0)
+		conn->mtu = hcon->mtu;
 	else
 		conn->mtu = 60;
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index bc700f85f80b..ea277c55a38d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -38,6 +38,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
-			return PTR_ERR(w);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
+			ret = PTR_ERR(w);
+			goto err;
+		}
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
@@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 * trigger, so if it does there's something nefarious going on
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
-		return -EINVAL;
+		 "BUG: scratch buffer is too small")) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
@@ -79,10 +84,18 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (IS_ERR(work1)) {
+		ret = PTR_ERR(work1);
+		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
+		goto err;
+	}
 
+	kfree(scratch);
 	return work1 - payload->blob;
+
+err:
+	kfree(scratch);
+	return ret;
 }
 
 struct tpm2_key_context {

