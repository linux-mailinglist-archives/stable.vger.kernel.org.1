Return-Path: <stable+bounces-154916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB5AE1338
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1617B1897625
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE11F09BF;
	Fri, 20 Jun 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OFx3iRa5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDF1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398235; cv=none; b=Ryzl9LakkXH+8F54tk0FwVjfIUAc2QRTc7PIOcCyHT3y/3ad9KqTmGU8sqW1XavurGRPXpNZn3KPe33aA35GFxyXkdT4rbQYMxs2t5rNZkr3tJjGUgM0dzQp8PyH/frv7u5ILIMMwEvUHMRu9s5mV1ZslCs10TSfWGiUrUf9feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398235; c=relaxed/simple;
	bh=u+mAV2e4TZ9YfVRlOGboPRc3yvRqHQyzUe0q4tBSw2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wr1AolVabA411EdgwTt2ZUOuxj9pUwjh2kko+rWr3Gm3C46zU4+UJV2IihagTP/oOcfh3YT6ygrlOzFqidQB9XD2u3pyhPiyd9XR8XeHKYTOI6uCPAJ4xUV95SJrOw2uIhsQnZE3D53rVvL+DeBf1mrxN5lcDcIblwptN7/iQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OFx3iRa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D7FC4CEE3;
	Fri, 20 Jun 2025 05:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398235;
	bh=u+mAV2e4TZ9YfVRlOGboPRc3yvRqHQyzUe0q4tBSw2g=;
	h=Subject:To:Cc:From:Date:From;
	b=OFx3iRa518u6YQ+MaIMWcDNbfnG04J2QDZcvfRNbS8tHJx+5RDX20hdeF35xuPcwe
	 X8uQwDE5dITklcEhGscoN5TqSej5jhVPV6mx56PQ7zn4TNG3HHCQ7ziCTrVNqkhI60
	 PghCjnMbOCYvcFfjOTKYdWTu+gw3BtSHkousbBJY=
Subject: FAILED: patch "[PATCH] btrfs: fix qgroup reservation leak on failure to allocate" failed to apply to 6.15-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:43:52 +0200
Message-ID: <2025062052-chair-rancidity-cf1d@gregkh>
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
git cherry-pick -x 1f2889f5594a2bc4c6a52634c4a51b93e785def5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-chair-rancidity-cf1d@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f2889f5594a2bc4c6a52634c4a51b93e785def5 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 7 May 2025 13:05:36 +0100
Subject: [PATCH] btrfs: fix qgroup reservation leak on failure to allocate
 ordered extent

If we fail to allocate an ordered extent for a COW write we end up leaking
a qgroup data reservation since we called btrfs_qgroup_release_data() but
we didn't call btrfs_qgroup_free_refroot() (which would happen when
running the respective data delayed ref created by ordered extent
completion or when finishing the ordered extent in case an error happened).

So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
ordered extent for a COW write.

Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space for ordered extents to fix reserved space leak")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ae49f87b27e8..e44d3dd17caf 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	struct btrfs_ordered_extent *entry;
 	int ret;
 	u64 qgroup_rsv = 0;
+	const bool is_nocow = (flags &
+	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (flags &
-	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
+	if (is_nocow) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
-	if (!entry)
+	if (!entry) {
+		if (!is_nocow)
+			btrfs_qgroup_free_refroot(inode->root->fs_info,
+						  btrfs_root_id(inode->root),
+						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;


