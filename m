Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28E97CD000
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJQWXb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjJQWXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E0B0
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:29 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMJYhI005339
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h6d5Pj44dJmE90B6+vkDHgJJNBSpn57vv7Npa+vIeFw=;
 b=sL0qzd4aYHNpaCsPuWlpASA91cpQp+Zd5lLUc7GZ3xQQN1zHzqFZDTy3nnHC+7BI4KyE
 YK/RHYzK90poktrZloQUY4FJiaqFwK6PqVuOobAftlpCVIU/aQB2tShMvmDYBJyJArif
 iri8djiThVGutbAJ45EVbXEyxV/pff5NHdYi7kYFSEKoklxe0UhybL1MIhThxls1BXv4
 bYfcryJHdEdzphpa9Cg1wRhbvvEI9R3HNk6S+mr8SxUE95baEdFGJ+lmIhFhZSKt5iY4
 YOlTAiIfsN8aCRrMY0rUAnuSYvOkbNau0gSVrhscf6hbs++KV4oZqGmpwjmTaxw0wEYb bg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt2yag2qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HLFtaf026879
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5ascf7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMN4j626870500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:23:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E75185804B;
        Tue, 17 Oct 2023 22:23:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0593358059;
        Tue, 17 Oct 2023 22:23:03 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:23:02 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 7/7] s390/vfio-ap: reset queues associated with adapter for queue unbound from driver
Date:   Tue, 17 Oct 2023 18:22:54 -0400
Message-ID: <20231017222254.68457-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DFA7JhbDgJxCCWjxrLP5TlY6VBX7tVWu
X-Proofpoint-ORIG-GUID: DFA7JhbDgJxCCWjxrLP5TlY6VBX7tVWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=699
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

When a queue is unbound from the vfio_ap device driver, if that queue is
assigned to a guest's AP configuration, its associated adapter is removed
because queues are defined to a guest via a matrix of adapters and
domains; so, it is not possible to remove a single queue.

If an adapter is removed from the guest's AP configuration, all associated
queues must be reset to prevent leaking crypto data should any of them be
assigned to a different guest or device driver. The one caveat is that if
the queue is being removed because the adapter or domain has been removed
from the host's AP configuration, then an attempt to reset the queue will
fail with response code 01, AP-queue number not valid; so resetting these
queues should be skipped.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: 09d31ff78793 ("s390/vfio-ap: hot plug/unplug of AP devices when probed/removed")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 48 ++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2a1e6979d613..e57202e92a0e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2217,6 +2217,23 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	return ret;
 }
 
+static void reset_queues_for_apid(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long apid)
+{
+	DECLARE_BITMAP(apm_reset, AP_DEVICES);
+
+	/*
+	 * If the adapter is not in the host's AP configuration, then resetting
+	 * any queue for that adapter will fail with response code 01, (APQN not
+	 * valid).
+	 */
+	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm)) {
+		bitmap_clear(apm_reset, 0, AP_DEVICES);
+		set_bit_inv(apid, apm_reset);
+		reset_queues_for_apids(matrix_mdev, apm_reset);
+	}
+}
+
 void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 {
 	unsigned long apid, apqi;
@@ -2231,23 +2248,24 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	apqi = AP_QID_QUEUE(q->apqn);
 
 	if (matrix_mdev) {
-		vfio_ap_unlink_queue_fr_mdev(q);
-
-		/*
-		 * If the queue is assigned to the guest's APCB, then remove
-		 * the adapter's APID from the APCB and hot it into the guest.
-		 */
+		/* If the queue is assigned to the guest's AP configuration */
 		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
+			/*
+			 * Since the queues are defined via a matrix of adapters
+			 * and domains, it is not possible to hot unplug a
+			 * single queue; so, let's unplug the adapter.
+			 */
 			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apid(matrix_mdev, apid);
+			goto done;
 		}
 	}
 
 	/*
-	 * If the queue is not in the host's AP configuration, then resetting
-	 * it will fail with response code 01, (APQN not valid); so, let's make
-	 * sure it is in the host's config.
+	 * Make sure the queue is in the host's AP configuration or attempting
+	 * to reset it will fail with response code 01 (APQN not valid).
 	 */
 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
@@ -2255,6 +2273,10 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		flush_work(&q->reset_work);
 	}
 
+done:
+	if (matrix_mdev)
+		vfio_ap_unlink_queue_fr_mdev(q);
+
 	dev_set_drvdata(&apdev->device, NULL);
 	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
@@ -2305,17 +2327,15 @@ static void vfio_ap_mdev_hot_unplug_cfg(struct ap_matrix_mdev *matrix_mdev,
 {
 	int do_hotplug = 0;
 
-	if (!bitmap_empty(aprem, AP_DEVICES)) {
+	if (!bitmap_empty(aprem, AP_DEVICES))
 		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.apm,
 					    matrix_mdev->shadow_apcb.apm,
 					    aprem, AP_DEVICES);
-	}
 
-	if (!bitmap_empty(aqrem, AP_DOMAINS)) {
+	if (!bitmap_empty(aqrem, AP_DOMAINS))
 		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.aqm,
 					    matrix_mdev->shadow_apcb.aqm,
-					    aqrem, AP_DEVICES);
-	}
+					    aqrem, AP_DOMAINS);
 
 	if (!bitmap_empty(cdrem, AP_DOMAINS))
 		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.adm,
-- 
2.41.0

