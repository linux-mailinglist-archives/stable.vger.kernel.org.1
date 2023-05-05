Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AF6F8AB6
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjEEVYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEEVYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 17:24:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5521BC
        for <stable@vger.kernel.org>; Fri,  5 May 2023 14:24:09 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhLNs031584;
        Fri, 5 May 2023 21:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=geOwwVAtA4YtQcw9ZvgruOgp4u2nOXXz19598VGLQyI=;
 b=L9N4JpIy/wD2e83wFw12HtZnaI6UNQPbiB/hyL3mkbpnYQfW7SePI9HQsUwkZAH+4D0U
 zQvKDPZRsJ9NUce0wgjTP1oRT2UVXQAQqT11JTTYrnoHWXQv0/j/IkR0UOeAYltV3a+g
 oraAaREAkh8I8QcxZbKQCvNUmQUVjQEBXSo0jFlQ5FUh9hiagj97g5QjxALmt+lKades
 zLxm3GUBTlF3NuACOwWhhRKnhChbEakYnO7wfutJvtVEJNJDlt4hZ8nePTQEbZu1M6Xe
 UFMYw8U6F/iMsX62jdrkrWz714V9egEA4bA40H2N9nKeOSoN5HKGwNI7c6E/eYRTUqNG ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d615a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345J3OMf009864;
        Fri, 5 May 2023 21:24:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spavd52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 345LNjEN009843;
        Fri, 5 May 2023 21:24:05 GMT
Received: from hmadhani-upstream.osdevelopmeniad.oraclevcn.com (hmadhani-upstream.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q8spavcve-23;
        Fri, 05 May 2023 21:24:05 +0000
From:   himanshu.madhani@oracle.com
To:     himanshu.madhani@oracle.com
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 22/24] zonefs: Fix error message in zonefs_file_dio_append()
Date:   Fri,  5 May 2023 21:23:34 +0000
Message-Id: <98967bd9d7e7b52cf386b085dd9fab83bacc8e83.1683321409.git.himanshu.madhani@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1683321409.git.himanshu.madhani@oracle.com>
References: <cover.1683321409.git.himanshu.madhani@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050173
X-Proofpoint-GUID: IBjMCqBtzRDNg5NHP5LeMUaKKSvZ-LGO
X-Proofpoint-ORIG-GUID: IBjMCqBtzRDNg5NHP5LeMUaKKSvZ-LGO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Since the expected write location in a sequential file is always at the
end of the file (append write), when an invalid write append location is
detected in zonefs_file_dio_append(), print the invalid written location
instead of the expected write location.

Fixes: a608da3bd730 ("zonefs: Detect append writes at invalid locations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
(cherry picked from commit 88b170088ad2c3e27086fe35769aa49f8a512564)

Orabug: 35351356

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 fs/zonefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 82f608d57a84..5708c54cda69 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -428,7 +428,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 		if (bio->bi_iter.bi_sector != wpsector) {
 			zonefs_warn(inode->i_sb,
 				"Corrupted write pointer %llu for zone at %llu\n",
-				wpsector, z->z_sector);
+				bio->bi_iter.bi_sector, z->z_sector);
 			ret = -EIO;
 		}
 	}
-- 
2.31.1

