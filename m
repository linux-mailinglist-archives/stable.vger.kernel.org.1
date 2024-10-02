Return-Path: <stable+bounces-80556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBE98DE66
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8850D1F27EE6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912A1D079B;
	Wed,  2 Oct 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lTK+wfxe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B21D014A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881622; cv=none; b=IkwlveTwC6qEySk2BsU7DKXRPLp3aiQgcLNpFRF1bSZtUsfurXGH/3XtOp/ToY/kWxoOM2bOB3Y8MjBumtN39xF/ajE+tHHf8M3lonzL91BqxCOmebYLVWhyC5CsSTG1JZRzUENlKln65lA80wESC+IMqKfRmPCUEWJkFBd1mdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881622; c=relaxed/simple;
	bh=67gC+sdycsd89kF/ZN1YZw+yvFn+yUbJF2/Tkvvp4bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvUBznBqV7WYaUJiJid59NzV5/gYHGI1XyFktLoj7Ltft5rRZ3K8EhZGCUTb8wYiJm+2HNoJtTn+5iIs92WXAyLZE/J3rgUnDP6b8F4lttnbYnh5ZiLBRLBzAUsIt7FB0jZJq1KxfxutGJAKolC+RcLPXB8kigCHroEV9xmpLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lTK+wfxe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd47o011627;
	Wed, 2 Oct 2024 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=g
	UrJV3j2hY74JlgQWzmUYhZLy+a6taaL2TrlfL6Dqok=; b=lTK+wfxeTRRQC5tA5
	y2YYvD3P3HXj/cYavLpfoYbMWrDqslTVhE2t3SCsjZg4+QoJsmVIYE/yUbx/PddU
	VeuSlGTtCFF8ap3TZ2Ef9EO+WDVM8efk42L9gOS9tz0kkyp9Vj8MeG1DXHgBNer6
	61rpKEZ9Qkp0/SQuXXa4LIQZYZTfJuUzha26J0qXoRdVVz2VVNgwfsvMBQYB2xMP
	OBaz7wU4FbG9HXQIn85oFce7fFYSRGtSyMVG6QpgnP9hkIZ/pxwghcNnyb8ccDH/
	sZkJ10QBFGUuEaKBqzJ4OS4Z8icRRXeh4nNVm+LS8vtEpcbr9t412pNpzQVqeNjt
	xaCqg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EsOuJ017377;
	Wed, 2 Oct 2024 15:06:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y04c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZE012831;
	Wed, 2 Oct 2024 15:06:30 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-2;
	Wed, 02 Oct 2024 15:06:29 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Zhihao Cheng <chengzhihao1@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 01/15] ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path
Date: Wed,  2 Oct 2024 17:05:52 +0200
Message-Id: <20241002150606.11385-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: NtTPQ7whmyf8lu_ECd-F-qb43TeMRttD
X-Proofpoint-ORIG-GUID: NtTPQ7whmyf8lu_ECd-F-qb43TeMRttD

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 6379b44cdcd67f5f5d986b73953e99700591edfa ]

For error handling path in ubifs_symlink(), inode will be marked as
bad first, then iput() is invoked. If inode->i_link is initialized by
fscrypt_encrypt_symlink() in encryption scenario, inode->i_link won't
be freed by callchain ubifs_free_inode -> fscrypt_free_inode in error
handling path, because make_bad_inode() has changed 'inode->i_mode' as
'S_IFREG'.
Following kmemleak is easy to be reproduced by injecting error in
ubifs_jnl_update() when doing symlink in encryption scenario:
 unreferenced object 0xffff888103da3d98 (size 8):
  comm "ln", pid 1692, jiffies 4294914701 (age 12.045s)
  backtrace:
   kmemdup+0x32/0x70
   __fscrypt_encrypt_symlink+0xed/0x1c0
   ubifs_symlink+0x210/0x300 [ubifs]
   vfs_symlink+0x216/0x360
   do_symlinkat+0x11a/0x190
   do_syscall_64+0x3b/0xe0
There are two ways fixing it:
 1. Remove make_bad_inode() in error handling path. We can do that
    because ubifs_evict_inode() will do same processes for good
    symlink inode and bad symlink inode, for inode->i_nlink checking
    is before is_bad_inode().
 2. Free inode->i_link before marking inode bad.
Method 2 is picked, it has less influence, personally, I think.

Cc: stable@vger.kernel.org
Fixes: 2c58d548f570 ("fscrypt: cache decrypted symlink target in ->i_link")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
(cherry picked from commit 6379b44cdcd67f5f5d986b73953e99700591edfa)
[Vegard: CVE-2024-26972; no conflicts]
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 fs/ubifs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index be45972ff95d9..d2b76367908f2 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1126,6 +1126,8 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	mutex_unlock(&dir_ui->ui_mutex);
 out_inode:
+	/* Free inode->i_link before inode is marked as bad. */
+	fscrypt_free_inode(inode);
 	make_bad_inode(inode);
 	iput(inode);
 out_fname:
-- 
2.34.1


