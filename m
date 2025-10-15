Return-Path: <stable+bounces-185785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B885BDE0CC
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C17C19C3B89
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEA31A7FD;
	Wed, 15 Oct 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nFX4Trtr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615F311C36
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524714; cv=none; b=mPBA5Wx2zERUEMl5t7Va8pwHv7ys/YiGodxdiWxgHNyJdbVdyLgZ0fI3puLr3eOsgoP6FOUlw4ERtZWUE5Re2VTUfPB7qGdwCRkA4cBb1bYJCG42pXGu90JR4SfptDa1lEiIVGtzTsbZPSyThfMczUsZUxQ5uDzuA4NbhVNZyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524714; c=relaxed/simple;
	bh=UgYI1CUsS7/FbekZnFKcPMTK9fnJ40RU7ZXy8j9/aW0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oy8ReThJ9596Z2us+Nu+QnIsTkvrVGECWzqj3cazAWH7h3V2tcoB8huJ7i3eSQJ0HVERw6DxN6JOOPmYPsRZw/SYL5p1Zg61ZtTFZcfpvP1q7fBTCgF9Z1JdBgoTCZhB2NiA0MdniR2KuuWE/JnTlWMqjQ72PDqOLsEdc6s24vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nFX4Trtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA62C116B1;
	Wed, 15 Oct 2025 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760524713;
	bh=UgYI1CUsS7/FbekZnFKcPMTK9fnJ40RU7ZXy8j9/aW0=;
	h=Subject:To:Cc:From:Date:From;
	b=nFX4TrtrL9FzkMiSXqeMYyfLEeX2l5uioN1YyzGfjzQa8SH29rgob+ics1OxAdnOa
	 fca/ySGV8unkTxDEUw1fijYevNdLMW+G76eFO2BGh89k0IyIAR0d+iPSzr9QOdhuNT
	 xoukKbyAxYz0WeLZWt0Qqrr3bNfh7P/E8HtIy/ak=
Subject: FAILED: patch "[PATCH] btrfs: fix the incorrect max_bytes value for" failed to apply to 6.1-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:38:30 +0200
Message-ID: <2025101530-composed-concave-1075@gregkh>
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
git cherry-pick -x 7b26da407420e5054e3f06c5d13271697add9423
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101530-composed-concave-1075@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b26da407420e5054e3f06c5d13271697add9423 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Fri, 19 Sep 2025 14:33:23 +0930
Subject: [PATCH] btrfs: fix the incorrect max_bytes value for
 find_lock_delalloc_range()

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

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0782533aad51..2b6027ebf265 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -393,6 +393,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
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
@@ -423,13 +430,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				   delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the folios are gone, lets avoid looping by
-		 * shortening the size of the delalloc range we're searching
+		/*
+		 * Some of the folios are gone, lets avoid looping by
+		 * shortening the size of the delalloc range we're searching.
 		 */
 		btrfs_free_extent_state(cached_state);
 		cached_state = NULL;
 		if (!loops) {
-			max_bytes = PAGE_SIZE;
+			max_bytes = fs_info->sectorsize;
 			loops = 1;
 			goto again;
 		} else {


