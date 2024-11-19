Return-Path: <stable+bounces-93977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA039D25E8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49C52855E1
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3051CBEB5;
	Tue, 19 Nov 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7D/0sx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5213B780
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019480; cv=none; b=uXQ5xgD6EdB2MA1lVt0EpSQUTj1cVtSLSQWuoTB8pdatLTqznpBjelt6EKLNvCMYvpEdeOSF7zWaT6tI7EgGB4/gXvSYQcjiOJ2mvd/icEJr4heYAb/jiibY/F9X2qo4BzdWRX3heAfUPVvC9tu+qvsOIFfsMoYqcEbR7M1w5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019480; c=relaxed/simple;
	bh=PlYZx/IyVQolJT1Ae0l3rV89t0nSuhEHYfqkRezJXCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWt0g+2ikA0VNmHAzuPZp4S35x03bXI3tfy0aFMLbpqh6DC2z+XeDGHIKRh178EJwDYro9tH7kU75nT6N6HyjtC/ECq6LiWQWCZZPcHmuXPFOlE+cDZq9UJHUOyT0s06GsmpooKOM3ihS55A1DbOQ4IyI4G5nocQK/Sx8hmpJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7D/0sx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85CDC4CECF;
	Tue, 19 Nov 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019480;
	bh=PlYZx/IyVQolJT1Ae0l3rV89t0nSuhEHYfqkRezJXCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7D/0sx80Av5Esr+zvtYZ1zQOA8MKaAfpjHoKPtxevGgYW2ERVGsUBSLYyuhfkSLZ
	 ls28P892x9Wc9b7xOlXyzYBCnwfX6gABMr6Segvb6Ldv81kyiHwDKwHLqU81wGyHsE
	 4rPNh7AFVn2pnVNJEM8Hc2I4Rmbtt+Ajy0tLX7n92t11n+KHfqeeyGqNAVk3JIWkV3
	 eOBRs/iLRCd/6YAmOWgz3oslJbMLr6hBHvkKuClSb4IWLWUmvbMFyR90nVe5uJYe7P
	 ZjC7o4HmidIm4am0lJV42SvOlxhNyXdtvkanciVbLSbTgnIDpVY+UGUaxzmOXABfM8
	 8V36PvMmI6OCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] fs/9p: fix uninitialized values during inode evict
Date: Tue, 19 Nov 2024 07:31:18 -0500
Message-ID: <20241119034317.3364577-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119034317.3364577-2-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 6630036b7c228f57c7893ee0403e92c2db2cd21d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Eric Van Hensbergen <ericvh@kernel.org>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 02:22:27.424212767 -0500
+++ /tmp/tmp.RwSqbmtnlO	2024-11-19 02:22:27.419074107 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 6630036b7c228f57c7893ee0403e92c2db2cd21d ]
+
 If an iget fails due to not being able to retrieve information
 from the server then the inode structure is only partially
 initialized.  When the inode gets evicted, references to
@@ -12,39 +14,48 @@
 
 Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
 Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
+(cherry picked from commit 1b4cb6e91f19b81217ad98142ee53a1ab25893fd)
+[Xiangyu: CVE-2024-36923 Minor conflict resolution due to missing 4eb31178 ]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- fs/9p/vfs_inode.c | 16 ++++++++++------
- 1 file changed, 10 insertions(+), 6 deletions(-)
+ fs/9p/vfs_inode.c | 23 +++++++++++++----------
+ 1 file changed, 13 insertions(+), 10 deletions(-)
 
 diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
-index 360a5304ec03c..b01b1bbf24937 100644
+index 8f287009545c..495631eba3a6 100644
 --- a/fs/9p/vfs_inode.c
 +++ b/fs/9p/vfs_inode.c
-@@ -344,17 +344,21 @@ void v9fs_evict_inode(struct inode *inode)
- 	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
- 	__le32 __maybe_unused version;
+@@ -392,17 +392,20 @@ void v9fs_evict_inode(struct inode *inode)
+ 	struct v9fs_inode *v9inode = V9FS_I(inode);
+ 	__le32 version;
  
 -	truncate_inode_pages_final(&inode->i_data);
+-	version = cpu_to_le32(v9inode->qid.version);
+-	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 +	if (!is_bad_inode(inode)) {
 +		truncate_inode_pages_final(&inode->i_data);
- 
--	version = cpu_to_le32(v9inode->qid.version);
--	netfs_clear_inode_writeback(inode, &version);
 +		version = cpu_to_le32(v9inode->qid.version);
-+		netfs_clear_inode_writeback(inode, &version);
- 
++		fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
+ 				      &version);
 -	clear_inode(inode);
 -	filemap_fdatawrite(&inode->i_data);
+-
+-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+-	/* clunk the fid stashed in writeback_fid */
+-	p9_fid_put(v9inode->writeback_fid);
+-	v9inode->writeback_fid = NULL;
 +		clear_inode(inode);
 +		filemap_fdatawrite(&inode->i_data);
- 
- #ifdef CONFIG_9P_FSCACHE
--	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 +		if (v9fs_inode_cookie(v9inode))
 +			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
- #endif
++		/* clunk the fid stashed in writeback_fid */
++		p9_fid_put(v9inode->writeback_fid);
++		v9inode->writeback_fid = NULL;
 +	} else
 +		clear_inode(inode);
  }
  
- struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
+ static int v9fs_test_inode(struct inode *inode, void *data)
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

