Return-Path: <stable+bounces-83796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BB99C989
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A02E1F254DB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77819E99B;
	Mon, 14 Oct 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTP5ii7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898019E98B
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906928; cv=none; b=Z9u3nSL558i5y6kWftFS92bMPm5hwYtlVk45dlbblIkajBPqD32hczAe8WPLgloU2ZjaerQiw7yhQqOvmW9z2W/BENCdkDQ4gRxkGVgSnm9KXasPq8ltXqt4TiFiG4nwahA132uafGG2n0bMgiBWT2GVFny+tT2e5aPuztdde5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906928; c=relaxed/simple;
	bh=BhhYqzoiABVcZD8k3nFZczq35Me6s0Lu8TWK+7uFj+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aRHQ/0wRDrMCRKt9NAZSwIWhM5N8hl2CGOom+8SjwNZuI3oZCHTrN6xFQJ6Hk9Ou2VsBqfxFiKhKbI8WBa4yGeliwhEphdJAPOIWBRif8fLoFfEIqNbPt+qIe87gFWoNDgk1iya7TuxmtIzQ9Hp9+0oCHUmfSPJBJKzXHoWDGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTP5ii7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB25C4CEC3;
	Mon, 14 Oct 2024 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906927;
	bh=BhhYqzoiABVcZD8k3nFZczq35Me6s0Lu8TWK+7uFj+M=;
	h=Subject:To:Cc:From:Date:From;
	b=RTP5ii7Re3bQLYwQzu6HIkll0cCYZW+hH1MvY1Nzsfkim5KvK0CZPslwkW4xbyoRg
	 uljIwcW+ydWnkal55o9m3ADRdYnT3xxS6MN/aeO2zyI2IL7oR0gK+BE0Z48HOK3RSL
	 S5+72CK+8i4qbuQLbrnFeLE+2f3HXhXoy5wJTWKg=
Subject: FAILED: patch "[PATCH] btrfs: add cancellation points to trim loops" failed to apply to 6.1-stable tree
To: luca.stefani.ge1@gmail.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:55:13 +0200
Message-ID: <2024101412-backfire-pacific-1f0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 69313850dce33ce8c24b38576a279421f4c60996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101412-backfire-pacific-1f0b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

69313850dce3 ("btrfs: add cancellation points to trim loops")
a99fcb015897 ("btrfs: split remaining space to discard in chunks")
602035d7fecf ("btrfs: add forward declarations and headers, part 2")
22b46bdc5f11 ("btrfs: add forward declarations and headers, part 1")
2b712e3bb2c4 ("btrfs: remove unused included headers")
f86f7a75e2fb ("btrfs: use the flags of an extent map to identify the compression type")
1a9fb16c6052 ("btrfs: avoid useless rbtree iterations when attempting to merge extent map")
ad21f15b0f79 ("btrfs: switch to the new mount API")
f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
0f85e244dfc5 ("btrfs: add fs context handling functions")
17b3612022fe ("btrfs: add parse_param callback for the new mount API")
15ddcdd34ebf ("btrfs: add fs_parameter definitions")
a6a8f22a4af6 ("btrfs: move space cache settings into open_ctree")
2b41b19dd6d0 ("btrfs: split out the mount option validation code into its own helper")
3c0e918b8fb3 ("btrfs: remove no longer used EXTENT_MAP_DELALLOC block start value")
7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
2ecec0d6a5b5 ("btrfs: unexport extent_map_block_end()")
3128b548c759 ("btrfs: split assert into two different asserts when removing block group")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69313850dce33ce8c24b38576a279421f4c60996 Mon Sep 17 00:00:00 2001
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Tue, 17 Sep 2024 22:33:05 +0200
Subject: [PATCH] btrfs: add cancellation points to trim loops

There are reports that system cannot suspend due to running trim because
the task responsible for trimming the device isn't able to finish in
time, especially since we have a free extent discarding phase, which can
trim a lot of unallocated space. There are no limits on the trim size
(unlike the block group part).

Since trime isn't a critical call it can be interrupted at any time,
in such cases we stop the trim, report the amount of discarded bytes and
return an error.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ad70548d1f72..d9f511babd89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1316,6 +1316,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		start += bytes_to_discard;
 		bytes_left -= bytes_to_discard;
 		*discarded_bytes += bytes_to_discard;
+
+		if (btrfs_trim_interrupted()) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 	}
 
 	return ret;
@@ -6470,7 +6475,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index eaa1dbd31352..f4bcb2530660 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3809,7 +3809,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed)
 			break;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -4000,7 +4000,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 83774bfd7b3b..9f1dbfdee8ca 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 #include "fs.h"
 
 struct inode;
@@ -56,6 +57,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
 }
 
+static inline bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 /*
  * Deltas are an effective way to populate global statistics.  Give macro names
  * to make it clear what we're doing.  An example is discard_extents in


