Return-Path: <stable+bounces-208119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE8D12F03
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09D413008D70
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC335581A;
	Mon, 12 Jan 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8cyWfm3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD04274FC2
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226095; cv=none; b=utgXUckFcCwHX19zg7ScN2p2/HNOFQYMIf3bq3dHcGuGZru/iNa/5GGEilFM3oZgmFp79ubh/HVqHOV3h4klCh01X1ZrUKrhufaTZodenOpnFKZbZSsGwhIcHaaOytVF1Rzn8uq/IsK/KrKardCtlx1qcRXtNiCuvc4o8yvhT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226095; c=relaxed/simple;
	bh=C/HIwzrVV6lZB1EHOS8eHE+n83DeZ7w0hT9a1eViDig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Rpl7sTDMDVix/P6kCx6H31oXQuOFaI4kl3cdcCtpHXVSYh+p9ksgkgPaVAQwX3YDUdLYoRU5n1LgBm0EzYhOIHvYZv2fVgpAd9hScEwllMJWMwsrPzHusGfO2YYC8Fus/tWgVMdA3HZR6JV+C30d4xnVRp57yQSAblKbpvZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8cyWfm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49144C19421;
	Mon, 12 Jan 2026 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226094;
	bh=C/HIwzrVV6lZB1EHOS8eHE+n83DeZ7w0hT9a1eViDig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8cyWfm39TGqoHYHWzIDpiqhOMJxsnrLx3yfHV0Kdxyh36YEkvhRpBY4W3HAwd7bx
	 CPJh6QoA42s6YB90rI+DK0rl0+4QMEnW3mRh0RwgHqYVe+Vky0hYrKKb6I2h8T26gt
	 dFIlIAfDvRhH4E2Gk+z4L0sNCZIQaktfpty9PKDtLtSSbnUufgOXzn03u+4g/d/Awt
	 qvVcxBQNrUWqCvcMMIZYIBsvqmn/RmnOHlwaC5LrHKOLDWeA361du+kc2NSVKfMGwa
	 nnGNcbhtGwRc+gVqsrkLYxmXj1NYmhfgdrFcHl/Ki5ZaeOTS4BWs9ya/lGln5r0sNl
	 lJfh2hLgzLZaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Anand Jain <asj@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] btrfs: use variable for end offset in extent_writepage_io()
Date: Mon, 12 Jan 2026 08:54:50 -0500
Message-ID: <20260112135451.704777-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112135451.704777-1-sashal@kernel.org>
References: <2026011240-unreal-knee-7bf4@gregkh>
 <20260112135451.704777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 46a23908598f4b8e61483f04ea9f471b2affc58a ]

Instead of repeating the expression "start + len" multiple times, store it
in a variable and use it where needed.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <asj@kernel.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7cbccd4604c50..ca09f42d26aa1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1691,6 +1691,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
 	int found_error = 0;
+	const u64 end = start + len;
 	const u64 folio_start = folio_pos(folio);
 	const u64 folio_end = folio_start + folio_size(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
@@ -1698,7 +1699,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	int bit;
 	int ret = 0;
 
-	ASSERT(start >= folio_start && start + len <= folio_end);
+	ASSERT(start >= folio_start && end <= folio_end);
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret == -EAGAIN) {
@@ -1714,7 +1715,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return ret;
 	}
 
-	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
+	for (cur = start; cur < end; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
@@ -1743,7 +1744,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       start + len - cur, true);
+						       end - cur, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1752,8 +1753,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur,
-						start + len - cur);
+			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-- 
2.51.0


