Return-Path: <stable+bounces-104217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91309F2130
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090D4166D0D
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCA1B0F19;
	Sat, 14 Dec 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oAvNMVdk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BF1AB500
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214750; cv=none; b=ipuGz9pkE7qgf2buZbF2JuxdQtZLJSoyFgFf7Ob9YzDOvwGFAQcCl8XAtdGxXc/SfzXeumpRnFVpUrONke8HAizoYvJ1iPsg8SCQTvmdGsIqtAZ0he8T+fx/tP0SuG16E1WdUCm0DvQtH0ti82w0leusn7WmMJbm2CRnDUXp5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214750; c=relaxed/simple;
	bh=pKhOtl4mzQL4enUuf4f8HkMHFVdhHR+XuNvtR9c22WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd1fr8P71X3N00WficmFC+Lztd7F20OvyG0DWGgq6IqxfvxpPt77GhUwkj9PANz8CthGT7Ze3qk2rECPWFhZ3MXkc5z19kGY5J7VPnKTG//LMVI2r/cvCQcP39+c3uSF91xVkv7KqGUcuVJe1uZ3MSWH4PvU6HiK/Awz1FVTqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oAvNMVdk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEMGiki009609;
	Sat, 14 Dec 2024 22:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=1Qx+k
	pZBQG36YW9tkLcDIHjLkPvIaZYZC3A5d7VA93k=; b=oAvNMVdkCpn2HcJ5DqT+U
	7vnvtVO8Gb2Kfw0yVm4vELwBQW90axV6VnEn9XZD/nVehWJPwmTDRGdt5MRfY10a
	wws9iVGbFNILfazKFc4yTzbp4SUJatH08p2jUtZQBkxpNzGykYEg1zAfbDyXN7Jg
	tIP+PFYeX087E64/IGw0XEVPj3DGpHo7TQH7EwFMXx2JGAXPc7MD+cQrAtRK+2yE
	Yyj7FL8ndqCckXu2F/H7wLIwyFZTtchXGmG4j7Cwe9HFaQAdaUnEWX0vflcv30xc
	H0ZxKd3cH4lEqcHdRDAYwoaqAxACE4pnp1Vz3PRYamYP+dqrGHoS3TT14X8kZJfY
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t28ry1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 22:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEJGaYL010974;
	Sat, 14 Dec 2024 22:18:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f5ry70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 22:18:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BEMIpQT029436;
	Sat, 14 Dec 2024 22:18:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43h0f5ry5t-2;
	Sat, 14 Dec 2024 22:18:52 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: sherry.yang@oracle.com, vegard.nossum@oracle.com,
        Sungjong Seo <sj1557.seo@samsung.com>,
        syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com,
        Namjae Jeon <linkinjeon@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 2/2] exfat: fix potential deadlock on __exfat_get_dentry_set
Date: Sat, 14 Dec 2024 14:18:39 -0800
Message-ID: <20241214221839.3274375-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241214221839.3274375-1-harshit.m.mogalapalli@oracle.com>
References: <20241214221839.3274375-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: _OFT0v_z8u0aOxz3DonI7plyDHj0klc8
X-Proofpoint-GUID: _OFT0v_z8u0aOxz3DonI7plyDHj0klc8

From: Sungjong Seo <sj1557.seo@samsung.com>

[ Upstream commit 89fc548767a2155231128cb98726d6d2ea1256c9 ]

When accessing a file with more entries than ES_MAX_ENTRY_NUM, the bh-array
is allocated in __exfat_get_entry_set. The problem is that the bh-array is
allocated with GFP_KERNEL. It does not make sense. In the following cases,
a deadlock for sbi->s_lock between the two processes may occur.

       CPU0                CPU1
       ----                ----
  kswapd
   balance_pgdat
    lock(fs_reclaim)
                      exfat_iterate
                       lock(&sbi->s_lock)
                       exfat_readdir
                        exfat_get_uniname_from_ext_entry
                         exfat_get_dentry_set
                          __exfat_get_dentry_set
                           kmalloc_array
                            ...
                            lock(fs_reclaim)
    ...
    evict
     exfat_evict_inode
      lock(&sbi->s_lock)

To fix this, let's allocate bh-array with GFP_NOFS.

Fixes: a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000fef47e0618c0327f@google.com
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
(cherry picked from commit 89fc548767a2155231128cb98726d6d2ea1256c9)
[Harshit: Backport to 6.1.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/exfat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 6fd9a06cc7d0..d58c69018051 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -870,7 +870,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
 	if (num_bh > ARRAY_SIZE(es->__bh)) {
-		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_NOFS);
 		if (!es->bh) {
 			brelse(bh);
 			kfree(es);
-- 
2.46.0


