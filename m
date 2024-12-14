Return-Path: <stable+bounces-104218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779509F2131
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 23:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BF1887E54
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC861AB500;
	Sat, 14 Dec 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KG9XOMkJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0A29CEF
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214751; cv=none; b=sFKTjS9b1fBU2/hzSY3Vpvt9tx70QJNkwwb7BDpieRSKB9KAqFY5BLlg9gMzKz1JX16IaVk9XPbpWrTcD/ExcD1tEKW6O28CwkruleEDiccB/VMpp+8e7BUyGnJDRT1Xe7Fh3ATJKjRMcl8WQA+i46gYHUkC0JpUWxJ8BcNr65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214751; c=relaxed/simple;
	bh=Okwx8B1SW9dtxX0++WtSeEttgN9ZOKGqQ497cfpG6QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZKiXRjQtvjkKmSHa/7dy3itePNwON80pKy+L0JbhoLCLTv6oSnC+B6tKGWVYbGtT4dpIG3uGnMSv0+xetz4ducdBB6layxE6Gqe+61TA0Nk2/RNCHluqbjOaRuohChyqJdQGkJS/x8y05tcGebtVcLJu7kxbtrVGJrcIkD83sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KG9XOMkJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BELFbA9018516;
	Sat, 14 Dec 2024 22:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=aNHraNJeWw6L9gbBm1he+jz8MISKw
	cOyJ6gDykzD/c4=; b=KG9XOMkJyugNHCfkHm+bz7Jvz1Lgd+wy5J4HVNGPuY29d
	wDtCeA5YlzpLCg8fXwGEQHdi/+QPjvZHSjqnzCwvCoKnVqSuhmWf2AYMwJiu9tHq
	zgjZo+Qr+NRtJgPu4Ga+KXThJUdd0GjjoHjcE0GKbTU60opX5EA8nrGN99Tggu3d
	51nRCH4b/6+tHPbILpb3nIrhzWbgAi7aCUlZXU9Pjk4HrPp1RA2G8b4Ia92guJmg
	k1PQ/EL73P51XL0DdD8UFHIQmVeqOHA/d3VY6qR9o1rLrxFJJLWZnqYvzJv5soHp
	67skWbsQF6dr5qnyMdN6XBLP/yksIBxUQ0/LWccDA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1msgqhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 22:18:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEJkf1J010926;
	Sat, 14 Dec 2024 22:18:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f5ry67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 22:18:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BEMIpQR029436;
	Sat, 14 Dec 2024 22:18:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43h0f5ry5t-1;
	Sat, 14 Dec 2024 22:18:51 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: sherry.yang@oracle.com, vegard.nossum@oracle.com,
        Yuezhang Mo <Yuezhang.Mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
        Aoyama Wataru <wataru.aoyama@sony.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 1/2] exfat: support dynamic allocate bh for exfat_entry_set_cache
Date: Sat, 14 Dec 2024 14:18:38 -0800
Message-ID: <20241214221839.3274375-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_09,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140184
X-Proofpoint-ORIG-GUID: qsChbtBLezdRDXS4QOXngG5455DSYg-0
X-Proofpoint-GUID: qsChbtBLezdRDXS4QOXngG5455DSYg-0

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit a3ff29a95fde16906304455aa8c0bd84eb770258 ]

In special cases, a file or a directory may occupied more than 19
directory entries, pre-allocating 3 bh is not enough. Such as
  - Support vendor secondary directory entry in the future.
  - Since file directory entry is damaged, the SecondaryCount
    field is bigger than 18.

So this commit supports dynamic allocation of bh.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
(cherry picked from commit a3ff29a95fde16906304455aa8c0bd84eb770258)
[Harshit: Backport - clean cherry-pick to 6.1.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is already in 5.10.y and 5.15.y, let us apply this to 6.1.y, this
also has a fix commit: 89fc548767a2 ("exfat: fix potential deadlock on
__exfat_get_dentry_set"). Both apply cleanly on 6.1.y and builds fine.
No exfat specific testing is done.
---
 fs/exfat/dir.c      | 15 +++++++++++++++
 fs/exfat/exfat_fs.h |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 51b03b0dd5f7..6fd9a06cc7d0 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -613,6 +613,10 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 			bforget(es->bh[i]);
 		else
 			brelse(es->bh[i]);
+
+	if (IS_DYNAMIC_ES(es))
+		kfree(es->bh);
+
 	kfree(es);
 	return err;
 }
@@ -845,6 +849,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
 	es->start_off = off;
+	es->bh = es->__bh;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -864,6 +869,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	es->num_entries = num_entries;
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	if (num_bh > ARRAY_SIZE(es->__bh)) {
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		if (!es->bh) {
+			brelse(bh);
+			kfree(es);
+			return NULL;
+		}
+		es->bh[0] = bh;
+	}
+
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e0af6ace633c..c79c78bf265b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -169,10 +169,13 @@ struct exfat_entry_set_cache {
 	bool modified;
 	unsigned int start_off;
 	int num_bh;
-	struct buffer_head *bh[DIR_CACHE_SIZE];
+	struct buffer_head *__bh[DIR_CACHE_SIZE];
+	struct buffer_head **bh;
 	unsigned int num_entries;
 };
 
+#define IS_DYNAMIC_ES(es)	((es)->__bh != (es)->bh)
+
 struct exfat_dir_entry {
 	struct exfat_chain dir;
 	int entry;
-- 
2.46.0


