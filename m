Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138576657A
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjG1Hjr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjG1Hjq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 03:39:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBA2D64
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 00:39:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2YxMg020250;
        Fri, 28 Jul 2023 07:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=MCawt/0owLybzIzpz2sNVs3FdGU9xYbqfDKIHvBQa6w=;
 b=FCNr2ddN7trOndNbf4IbjQRpu68mUWp+fh1DDqFcE98DGnmRFD11iP+EdSexkCAQ1v25
 vrt4kyFr/c2+kfQUdOaQNmkuaewtGdpzTgrPv+npmjRfRwHyRDvC7LT9rQJY+KS6wMBp
 4nmQPRM/65aWq7r0htgUYSVtMvJ2nmXRZbdiPcntAtqAuQwUxLA26dx2gObHwZcq6aAg
 iwtFY/U4GYYxofLUr8Fq2jA05X7VY1nziAXM1hUkaWkMRO88RMMN4xq+1a+k3SsSb0yR
 IWMjIC3rIy2efeWEjPdw9Tm9rjp3/808p46cZT/k35QYmKd/oB8eaNAF6P6PSdMGJM+j Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3uc17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S6gNdr030480;
        Fri, 28 Jul 2023 07:39:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jf0a6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:18 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S7dG0s007017;
        Fri, 28 Jul 2023 07:39:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s05jf0a4q-3;
        Fri, 28 Jul 2023 07:39:18 +0000
From:   Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To:     stable@vger.kernel.org
Cc:     harshvardhan.j.jha@oracle.com, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com
Subject: [PATCH 5.4 2/3] btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled
Date:   Fri, 28 Jul 2023 00:39:13 -0700
Message-ID: <20230728073914.226947-3-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728073914.226947-1-harshvardhan.j.jha@oracle.com>
References: <20230728073914.226947-1-harshvardhan.j.jha@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280069
X-Proofpoint-GUID: _LtNo74qbv3m621wMfYjq6I7Yb9KnWo5
X-Proofpoint-ORIG-GUID: _LtNo74qbv3m621wMfYjq6I7Yb9KnWo5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[Upstream commit 8a36e408d40606e21cd4e2dd9601004a67b14868]

[PROBLEM]
qgroup create/remove code is currently returning EINVAL when the user
tries to create a qgroup on a subvolume without quota enabled. EINVAL is
already being used for too many error scenarios so that is hard to
depict what is the problem.

[FIX]
Currently scrub and balance code return -ENOTCONN when the user tries to
cancel/pause and no scrub or balance is currently running for the
desired subvolume. Do the same here by returning -ENOTCONN  when a user
tries to create/delete/assing/list a qgroup on a subvolume without quota
enabled.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 fs/btrfs/qgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 588abadcd784..7327636c9f26 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1354,7 +1354,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	member = find_qgroup_rb(fs_info, src);
@@ -1413,7 +1413,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		return -ENOMEM;
 
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1479,7 +1479,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	quota_root = fs_info->quota_root;
@@ -1513,7 +1513,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1564,7 +1564,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
-- 
2.40.0

