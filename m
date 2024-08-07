Return-Path: <stable+bounces-65534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B594A948
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BEC1F2A07D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC82AF10;
	Wed,  7 Aug 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z9OOhEox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047721373
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039375; cv=none; b=EFPV6QxhN9jbhNAxYGPgRnBQHmZiXtU5GBmutpbBBBKqiLvgI8/KTqjqrlQn45GIAGP7i4fialEyNeGYzHCuCXDRSBG3QpXgVyLd2pQVrsbsFEcn73O1g+FwQ5+/+zR5t8qnmbe5CC2w8aSJK+nuvIbtFeIgHHoQOurmo8bFgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039375; c=relaxed/simple;
	bh=WKvYWbQKxa76oXrNkitkADuHz0uKRHJ8vLplt9U3fjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KQRnHHPFeIgjrFWqSOendjEtr3w156d57o/3OBm7KPLaVQqFqi4oLIWyOju2KK0vIezTgHYFdnbYgKUUuAajUrsOgFcI/wf6XpYcrkaK2YUGvRJ/Icu5SHLgKxmdsQyJyp9k6oVs9HAuLt5HQzk9p9AYzJDUywd41KMo3FqJ0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z9OOhEox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C94C32781;
	Wed,  7 Aug 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039375;
	bh=WKvYWbQKxa76oXrNkitkADuHz0uKRHJ8vLplt9U3fjw=;
	h=Subject:To:Cc:From:Date:From;
	b=z9OOhEoxPjV1NZ/TXJPgZ4ik9Rea5BLD8xVvd2iCIKd1WK7ZF5A0qf0jB0JiYs4Vx
	 WjJQxj4umndkScweZzJ3C6ebnWprdK95/gLI8NhqqO0/eHYhsaeiBU23x1kXfFrtKk
	 SLEmupmrO82lqqBxfokJSGdS80R1kaR+uYyJkaTk=
Subject: FAILED: patch "[PATCH] btrfs: zoned: fix zone_unusable accounting on making block" failed to apply to 5.15-stable tree
To: naohiro.aota@wdc.com,dsterba@suse.com,johannes.thumshirn@wdc.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:02:51 +0200
Message-ID: <2024080751-importer-postbox-eb90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8cd44dd1d17a23d5cc8c443c659ca57aa76e2fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080751-importer-postbox-eb90@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8cd44dd1d17a ("btrfs: zoned: fix zone_unusable accounting on making block group read-write again")
9d4b0a129a0d ("btrfs: simplify arguments of btrfs_update_space_info and rename")
6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
f6fca3917b4d ("btrfs: store chunk size in space-info struct")
b8bea09a456f ("btrfs: add trace event for submitted RAID56 bio")
c67c68eb57f1 ("btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and finish_pbitmap")
143823cf4d5a ("btrfs: fix typos in comments")
385de0ef387d ("btrfs: use a normal workqueue for rmw_workers")
a7b8e39c922b ("btrfs: raid56: enable subpage support for RAID56")
3907ce293d68 ("btrfs: raid56: make alloc_rbio_essential_pages() subpage compatible")
ac26df8b3b02 ("btrfs: raid56: remove btrfs_raid_bio::bio_pages array")
07e4d3808047 ("btrfs: raid56: make __raid_recover_endio_io() subpage compatible")
46900662d02f ("btrfs: raid56: make finish_parity_scrub() subpage compatible")
3e77605d6a81 ("btrfs: raid56: make rbio_add_io_page() subpage compatible")
00425dd976d3 ("btrfs: raid56: introduce btrfs_raid_bio::bio_sectors")
eb3570607c8c ("btrfs: raid56: introduce btrfs_raid_bio::stripe_sectors")
94efbe19b9f1 ("btrfs: raid56: introduce new cached members for btrfs_raid_bio")
29b068382c6f ("btrfs: raid56: make btrfs_raid_bio more compact")
843de58b3e31 ("btrfs: raid56: open code rbio_nr_pages()")
cc353a8be2fd ("btrfs: reduce width for stripe_len from u64 to u32")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cd44dd1d17a23d5cc8c443c659ca57aa76e2fa5 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Wed, 15 Feb 2023 09:18:02 +0900
Subject: [PATCH] btrfs: zoned: fix zone_unusable accounting on making block
 group read-write again

