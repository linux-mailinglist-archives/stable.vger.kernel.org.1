Return-Path: <stable+bounces-81139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E051991287
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 00:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD941C22012
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8E14BF8A;
	Fri,  4 Oct 2024 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VnWhV6gI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8E14BF92
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082428; cv=none; b=uuozA804d36QQHlZIwS/KxPk6/p0iZXjzeYT1jDjd27h+VGpSY0n6RlRKkOzdeH86oBuBzTeSdCW7GsIkV58uN7rqpjrg3SzTyMDV7hDW5YWOmMXFJCL5mH4wWEEJVHbR9kfaGTrK3AyyQHeKtIw/IddWHDqUws0e8YaEMjghyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082428; c=relaxed/simple;
	bh=mEGZgk/H3Vt8/9b3XEoSPrWMrFcBzNIR9FTJX7liKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ID2CxZdnC5Kyw6FpmBvl51tgYbbOxXwp2jJJ/LInJslpDU49vdqRaO/EuCN2Z+kmvZdtcYk/f2+Y3oPXuJw63sHwODM7E+HKI5+3BRS4Zt8tYuW5rdOMuK0qVfxKLnOu1KrpEc5vS4SgpJL3Ma6Rg/0G4Kqq2G8jIKH5SXiLoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VnWhV6gI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494LtcJ6023656;
	Fri, 4 Oct 2024 22:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=VDUsfIEBE8zoIJ
	iGMwoaN/xybB/rnXxwT5CQznfdflc=; b=VnWhV6gIZNJqTSXsUlLAOGdm+yp0tM
	06EdJgBwWMOjZQq43oWFJFLmrh6Hhmn7w1YnQpNHOAbEYosbtAp+php8FdfR60uJ
	dyUIVwdwTtkhClj4qtdjkbK/fbxoerI9gdQcE8WXaj1sr1kZUIcQJ8YZJJ/Vtn7n
	uIEzoFCdCsfQivBGPAyG3NeFzj7dzHz+yL/plDDuidB2pD22ieMedpsajMkQXv/H
	qKpKYbE36ucBWYFRxuqT2+n78VAkuN23KjEa1JFY+3Id0BhU/cjsX46JO4kqbuk9
	kHGk/6ApIyP5YMWuRxx9/NDCUpTgy7iHh4auLMy38OwMeD0PhXqVzliw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b2kn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 22:52:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494Kn86T013780;
	Fri, 4 Oct 2024 22:52:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4220585fs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 22:52:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494MqujV028945;
	Fri, 4 Oct 2024 22:52:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4220585frt-1;
	Fri, 04 Oct 2024 22:52:56 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: asmadeus@codewreck.org, linux_oss@crudebyte.com,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 5.15.y] 9p: add missing locking around taking dentry fid list
Date: Fri,  4 Oct 2024 15:52:55 -0700
Message-ID: <20241004225255.370933-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_20,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=890 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040157
X-Proofpoint-ORIG-GUID: Vv1wVAZLShld1YWz6I95S2qUWYFfmCUx
X-Proofpoint-GUID: Vv1wVAZLShld1YWz6I95S2qUWYFfmCUx

From: Dominique Martinet <asmadeus@codewreck.org>

commit c898afdc15645efb555acb6d85b484eb40a45409 upstream.

Fix a use-after-free on dentry's d_fsdata fid list when a thread
looks up a fid through dentry while another thread unlinks it:

UAF thread:
refcount_t: addition on 0; use-after-free.
 p9_fid_get linux/./include/net/9p/client.h:262
 v9fs_fid_find+0x236/0x280 linux/fs/9p/fid.c:129
 v9fs_fid_lookup_with_uid linux/fs/9p/fid.c:181
 v9fs_fid_lookup+0xbf/0xc20 linux/fs/9p/fid.c:314
 v9fs_vfs_getattr_dotl+0xf9/0x360 linux/fs/9p/vfs_inode_dotl.c:400
 vfs_statx+0xdd/0x4d0 linux/fs/stat.c:248

Freed by:
 p9_fid_destroy (inlined)
 p9_client_clunk+0xb0/0xe0 linux/net/9p/client.c:1456
 p9_fid_put linux/./include/net/9p/client.h:278
 v9fs_dentry_release+0xb5/0x140 linux/fs/9p/vfs_dentry.c:55
 v9fs_remove+0x38f/0x620 linux/fs/9p/vfs_inode.c:518
 vfs_unlink+0x29a/0x810 linux/fs/namei.c:4335

The problem is that d_fsdata was not accessed under d_lock, because
d_release() normally is only called once the dentry is otherwise no
longer accessible but since we also call it explicitly in v9fs_remove
that lock is required:
move the hlist out of the dentry under lock then unref its fids once
they are no longer accessible.

Fixes: 154372e67d40 ("fs/9p: fix create-unlink-getattr idiom")
Cc: stable@vger.kernel.org
Reported-by: Meysam Firouzi
Reported-by: Amirmohammad Eftekhar
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <20240521122947.1080227-1-asmadeus@codewreck.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[Samasth: backport to 5.15.y]
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Conflicts:
        fs/9p/vfs_dentry.c
        keep p9_client_clunk instead of introducing the helper function
        p9_fid_get/put from commit b48dbb998d70 ("9p fid refcount: add
        p9_fid_get/put wrappers")
---
This is a fix for CVE-2024-39463, minor conflict resolution involved.
---
 fs/9p/vfs_dentry.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c2736af97884f..afcf4711ac2a8 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -52,12 +52,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 static void v9fs_dentry_release(struct dentry *dentry)
 {
 	struct hlist_node *p, *n;
+	struct hlist_head head;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
-	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
+
+	spin_lock(&dentry->d_lock);
+	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	spin_unlock(&dentry->d_lock);
+
+	hlist_for_each_safe(p, n, &head)
 		p9_client_clunk(hlist_entry(p, struct p9_fid, dlist));
-	dentry->d_fsdata = NULL;
 }
 
 static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
-- 
2.46.0


