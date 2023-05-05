Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63B6F8ADC
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 23:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjEEV0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjEEV0d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 17:26:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3A59E9
        for <stable@vger.kernel.org>; Fri,  5 May 2023 14:26:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhKB4002999;
        Fri, 5 May 2023 21:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=zsjYpZDjec2cDG11KofgKIbf8pBRX5GD+P+aBbDcLwI=;
 b=xtANUU0HBjyl5UEywkvk0zqErMYqLVDjpRnpJHReUGH2ddJwK7ZuVqDUWfLg/hGl8hEv
 pvhe6R1MaoYcRVQP2wuGA0wqKGc1/IIuZ3Fg6u+Uq9tqiXVHhBg5zNmWzIALk6vTnBJm
 +/kqhWhZhfUuppoO4kP1Z5FfBix+e8XxK9hw3bCPLmvgy21z9je2xoDpUr9oN9yPYsJl
 nj7MmHbnBTrtdpE6TzsA3tBxoB3DD+EMDpwoY7TQqbyIraGlq7cGb/4oH/Th0Pd95CVI
 0eLQ2uT/cL/oyO9SW9OgWIQ1c26mzc9Rjd6ejvqTYkq+zB5pkZeZYWoGIxeZQVU4mkyH lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdxy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345L2Ymm009942;
        Fri, 5 May 2023 21:24:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spavd6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:24:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 345LNjER009843;
        Fri, 5 May 2023 21:24:07 GMT
Received: from hmadhani-upstream.osdevelopmeniad.oraclevcn.com (hmadhani-upstream.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q8spavcve-25;
        Fri, 05 May 2023 21:24:07 +0000
From:   himanshu.madhani@oracle.com
To:     himanshu.madhani@oracle.com
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH 24/24] zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space
Date:   Fri,  5 May 2023 21:23:36 +0000
Message-Id: <442adac9dc216fbc85169a7086f7bec3d25baf66.1683321409.git.himanshu.madhani@oracle.com>
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
X-Proofpoint-GUID: YfKPeDfC-A02akiA_4AYh79MGq6wUHN7
X-Proofpoint-ORIG-GUID: YfKPeDfC-A02akiA_4AYh79MGq6wUHN7
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

The call to invalidate_inode_pages2_range() in __iomap_dio_rw() may
fail, in which case -ENOTBLK is returned and this error code is
propagated back to user space trhough iomap_dio_rw() ->
zonefs_file_dio_write() return chain. This error code is fairly obscure
and may confuse the user. Avoid this and be consistent with the behavior
of zonefs_file_dio_append() for similar invalidate_inode_pages2_range()
errors by returning -EBUSY to user space when iomap_dio_rw() returns
-ENOTBLK.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
(cherry picked from commit 77af13ba3c7f91d91c377c7e2d122849bbc17128)

Orabug: 35351356

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Conflicts:
	fs/zonefs/file.c

small conflicts due to old api for iomap_dio_rw()
---
 fs/zonefs/file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 49b934c98c5a..27cd84c5e5d0 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -583,11 +583,20 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		append = sync;
 	}
 
-	if (append)
+	if (append) {
 		ret = zonefs_file_dio_append(iocb, from);
-	else
+	} else {
+		/*
+		 * iomap_dio_rw() may return ENOTBLK if there was an issue with
+		 * page invalidation. Overwrite that error code with EBUSY to
+		 * be consistent with zonefs_file_dio_append() return value for
+		 * similar issues.
+		 */
 		ret = iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, 0);
+		if (ret == -ENOTBLK)
+			ret = -EBUSY;
+	}
 
 	if (zonefs_zone_is_seq(z) &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
-- 
2.31.1