When btrfs makes a block group read-only, it adds all free regions in the
block group to space_info->bytes_readonly. That free space excludes
reserved and pinned regions. OTOH, when btrfs makes the block group
read-write again, it moves all the unused regions into the block group's
zone_unusable. That unused region includes reserved and pinned regions.
As a result, it counts too much zone_unusable bytes.

Fortunately (or unfortunately), having erroneous zone_unusable does not
affect the calculation of space_info->bytes_readonly, because free
space (num_bytes in btrfs_dec_block_group_ro) calculation is done based on
the erroneous zone_unusable and it reduces the num_bytes just to cancel the
error.

This behavior can be easily discovered by adding a WARN_ON to check e.g,
"bg->pinned > 0" in btrfs_dec_block_group_ro(), and running fstests test
case like btrfs/282.

Fix it by properly considering pinned and reserved in
btrfs_dec_block_group_ro(). Also, add a WARN_ON and introduce
btrfs_space_info_update_bytes_zone_unusable() to catch a similar mistake.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 498442d0c216..2e49d978f504 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1223,8 +1223,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	block_group->space_info->total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
-	block_group->space_info->bytes_zone_unusable -=
-		block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(fs_info, block_group->space_info,
+						    -block_group->zone_unusable);
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1396,7 +1396,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes to readonly */
 			sinfo->bytes_readonly += cache->zone_unusable;
-			sinfo->bytes_zone_unusable -= cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    -cache->zone_unusable);
 			cache->zone_unusable = 0;
 		}
 		cache->ro++;
@@ -3056,9 +3057,11 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes back */
 			cache->zone_unusable =
-				(cache->alloc_offset - cache->used) +
+				(cache->alloc_offset - cache->used - cache->pinned -
+				 cache->reserved) +
 				(cache->length - cache->zone_capacity);
-			sinfo->bytes_zone_unusable += cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    cache->zone_unusable);
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
 		num_bytes = cache->length - cache->reserved -
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d77498e7671c..ff9f0d41987e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2793,7 +2793,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			readonly = true;
 		} else if (btrfs_is_zoned(fs_info)) {
 			/* Need reset before reusing in a zoned block group */
-			space_info->bytes_zone_unusable += len;
+			btrfs_space_info_update_bytes_zone_unusable(fs_info, space_info,
+								    len);
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3f9b7507543a..f5996a43db24 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2723,8 +2723,10 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
 	 */
-	if (!block_group->ro)
+	if (!block_group->ro) {
 		block_group->zone_unusable += to_unusable;
+		WARN_ON(block_group->zone_unusable > block_group->length);
+	}
 	spin_unlock(&ctl->tree_lock);
 	if (!used) {
 		spin_lock(&block_group->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c1d9d3664400..68e14fd48638 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -316,7 +316,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
 	found->bytes_readonly += block_group->bytes_super;
-	found->bytes_zone_unusable += block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(info, found, block_group->zone_unusable);
 	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 4db8a0267c16..88b44221ce97 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -249,6 +249,7 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
+DECLARE_SPACE_INFO_UPDATE(bytes_zone_unusable, "zone_unusable");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index eeb56975bee7..de55a555d95b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2383,6 +2383,14 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+DEFINE_EVENT(btrfs__space_info_update, update_bytes_zone_unusable,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff)
+);
+
 DECLARE_EVENT_CLASS(btrfs_raid56_bio,
 
 	TP_PROTO(const struct btrfs_raid_bio *rbio,


