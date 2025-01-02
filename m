Return-Path: <stable+bounces-106638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467B9FF676
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563803A1E2D
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1B18B499;
	Thu,  2 Jan 2025 06:22:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03115C0
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735798947; cv=none; b=by8OCFRwXwlkZRYr2nPq4Fcj66laFEgdD6+MtboH9JTyGfOtY0Tq2F98aGcBPUsOMzdtRtln/wU1E0Wj4DpC+iMdZdHEDOCiX4JtoWEhKFiMd8fQYMNq7SoPADHHXEdoa4OaasY8D9VIhZFSNzWKPCwG1Af2WLsUFlD8Xm7/2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735798947; c=relaxed/simple;
	bh=xrvutlmgto6C97iXeEUZM7hcVXsqqhpscWAKSN2SG94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COrIXBj7YoWiPkG7VsBbR8xE/wJ7CgW4zPAZ1qEz8EBp05JRxrsLKSCQl0db8ikzMlUwpJwifQSeh1ZNZzsfll5DuxWDI9SyTY3gIr9Kms8CD42V6MDA0DFPZmpo2acK36337U10iTdBavMUQsnQ1hC5AiRNSaHOn9PRbIYibeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=fail smtp.mailfrom=foxmail.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=foxmail.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5025xGof009542;
	Wed, 1 Jan 2025 22:22:14 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43thqq3hgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 01 Jan 2025 22:22:13 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 1 Jan 2025 22:22:13 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.139) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 1 Jan 2025 22:22:12 -0800
From: Alva Lan <alvalan9@foxmail.com>
To: <stable@vger.kernel.org>, <chao@kernel.org>
CC: <jaegeuk@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to wait dio completion
Date: Thu, 2 Jan 2025 14:22:45 +0800
Message-ID: <20250102062245.456512-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RoI/LDmK c=1 sm=1 tr=0 ts=67763095 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VdSt8ZQiCzkA:10 a=x7bEGLp0ZPQA:10 a=NwS9F1Xdo7AA:10 a=VwQbUJbxAAAA:8 a=bDN84i_9AAAA:8 a=bwK7ZqNxcec2lMBulLIA:9
 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-GUID: e80Pqgpn5AlQ7SJ077tdlrqttg8AQpQw
X-Proofpoint-ORIG-GUID: e80Pqgpn5AlQ7SJ077tdlrqttg8AQpQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_02,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1034 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501020054

From: Chao Yu <chao@kernel.org>

[ Upstream commit 96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d ]

It should wait all existing dio write IOs before block removal,
otherwise, previous direct write IO may overwrite data in the
block which may be reused by other inode.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Resolve line conflicts to make it work on 6.6.y ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/f2fs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 196755a34833..ae129044c52f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1037,6 +1037,13 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1873,6 +1880,12 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (ret)
 		goto out;
 
+	/*
+	 * wait for inflight dio, blocks should be removed after IO
+	 * completion.
+	 */
+	inode_dio_wait(inode);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.43.0


