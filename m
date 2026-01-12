Return-Path: <stable+bounces-208140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C0D1392B
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AC0F30574F9
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86841E4AF;
	Mon, 12 Jan 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbtxkOVF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F352BDC32
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229762; cv=none; b=KLlzjAMpsqt5Cgvvz9LTexO5IrAmkwVjak3WSY0lCjxWLP+nptAZZr8H+2Kmu9go6UmUjMa5yOqJbw2ANUsuBN0K0KSezxtb1CXZtH0w+yAmO3L/9bJncs0kLEwqwQeDoSg5dUeb32eBmz3IQnD5tzvwPAHTJYfDrdfeyHMfCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229762; c=relaxed/simple;
	bh=CREPI2MjzTAOzZKm86YsQ2hDZt6oEsTV+CDOKzImUps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMUY2YmOq5JoojIUkrLcBbf52EdENgTjCqDTnWKDgHlU/5uoqakJnPjII3ughApMrVDLzS37ULIS5GRGWRF8B71o4iRamN1rVo9kabQP5bEyUjbBg/I7L9skp1sI9ow0vueGUOyLtinoctMCXrlnIuark7MN9FoJpb8pmY/AA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbtxkOVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5621C16AAE;
	Mon, 12 Jan 2026 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229762;
	bh=CREPI2MjzTAOzZKm86YsQ2hDZt6oEsTV+CDOKzImUps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbtxkOVFazVG6LpOcnDigkDq0gc0abehBm2KftW8GGjaIX8TD7OzyD3lKYKi/v7Ip
	 nTatJbBStCnTKjtWFcDrgQdNY8SHZe4iS0cHteB/rDwCdf0YX2i2yQvgXHXJ7NKkEQ
	 +NlqR3sflFVXqXVT1soaLZe3Jw5ycZQ0m4+x9K7WPyaNSowsP5Bl0mz5riXFpz0/qQ
	 LQjrMZqqiMeIMKKajNjnDvevqPNsCznRrw/qCkRQ98t1JvYi4lWwjqovNui+FQI8GQ
	 X8IGt7nsTcKneTq7/fzhsnXY4C+Bp7YZ6bkEbd77znOmM3d1JPVZZuseF/GUeTArua
	 RHCUkDnq1LvaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Anand Jain <asj@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] btrfs: use variable for end offset in extent_writepage_io()
Date: Mon, 12 Jan 2026 09:55:54 -0500
Message-ID: <20260112145555.720657-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112145555.720657-1-sashal@kernel.org>
References: <2026011242-empirical-gullible-4683@gregkh>
 <20260112145555.720657-1-sashal@kernel.org>
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
index 3658b74a97adb..657c4652f8b48 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1498,6 +1498,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
 	int found_error = 0;
+	const u64 end = start + len;
 	const u64 folio_start = folio_pos(folio);
 	const u64 folio_end = folio_start + folio_size(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
@@ -1505,7 +1506,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	int bit;
 	int ret = 0;
 
-	ASSERT(start >= folio_start && start + len <= folio_end);
+	ASSERT(start >= folio_start && end <= folio_end);
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret) {
@@ -1515,7 +1516,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
+	for (cur = start; cur < end; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
@@ -1544,7 +1545,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       start + len - cur, true);
+						       end - cur, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1553,8 +1554,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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


