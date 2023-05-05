Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22C16F8AB0
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEEVYE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 17:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEEVYD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 17:24:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558A3AAD
        for <stable@vger.kernel.org>; Fri,  5 May 2023 14:24:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhLqZ003012;
        Fri, 5 May 2023 21:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=d1YS56ngbUrEXDhX2GcjwghZwqYutEsfCxhIWeBUxyM=;
 b=DJCXY8d59uBYpMi0mmCEWn76xUb2vDM1A4iNhUM7HAMj2sNt2zcAozEjlWTvk1lq95Zy
 /s5N9Q6nexNfE63QyOG8zYMzzjCSm/1NmubCqkDy8HEePwHlos7tg6tzMmpyQkt8FtZV
 Xb/f/IsnzYWclra253U9bFievXWNj14frmM6gewpm+N0MII2H3GyfEfZBf0itvqvGIub
 mem0+E9Rrt9U4W8YP1mrkuDwaCIbr+ixkvUK+YpPP8CX/BieeQtPrHADgIxd9L8Tj6t1
 OHwTHSUN4tV+d/zoRJRmq7y+izUkbeUqiVT2hA14ZOZEHJWGYSRkZj/OG0l9r1xueb/4 yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdxxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:23:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345LMqFS009941;
        Fri, 5 May 2023 21:23:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spavd1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 21:23:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 345LNjE7009843;
        Fri, 5 May 2023 21:23:57 GMT
Received: from hmadhani-upstream.osdevelopmeniad.oraclevcn.com (hmadhani-upstream.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q8spavcve-15;
        Fri, 05 May 2023 21:23:57 +0000
From:   himanshu.madhani@oracle.com
To:     himanshu.madhani@oracle.com
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/24] zonefs: Fix active zone accounting
Date:   Fri,  5 May 2023 21:23:26 +0000
Message-Id: <d784a36bbd744692486c9efe648e2e6f87d8c102.1683321409.git.himanshu.madhani@oracle.com>
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
X-Proofpoint-GUID: zVwVaitQ03OcoDuYacFKwkkY_2Vd6Mms
X-Proofpoint-ORIG-GUID: zVwVaitQ03OcoDuYacFKwkkY_2Vd6Mms
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

If a file zone transitions to the offline or readonly state from an
active state, we must clear the zone active flag and decrement the
active seq file counter. Do so in zonefs_account_active() using the new
zonefs inode flags ZONEFS_ZONE_OFFLINE and ZONEFS_ZONE_READONLY. These
flags are set if necessary in zonefs_check_zone_condition() based on the
result of report zones operation after an IO error.

Fixes: 87c9ce3ffec9 ("zonefs: Add active seq file accounting")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
(cherry picked from commit db58653ce0c7cf4d155727852607106f890005c0)

Orabug: 35351356

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 fs/zonefs/super.c  | 11 +++++++++++
 fs/zonefs/zonefs.h |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 355f2da12374..0552c103fcd8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -40,6 +40,13 @@ static void zonefs_account_active(struct inode *inode)
 	if (zi->i_ztype != ZONEFS_ZTYPE_SEQ)
 		return;
 
+	/*
+	 * For zones that transitioned to the offline or readonly condition,
+	 * we only need to clear the active state.
+	 */
+	if (zi->i_flags & (ZONEFS_ZONE_OFFLINE | ZONEFS_ZONE_READONLY))
+		goto out;
+
 	/*
 	 * If the zone is active, that is, if it is explicitly open or
 	 * partially written, check if it was already accounted as active.
@@ -53,6 +60,7 @@ static void zonefs_account_active(struct inode *inode)
 		return;
 	}
 
+out:
 	/* The zone is not active. If it was, update the active count */
 	if (zi->i_flags & ZONEFS_ZONE_ACTIVE) {
 		zi->i_flags &= ~ZONEFS_ZONE_ACTIVE;
@@ -324,6 +332,7 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 		inode->i_flags |= S_IMMUTABLE;
 		inode->i_mode &= ~0777;
 		zone->wp = zone->start;
+		zi->i_flags |= ZONEFS_ZONE_OFFLINE;
 		return 0;
 	case BLK_ZONE_COND_READONLY:
 		/*
@@ -342,8 +351,10 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 			zone->cond = BLK_ZONE_COND_OFFLINE;
 			inode->i_mode &= ~0777;
 			zone->wp = zone->start;
+			zi->i_flags |= ZONEFS_ZONE_OFFLINE;
 			return 0;
 		}
+		zi->i_flags |= ZONEFS_ZONE_READONLY;
 		inode->i_mode &= ~0222;
 		return i_size_read(inode);
 	case BLK_ZONE_COND_FULL:
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3233..1dbe78119ff1 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -39,8 +39,10 @@ static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)
 	return ZONEFS_ZTYPE_SEQ;
 }
 
-#define ZONEFS_ZONE_OPEN	(1 << 0)
-#define ZONEFS_ZONE_ACTIVE	(1 << 1)
+#define ZONEFS_ZONE_OPEN	(1U << 0)
+#define ZONEFS_ZONE_ACTIVE	(1U << 1)
+#define ZONEFS_ZONE_OFFLINE	(1U << 2)
+#define ZONEFS_ZONE_READONLY	(1U << 3)
 
 /*
  * In-memory inode data.
-- 
2.31.1

