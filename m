Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB787CCFFF
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJQWXb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJQWXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09E95
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:28 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMJZl3005388
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MLbQ17I4NgwbgSwKOaqfm86b0ckw8a+JPvBLrtjPX8s=;
 b=mltJ6pklGm1Q9MZ6QByGwBSoqhxuKQSemU7NopQb4h9M/dcyHgZnXhHTFdoukDkI+/uN
 uOxQI9oZUc8cHDUZj9zBTP8N85nN9+cV6/OqyBcy+amijAeqnnr28hPClXYDkAHMyMh4
 wxYvmqxE3lKqTbAxZIEjb12CxqM1LiVFT8nQpCnXckmx9r89ht6RyulADm70vM+Lb2dd
 9+hJV0x9HRiVyt8Gum3D4R51FIhKDnQ6A+9rrhaC/mxA4RbO3j1qfUBCAyidrAbcDgEv
 uh/shSkdGvNV22DROwjUPFB1uekrdhnYA+zMxkYdIzUyIItEBmSXx2wpSt8B/pVlfcr0 sQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt2yag2qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMJkZI027098
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkc146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMN2IA21365360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:23:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE9C58055;
        Tue, 17 Oct 2023 22:23:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E04995805B;
        Tue, 17 Oct 2023 22:23:01 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:23:01 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 6/7] s390/vfio-ap: reset queues filtered from the guest's AP config
Date:   Tue, 17 Oct 2023 18:22:53 -0400
Message-ID: <20231017222254.68457-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HlbgTJlxpvzG0WJU3qjyjdBcSCDL4wn8
X-Proofpoint-ORIG-GUID: HlbgTJlxpvzG0WJU3qjyjdBcSCDL4wn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When filtering the adapters and domains assigned to the matrix mdev to
create or update a guest's AP configuration, if the APID of an adapter
and the APQI of a domain identify a queue device that is not bound to
the vfio_ap device driver, the APID of the adapter will be unassigned from
the guest's AP configuration because an individual APQN can not be
unassigned due to the fact the APQNs are assigned via a matrix of APIDs and
APQIs. Consequently, a guest will lose access to all of the queues
associated with that adapter. Since these queues could subsequently get
assigned to another guest, they must be reset in order to avoid prevent the
leaking of data from the queue being unassigned, so let's make sure all
queues associated with an adapter unplugged from the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 95 ++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 362d3942e506..2a1e6979d613 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -661,16 +661,21 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  *				device driver.
  *
  * @matrix_mdev: the matrix mdev whose matrix is to be filtered.
+ * @apm_filtered: a 256-bit bitmap for storing the APIDs filtered from the
+ *		  guest's AP configuration.
  *
  * Note: If an APQN referencing a queue device that is not bound to the vfio_ap
  *	 driver, its APID will be filtered from the guest's APCB. The matrix
  *	 structure precludes filtering an individual APQN, so its APID will be
- *	 filtered.
+ *	 filtered. Consequently, all queues associated with the adapter
+ *	 identified by the filtered APID will need to be reset lest they get
+ *	 plugged into another guest.
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
@@ -680,6 +685,7 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	bitmap_clear(apm_filtered, 0, AP_DEVICES);
 
 	/*
 	 * Copy the adapters, domains and control domains to the shadow_apcb
@@ -724,8 +730,16 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
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
@@ -937,6 +951,52 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 				       AP_MKQID(apid, apqi));
 }
 
+static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long *apm_reset)
+{
+	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
+	struct hlist_node *tmp_qnode;
+	struct ap_queue_table *qtable;
+	int apqn, ret = 0, loop_cursor;
+
+	qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	if (WARN(!qtable, "Failed to allocate qtable"))
+		return -ENOMEM;
+
+	ap_queue_table_init(qtable, RESET_QTABLE);
+
+	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
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
+				hash_add(qtable->queues, &q->reset_qnode, apqn);
+		}
+	}
+
+	ret = vfio_ap_mdev_reset_queues(qtable);
+
+	hash_for_each_safe(qtable->queues, loop_cursor, tmp_qnode, q,
+			   reset_qnode)
+		hash_del(&q->reset_qnode);
+
+	kfree(qtable);
+
+	return ret;
+}
+
 /**
  * assign_adapter_store - parses the APID from @buf and sets the
  * corresponding bit in the mediated matrix device's APM
@@ -977,6 +1037,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1006,8 +1067,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1183,6 +1246,7 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
+	DECLARE_BITMAP(aqm_filtered, AP_DOMAINS);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1212,8 +1276,10 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, aqm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, aqm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1762,6 +1828,9 @@ static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
 	int ret = 0, loop_cursor;
 	struct vfio_ap_queue *q;
 
+	if (hash_empty(qtable->queues))
+		return 0;
+
 	switch (qtable->type) {
 	case MDEV_QTABLE:
 		hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode)
@@ -2098,6 +2167,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	int ret;
 	struct vfio_ap_queue *q;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2130,15 +2200,17 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
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
@@ -2490,6 +2562,7 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
@@ -2503,7 +2576,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 					 matrix_mdev->adm_add, AP_DOMAINS);
 
 	if (filter_adapters || filter_domains)
-		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev,
+							apm_filtered);
 
 	if (filter_cdoms)
 		do_hotplug = vfio_ap_mdev_filter_cdoms(matrix_mdev);
@@ -2511,6 +2585,9 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
+	if (!bitmap_empty(apm_filtered, AP_DEVICES))
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_mdev->kvm->lock);
 }
-- 
2.41.0

