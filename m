Return-Path: <stable+bounces-156038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C17AE44FF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F5B445E32
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54A2505CB;
	Mon, 23 Jun 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5yrrlD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FD248895;
	Mon, 23 Jun 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685984; cv=none; b=i2BXUj0WU4NnQz84owfq08JxYG12+56WWvtvLUKnRoclTMlw+sUgMu9mq/hOctEa2kBVOLMjy9wTDlJaGuthERzN+WvVsZK+x0oUpmSdizijJsmZfyTW/3cUR5mMy1XpkYhbqDcUkBFpvpO4CVErDXLpMLcosvlOxLGIJ+stEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685984; c=relaxed/simple;
	bh=DGne7BRTw2kthKVJJEDAqkwG1OsCjHeuNDGbRKjGu/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fih8No1Gy6nf9zubjj2AXBl9VUInu63+UHhvfqM9ZeTGy4WCbMPDMMFmsqFXfA9MBV+s2A8UM61/kTmRQICA6bI0i7KKbTBjodc15s/1+wyVNOYuRIGtUvgVpFgtHniJQwRpuujarEJLG2h4Kf5R9JIFBt0/PlRJzmnGYEGJ/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5yrrlD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3EFC4CEEA;
	Mon, 23 Jun 2025 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685984;
	bh=DGne7BRTw2kthKVJJEDAqkwG1OsCjHeuNDGbRKjGu/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5yrrlD1WyLQwvMZS7Vd6DkaEqZVlYPHzY0YHDGCHaPASZZJudvIJunhkMBX5Lt3k
	 Sh6EA6Lpi1utm1iBoELt4WhVYeWpVuZdAF1DisryLJu0V7eqVTixzTJtvkir0Gn5Dx
	 tlKMcnmTQ+bncYc6J7hZ63nuB5VExVIoSeON6rsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 073/411] f2fs: use d_inode(dentry) cleanup dentry->d_inode
Date: Mon, 23 Jun 2025 15:03:37 +0200
Message-ID: <20250623130635.198531301@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit a6c397a31f58a1d577c2c8d04b624e9baa31951c ]

no logic changes.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/namei.c | 8 ++++----
 fs/f2fs/super.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b70ac99267728..364731547f696 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -406,7 +406,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (is_inode_flag_set(dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(inode)->i_projid)))
 		return -EXDEV;
 
 	err = f2fs_dquot_initialize(dir);
@@ -885,7 +885,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(new_dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)))
+			F2FS_I(old_inode)->i_projid)))
 		return -EXDEV;
 
 	/*
@@ -1075,10 +1075,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(new_dir)->i_projid,
-			F2FS_I(old_dentry->d_inode)->i_projid)) ||
+			F2FS_I(old_inode)->i_projid)) ||
 	    (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(old_dir)->i_projid,
-			F2FS_I(new_dentry->d_inode)->i_projid)))
+			F2FS_I(new_inode)->i_projid)))
 		return -EXDEV;
 
 	err = f2fs_dquot_initialize(old_dir);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0cf564ded140a..8d06b8b99d939 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1811,9 +1811,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_fsid    = u64_to_fsid(id);
 
 #ifdef CONFIG_QUOTA
-	if (is_inode_flag_set(dentry->d_inode, FI_PROJ_INHERIT) &&
+	if (is_inode_flag_set(d_inode(dentry), FI_PROJ_INHERIT) &&
 			sb_has_quota_limits_enabled(sb, PRJQUOTA)) {
-		f2fs_statfs_project(sb, F2FS_I(dentry->d_inode)->i_projid, buf);
+		f2fs_statfs_project(sb, F2FS_I(d_inode(dentry))->i_projid, buf);
 	}
 #endif
 	return 0;
-- 
2.39.5




