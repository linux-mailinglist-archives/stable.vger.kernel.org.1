Return-Path: <stable+bounces-159534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABCAF794F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D651894A15
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D69126BFF;
	Thu,  3 Jul 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CZvyhniR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EF2ED168;
	Thu,  3 Jul 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554532; cv=none; b=egAA3Lybr4kP4tEj9imNyA1ylG32XLkFX2NLHvjIr97tMuBubrPjcKe1zVhvQytpLACnK8o4GHeLd5ob2pm3myb2AWP5RGxTLCO57zWdOI0TLz78yBbviDseIVk3A7+zd8ik3fRnHnkayMxF6kqTL4/AC/wH9SyzqleDcH3IeDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554532; c=relaxed/simple;
	bh=uVx3mBtFP5rgR6t+A3y9zQjhRk1ULeogXFsWzRjfgis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlAFQwvBOuDbqDdAQbw+JYF6CHOKCx6A95X0Vhq+s+KIZCx+p1HjSfANHYg1yy09uCYO0gYfS+utc7ru6Mli0QrhlGWXBchNHqVfV3p42dC8ujnUz+taK5Ju62Y/TraxHQxWILKI7fcW+hxe+RTCZ6sWQW1w3ZDTvEfntUDuquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CZvyhniR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C7C4CEE3;
	Thu,  3 Jul 2025 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554532;
	bh=uVx3mBtFP5rgR6t+A3y9zQjhRk1ULeogXFsWzRjfgis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZvyhniRntMmeEwV6QS5YloTS3ABrpXAvpLnAJmFtSOu342wBTKLfA/y95wr6CFC0
	 DbbVpUrg5cqxJVbL79K9DVbQ9/2mAVukc6aX0TQxGuVEz5POOGO68oZq11iRYaALYo
	 wcnpchnMNORcrgeUNmrU0FZeeDh0KtN89pBnXm8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Shapovalov <intelfx@intelfx.name>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 217/218] btrfs: fix use-after-free on inode when scanning root during em shrinking
Date: Thu,  3 Jul 2025 16:42:45 +0200
Message-ID: <20250703144004.887662954@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 59f37036bb7ab3d554c24abc856aabca01126414 ]

At btrfs_scan_root() we are accessing the inode's root (and fs_info) in a
call to btrfs_fs_closing() after we have scheduled the inode for a delayed
iput, and that can result in a use-after-free on the inode in case the
cleaner kthread does the iput before we dereference the inode in the call
to btrfs_fs_closing().

Fix this by using the fs_info stored already in a local variable instead
of doing inode->root->fs_info.

Fixes: 102044384056 ("btrfs: make the extent map shrinker run asynchronously as a work queue job")
CC: stable@vger.kernel.org # 6.13+
Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 93043edc8ff93..36af9aa9aab13 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1250,6 +1250,7 @@ static struct btrfs_inode *find_first_inode_to_shrink(struct btrfs_root *root,
 
 static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx *ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_inode *inode;
 	long nr_dropped = 0;
 	u64 min_ino = ctx->last_ino + 1;
@@ -1264,7 +1265,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		iput(&inode->vfs_inode);
 
 		if (ctx->scanned >= ctx->nr_to_scan ||
-		    btrfs_fs_closing(inode->root->fs_info))
+		    btrfs_fs_closing(fs_info))
 			break;
 
 		cond_resched();
-- 
2.39.5




