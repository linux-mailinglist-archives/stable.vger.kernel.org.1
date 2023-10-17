Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A557CCFFD
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjJQWXG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWXF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EBD3
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:03 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMK9m5022923
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=irT6VBZTR5ckmzDYOl/HXwMWFcPX9qmVRKZ9W2zmeA8=;
 b=OR1ykOSHb4VEP//IhNv5iW0JQ6Q2jidtv2JeQpweGykgtQP5oAsuZisA4gdT4yt92pj+
 ubtmveeQmh1zqdMSve0R6DYBgK3+RIXH9sUVyw+zTuBzPPw3gm2XTE8bieRkHR8ATXJU
 GXsM5ykmG0MX13xtVaXgei0e6XVQWSPXgQPf5oUo0mpnG4ABeJwbvhsIkbpCNQDTOWzy
 pD/fDN3Nd5ZN9MfFjN1SQu8Heb4Mb/0MnlE87X/ZzGecuUy9pVfBLx3jvxTPQ5n5VCfi
 ZDDqLUxH90ULu/8M/DXV1GCptUFqIAsyMNTppPokRiY1osWaanA1/60/XMdZAzzL5Dmp 3g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt2yg01ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HKamsI026943
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5ascf77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMMwtC17629744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:22:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F6D958055;
        Tue, 17 Oct 2023 22:22:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 826A958059;
        Tue, 17 Oct 2023 22:22:57 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:22:57 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 2/7] s390/vfio-ap: circumvent filtering for adapters/domains not in host config
Date:   Tue, 17 Oct 2023 18:22:49 -0400
Message-ID: <20231017222254.68457-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: waiB0S_rAkYymdconduq7jx_9SYNyIhC
X-Proofpoint-GUID: waiB0S_rAkYymdconduq7jx_9SYNyIhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170188
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

While filtering the mdev matrix, it doesn't make sense - and will have
unexpected results - to filter an APID from the matrix if the APID or one
of the associated APQIs is not in the host's AP configuration. There are
two reasons for this:

1. An adapter or domain that is not in the host's AP configuration can be
   assigned to the matrix; this is known as over-provisioning. Queue
   devices, however, are only created for adapters and domains in the
   host's AP configuration, so there will be no queues associated with an
   over-provisioned adapter or domain to filter.

2. The adapter or domain may have been externally removed from the host's
   configuration via an SE or HMC attached to a DPM enabled LPAR. In this
   case, the vfio_ap device driver would have been notified by the AP bus
   via the on_config_changed callback and the adapter or domain would
   have already been filtered.

Let's bypass the filtering of an APID if an adapter or domain assigned to
the mdev matrix is not in the host's AP configuration.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 32 +++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e5490640e19c..4e40e226ce62 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -692,17 +692,37 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
 
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		/*
+		 * If the adapter is not in the host's AP configuration, it will
+		 * be due to one of two reasons:
+		 * 1. The adapter is over-provisioned.
+		 * 2. The adapter was removed from the host's
+		 *    configuration in which case it will already have
+		 *    been processed by the on_config_changed callback.
+		 * In either case, we should skip the filtering and
+		 * continue examining APIDs.
+		 */
+		if (!test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm))
+			continue;
+
 		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 			/*
-			 * If the APQN is not bound to the vfio_ap device
-			 * driver, then we can't assign it to the guest's
-			 * AP configuration. The AP architecture won't
-			 * allow filtering of a single APQN, so let's filter
-			 * the APID since an adapter represents a physical
-			 * hardware device.
+			 * If the domain is not in the host's AP configuration,
+			 * it will for one of two reasons:
+			 * 1. The domain is over-provisioned.
+			 * 2. The domain was removed from the host's
+			 *    configuration in which case it will already have
+			 *    been processed by the on_config_changed callback.
+			 * In either case, we should skip the filtering and
+			 * continue examining APQIs.
 			 */
+			if (!test_bit_inv(apqi,
+					  (unsigned long *)matrix_dev->info.aqm))
+				continue;
+
 			apqn = AP_MKQID(apid, apqi);
 			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
 			if (!q || q->reset_status.response_code) {
 				clear_bit_inv(apid,
 					      matrix_mdev->shadow_apcb.apm);
-- 
2.41.0

