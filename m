Return-Path: <stable+bounces-169997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B4B29FA9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7B1787B1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBC3101BE;
	Mon, 18 Aug 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLpzVE2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4513101C4
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514416; cv=none; b=o4LLPceriGMgaaC3QpDTbrR+QgcwqZxD68ZWrZdSE1UTlTvUD6TV4Ao4tyDTNHIRKT2shDViHUVbq/Kql4gXvXqtNMrQ1Z3t2exJeEUt9lTSYTK4I1PjWQpT0N4XDGU7KLd+GTk8PI1M9Th93LW6PIwmncKYbqQQby4K5bvPUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514416; c=relaxed/simple;
	bh=ChjNhhdhl4VvpGp0/9SIkxdz6VMW5RIx/j7bHRZ/J2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YCBcNvKWCMQ4mMU1mytlcjkyyWv87A43U4obg7AiATBG0MzLOcGDmYdAgou8q9uH788P0r30+TKq3TZXHqjEJLTrRIcDObivzdcBbOBRNA63RsoQAR+af5kwScG9pH/rTNqPqETi0g/ULiTjgQmRjm1qXBtxrs+8GCZNluTI03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLpzVE2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C061DC4CEED;
	Mon, 18 Aug 2025 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514416;
	bh=ChjNhhdhl4VvpGp0/9SIkxdz6VMW5RIx/j7bHRZ/J2E=;
	h=Subject:To:Cc:From:Date:From;
	b=zLpzVE2mjrpxdCzxmkPx2dCiWLf2pLaeRHBRjgxZCocgvlaEw3DORo6PywlmX9xgA
	 pJ+S4c22wMqj4FR4qfxN15cYuwYoRBxxd7UTc3DdsJ51zV2+UCu5Uo2wqxX3Gix/K8
	 9YFWAUZBkTHtSwAxor+yk+FbJiemfhVEwtD7UzrY=
Subject: FAILED: patch "[PATCH] btrfs: zoned: reserve data_reloc block group on mount" failed to apply to 6.15-stable tree
To: johannes.thumshirn@wdc.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:53:33 +0200
Message-ID: <2025081833-overhaul-cyclist-f958@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 694ce5e143d67267ad26b04463e790a597500b00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081833-overhaul-cyclist-f958@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 694ce5e143d67267ad26b04463e790a597500b00 Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 3 Jun 2025 08:14:01 +0200
Subject: [PATCH] btrfs: zoned: reserve data_reloc block group on mount

Create a block group dedicated for data relocation on mount of a zoned
filesystem.

If there is already more than one empty DATA block group on mount, this
one is picked for the data relocation block group, instead of a newly
created one.

This is done to ensure, there is always space for performing garbage
collection and the filesystem is not hitting ENOSPC under heavy overwrite
workloads.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0d6ad7512f21..4cfcd879dc5e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3561,6 +3561,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	btrfs_zoned_reserve_data_reloc_bg(fs_info);
 	btrfs_free_zone_cache(fs_info);
 
 	btrfs_check_active_zone_reservation(fs_info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 805f2eca20e9..4ab7808bca62 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2501,6 +2502,66 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->relocation_bg_lock);
 }
 
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_space_info *space_info = data_sinfo->sub_group[0];
+	struct btrfs_trans_handle *trans;
+	struct btrfs_block_group *bg;
+	struct list_head *bg_list;
+	u64 alloc_flags;
+	bool initial = false;
+	bool did_chunk_alloc = false;
+	int index;
+	int ret;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	if (fs_info->data_reloc_bg)
+		return;
+
+	if (sb_rdonly(fs_info->sb))
+		return;
+
+	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
+	index = btrfs_bg_flags_to_raid_index(alloc_flags);
+
+	bg_list = &data_sinfo->block_groups[index];
+again:
+	list_for_each_entry(bg, bg_list, list) {
+		if (bg->used > 0)
+			continue;
+
+		if (!initial) {
+			initial = true;
+			continue;
+		}
+
+		fs_info->data_reloc_bg = bg->start;
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
+		btrfs_zone_activate(bg);
+
+		return;
+	}
+
+	if (did_chunk_alloc)
+		return;
+
+	trans = btrfs_join_transaction(fs_info->tree_root);
+	if (IS_ERR(trans))
+		return;
+
+	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
+	btrfs_end_transaction(trans);
+	if (ret == 1) {
+		did_chunk_alloc = true;
+		bg_list = &space_info->block_groups[index];
+		goto again;
+	}
+}
+
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9672bf4c3335..6e11533b8e14 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -88,6 +88,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
@@ -241,6 +242,8 @@ static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
+static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info) { }
+
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
 
 static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)


