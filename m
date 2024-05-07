Return-Path: <stable+bounces-43353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233B8BF1FE
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CDE1C236E9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEF14C594;
	Tue,  7 May 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqQkP0bB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742714C58C;
	Tue,  7 May 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123474; cv=none; b=nufJ9yB7LkPq6PPlCs2q6cZLhdudzEgPhIXsjAH27XR/csX9znsuywK4Ii7JUDFroZ5D8lk5Gf1flS9dTacowTHgvb1NSj4KpQkkaGtLmr6ZQIvJ/XcNUdxirUR8cwtq4t0oEJ7nskYQe+JvHG58LWJYMkTbwSD854rRGiUKeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123474; c=relaxed/simple;
	bh=vSS8ckXDKosjRvmfUEUfLwEc+gkRcWIIO5CcIp/zg/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9sspROHXk9nnGGnklT81H9HLMwvWQcfmHvNJnZsFwbLSO1ASC+HK3W1mZr2U7uwfa69/35s9nzmUSDRkf0WCCEeVpCtzdTbs//ErNyTrLZ2k2WwTXtsLlxKPU9ZQsFcDxtt7vkb2mvhjKbMoLef0GcyCq5rzLS9Nc4bGEARUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQkP0bB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218DEC4AF63;
	Tue,  7 May 2024 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123474;
	bh=vSS8ckXDKosjRvmfUEUfLwEc+gkRcWIIO5CcIp/zg/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqQkP0bBY+tGJ+vKdJPkp5Pjp/37CjTBX6gQnBys91pA5B5yQYHXc2K5Plcp610Xz
	 XuKATXgnNIWpVwZ4azuwyfANM/bZJeRWnxkWjMwBXnc1/Iy+sIUxAO1Q0BMdLYxKKA
	 HTVelDipo76nke+j6rmpVv8QAN/O3vpLk2pbIXcegygidL45Tx/tCwlWWwib10sKQi
	 5cNd9+NiysyI1rrdZk981ODCYoEEFdt9jAU6zySTSAGt/8W5ujBQqfvZjaRL7WqfWe
	 ZiR4dJTBXgBp6b7wmgMtb/UfBGWGG54794OtyBjtaytfXbsnnyIDNlYehwmIsSHxrg
	 8aJdAmKUB+YtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 21/43] erofs: reliably distinguish block based and fscache mode
Date: Tue,  7 May 2024 19:09:42 -0400
Message-ID: <20240507231033.393285-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 ]

When erofs_kill_sb() is called in block dev based mode, s_bdev may not
have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
it will be mistaken for fscache mode, and then attempt to free an anon_dev
that has never been allocated, triggering the following warning:

============================================
ida_free called for id=0 which is not allocated.
WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
Modules linked in:
CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
RIP: 0010:ida_free+0x134/0x140
Call Trace:
 <TASK>
 erofs_kill_sb+0x81/0x90
 deactivate_locked_super+0x35/0x80
 get_tree_bdev+0x136/0x1e0
 vfs_get_tree+0x2c/0xf0
 do_new_mount+0x190/0x2f0
 [...]
============================================

Now when erofs_kill_sb() is called, erofs_sb_info must have been
initialised, so use sbi->fsid to distinguish between the two modes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c9f9a43197db6..6a785b95121f1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -796,17 +796,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-- 
2.43.0


