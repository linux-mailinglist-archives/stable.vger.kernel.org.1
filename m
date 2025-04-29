Return-Path: <stable+bounces-137955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A384AA15C9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FE418981CD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39E21ADC7;
	Tue, 29 Apr 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLIY7a7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5F1FE468;
	Tue, 29 Apr 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947642; cv=none; b=KdzGpFc4ozOjBb1PFmiBEovnSt68DhtOHLwMe71rKf/AsIIWsFPC0phD+nUIVME/ti6o1FZHg/uGcww2Zh3Kjmr3WlWmUYw135vrWeomSOYr12jsy64LF/D82VTyGoJPDwAtQoDOnCYt1TjsDTPtedUAnGePAd/aXy77WeujgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947642; c=relaxed/simple;
	bh=iWxH48q/JGlshqoJdhVehW6AkAGaaCFQF1arfJmpJg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1wa9NAQXQxJ2VBlvG+STSCRPmOrm4WRdLxlcEW5JeFbIDe1Fy/l/bvVl0w7zqJr1Gc2ovnQ3u1VK5ofYRYWb2CYIG0/8gGxidA1MoHNXigV68KVScSOoB3JMJw33WCvmuppjP9xo/2eIiD/bf0BHaPQwQfn61nJ+/DS7VtEZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLIY7a7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F1EC4CEE3;
	Tue, 29 Apr 2025 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947642;
	bh=iWxH48q/JGlshqoJdhVehW6AkAGaaCFQF1arfJmpJg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLIY7a7R3kWOIvKJJ9CIaiLgryg0QS3+SNlfBVTwK2R8vbGAPlCz8QUiSG2QpUL3p
	 Ot+mFfCIFGWxhK5WZlcM30JTQV2XaPP0gp29prCPWmV2CJpTk1dK9VAejgiDY73gi4
	 BpsaYN1GOMkmmFziQ9yYkdrFPX0nH6U+latpIpuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 060/280] btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
Date: Tue, 29 Apr 2025 18:40:01 +0200
Message-ID: <20250429161117.567277689@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 78c4a3765002e..eaa991e698049 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2235,15 +2235,20 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
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
@@ -2255,7 +2260,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we do, unlock the range and retry.
 		 */
 		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+					    page_lockend - 1))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.39.5




