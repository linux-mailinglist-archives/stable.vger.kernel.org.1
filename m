Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B7CCFFC
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQWXF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjJQWXF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE45395
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:03 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMMJuU021387
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mmSpsLtEYhNjfbP1KwIbqLUdqadT9vsbL8mYepAjroQ=;
 b=K1IEmhUpwLGmkFl0QrObEBvpWoxYfXRzHNERAntL3hT0SEZ6JFGUsJTniYXf3G89MJwm
 ehY33WC+VpXLTPjlEega8mKUUKhtKUhD+sgaH7Z+/8eEU6aDP3hqNNIfZsnFLT2I+uIg
 Uxe9vYUfOwiNfZqU8+BCb/wj5JKHWsMn/2VQHX36bfDRv5VTAkvxwBzRAaJysgKvSlvL
 fK1RIDVIrJ/T8ylJMWUS0jopz9CU4HwmftxNg8zcJMd80X2fOSJvmIhF8hPn6jDDhdpA
 dWQy4rvlVJmMlZl7pn6j3cRKi1t2ry1glPijcaffvJD4/nROl3YnWzLc1UT5czO4EQ4m bQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt30k814m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HKkura019713
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811kq0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMMxDB49611016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:22:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C4A558055;
        Tue, 17 Oct 2023 22:22:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6E35804B;
        Tue, 17 Oct 2023 22:22:58 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:22:58 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 3/7] s390/vfio-ap: do not reset queue removed from host config
Date:   Tue, 17 Oct 2023 18:22:50 -0400
Message-ID: <20231017222254.68457-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MPe_JbHR5a6G0PQPvAeoO7DvhA8CucPY
X-Proofpoint-ORIG-GUID: MPe_JbHR5a6G0PQPvAeoO7DvhA8CucPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=931
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When a queue is unbound from the vfio_ap device driver, it is reset to
ensure its crypto data is not leaked when it is bound to another device
driver. If the queue is unbound due to the fact that the adapter or domain
was removed from the host's AP configuration, then attempting to reset it
will fail with response code 01 (APID not valid) getting returned from the
reset command. Let's ensure that the queue is assigned to the host's
configuration before resetting it.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4e40e226ce62..08d612dfc506 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2125,13 +2125,12 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	q = dev_get_drvdata(&apdev->device);
 	get_update_locks_for_queue(q);
 	matrix_mdev = q->matrix_mdev;
+	apid = AP_QID_CARD(q->apqn);
+	apqi = AP_QID_QUEUE(q->apqn);
 
 	if (matrix_mdev) {
 		vfio_ap_unlink_queue_fr_mdev(q);
 
-		apid = AP_QID_CARD(q->apqn);
-		apqi = AP_QID_QUEUE(q->apqn);
-
 		/*
 		 * If the queue is assigned to the guest's APCB, then remove
 		 * the adapter's APID from the APCB and hot it into the guest.
@@ -2143,8 +2142,17 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		}
 	}
 
-	vfio_ap_mdev_reset_queue(q);
-	flush_work(&q->reset_work);
+	/*
+	 * If the queue is not in the host's AP configuration, then resetting
+	 * it will fail with response code 01, (APQN not valid); so, let's make
+	 * sure it is in the host's config.
+	 */
+	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
+	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+	}
+
 	dev_set_drvdata(&apdev->device, NULL);
 	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
-- 
2.41.0

