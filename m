Return-Path: <stable+bounces-208135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EDD13928
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A9CB301146B
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156026CE17;
	Mon, 12 Jan 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMGSkCTg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F21F3B87
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229758; cv=none; b=MzS3T9W5Hs6e/aG0fCdsgwt6zT+deyB7C8rGzP1i2THoiTCKR7aV0gt05aE2TeC16x46nknUzi32S7QQwJiiQun9JUiFOzvSmGmh6tXhcPpBL6utBlel3EMKlwX2SDUcmdcb2JoV0XVThRyBSPO9gXH+O66Pt9/rEKpl+aQaa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229758; c=relaxed/simple;
	bh=xzL+Kntt3mDZClqkiJaMmjj7rBqCE5tTgPKFP+hYQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGnh+wIq8iiTkjIGxPPHxwCOSQwVP4RjCLdRXRkr7wZQnJaljB74LMrz53azuTaYQqhKtSAWFCu9D2AmDQ5SBVBaOFsJZ5T9axiXNQs1+CN/zTMxRPYy1THqGMMheisvuiInJ1HARfTD5a2G6eLYq/GPFf+nMtFQbXAQrnraVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMGSkCTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE051C19422;
	Mon, 12 Jan 2026 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229758;
	bh=xzL+Kntt3mDZClqkiJaMmjj7rBqCE5tTgPKFP+hYQ60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMGSkCTgMXVMCFrvIFPaoVsq6YGWSM2s1MMOKDAA0HCqGP44IJhEa3M9hQgow4yRZ
	 1lyamEygSRmXBMglaS5XVZAdAjCN+mH5P4fLLTki/kH8Rml++7f4f9YiCIY4utlDnm
	 r2GS/53eRTDqhLQQQj7YUEvGiO5CXOrePLySepseygD2FBTtc4lkQsXAdCJNrjQoU6
	 xWuYwcDJPGYbETyPMAspvKCZgTRH467cW+RYr43W13KmlXZN2RwfcViA5khGViq81n
	 HgrvNVl7m4r/2m52w0sqiGjTVmvN5wgklxrpLjp5vUcTDHoswc9Rh1pnUs1ZaREswu
	 7nuunrLsCpTRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/7] btrfs: fix error handling of submit_uncompressed_range()
Date: Mon, 12 Jan 2026 09:55:49 -0500
Message-ID: <20260112145555.720657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011242-empirical-gullible-4683@gregkh>
References: <2026011242-empirical-gullible-4683@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a7858d5c36cae52eaf3048490b05c0b19086073b ]

[BUG]
If we failed to compress the range, or cannot reserve a large enough
data extent (e.g. too fragmented free space), we will fall back to
submit_uncompressed_range().

But inside submit_uncompressed_range(), run_delalloc_cow() can also fail
due to -ENOSPC or any other error.

In that case there are 3 bugs in the error handling:

1) Double freeing for the same ordered extent
   This can lead to crash due to ordered extent double accounting

2) Start/end writeback without updating the subpage writeback bitmap

3) Unlock the folio without clear the subpage lock bitmap

Both bugs 2) and 3) will crash the kernel if the btrfs block size is
smaller than folio size, as the next time the folio gets writeback/lock
updates, subpage will find the bitmap already have the range set,
triggering an ASSERT().

[CAUSE]
Bug 1) happens in the following call chain:

  submit_uncompressed_range()
  |- run_delalloc_cow()
  |  |- cow_file_range()
  |     |- btrfs_reserve_extent()
  |        Failed with -ENOSPC or whatever error
  |
  |- btrfs_clean_up_ordered_extents()
  |  |- btrfs_mark_ordered_io_finished()
  |     Which cleans all the ordered extents in the async_extent range.
  |
  |- btrfs_mark_ordered_io_finished()
     Which cleans the folio range.

The finished ordered extents may not be immediately removed from the
ordered io tree, as they are removed inside a work queue.

So the second btrfs_mark_ordered_io_finished() may find the finished but
not-yet-removed ordered extents, and double free them.

Furthermore, the second btrfs_mark_ordered_io_finished() is not subpage
compatible, as it uses fixed folio_pos() with PAGE_SIZE, which can cover
other ordered extents.

Bugs 2) and 3) are more straightforward, btrfs just calls folio_unlock(),
folio_start_writeback() and folio_end_writeback(), other than the helpers
which handle subpage cases.

[FIX]
For bug 1) since the first btrfs_cleanup_ordered_extents() call is
handling the whole range, we should not do the second
btrfs_mark_ordered_io_finished() call.

And for the first btrfs_cleanup_ordered_extents(), we no longer need to
pass the @locked_page parameter, as we are already in the async extent
context, thus will never rely on the error handling inside
btrfs_run_delalloc_range().

So just let the btrfs_clean_up_ordered_extents() handle every folio
equally.

For bug 2) we should not even call
folio_start_writeback()/folio_end_writeback() anymore.
As the error handling protocol, cow_file_range() should clear
dirty flag and start/finish the writeback for the whole range passed in.

For bug 3) just change the folio_unlock() to btrfs_folio_end_lock()
helper.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ce13b0ec978ed..38323620b819e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1159,19 +1159,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, locked_folio,
-					      start, end - start + 1);
-		if (locked_folio) {
-			const u64 page_start = folio_pos(locked_folio);
-
-			folio_start_writeback(locked_folio);
-			folio_end_writeback(locked_folio);
-			btrfs_mark_ordered_io_finished(inode, locked_folio,
-						       page_start, PAGE_SIZE,
-						       !ret);
-			mapping_set_error(locked_folio->mapping, ret);
-			folio_unlock(locked_folio);
-		}
+		btrfs_cleanup_ordered_extents(inode, NULL, start, end - start + 1);
+		if (locked_folio)
+			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
+					     start, async_extent->ram_size);
 	}
 }
 
-- 
2.51.0


