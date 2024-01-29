Return-Path: <stable+bounces-17047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41B5840F9A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79807282B09
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F35159581;
	Mon, 29 Jan 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXieaggp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F556F099;
	Mon, 29 Jan 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548470; cv=none; b=MevIj0rSHVzI0atyNZCYuwwgrUMF2l+7ysM9SDu+WfBxmZBi1UeaPiD9olqFyjnLHfZw54lbYfs/UJ6LfB0ks42fWzuCFFFN5JocYMRGEGQR22qV6Psc6YeUKukFnb8Cm8CX0CQT9r/pcSJYSlke569Xa1t1/WCELbSfxvJPaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548470; c=relaxed/simple;
	bh=zkOZh1jHmmO/Abfl9NL+br/vgB0eaq5qDPB4Ukm/psc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+URjP826Lbha9YA4hmREfauXCvnG7ralAq3a9Zc3h7BdmxLjhBuPQyoNdAEh63haP5CcNEPhPJn4YXB2ooyrT5g+q3e0zOtsKGf/gBASKaa9BhbgTG4s6nij681pUltodGKDbgVPMsA2pafyjJnlFHsFXs8aFmiIqvOaVKkup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXieaggp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C906C43390;
	Mon, 29 Jan 2024 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548470;
	bh=zkOZh1jHmmO/Abfl9NL+br/vgB0eaq5qDPB4Ukm/psc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXieaggp+vGt+MVClmv5ITf5COhNb+reidgvo1AetdxoZcII1YQurIIg1rHEj1UzA
	 W1zfnCs+WkrNbnXZAiaRcR+kOiVnFE3mJ+t9zACdssdjdzHbbas0tpikTee10gsjX9
	 zv8VAFCVL03yRjSmFPWelfjSUdMq/bR/cHLzfHfk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.6 062/331] s390/vfio-ap: reset queues filtered from the guests AP config
Date: Mon, 29 Jan 2024 09:02:06 -0800
Message-ID: <20240129170016.749856067@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>

commit f848cba767e59f8d5c54984b1d45451aae040d50 upstream.

When filtering the adapters from the configuration profile for a guest to
create or update a guest's AP configuration, if the APID of an adapter and
the APQI of a domain identify a queue device that is not bound to the
vfio_ap device driver, the APID of the adapter will be filtered because an
individual APQN can not be filtered due to the fact the APQNs are assigned
to an AP configuration as a matrix of APIDs and APQIs. Consequently, a
guest will not have access to all of the queues associated with the
filtered adapter. If the queues are subsequently made available again to
the guest, they should re-appear in a reset state; so, let's make sure all
queues associated with an adapter unplugged from the guest are reset.

In order to identify the set of queues that need to be reset, let's allow a
vfio_ap_queue object to be simultaneously stored in both a hashtable and a
list: A hashtable used to store all of the queues assigned
to a matrix mdev; and/or, a list used to store a subset of the queues that
need to be reset. For example, when an adapter is hot unplugged from a
guest, all guest queues associated with that adapter must be reset. Since
that may be a subset of those assigned to the matrix mdev, they can be
stored in a list that can be passed to the vfio_ap_mdev_reset_queues
function.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115185441.31526-5-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/vfio_ap_ops.c     |  171 +++++++++++++++++++++++++---------
 drivers/s390/crypto/vfio_ap_private.h |    3 
 2 files changed, 129 insertions(+), 45 deletions(-)

--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -32,7 +32,8 @@
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable);
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
 static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
@@ -662,16 +663,23 @@ static bool vfio_ap_mdev_filter_cdoms(st
  *				device driver.
  *
  * @matrix_mdev: the matrix mdev whose matrix is to be filtered.
+ * @apm_filtered: a 256-bit bitmap for storing the APIDs filtered from the
+ *		  guest's AP configuration that are still in the host's AP
+ *		  configuration.
  *
  * Note: If an APQN referencing a queue device that is not bound to the vfio_ap
  *	 driver, its APID will be filtered from the guest's APCB. The matrix
  *	 structure precludes filtering an individual APQN, so its APID will be
- *	 filtered.
+ *	 filtered. Consequently, all queues associated with the adapter that
+ *	 are in the host's AP configuration must be reset. If queues are
+ *	 subsequently made available again to the guest, they should re-appear
+ *	 in a reset state
  *
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
+				       unsigned long *apm_filtered)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -681,6 +689,7 @@ static bool vfio_ap_mdev_filter_matrix(s
 	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	bitmap_clear(apm_filtered, 0, AP_DEVICES);
 
 	/*
 	 * Copy the adapters, domains and control domains to the shadow_apcb
@@ -706,8 +715,16 @@ static bool vfio_ap_mdev_filter_matrix(s
 			apqn = AP_MKQID(apid, apqi);
 			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
 			if (!q || q->reset_status.response_code) {
-				clear_bit_inv(apid,
-					      matrix_mdev->shadow_apcb.apm);
+				clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+
+				/*
+				 * If the adapter was previously plugged into
+				 * the guest, let's let the caller know that
+				 * the APID was filtered.
+				 */
+				if (test_bit_inv(apid, prev_shadow_apm))
+					set_bit_inv(apid, apm_filtered);
+
 				break;
 			}
 		}
@@ -809,7 +826,7 @@ static void vfio_ap_mdev_remove(struct m
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	vfio_ap_mdev_unlink_fr_queues(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->mdevs_lock);
@@ -919,6 +936,47 @@ static void vfio_ap_mdev_link_adapter(st
 				       AP_MKQID(apid, apqi));
 }
 
