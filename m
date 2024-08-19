Return-Path: <stable+bounces-69538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE29567AB
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8829A1C21969
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEB13B592;
	Mon, 19 Aug 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkK9USq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0226157E93
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061354; cv=none; b=IhMBfU2AM2JKdKXBzaNndJmw6oUoqZQBDb2Vz+rUW9FTPsbhNZ+b3aKreeNmRIfdbWJiXQd9Bq4ibPqzyxb9rvGdZyhIKWS+vt3CBCHHskxRQDGO8bY2TEOZcd89tnLdD1eriu6gJ9toZGdnAtAi+QvAp05l01JeJ4qBLNtb9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061354; c=relaxed/simple;
	bh=k5M4C2met7hGOvyxiuPz6INhkUDLQ5pnEPreB6RKPdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C7RXh5y/vlFxOeS68qGM0igQg9w1YeaM8o1fFcz/RR7/83gU7Lm6r1aDn1BWvNui55zUnLnOspuHL7W/v0x5QDrYNqIHk934MaD66pv6s3/yG1bPd8MRmkNkfttUbaqwv4dvIdrLUOn8X2ichOJl7LIyX0kj3Quets1UGO2JYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nkK9USq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3250AC4AF0E;
	Mon, 19 Aug 2024 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061354;
	bh=k5M4C2met7hGOvyxiuPz6INhkUDLQ5pnEPreB6RKPdI=;
	h=Subject:To:Cc:From:Date:From;
	b=nkK9USq0iBAltJyQWAZFVzLHitfk+V8Bs8dIhpdwYRrQzv/3HUSL1/UgENJj7GRm9
	 ybcLyiXgnlOOGHH3i9nh3j9DGfwYuOOIwaRGmRoAMjdJ2KP4lHnmbLRmYuLaAJqaJj
	 LWotuCY73oKPxfDQi7H9JMxZWiGXzSFmTRAoHE7I=
Subject: FAILED: patch "[PATCH] btrfs: zoned: properly take lock to read/update block group's" failed to apply to 5.15-stable tree
To: naohiro.aota@wdc.com,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:55:51 +0200
Message-ID: <2024081951-enrich-hesitate-0db0@gregkh>
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
git cherry-pick -x e30729d4bd4001881be4d1ad4332a5d4985398f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081951-enrich-hesitate-0db0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e30729d4bd40 ("btrfs: zoned: properly take lock to read/update block group's zoned variables")
8cd44dd1d17a ("btrfs: zoned: fix zone_unusable accounting on making block group read-write again")
b9fd2affe4aa ("btrfs: zoned: fix initial free space detection")
6a8ebc773ef6 ("btrfs: zoned: no longer count fresh BG region as zone unusable")
fa2068d7e922 ("btrfs: zoned: count fresh BG region as zone unusable")
3349b57fd47b ("btrfs: convert block group bit field to use bit helpers")
9d4b0a129a0d ("btrfs: simplify arguments of btrfs_update_space_info and rename")
6ca64ac27631 ("btrfs: zoned: fix mounting with conventional zones")
ced8ecf026fd ("btrfs: fix space cache corruption and potential double allocations")
b09315139136 ("btrfs: zoned: activate metadata block group on flush_space")
6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
393f646e34c1 ("btrfs: zoned: finish least available block group on data bg allocation")
bb9950d3df71 ("btrfs: let can_allocate_chunk return error")
f6fca3917b4d ("btrfs: store chunk size in space-info struct")
b8bea09a456f ("btrfs: add trace event for submitted RAID56 bio")
c67c68eb57f1 ("btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and finish_pbitmap")
143823cf4d5a ("btrfs: fix typos in comments")
b3a3b0255797 ("btrfs: zoned: drop optimization of zone finish")
343d8a30851c ("btrfs: zoned: prevent allocation from previous data relocation BG")
d70cbdda75da ("btrfs: zoned: consolidate zone finish functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e30729d4bd4001881be4d1ad4332a5d4985398f8 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Thu, 1 Aug 2024 16:47:52 +0900
Subject: [PATCH] btrfs: zoned: properly take lock to read/update block group's
 zoned variables

__btrfs_add_free_space_zoned() references and modifies bg's alloc_offset,
ro, and zone_unusable, but without taking the lock. It is mostly safe
because they monotonically increase (at least for now) and this function is
mostly called by a transaction commit, which is serialized by itself.

Still, taking the lock is a safer and correct option and I'm going to add a
change to reset zone_unusable while a block group is still alive. So, add
locking around the operations.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f5996a43db24..eaa1dbd31352 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	bool initial;
 	u64 reclaimable_unusable;
 
-	WARN_ON(!initial && offset + size > block_group->zone_capacity);
+	spin_lock(&block_group->lock);
 
+	initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 	if (!initial)
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
-	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
 	else if (initial)
@@ -2718,7 +2719,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		to_free = offset + size - block_group->alloc_offset;
 	to_unusable = size - to_free;
 
+	spin_lock(&ctl->tree_lock);
 	ctl->free_space += to_free;
+	spin_unlock(&ctl->tree_lock);
 	/*
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
@@ -2727,11 +2730,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		block_group->zone_unusable += to_unusable;
 		WARN_ON(block_group->zone_unusable > block_group->length);
 	}
-	spin_unlock(&ctl->tree_lock);
 	if (!used) {
-		spin_lock(&block_group->lock);
 		block_group->alloc_offset -= size;
-		spin_unlock(&block_group->lock);
 	}
 
 	reclaimable_unusable = block_group->zone_unusable -
@@ -2745,6 +2745,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
+	spin_unlock(&block_group->lock);
+
 	return 0;
 }
 


