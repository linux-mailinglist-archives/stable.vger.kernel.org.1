Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21072F9FC
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjFNKDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjFNKDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 06:03:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069D18C
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 03:03:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E9nVWY032705
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OlIA8Zjdhd0KF2C+FVcWYZjh1256/55mL+BAkaDth6U=;
 b=GlAyjnrYhHAUGyjW7rYfZvcckbMgsvS2FP2/UPgJ7p85q4lb1PNEZFAG9nj7D6iwMEUE
 cJ4i75x24vNj4J4pyPt8RmB/8HfzDGVACYXPtvXX57Atune3X5aN2nQMoM24fDdHyVj4
 a1qHPKlsX2GR5lJllnRR9HiA8fVFPHIlR3i+X11NM9aCMRdeIPUDkLZKCKIL9TdpQASY
 Sxf4vrxnqlnF2gEVRo40s8ImXlgyFff/Lu8yZz/wXZBs0S9aRmQfIgAQb6Wp6evnKCAg
 WrG9reV6D+huZytqFkIQz0MRMTN1m6KOQI+cUc42OypTENe9JoFqBM1Rc6PtpzXlkv6F 0g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7b8sgc8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:03:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E7Q3fW002264
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r4gt52290-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EA2aRM13501052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7258420092
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D53820090
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:02:36 +0000 (GMT)
From:   =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.4.y] s390/dasd: Use correct lock while counting channel queue length
Date:   Wed, 14 Jun 2023 12:02:36 +0200
Message-Id: <20230614100236.726123-1-hoeppner@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023061111-tracing-shakiness-9054@gregkh>
References: <2023061111-tracing-shakiness-9054@gregkh>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WmlubNSAewen7ojuYj6MXKY7tQuH4hyD
X-Proofpoint-ORIG-GUID: WmlubNSAewen7ojuYj6MXKY7tQuH4hyD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The lock around counting the channel queue length in the BIODASDINFO
ioctl was incorrectly changed to the dasd_block->queue_lock with commit
583d6535cb9d ("dasd: remove dead code"). This can lead to endless list
iterations and a subsequent crash.

The queue_lock is supposed to be used only for queue lists belonging to
dasd_block. For dasd_device related queue lists the ccwdev lock must be
used.

Fix the mentioned issues by correctly using the ccwdev lock instead of
the queue lock.

Fixes: 583d6535cb9d ("dasd: remove dead code")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20230609153750.1258763-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit ccc45cb4e7271c74dbb27776ae8f73d84557f5c6)
---
 drivers/s390/block/dasd_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9a5f3add325f..c995dae5cc6f 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -516,10 +516,10 @@ static int dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	rc = 0;
 	if (copy_to_user(argp, dasd_info,
-- 
2.39.2

