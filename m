Return-Path: <stable+bounces-41665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708468B568B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C98A282C67
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAB3FBBD;
	Mon, 29 Apr 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwcHhwji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3E45018
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390090; cv=none; b=QbGH0uM53tKHNtq0CPALUqIRmpMdXi0pK/Qp3lrzmBi2/em+KA1h8rBR26E2NRk+Wes2XMbRfON7J77RCHDzgXjoZOwLkGz4dtlHq2zeL6fvcUP42VP9SdIQVg9nZX92Y6WbUyZjPJKQFakpq/6YiI0tC029kUEBMpksLJekcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390090; c=relaxed/simple;
	bh=sLNjfz4wqws+327ZJgPbIMWRnBKTySJRMMJqSHJHQO4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nmLKOBdd9I6Jfom8YEGF1OYMBN1QGCE6bJmxkQJLssd/02/Mnrj1l6HVr2JRtrcROKgmdDzU5zWCRmNL4hhfvDvJPI/yedxkz7a2eisOfkpqF2s0Jt0KBrVmYPH44SrYGrmfyR4msivvS90HiY6Ea1WlUnszVFtwF/sruJTQu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwcHhwji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BAC113CD;
	Mon, 29 Apr 2024 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390090;
	bh=sLNjfz4wqws+327ZJgPbIMWRnBKTySJRMMJqSHJHQO4=;
	h=Subject:To:Cc:From:Date:From;
	b=JwcHhwjibNQ2ma5WfW6cHnn4oNolWW4kD+YZwINcpF1iih8emY0avj7ctSOIBrVJI
	 Vlm4N06JdszAspWS+SO81mGI2Zc8hili77z7WmDgqHGTG2lfroU3BdkHogrTccWx8p
	 XKSv8g0ySodarXgpdUlsTKt1qqrvfu1GQUqr5280=
Subject: FAILED: patch "[PATCH] btrfs: fix wrong block_start calculation for" failed to apply to 6.1-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:28:07 +0200
Message-ID: <2024042906-stapling-dosage-67ad@gregkh>
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
git cherry-pick -x fe1c6c7acce10baf9521d6dccc17268d91ee2305
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042906-stapling-dosage-67ad@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

fe1c6c7acce1 ("btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()")
92e1229b204d ("btrfs: tests: test invalid splitting when skipping pinned drop extent_map")
f345dbdf2c9c ("btrfs: tests: add a test for btrfs_add_extent_mapping")
89c3760428db ("btrfs: tests: add extent_map tests for dropping with odd layouts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe1c6c7acce10baf9521d6dccc17268d91ee2305 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 9 Apr 2024 20:32:34 +0930
Subject: [PATCH] btrfs: fix wrong block_start calculation for
 btrfs_drop_extent_map_range()

[BUG]
During my extent_map cleanup/refactor, with extra sanity checks,
extent-map-tests::test_case_7() would not pass the checks.

The problem is, after btrfs_drop_extent_map_range(), the resulted
extent_map has a @block_start way too large.
Meanwhile my btrfs_file_extent_item based members are returning a
correct @disk_bytenr/@offset combination.

The extent map layout looks like this:

     0        16K    32K       48K
     | PINNED |      | Regular |

The regular em at [32K, 48K) also has 32K @block_start.

Then drop range [0, 36K), which should shrink the regular one to be
[36K, 48K).
However the @block_start is incorrect, we expect 32K + 4K, but got 52K.

[CAUSE]
Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
that covers the target range but is still beyond it, we need to split
that extent map into half:

	|<-- drop range -->|
		 |<----- existing extent_map --->|

And if the extent map is not compressed, we need to forward
extent_map::block_start by the difference between the end of drop range
and the extent map start.

However in that particular case, the difference is calculated using
(start + len - em->start).

The problem is @start can be modified if the drop range covers any
pinned extent.

This leads to wrong calculation, and would be caught by my later
extent_map sanity checks, which checks the em::block_start against
btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.

This is a regression caused by commit c962098ca4af ("btrfs: fix
incorrect splitting in btrfs_drop_extent_map_range"), which removed the
@len update for pinned extents.

[FIX]
Fix it by avoiding using @start completely, and use @end - em->start
instead, which @end is exclusive bytenr number.

And update the test case to verify the @block_start to prevent such
problem from happening.

Thankfully this is not going to lead to any data corruption, as IO path
does not utilize btrfs_drop_extent_map_range() with @skip_pinned set.

So this fix is only here for the sake of consistency/correctness.

CC: stable@vger.kernel.org # 6.5+
Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 445f7716f1e2..24a048210b15 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -817,7 +817,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->block_len = em->block_len;
 					split->orig_start = em->orig_start;
 				} else {
-					const u64 diff = start + len - em->start;
+					const u64 diff = end - em->start;
 
 					split->block_len = split->len;
 					split->block_start += diff;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 253cce7ffecf..47b5d301038e 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -847,6 +847,11 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (em->block_start != SZ_32K + SZ_4K) {
+		test_err("em->block_start is %llu, expected 36K", em->block_start);
+		goto out;
+	}
+
 	free_extent_map(em);
 
 	read_lock(&em_tree->lock);


