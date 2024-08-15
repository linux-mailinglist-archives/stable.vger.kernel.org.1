Return-Path: <stable+bounces-68572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24844953301
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF74D1F23F87
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888611BB6A9;
	Thu, 15 Aug 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1LczS6dl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7E1BB6A4;
	Thu, 15 Aug 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730991; cv=none; b=UvPGb8/z7N3DSo2Pu+wmX674UNBrnwj7u96J3O+f4KANo/Ke9ag7oBRU8TJrnWSubvYQVXT7GsDfJD6r67ik9MnliuKgra06nNoft07j/XJIHBnLb8niuxBXqfudkobtmyfjjMN590M14bVawkG678WJXG77WnE651aPyFdGwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730991; c=relaxed/simple;
	bh=HPhDvQuuOEc/I0FCZ9igh6o0t3+QgJqASj4uFwa5k4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqpvByMyjp5TfY03XUZjdmUBU92QyHB6ZvFHIpGQa4hlsbARpmB4HhiLHMLEKMbMAoufpQXKRCImoSQ+keCRDGXJ8CuJeGAkVAzGuYdpEm27+F2GsUvbIGS4UK1mV2yoyFPKW4XM52t3CPVxgvyoqS4iXAbajvSHqkTM5DQSwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1LczS6dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF9EC32786;
	Thu, 15 Aug 2024 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730991;
	bh=HPhDvQuuOEc/I0FCZ9igh6o0t3+QgJqASj4uFwa5k4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1LczS6dlfNdW+8Ytgh2ol0xE9K3GXbPtejpYu1BQboybjtX7AH9afbxIzWIRRfqPq
	 ewzXVw30qQPN8AbSgNUfTynchi8usOE3BV6wgUK0SVWKZHvnWK0j+HxBvKD7KTkDrM
	 QzK8Hmin5uAThcmfa9gn2V9c7DZA8ClKpW5Yk29E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 25/67] fs: Convert to bdev_open_by_dev()
Date: Thu, 15 Aug 2024 15:25:39 +0200
Message-ID: <20240815131839.298190611@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit f4a48bc36cdfae7c603e8e3f2a51e2a283f3f365 ]

Convert mount code to use bdev_open_by_dev() and propagate the handle
around to bdev_release().

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230927093442.25915-19-jack@suse.cz
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 6306ff39a7fc ("jfs: fix log->bdev_handle null ptr deref in lbmStartIO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cramfs/inode.c  |  2 +-
 fs/romfs/super.c   |  2 +-
 fs/super.c         | 15 +++++++++------
 include/linux/fs.h |  1 +
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 5ee7d7bbb361c..2fbf97077ce91 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		blkdev_put(sb->s_bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 	kfree(sbi);
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 5c35f6c760377..b1bdfbc211c3c 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -593,7 +593,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		blkdev_put(sb->s_bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index 576abb1ff0403..b142e71eb8dfd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1490,14 +1490,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	if (IS_ERR(bdev_handle)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev);
+		return PTR_ERR(bdev_handle);
 	}
+	bdev = bdev_handle->bdev;
 
 	/*
 	 * This really should be in blkdev_get_by_dev, but right now can't due
@@ -1505,7 +1507,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EACCES;
 	}
 
@@ -1521,10 +1523,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
+	sb->s_bdev_handle = bdev_handle;
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
@@ -1657,7 +1660,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56dce38c47862..5ca9e859c042b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1223,6 +1223,7 @@ struct super_block {
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;
+	struct bdev_handle	*s_bdev_handle;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
-- 
2.43.0




