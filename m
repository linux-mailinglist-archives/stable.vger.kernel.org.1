Return-Path: <stable+bounces-93758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DE9D07F4
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 03:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F00281E7A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA264437A;
	Mon, 18 Nov 2024 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbQiE8ln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4C43ABD
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898130; cv=none; b=inXPxBWPo7LHPpruY4/DZkF0dOz5j1sGqOW7OoNvxHG9aRsjdbShHkPETxCn+VHZl14/JPqCpa467BJiGi4HsHBT1rLuhFDATPWE16c+vX3egG9K1R5wuMtfPBS47j3zVJUtP9HnyfWIpzQWWDxjk0KQIrv5JoQgqR8BRNJlyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898130; c=relaxed/simple;
	bh=vfdLAguinJtQe1lTsV3ThzsSkjg83XwaaDaI2xsXTEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ11J3KHQAaOaDAud5XNsCxExGGovEYlF9D03r7pzb5MhBedQz+nzs6wA14Y4R7+B7XulMN4KXxbUATtgEr2o6sAovOUTv7UlHIisS1yaRwmgPzQlxg6HSQ+sTvrehKemWxdwXcPSquhIoZUsEdTVnh9RR8U54Ruqy2AfN1sLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbQiE8ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACACFC4CECD;
	Mon, 18 Nov 2024 02:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731898130;
	bh=vfdLAguinJtQe1lTsV3ThzsSkjg83XwaaDaI2xsXTEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbQiE8lnwYDNLImBBX9F2GhCBGSgb4cM0paZVc/wfxDVd6k2/TkVVhqfbVZNzwbTG
	 IpqBZZ56GEAE01Ql5fcqY6GjCuQuzopvgeTSVKFOIZC82vVq7vvVu/VSe4aWb5ZnOQ
	 /30yTlTffchvu9w6xb1Q/6bNb6EvqZeqPGXU1duwdkt8VBCdi4pc0+J8C6fgrEKgdP
	 k+irEYfsQYtcxAdPiYM/6NIRbHI0ibRl2x4KoR6eouKKmyxRJp/f/4n4n2yEQ0MNdH
	 1kDUsU3VeWNw6iJqLRAywp/2O2V3AFiAqEzAtWLJGld+0vmqfhos3MqaT+FFx7r6bz
	 +0+CpLAX7zTcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] fs/ntfs3: Additional check in ntfs_file_release
Date: Sun, 17 Nov 2024 21:48:40 -0500
Message-ID: <20241118022650.558385-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118022650.558385-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 031d6f608290c847ba6378322d0986d08d1a645a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Note: The patch differs from the upstream commit:
---
--- -	2024-11-17 21:38:25.916310313 -0500
+++ /tmp/tmp.zOVCh2qWVm	2024-11-17 21:38:25.910015113 -0500
@@ -1,18 +1,24 @@
+[ Upstream commit 031d6f608290c847ba6378322d0986d08d1a645a ]
+
 Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
 Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- fs/ntfs3/file.c | 9 ++++++++-
- 1 file changed, 8 insertions(+), 1 deletion(-)
+ fs/ntfs3/file.c | 12 ++++++++++--
+ 1 file changed, 10 insertions(+), 2 deletions(-)
 
 diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
-index 4fdcb5177ea17..eb935d4180c0a 100644
+index aedd4f5f459e..70b38465aee3 100644
 --- a/fs/ntfs3/file.c
 +++ b/fs/ntfs3/file.c
-@@ -1314,7 +1314,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
+@@ -1214,8 +1214,16 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
+ 	int err = 0;
+ 
  	/* If we are last writer on the inode, drop the block reservation. */
- 	if (sbi->options->prealloc &&
- 	    ((file->f_mode & FMODE_WRITE) &&
--	     atomic_read(&inode->i_writecount) == 1)) {
+-	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
+-				      atomic_read(&inode->i_writecount) == 1)) {
++	if (sbi->options->prealloc &&
++	    ((file->f_mode & FMODE_WRITE) &&
 +	     atomic_read(&inode->i_writecount) == 1)
 +	   /*
 +	    * The only file when inode->i_fop = &ntfs_file_operations and
@@ -24,3 +30,6 @@
  		ni_lock(ni);
  		down_write(&ni->file.run_lock);
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

