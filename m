Return-Path: <stable+bounces-93757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E206D9D07E6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 03:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380C2B218A5
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 02:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87D1E507;
	Mon, 18 Nov 2024 02:26:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D33360
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896799; cv=none; b=eLxKkpSypVmAw2K5zp2j1G7TBVAbAjJPl29edng7FWcsp1OcaPNIK4lYdazTFJH5zE5sueBQgky0m0XvCThjxwWa22tgVE/9rirzFnz80YfdOwDpb8qYhOFn3zJirQp1cBsVCM89BAv0fJsxup7jD1ye3CB5dAcpO+ZnmFtBxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896799; c=relaxed/simple;
	bh=TXn4y5juGEPBgwUxkcoJFh3/fXqGLIrnAAh6BseMT/M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWXQBBD2Av5Wfpn8o8WNFp+PWOFfW+NFXCMbz3KrsdWBjst4M/UibWd5jr6V9T3ioyAlrqunWmQkDhtCSym5MB5n01x92dfh92lSQ0goBX2tSU1GTX2no/pfbNwXIMREofeA9S1lmBQkIBlkvHo/kqu+AFQwfhDiEBsfzr9fsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1SRKC027004;
	Sun, 17 Nov 2024 18:26:30 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7s3xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 17 Nov 2024 18:26:29 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 17 Nov 2024 18:26:29 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 17 Nov 2024 18:26:28 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1] fs/ntfs3: Additional check in ntfs_file_release
Date: Mon, 18 Nov 2024 10:26:50 +0800
Message-ID: <20241118022650.558385-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WBGNfDIgZLgYHqb3RVdV_xkXT1JWHZRW
X-Proofpoint-GUID: WBGNfDIgZLgYHqb3RVdV_xkXT1JWHZRW
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673aa5d5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=GFCt93a2AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=2DXtWoY0YfVhbeZ-LxUA:9 a=0UNspqPZPZo5crgNHNjb:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180020

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 031d6f608290c847ba6378322d0986d08d1a645a ]

Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/ntfs3/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index aedd4f5f459e..70b38465aee3 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1214,8 +1214,16 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	int err = 0;
 
 	/* If we are last writer on the inode, drop the block reservation. */
-	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
-				      atomic_read(&inode->i_writecount) == 1)) {
+	if (sbi->options->prealloc &&
+	    ((file->f_mode & FMODE_WRITE) &&
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
-- 
2.43.0


