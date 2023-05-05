Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B716F8ADA
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjEEV0d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEEV0a (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 17:26:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F32D6A
        for <stable@vger.kernel.org>; Fri,  5 May 2023 14:26:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQUJ031799;
        Fri, 5 May 2023 21:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=bjUwjCQyiSBwtCg47yTdpi2L9PLY8w9an/0GAGfqqWo=;
 b=hHy13W5LQi3LDM4QA3H1MJYIAY2Zrc5MdG6zdzK3xOqfx2BN9ShUSC/5jK/PqsltmBx4
 fliW55e1AD4w+GCP3l3igb1ku1wJPIYg+4FHpGqj62jgk2vd8XvwPyYbJSEcomAthfkq
 mFOAmUdSp59awP1WRUJiLjv8gElbiVDNG4LdMsFpVE/dL+uL+7VvGb6nA9bz/bn6GfdP
 WgKf2jXJQAwD6jtetBatas1TSysgt4vYWiDG3oTSXzB+cKZTX9P3Zr8XJ2Pj87Veo0mv
 y8Xe5n+2Wz/JpO/L9hOQn4ciK1OU45QnwmIwb6aHMM8kfyvXKFBtbneLnRH4vd09MJyn sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d615c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345K7LdJ010063;
        Fri, 5 May 2023 21:24:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spavd5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 345LNjEP009843;
        Fri, 5 May 2023 21:24:06 GMT
Received: from hmadhani-upstream.osdevelopmeniad.oraclevcn.com (hmadhani-upstream.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q8spavcve-24;
        Fri, 05 May 2023 21:24:06 +0000
From:   himanshu.madhani@oracle.com
To:     himanshu.madhani@oracle.com
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH 23/24] zonefs: Always invalidate last cached page on append write
Date:   Fri,  5 May 2023 21:23:35 +0000
Message-Id: <7e622d339b9a2184628e8e49c38ab4e23b4dfc24.1683321409.git.himanshu.madhani@oracle.com>
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
X-Proofpoint-GUID: OCkMSyIbz3rso00aAZvx_77Gfzph0CRo
X-Proofpoint-ORIG-GUID: OCkMSyIbz3rso00aAZvx_77Gfzph0CRo
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

When a direct append write is executed, the append offset may correspond
to the last page of a sequential file inode which might have been cached
already by buffered reads, page faults with mmap-read or non-direct
readahead. To ensure that the on-disk and cached data is consistant for
such last cached page, make sure to always invalidate it in
zonefs_file_dio_append(). If the invalidation fails, return -EBUSY to
userspace to differentiate from IO errors.

This invalidation will always be a no-op when the FS block size (device
zone write granularity) is equal to the page size (e.g. 4K).

Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
(cherry picked from commit c1976bd8f23016d8706973908f2bb0ac0d852a8f)

Orabug: 35351356

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 fs/zonefs/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 5708c54cda69..49b934c98c5a 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -382,6 +382,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct block_device *bdev = inode->i_sb->s_bdev;
 	unsigned int max = bdev_max_zone_append_sectors(bdev);
+	pgoff_t start, end;
 	struct bio *bio;
 	ssize_t size = 0;
 	int nr_pages;
@@ -390,6 +391,19 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
+	/*
+	 * If the inode block size (zone write granularity) is smaller than the
+	 * page size, we may be appending data belonging to the last page of the
+	 * inode straddling inode->i_size, with that page already cached due to
+	 * a buffered read or readahead. So make sure to invalidate that page.
+	 * This will always be a no-op for the case where the block size is
+	 * equal to the page size.
+	 */
+	start = iocb->ki_pos >> PAGE_SHIFT;
+	end = (iocb->ki_pos + iov_iter_count(from) - 1) >> PAGE_SHIFT;
+	if (invalidate_inode_pages2_range(inode->i_mapping, start, end))
+		return -EBUSY;
+
 	nr_pages = iov_iter_npages(from, BIO_MAX_VECS);
 	if (!nr_pages)
 		return 0;
-- 
2.31.1

