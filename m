Return-Path: <stable+bounces-138599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C0AA1927
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7720E9C0BA9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CB224222;
	Tue, 29 Apr 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQZa3/4o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEF22AE68;
	Tue, 29 Apr 2025 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949759; cv=none; b=kPvuKWsHL9qzOdnPqHEcwLDTT8YyBiVAEQaWXTxZHNTjzO6dTgAxufrRw2DzmmeO4ds/KvV05q07Jd/tTjCYiBheb1aqpMsiX4RVoiMH6aDnfu+JHGHNy0Y+upjJAnDUeMTahC+3lj9w3lZCutZldz2vClU1o6jmC48j8tq+ZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949759; c=relaxed/simple;
	bh=Gvg68PHoevoa+JLi5MmtPV/8sWhi7GWEXpWA+vrIoGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH52Tlw9SHKxbs6TbBhQgUEFq/cCZw2VmGCNLRcleLUeO/VxiPialsR+NzAI+qWrr4S+Lr+p7MHoHMU8itQYeyTK/PXA0PZ8r/kS5CYfN7cI8NB1/GztLDVJ8KQ9N13LSwxKyrbWGlD0TI6qPriYW660s2WBvO1vGt6BeMQiTd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQZa3/4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CF6C4CEE3;
	Tue, 29 Apr 2025 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949758;
	bh=Gvg68PHoevoa+JLi5MmtPV/8sWhi7GWEXpWA+vrIoGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQZa3/4oFK6aYEYGllgHfePVBjeaxVsZOYP2NCEhS/hxwH3IB/UmFGWm2BLvAkDnN
	 VnySkRl34+yjZn/ldGywbRjOy8Q02F96ZQTylsQIgD2XDB+p3H2Q8bk7+ywO36Cdfn
	 XLZY7iljuxJCeN0Io+O3SvfiGI3PsBTTmAW3MTm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/167] btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
Date: Tue, 29 Apr 2025 18:42:35 +0200
Message-ID: <20250429161053.665207250@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit bc2dbc4983afedd198490cca043798f57c93e9bf ]

[BUG]
When running btrfs/004 with 4K fs block size and 64K page size,
sometimes fsstress workload can take 100% CPU for a while, but not long
enough to trigger a 120s hang warning.

[CAUSE]
When such 100% CPU usage happens, btrfs_punch_hole_lock_range() is
always in the call trace.

One example when this problem happens, the function
btrfs_punch_hole_lock_range() got the following parameters:

  lock_start = 4096, lockend = 20469

Then we calculate @page_lockstart by rounding up lock_start to page
boundary, which is 64K (page size is 64K).

For @page_lockend, we round down the value towards page boundary, which
result 0.  Then since we need to pass an inclusive end to
filemap_range_has_page(), we subtract 1 from the rounded down value,
resulting in (u64)-1.

In the above case, the range is inside the same page, and we do not even
need to call filemap_range_has_page(), not to mention to call it with
(u64)-1 at the end.

This behavior will cause btrfs_punch_hole_lock_range() to busy loop
waiting for irrelevant range to have its pages dropped.

[FIX]
Calculate @page_lockend by just rounding down @lockend, without
decreasing the value by one.  So @page_lockend will no longer overflow.

Then exit early if @page_lockend is no larger than @page_lockstart.
As it means either the range is inside the same page, or the two pages
are adjacent already.

Finally only decrease @page_lockend when calling filemap_range_has_page().

Fixes: 0528476b6ac7 ("btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9e06d1a0d373d..3814f09dc4ae0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2224,15 +2224,20 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 * will always return true.
 	 * So here we need to do extra page alignment for
 	 * filemap_range_has_page().
+	 *
+	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
 	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
+	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
 
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
+		/* The same page or adjacent pages. */
+		if (page_lockend <= page_lockstart)
+			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2244,7 +2249,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we do, unlock the range and retry.
 		 */
 		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+					    page_lockend - 1))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.39.5




