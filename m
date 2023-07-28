Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54EB766577
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjG1HjY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjG1HjX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 03:39:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C221B6
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 00:39:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2C62c015815;
        Fri, 28 Jul 2023 07:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=qXAQvX1n/422sBe1eWteRHPdDcJ44srlAsw63XcdWhc=;
 b=UCOJj1mFgA1RcNfJI9paYmZz88D+iKy0Z6ym0+K0CL//qMTIzC8bnY4tI6hepD6WHYE9
 xVutTlqDoWbWRssANIZjPxj68DL/rdwZsbH56E3FO9uq/SjcgAXuJZ+ikeE1kL94I7kT
 Q2F1FikXMZici37JX3EYk0062vLnkt6YJiwQDNO6snIgcfHMI/wQrgwOdZtg4Dl7srPA
 ksT9C89F1SR6Xca8rRoWml1I9oWqu3Dr80o07Pi+/aTDifOOhRKsStbkJvsFBYXtXMY8
 XuCsdKe93acqCne9H1jSIUrF+s5LFpsQfCmhlA1aTo+FI97jBWrU4bmhihn5+3YojN3f Sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu3au7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S63mln030382;
        Fri, 28 Jul 2023 07:39:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jf0a66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S7dG0q007017;
        Fri, 28 Jul 2023 07:39:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s05jf0a4q-2;
        Fri, 28 Jul 2023 07:39:17 +0000
From:   Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To:     stable@vger.kernel.org
Cc:     harshvardhan.j.jha@oracle.com, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com
Subject: [PATCH 5.4 1/3] btrfs: qgroup: remove one-time use variables for quota_root checks
Date:   Fri, 28 Jul 2023 00:39:12 -0700
Message-ID: <20230728073914.226947-2-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-ORIG-GUID: bkqRfskaIIZctSYnAUMtcJORH2zGdghh
X-Proofpoint-GUID: bkqRfskaIIZctSYnAUMtcJORH2zGdghh
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

[Upstream commit e3b0edd29737d44137fc7583a9c185abda6e23b8]

Remove some variables that are set only to be checked later, and never
used.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 fs/btrfs/qgroup.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 353e89efdebf..588abadcd784 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1338,7 +1338,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
@@ -1354,8 +1353,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		return -ENOMEM;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1402,7 +1400,6 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 				 u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
@@ -1415,8 +1412,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	if (!tmp)
 		return -ENOMEM;
 
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1482,11 +1478,11 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
+	quota_root = fs_info->quota_root;
 	qgroup = find_qgroup_rb(fs_info, qgroupid);
 	if (qgroup) {
 		ret = -EEXIST;
@@ -1511,14 +1507,12 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup_list *list;
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1560,7 +1554,6 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	int ret = 0;
 	/* Sometimes we would want to clear the limit on this qgroup.
@@ -1570,8 +1563,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 	const u64 CLEAR_VALUE = -1;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2677,10 +2669,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root = fs_info->quota_root;
 	int ret = 0;
 
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		return ret;
 
 	spin_lock(&fs_info->qgroup_lock);
@@ -2943,7 +2934,6 @@ static bool qgroup_check_limits(const struct btrfs_qgroup *qg, u64 num_bytes)
 static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 			  enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 ref_root = root->root_key.objectid;
@@ -2962,8 +2952,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 		enforce = false;
 
 	spin_lock(&fs_info->qgroup_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		goto out;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -3030,7 +3019,6 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 			       u64 ref_root, u64 num_bytes,
 			       enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
@@ -3048,8 +3036,7 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 	}
 	spin_lock(&fs_info->qgroup_lock);
 
-	quota_root = fs_info->quota_root;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		goto out;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -3940,7 +3927,6 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 				int num_bytes)
 {
-	struct btrfs_root *quota_root = fs_info->quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
@@ -3948,7 +3934,7 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 
 	if (num_bytes == 0)
 		return;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		return;
 
 	spin_lock(&fs_info->qgroup_lock);
-- 
2.40.0

