Return-Path: <stable+bounces-61087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4993A6CF
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F74C1F22DFD
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250F158A01;
	Tue, 23 Jul 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCPb/y8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AF157A55;
	Tue, 23 Jul 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759934; cv=none; b=anXRRFx0eHo8z6smhQfp2UOBwb/tLFpt71VUqLV58YZpasxSJhuFbYOKLeqE+dGonmDc783ToCoSyoUAoM8Izvhdc2d8v0LSya5Mtmhk+eg1PJSAxO7+WaK9cKW87AI4n34Rr27Fze2nrKDItLs/quVUeKBj5oUUdMiYqXzXhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759934; c=relaxed/simple;
	bh=OoSybKS6Vwx9iyp24vsKx1EBkSAh/FNDSIanUCKmxU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9JYLKAEJFOuqXskrf4+bm7rR694nOW+y3BEtkfb/ii5hMvaAgS+7bMTnveEuFzS04ffV2fBCMaVPk2uTVjq50Zg8Q3t3+QhEPqsTvNjxpCp2HHZyQJ0uRr8/hzHMVbcIcYVw0mBXn0Ngs0SOJkU92s4JQpS0Nu0l1CTaV3d9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCPb/y8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38881C4AF09;
	Tue, 23 Jul 2024 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759934;
	bh=OoSybKS6Vwx9iyp24vsKx1EBkSAh/FNDSIanUCKmxU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCPb/y8BnFZaRlt85cFoK0aDbGzGl37t6wzEiRCv/9Rmm+dwu5owyjzKWPIiah/Cm
	 Mo+LVsFyUWZHfie10Hv/edB9NJ852ayBo/yyThIp99IoKdpJYGD+1L18BiZGH2VCvj
	 q/wmlvGKwdBRtD0n9dgShNJNXD8f145Qeqi1XBHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 048/163] nfs: dont invalidate dentries on transient errors
Date: Tue, 23 Jul 2024 20:22:57 +0200
Message-ID: <20240723180145.327715795@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 0c8c7c559740d2d8b66048162af6c4dba8f0c88c ]

This is a slight variation on a patch previously proposed by Neil Brown
that never got merged.

Prior to commit 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()"),
any error from nfs_lookup_verify_inode() other than -ESTALE would result
in nfs_lookup_revalidate() returning that error (-ESTALE is mapped to
zero).

Since that commit, all errors result in nfs_lookup_revalidate()
returning zero, resulting in dentries being invalidated where they
previously were not (particularly in the case of -ERESTARTSYS).

Fix it by passing the actual error code to nfs_lookup_revalidate_done(),
and leaving the decision on whether to  map the error code to zero or
one to nfs_lookup_revalidate_done().

A simple reproducer is to run the following python code in a
subdirectory of an NFS mount (not in the root of the NFS mount):

---8<---
import os
import multiprocessing
import time

if __name__=="__main__":
    multiprocessing.set_start_method("spawn")

    count = 0
    while True:
        try:
            os.getcwd()
            pool = multiprocessing.Pool(10)
            pool.close()
            pool.terminate()
            count += 1
        except Exception as e:
            print(f"Failed after {count} iterations")
            print(e)
            break
---8<---

Prior to commit 5ceb9d7fdaaf, the above code would run indefinitely.
After commit 5ceb9d7fdaaf, it fails almost immediately with -ENOENT.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/dir.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bdd6cb33a3708..375c08fdcf2f3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1625,7 +1625,16 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 	switch (error) {
 	case 1:
 		break;
-	case 0:
+	case -ETIMEDOUT:
+		if (inode && (IS_ROOT(dentry) ||
+			      NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL))
+			error = 1;
+		break;
+	case -ESTALE:
+	case -ENOENT:
+		error = 0;
+		fallthrough;
+	default:
 		/*
 		 * We can't d_drop the root of a disconnected tree:
 		 * its d_hash is on the s_anon list and d_drop() would hide
@@ -1680,18 +1689,8 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
 
 	dir_verifier = nfs_save_change_attribute(dir);
 	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
-	if (ret < 0) {
-		switch (ret) {
-		case -ESTALE:
-		case -ENOENT:
-			ret = 0;
-			break;
-		case -ETIMEDOUT:
-			if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
-				ret = 1;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	/* Request help from readdirplus */
 	nfs_lookup_advise_force_readdirplus(dir, flags);
@@ -1735,7 +1734,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 			 unsigned int flags)
 {
 	struct inode *inode;
-	int error;
+	int error = 0;
 
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode = d_inode(dentry);
@@ -1780,7 +1779,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 out_bad:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
+	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
 
 static int
-- 
2.43.0




