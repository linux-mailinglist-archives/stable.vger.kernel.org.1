Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114137CCFFE
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJQWXH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJQWXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4A95
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:05 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMMJSW021424
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cJLjz1859+PB1W3016+X+LvE/jXm/xZw5cxwfcjGV6w=;
 b=hIpUR4AYi6Kz4KmnHj3CWcFrP/kSsv6S4waRRSVveCndohXs/doJs9vklHOm7sQ6fp1F
 uBBIJVsAIURffNpKxQZX+sWC28Ubh5bkvVaU4P/MDURS7XM972t9YMF/gEi7n+46x9Hd
 jlzgSn/fJR3kpeZb1DXAt1RtWvkLz0sgQOxEaTeGBg5m/0B3eIvmpUkl1a7iuk29m4je
 sQok9pvIDWx6GPm2WxdHCOem4TdccbWsXT7N1ickPifF3aBTG3RUiUQ35VWRRjOayUDJ
 GdGUhY16dikC07xMqdm4Y4f/JQ/CbwQViLSttYKEdfhPL1OZQKRUqBPeg6PytiHSaPXE hA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt30k816m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HL07Kx012880
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pycbmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMN0Nj24117782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:23:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADB0458063;
        Tue, 17 Oct 2023 22:23:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D0B58059;
        Tue, 17 Oct 2023 22:22:59 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:22:59 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 4/7] s390/vfio-ap: let 'on_scan_complete' callback filter matrix and update guest's APCB
Date:   Tue, 17 Oct 2023 18:22:51 -0400
Message-ID: <20231017222254.68457-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6_jNkS4KgCC6tqTna1xFGT8vfpdx6PdA
X-Proofpoint-ORIG-GUID: 6_jNkS4KgCC6tqTna1xFGT8vfpdx6PdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
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

When adapters and/or domains are added to the host's AP configuration, this
may result in multiple queue devices getting created and probed by the
vfio_ap device driver. For each queue device probed, the matrix of adapters
and domains assigned to a matrix mdev will be filtered to update the
guest's APCB. If any adapters or domains get added to or removed from the
APCB, the guest's AP configuration will be dynamically updated (i.e., hot
plug/unplug). To dynamically update the guest's configuration, its VCPUs
must be taken out of SIE for the period of time it takes to make the
update. This is disruptive to the guest's operation and if there are many
queues probed due to a change in the host's AP configuration, this could be
troublesome. The problem is exacerbated by the fact that the
'on_scan_complete' callback also filters the mdev's matrix and updates
the guest's AP configuration.

In order to reduce the potential amount of disruption to the guest that may
result from a change to the host's AP configuration, let's bypass the
filtering of the matrix and updating of the guest's AP configuration in the
probe callback - if due to a host config change - and defer it until the
'on_scan_complete' callback is invoked after the AP bus finishes its device
scan operation. This way the filtering and updating will be performed only
once regardless of the number of queues added.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 08d612dfc506..7c2cd062ffe8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2102,9 +2102,22 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
 
+		/*
+		 * If we're in the process of handling the adding of adapters or
+		 * domains to the host's AP configuration, then let the
+		 * vfio_ap device driver's on_scan_complete callback filter the
+		 * matrix and update the guest's AP configuration after all of
+		 * the new queue devices are probed.
+		 */
+		if (!bitmap_empty(matrix_mdev->apm_add, AP_DEVICES) ||
+		    !bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS))
+			goto done;
+
 		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
+
+done:
 	dev_set_drvdata(&apdev->device, q);
 	release_update_locks_for_mdev(matrix_mdev);
 
-- 
2.41.0