+static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long *apm_reset)
+{
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
+	unsigned long apid, apqi;
+	int apqn, ret = 0;
+
+	if (bitmap_empty(apm_reset, AP_DEVICES))
+		return 0;
+
+	INIT_LIST_HEAD(&qlist);
+
+	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
+				     AP_DOMAINS) {
+			/*
+			 * If the domain is not in the host's AP configuration,
+			 * then resetting it will fail with response code 01
+			 * (APQN not valid).
+			 */
+			if (!test_bit_inv(apqi,
+					  (unsigned long *)matrix_dev->info.aqm))
+				continue;
+
+			apqn = AP_MKQID(apid, apqi);
+			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
+			if (q)
+				list_add_tail(&q->reset_qnode, &qlist);
+		}
+	}
+
+	ret = vfio_ap_mdev_reset_qlist(&qlist);
+
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode)
+		list_del(&q->reset_qnode);
+
+	return ret;
+}
+
 /**
  * assign_adapter_store - parses the APID from @buf and sets the
  * corresponding bit in the mediated matrix device's APM
@@ -959,6 +1017,7 @@ static ssize_t assign_adapter_store(stru
 {
 	int ret;
 	unsigned long apid;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -988,8 +1047,10 @@ static ssize_t assign_adapter_store(stru
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1020,11 +1081,12 @@ static struct vfio_ap_queue
  *				 adapter was assigned.
  * @matrix_mdev: the matrix mediated device to which the adapter was assigned.
  * @apid: the APID of the unassigned adapter.
- * @qtable: table for storing queues associated with unassigned adapter.
+ * @qlist: list for storing queues associated with unassigned adapter that
+ *	   need to be reset.
  */
 static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 					unsigned long apid,
-					struct ap_queue_table *qtable)
+					struct list_head *qlist)
 {
 	unsigned long apqi;
 	struct vfio_ap_queue *q;
@@ -1032,11 +1094,10 @@ static void vfio_ap_mdev_unlink_adapter(
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1044,26 +1105,23 @@ static void vfio_ap_mdev_unlink_adapter(
 static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
 					    unsigned long apid)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
 
 	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
 		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1164,6 +1222,7 @@ static ssize_t assign_domain_store(struc
 {
 	int ret;
 	unsigned long apqi;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1193,8 +1252,10 @@ static ssize_t assign_domain_store(struc
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1207,7 +1268,7 @@ static DEVICE_ATTR_WO(assign_domain);
 
 static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 				       unsigned long apqi,
-				       struct ap_queue_table *qtable)
+				       struct list_head *qlist)
 {
 	unsigned long apid;
 	struct vfio_ap_queue *q;
@@ -1215,11 +1276,10 @@ static void vfio_ap_mdev_unlink_domain(s
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1227,26 +1287,23 @@ static void vfio_ap_mdev_unlink_domain(s
 static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 					   unsigned long apqi)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
 
 	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
 		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1601,7 +1658,7 @@ static void vfio_ap_mdev_unset_kvm(struc
 		get_update_locks_for_kvm(kvm);
 
 		kvm_arch_crypto_clear_masks(kvm);
-		vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		vfio_ap_mdev_reset_queues(matrix_mdev);
 		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
@@ -1737,15 +1794,33 @@ static void vfio_ap_mdev_reset_queue(str
 	}
 }
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	int ret = 0, loop_cursor;
 	struct vfio_ap_queue *q;
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode)
+	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode)
 		vfio_ap_mdev_reset_queue(q);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
+		flush_work(&q->reset_work);
+
+		if (q->reset_status.response_code)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
+{
+	int ret = 0;
+	struct vfio_ap_queue *q;
+
+	list_for_each_entry(q, qlist, reset_qnode)
+		vfio_ap_mdev_reset_queue(q);
+
+	list_for_each_entry(q, qlist, reset_qnode) {
 		flush_work(&q->reset_work);
 
 		if (q->reset_status.response_code)
@@ -1931,7 +2006,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
-		ret = vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 			ret = vfio_ap_get_irq_info(arg);
@@ -2063,6 +2138,7 @@ int vfio_ap_mdev_probe_queue(struct ap_d
 {
 	int ret;
 	struct vfio_ap_queue *q;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2095,15 +2171,17 @@ int vfio_ap_mdev_probe_queue(struct ap_d
 		    !bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS))
 			goto done;
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
+		}
 	}
 
 done:
 	dev_set_drvdata(&apdev->device, q);
 	release_update_locks_for_mdev(matrix_mdev);
 
-	return 0;
+	return ret;
 
 err_remove_group:
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2447,6 +2525,7 @@ void vfio_ap_on_cfg_changed(struct ap_co
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
@@ -2460,7 +2539,7 @@ static void vfio_ap_mdev_hot_plug_cfg(st
 					 matrix_mdev->adm_add, AP_DOMAINS);
 
 	if (filter_adapters || filter_domains)
-		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
 
 	if (filter_cdoms)
 		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
@@ -2468,6 +2547,8 @@ static void vfio_ap_mdev_hot_plug_cfg(st
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
+	reset_queues_for_apids(matrix_mdev, apm_filtered);
+
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_mdev->kvm->lock);
 }
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -133,6 +133,8 @@ struct ap_matrix_mdev {
  * @apqn: the APQN of the AP queue device
  * @saved_isc: the guest ISC registered with the GIB interface
  * @mdev_qnode: allows the vfio_ap_queue struct to be added to a hashtable
+ * @reset_qnode: allows the vfio_ap_queue struct to be added to a list of queues
+ *		 that need to be reset
  * @reset_status: the status from the last reset of the queue
  * @reset_work: work to wait for queue reset to complete
  */
@@ -143,6 +145,7 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 	struct hlist_node mdev_qnode;
+	struct list_head reset_qnode;
 	struct ap_queue_status reset_status;
 	struct work_struct reset_work;
 };



