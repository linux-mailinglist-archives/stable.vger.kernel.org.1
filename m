Return-Path: <stable+bounces-185833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0693BDF54F
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E692319C7672
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015E2FB0B7;
	Wed, 15 Oct 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX43PyfU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347221ABC9
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541841; cv=none; b=o5bYdmYE14v3187a29paDtrnws/T7874y4dQQSY0xvpUrcdr5ouKIKXiZshRbz2ff1IexKKLHK0lfH5sDPkI9T2ys3dDsCkTZ7wbvRj2sDtoKN6tpbMLwokMMlpw1k8ZSpEIoKF15uZxM2CWHzzsvRTW2BbWuAhR2uGXtU8Nv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541841; c=relaxed/simple;
	bh=TuD8Zu5yvKtsQ4kgNx8v7xxNzBc/6o5OL0GBUGd1aUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ7gDY3t1UvhGEL+CANIbJonZCrwGcJgpMkNXj3Pj3nwwQ+8L0xLbqpJaJ860Xxjlm39M61YQc9NbzqQ7q5SMuzeCIRdmk/QfZ5ngdO/8VMdUDO9Qg/5GGi8Qh4cjzRFFo1HsHfgLJbfstjaOJgtoFOqHhyp57OKVBz1nOQtsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX43PyfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2325C4CEF8;
	Wed, 15 Oct 2025 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760541840;
	bh=TuD8Zu5yvKtsQ4kgNx8v7xxNzBc/6o5OL0GBUGd1aUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eX43PyfUuEI8MNhPWT2U4Aesvg31vd6m2wjUkIdP9n73cL7EUc7OksM26o0cnoLIl
	 rAHug8myDbHuUWZUwSFuXtyRDE21zEgaGHASXQoSUPxywYYXKyaWkLSEm9iSjXpdwb
	 HbQVeOwf8VPGeFgUkrWUPNpZRR4UMc3hx5fG2M04AjQ6M5iraBqK3aZQFvWGudtkz+
	 NxW9kVuiMX4BaIpTrYPJqkNl3tIbBlPOzBqPBVyNO850XFP65zfnckaYWnfe9cLh1w
	 oK0veMXxyb/fTmnqceX+BAMFggrnITeZeRBEH12nPrWdMtDlKMCWDk9H9JRVHqRMKa
	 o2Eyhq4zTlZdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: fix the incorrect max_bytes value for find_lock_delalloc_range()
Date: Wed, 15 Oct 2025 11:23:57 -0400
Message-ID: <20251015152357.1457706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101530-composed-concave-1075@gregkh>
References: <2025101530-composed-concave-1075@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7b26da407420e5054e3f06c5d13271697add9423 ]

[BUG]
With my local branch to enable bs > ps support for btrfs, sometimes I
hit the following ASSERT() inside submit_one_sector():

	ASSERT(block_start != EXTENT_MAP_HOLE);

Please note that it's not yet possible to hit this ASSERT() in the wild
yet, as it requires btrfs bs > ps support, which is not even in the
development branch.

But on the other hand, there is also a very low chance to hit above
ASSERT() with bs < ps cases, so this is an existing bug affect not only
the incoming bs > ps support but also the existing bs < ps support.

[CAUSE]
Firstly that ASSERT() means we're trying to submit a dirty block but
without a real extent map nor ordered extent map backing it.

Furthermore with extra debugging, the folio triggering such ASSERT() is
always larger than the fs block size in my bs > ps case.
(8K block size, 4K page size)

After some more debugging, the ASSERT() is trigger by the following
sequence:

 extent_writepage()
 |  We got a 32K folio (4 fs blocks) at file offset 0, and the fs block
 |  size is 8K, page size is 4K.
 |  And there is another 8K folio at file offset 32K, which is also
 |  dirty.
 |  So the filemap layout looks like the following:
 |
 |  "||" is the filio boundary in the filemap.
 |  "//| is the dirty range.
 |
 |  0        8K       16K        24K         32K       40K
 |  |////////|        |//////////////////////||////////|
 |
 |- writepage_delalloc()
 |  |- find_lock_delalloc_range() for [0, 8K)
 |  |  Now range [0, 8K) is properly locked.
 |  |
 |  |- find_lock_delalloc_range() for [16K, 40K)
 |  |  |- btrfs_find_delalloc_range() returned range [16K, 40K)
 |  |  |- lock_delalloc_folios() locked folio 0 successfully
 |  |  |
 |  |  |  The filemap range [32K, 40K) got dropped from filemap.
 |  |  |
 |  |  |- lock_delalloc_folios() failed with -EAGAIN on folio 32K
 |  |  |  As the folio at 32K is dropped.
 |  |  |
 |  |  |- loops = 1;
 |  |  |- max_bytes = PAGE_SIZE;
 |  |  |- goto again;
 |  |  |  This will re-do the lookup for dirty delalloc ranges.
 |  |  |
 |  |  |- btrfs_find_delalloc_range() called with @max_bytes == 4K
 |  |  |  This is smaller than block size, so
 |  |  |  btrfs_find_delalloc_range() is unable to return any range.
 |  |  \- return false;
 |  |
 |  \- Now only range [0, 8K) has an OE for it, but for dirty range
 |     [16K, 32K) it's dirty without an OE.
 |     This breaks the assumption that writepage_delalloc() will find
 |     and lock all dirty ranges inside the folio.
 |
 |- extent_writepage_io()
    |- submit_one_sector() for [0, 8K)
    |  Succeeded
    |
    |- submit_one_sector() for [16K, 24K)
       Triggering the ASSERT(), as there is no OE, and the original
       extent map is a hole.

Please note that, this also exposed the same problem for bs < ps
support. E.g. with 64K page size and 4K block size.

If we failed to lock a folio, and falls back into the "loops = 1;"
branch, we will re-do the search using 64K as max_bytes.
Which may fail again to lock the next folio, and exit early without
handling all dirty blocks inside the folio.

[FIX]
Instead of using the fixed size PAGE_SIZE as @max_bytes, use
@sectorsize, so that we are ensured to find and lock any remaining
blocks inside the folio.

And since we're here, add an extra ASSERT() to
before calling btrfs_find_delalloc_range() to make sure the @max_bytes is
at least no smaller than a block to avoid false negative.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ adapted folio terminology and API calls to page-based equivalents ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 516d40f707a65..8d66a6858cd2d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -415,6 +415,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
+
+	/*
+	 * If @max_bytes is smaller than a block, btrfs_find_delalloc_range() can
+	 * return early without handling any dirty ranges.
+	 */
+	ASSERT(max_bytes >= fs_info->sectorsize);
+
 	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
 					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
@@ -445,13 +452,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				  delalloc_start, delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the pages are gone, lets avoid looping by
-		 * shortening the size of the delalloc range we're searching
+		/*
+		 * Some of the pages are gone, lets avoid looping by
+		 * shortening the size of the delalloc range we're searching.
 		 */
 		free_extent_state(cached_state);
 		cached_state = NULL;
 		if (!loops) {
-			max_bytes = PAGE_SIZE;
+			max_bytes = fs_info->sectorsize;
 			loops = 1;
 			goto again;
 		} else {
-- 
2.51.0


