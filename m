Return-Path: <stable+bounces-164821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3FB12890
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108A17A585B
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C01D5151;
	Sat, 26 Jul 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezJpb1mU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC842AB0
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753496708; cv=none; b=XgaQSW4oIA9QZWFSRn/Nml5P2tcBhe2BIBeM9gqQ+6KGw360llKmXzp+OKR20oE90jsMRnxifDPV89lAL5OjXUForhA41koxwYOPh2uGwX2V5+lv/n6ueHIneeLz2kSd2aY0mYo4XWefP3pMg6Gs8FAz5UFCjozVf0TSR0Y2xdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753496708; c=relaxed/simple;
	bh=DG2BRcrJM3tgsRlLAWh6xsBebC/XlAZobKnaRATWy6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUT255yt/wUWrbczIy2Ea2qxw3JL+VIboIoSS6qSug9peQvhA7l158G51+0TIwpng0q0akGpSRTKd0RNlkr5TJlrdm4quGp3BEKrhCsaTmkV7PA2uzYlJ02UW5kOHQs59h8oZ17+gk7HMTO8sccY5xfd+jlavgoOhVIBhmWWWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezJpb1mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2079C4CEE7;
	Sat, 26 Jul 2025 02:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753496707;
	bh=DG2BRcrJM3tgsRlLAWh6xsBebC/XlAZobKnaRATWy6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezJpb1mU5TcXncDc1GhUqgaXkfs0xrLIgn4hO1C9UEw3nWxKLQW0yp5X3fmFJ1N35
	 +5MMn/l/0rvjKeg/j8Xy0gt0gyT1k/qjFoj6YFibWmtq67r8QVxo0ZvZjb9OwPCEBC
	 zzBhv8gY+iH5tnd32HKpyY3OQynoUUWqsdFq6ViUHu0H1Hg8z0e2CGIJ6BDfos07uq
	 r9B18N6uVYGcuK7FyvgNkGXgtEGtzECbN0EXTEpY35BWnthCyDS8gUBp81/XTxfIP0
	 d2EfoBLDKfujMTE6E6vrQB9GEBpCFv6nzcZV95HEWt9qzCvQosCgfXvLBr6UbdvZA+
	 N7t5+ZNXBmORw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: fix qgroup reservation leak on failure to allocate ordered extent
Date: Fri, 25 Jul 2025 22:25:03 -0400
Message-Id: <20250726022503.2023611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062054-unhappily-kebab-e7e5@gregkh>
References: <2025062054-unhappily-kebab-e7e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1f2889f5594a2bc4c6a52634c4a51b93e785def5 ]

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
[ adjust to code movements ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ordered-data.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1b2af4785c0e2..69fd4f9d840b5 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -173,9 +173,10 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	struct btrfs_ordered_extent *entry;
 	int ret;
 	u64 qgroup_rsv = 0;
+	const bool is_nocow = (flags &
+	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (flags &
-	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
+	if (is_nocow) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -191,8 +192,13 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			return ret;
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
-	if (!entry)
+	if (!entry) {
+		if (!is_nocow)
+			btrfs_qgroup_free_refroot(inode->root->fs_info,
+						  btrfs_root_id(inode->root),
+						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
 		return -ENOMEM;
+	}
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
-- 
2.39.5


