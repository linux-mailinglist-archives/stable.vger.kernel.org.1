Return-Path: <stable+bounces-154918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F1AE133B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792493AADAC
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA3202C5A;
	Fri, 20 Jun 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgDqeb56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BF1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398247; cv=none; b=hgycSvHqArQZSV4fvkxMUlKU8j672d2JaJDk1434iap1PYz8ooUDBKaDrNPRr+2fcSt2koWLuc8hX/KNzyYba1s2iW2A8vScBF/+NWwHi6jQ9oujSmcM0Tze0gADX1l+7pn1ghaZOoAmY97Pr1UvQLUSonFocfZEtH/MiWc9bII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398247; c=relaxed/simple;
	bh=WRF1pkmv7psPkAj0SgsbtmYbc7baZl8IKeQAf6Ae53M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T22L+mb+4FkIqPXNmRd1ULoEUfsWRo0y75PjAclk5FPFYEZfgXw0/yuoGIJMcXe6Z1aE9CGLACiIze3xRfDgQtkTvIMRKhTz9Y5AE5ZGNg7dy9njE5FtcKa43xG/BOYpphasUePt0k6YVKmNqN8UxvVNXXj0RNa5vXUgY0FdBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgDqeb56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B3CC4CEED;
	Fri, 20 Jun 2025 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398247;
	bh=WRF1pkmv7psPkAj0SgsbtmYbc7baZl8IKeQAf6Ae53M=;
	h=Subject:To:Cc:From:Date:From;
	b=tgDqeb56LxqvnZO5vZL4KVbDkcrRtXF9bO0VZFAXKF/HDviAzU8h7qtc/pO81xDb1
	 AfTmc2eRlhovyC/ckDbX/a1tfz/q7z8Chwut6W9BY5wkdW/IcL1952GXUA9R8bwqLN
	 eZsYHmO28KzW66/46bwdqVhuXZvc5iJLQYfsOH5g=
Subject: FAILED: patch "[PATCH] btrfs: fix qgroup reservation leak on failure to allocate" failed to apply to 6.12-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:43:53 +0200
Message-ID: <2025062053-huff-down-519c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1f2889f5594a2bc4c6a52634c4a51b93e785def5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062053-huff-down-519c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


