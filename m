Return-Path: <stable+bounces-88242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D809B218A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752B61C20A22
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847F443D;
	Mon, 28 Oct 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mr5LpDNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC03C24
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075110; cv=none; b=oT8pOOue7ubJvwJwUwjd+zWK16FUf1bfiRWykG2ELppzCW0UAaaTjgH9jgzj/zdtR6ji0CXOZ7mE4ZnA0pYvxPAXJnJyvTWsuGesgn3URn+pnhzCb7cdBOqWWlwSzwiFEozxtNrVGHukhamGA0glLaC6q+gOBFRZSEuJkjxbFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075110; c=relaxed/simple;
	bh=8UpkOnIb9aG+T9NjfsUKVHYStji0ERI+nrG7l6hBWX0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ufjdUy4QKkH/L+J6tXeUE9t1mJQrmnoCzQzo5/neovvriU6PY+sF8yfBS0XIHFCUesJ+N60NDw1A0/7n/SWEdS8NH8P5SYU5FaRtfjnYAFT5Dck5DU8N4a58he7EmfvlaEpEMze8ad9QtjzjQn9aMghnneIXgQUbDJeuCusHKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mr5LpDNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B85C4CEC3;
	Mon, 28 Oct 2024 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075109;
	bh=8UpkOnIb9aG+T9NjfsUKVHYStji0ERI+nrG7l6hBWX0=;
	h=Subject:To:Cc:From:Date:From;
	b=Mr5LpDNE+MRiwCnvMlUFiyO0gTXEPvDz8sIhiK3ZMsg9bnXSl5wz7zM2ZHisjvqex
	 /CoTAhx+PAdviiqs6M1lXelHl39C5hhpM+kByWofLG1T/qmUPcBE0u+lW0dnh16zV1
	 /O+FZ6sqgFs4rVnL95DjElzch6q247M6GQQVu3p8=
Subject: FAILED: patch "[PATCH] btrfs: fix the delalloc range locking if sector size < page" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:24:57 +0100
Message-ID: <2024102857-unvaried-grip-2f5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f10f59f91a6278e9637327d1206140d28e2d5004
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102857-unvaried-grip-2f5d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f10f59f91a6278e9637327d1206140d28e2d5004 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 9 Oct 2024 09:37:03 +1030
Subject: [PATCH] btrfs: fix the delalloc range locking if sector size < page
 size

Inside lock_delalloc_folios(), there are several problems related to
sector size < page size handling:

- Set the writer locks without checking if the folio is still valid
  We call btrfs_folio_start_writer_lock() just like it's folio_lock().
  But since the folio may not even be the folio of the current mapping,
  we can easily screw up the folio->private.

- The range is not clamped inside the page
  This means we can over write other bitmaps if the start/len is not
  properly handled, and trigger the btrfs_subpage_assert().

- @processed_end is always rounded up to page end
  If the delalloc range is not page aligned, and we need to retry
  (returning -EAGAIN), then we will unlock to the page end.

  Thankfully this is not a huge problem, as now
  btrfs_folio_end_writer_lock() can handle range larger than the locked
  range, and only unlock what is already locked.

Fix all these problems by:

- Lock and check the folio first, then call
  btrfs_folio_set_writer_lock()
  So that if we got a folio not belonging to the inode, we won't
  touch folio->private.

- Properly truncate the range inside the page

- Update @processed_end to the locked range end

Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 309a8ae48434..872cca54cc6c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -262,22 +262,23 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
-			u32 len = end + 1 - start;
+			u64 range_start;
+			u32 range_len;
 
 			if (folio == locked_folio)
 				continue;
 
-			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
-							  len))
-				goto out;
-
+			folio_lock(folio);
 			if (!folio_test_dirty(folio) || folio->mapping != mapping) {
-				btrfs_folio_end_writer_lock(fs_info, folio, start,
-							    len);
+				folio_unlock(folio);
 				goto out;
 			}
+			range_start = max_t(u64, folio_pos(folio), start);
+			range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+					  end + 1) - range_start;
+			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
 
-			processed_end = folio_pos(folio) + folio_size(folio) - 1;
+			processed_end = range_start + range_len - 1;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();


