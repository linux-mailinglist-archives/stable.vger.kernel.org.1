Return-Path: <stable+bounces-43305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724C8BF18F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E4F1F21B5A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E013EFE0;
	Tue,  7 May 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbIzx5eJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95113E8B8;
	Tue,  7 May 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123331; cv=none; b=lXAwEtGSBCLkGzq0F/ndt6KunJCXLJW+mDJHieLO6YJJ5GovhCjiAzVz87zmuezI23h91I1jAYiGBLrmSE7hkzXC219I3yKTeC7pJnkQIZAJPzCl5rh6Jx98SZT980LiNarIzFJz7xE6DTedHHlAi1J1d4VpogqN9S4is4PLjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123331; c=relaxed/simple;
	bh=yqfzzvv4Vb9iFfLKiQtmvaF2w1b07asZiGiRgAATLho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji8d2Gw2oCjdfuL2qMChINza7PHSpwQ1RjnBHFUU9LKzUk4PW0In0rYqcDcyLFOntT8algfhaVkeIKK1N/yfM7Ova5/6WFJgBmrFIBjtaQWzg3TMUzVFZatm8MTgfoNemIK6ijJFxceuIu1T4LuXyDoPYsjya2bZCktKK73BaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbIzx5eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19EEC2BBFC;
	Tue,  7 May 2024 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123330;
	bh=yqfzzvv4Vb9iFfLKiQtmvaF2w1b07asZiGiRgAATLho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbIzx5eJKTFtd8mz8HF0R4R/P6SAOmLhIHt4kKOWURjuYoby+AnzZ8LRuBKzIY1wb
	 Tk0Zs6dtIyXxYAGdFuWs5hoGGpzthL4lKN4Ft8sIvZEEda96aK+gdOHYuXkElXlJsq
	 4BFKfolgOVLVcQNH106WiswGC4138586ZMJuYLfUrc+Dy0rU+PNzoMrTYRyil3QL4a
	 Wb5QtgQ7++6QvgwKrrZMPKqj4MyPBaxuGnbQI3BLF+JN89lVEZ97TO0Vqm+rF2NrUV
	 9aPqUAxnwuxdgVTzqFGAW/yjDg9Q4gxK/Jl1ed3DuHHY0YBSiWXsKcCYNQVF5yX9R6
	 jq1xLURwTtpcQ==
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
Subject: [PATCH AUTOSEL 6.8 26/52] erofs: reliably distinguish block based and fscache mode
Date: Tue,  7 May 2024 19:06:52 -0400
Message-ID: <20240507230800.392128-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 24788c230b494..020495168b124 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -800,17 +800,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
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


