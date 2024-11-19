Return-Path: <stable+bounces-93971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC259D25E2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E84A1F2473C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999F146D6A;
	Tue, 19 Nov 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqnndPy9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74641C2454
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019468; cv=none; b=SP5vs1s9JItVBY4LIxU/FryVJa3+S7kpZWCbfUGjyf731Az5moL+OFN3KSSGovvK8D1t+YjkHxgFfVHni4XBL4THIksC+EcRwC/jX+dxU1dyqp02RqeFaGPG1tz7fo4a0FvDbXyS4wCPUQ7j9rAtziJXCFrcROFFg4OJNRGyqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019468; c=relaxed/simple;
	bh=CWWDz5cAGY9GKg6Fc+Ep1jZ0128lLsjjN/IP61K/rA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Otq7/8KlzmEsRcYvZDcQW2TercSU/iskjzB0NzVSGJyGe17BIPF0jBVw7obfB1s8tf1wxrIz2iLFRYbVfqa0I4moTQ4BAyPZ2tNNtIF80HCg8pseYwSlSkTmQaEtk3mm1rk/EQCCSibHPUdJdIt0vqhwh+R4X6SPPUEDyDI/JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqnndPy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D5C4CECF;
	Tue, 19 Nov 2024 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019468;
	bh=CWWDz5cAGY9GKg6Fc+Ep1jZ0128lLsjjN/IP61K/rA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqnndPy9kthtoG4QAO9KesMtzLcV6ZI8ADGlClRxMiLGt9nZtc2s6zGVtW/phb52c
	 Eoe2KkhFYnl+ibLKuFCG/FiZiPWvL85Hsx314oF+Avzg5ommJbXIqZAhg+bXXQ6gas
	 2N803YtLXPPn92mK4MFkq2ymqetkA+gIdall5On7LfilHOhdpp1R9wOI+sdkQSbtiI
	 wIs8eSiMGGM3Xi5y+eQr9GQEbG7zFc7VkShD3bqFl9ZqmQ+s0Q+12f7LThi76bwbhO
	 VcE3bfM0e+L6ltse6hNEDLWirYCqeMg8wBoNSi+hA8islTDEsvweT+qVK7IP8qtf0Q
	 FLpKm5kurIcHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] fs/9p: fix uninitialized values during inode evict
Date: Tue, 19 Nov 2024 07:31:06 -0500
Message-ID: <20241119034317.3364577-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119034317.3364577-3-xiangyu.chen@eng.windriver.com>
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
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 07:08:06.191919182 -0500
+++ /tmp/tmp.4FOsp7mTRC	2024-11-19 07:08:06.186662472 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 6630036b7c228f57c7893ee0403e92c2db2cd21d ]
+
 If an iget fails due to not being able to retrieve information
 from the server then the inode structure is only partially
 initialized.  When the inode gets evicted, references to
@@ -12,15 +14,18 @@
 
 Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
 Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: CVE-2024-36923 Minor conflict resolution ]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- fs/9p/vfs_inode.c | 16 ++++++++++------
- 1 file changed, 10 insertions(+), 6 deletions(-)
+ fs/9p/vfs_inode.c | 17 ++++++++++-------
+ 1 file changed, 10 insertions(+), 7 deletions(-)
 
 diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
-index 360a5304ec03c..b01b1bbf24937 100644
+index 853c63b83681..aba0625de48a 100644
 --- a/fs/9p/vfs_inode.c
 +++ b/fs/9p/vfs_inode.c
-@@ -344,17 +344,21 @@ void v9fs_evict_inode(struct inode *inode)
+@@ -374,20 +374,23 @@ void v9fs_evict_inode(struct inode *inode)
  	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
  	__le32 __maybe_unused version;
  
@@ -28,11 +33,14 @@
 +	if (!is_bad_inode(inode)) {
 +		truncate_inode_pages_final(&inode->i_data);
  
+ #ifdef CONFIG_9P_FSCACHE
 -	version = cpu_to_le32(v9inode->qid.version);
--	netfs_clear_inode_writeback(inode, &version);
+-	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 +		version = cpu_to_le32(v9inode->qid.version);
-+		netfs_clear_inode_writeback(inode, &version);
- 
++		fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
+ 				      &version);
+ #endif
+-
 -	clear_inode(inode);
 -	filemap_fdatawrite(&inode->i_data);
 +		clear_inode(inode);
@@ -47,4 +55,7 @@
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
| stable/linux-6.6.y        |  Failed (series apply)  |  N/A       |

