Return-Path: <stable+bounces-172266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB15B30C9E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D54F5E168D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8328A1ED;
	Fri, 22 Aug 2025 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDSzvi7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7122172C
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833734; cv=none; b=r/lYbhux092EdGR9Ckn3yxHoeAiyPeg72Srcqm8Vl1nHYUokc9o5rsQ3JUWmM2t0ekZSxU2BHsCdKnPVs2dnkOeG/4VPtnR9nnQ4n6PohiV+aTWZoY5cDmjfkyTDsreUmm5F4IgEOI+sk4Io83cUwYM4EtAl257M5mSMHm106uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833734; c=relaxed/simple;
	bh=etmJiZxLv4AmZg8hYNhNJf4F2znB/tx3WUXXldbLHeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZiQyqfKaXuIFj27y0bO/uxE+cSxhLMEIEUKFUElztRqnZbZaTbOvi/Mdvj69yBJUYl/FAPsEA3TXDVAAJgz4AH1S2rMZmnZLJ61eelB1JPyBBtODr4z3DjMQ9WsIlTJwP6U0U1EdqIE4hEDOxqkVKRS6aIaxyeUvND4PlM2kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDSzvi7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8346FC116C6;
	Fri, 22 Aug 2025 03:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833734;
	bh=etmJiZxLv4AmZg8hYNhNJf4F2znB/tx3WUXXldbLHeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDSzvi7upUsN+V1tdcVEHxTP7wHhFUT+Z8Rf0QUFvUmVUZ4h+WAtfeA4UPwPuGFkD
	 OX/0/HVFFF+kd9xIAiciSuf0m5o0DuwbknN+qoDux16vGKiKBE96DmEt8QcuuOjKuy
	 wCEhxjp7/0zqHgPTXshVC20kGj3IE7DvLMkV/aW0PLU9LVUsoYuIsKWOU0yuVTZTRN
	 kgJQCOzuvDoahWT0kKZaol85E0EumFdI3iQRgopHhkQi0oa9G+GFySWpkKhrK/iqks
	 35Qqi8gl+e+FmLkgBSZbBC3fuW3PE9I+Pr39ILFmkSgtPxC84k2B6Z5WvqyAWfSq/D
	 GKrRdFMOWVJHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Date: Thu, 21 Aug 2025 23:35:17 -0400
Message-ID: <20250822033527.1065200-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822033527.1065200-1-sashal@kernel.org>
References: <2025082101-survive-mannish-1c90@gregkh>
 <20250822033527.1065200-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit b1511360c8ac882b0c52caa263620538e8d73220 ]

btrfs_subpage_set_writeback() calls folio_start_writeback() the first time
a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE tag
even if there are still dirty blocks in the folio. This can break ordering
guarantees, such as those required by btrfs_wait_ordered_extents().

That ordering breakage leads to a real failure. For example, running
generic/464 on a zoned setup will hit the following ASSERT. This happens
because the broken ordering fails to flush existing dirty pages before the
file size is truncated.

  assertion failed: !list_empty(&ordered->list) :: 0, in fs/btrfs/zoned.c:1899
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/zoned.c:1899!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 2 UID: 0 PID: 1906169 Comm: kworker/u130:2 Kdump: loaded Not tainted 6.16.0-rc6-BTRFS-ZNS+ #554 PREEMPT(voluntary)
  Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/2021
  Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
  RIP: 0010:btrfs_finish_ordered_zoned.cold+0x50/0x52 [btrfs]
  RSP: 0018:ffffc9002efdbd60 EFLAGS: 00010246
  RAX: 000000000000004c RBX: ffff88811923c4e0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffff827e38b1 RDI: 00000000ffffffff
  RBP: ffff88810005d000 R08: 00000000ffffdfff R09: ffffffff831051c8
  R10: ffffffff83055220 R11: 0000000000000000 R12: ffff8881c2458c00
  R13: ffff88811923c540 R14: ffff88811923c5e8 R15: ffff8881c1bd9680
  FS:  0000000000000000(0000) GS:ffff88a04acd0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f907c7a918c CR3: 0000000004024000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   ? srso_return_thunk+0x5/0x5f
   btrfs_finish_ordered_io+0x4a/0x60 [btrfs]
   btrfs_work_helper+0xf9/0x490 [btrfs]
   process_one_work+0x204/0x590
   ? srso_return_thunk+0x5/0x5f
   worker_thread+0x1d6/0x3d0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x118/0x230
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x205/0x260
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Consider process A calling writepages() with WB_SYNC_NONE. In zoned mode or
for compressed writes, it locks several folios for delalloc and starts
writing them out. Let's call the last locked folio folio X. Suppose the
write range only partially covers folio X, leaving some pages dirty.
Process A calls btrfs_subpage_set_writeback() when building a bio. This
function call clears the TOWRITE tag of folio X, whose size = 8K and
the block size = 4K. It is following state.

   0     4K    8K
   |/////|/////|  (flag: DIRTY, tag: DIRTY)
   <-----> Process A will write this range.

Now suppose process B concurrently calls writepages() with WB_SYNC_ALL. It
calls tag_pages_for_writeback() to tag dirty folios with
PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. Then,
B collects tagged folios using filemap_get_folios_tag() and must wait for
folio X to be written before returning from writepages().

   0     4K    8K
   |/////|/////|  (flag: DIRTY, tag: DIRTY|TOWRITE)

However, between tagging and collecting, process A may call
btrfs_subpage_set_writeback() and clear folio X's TOWRITE tag.
   0     4K    8K
   |     |/////|  (flag: DIRTY|WRITEBACK, tag: DIRTY)

As a result, process B won't see folio X in its batch, and returns without
waiting for it. This breaks the WB_SYNC_ALL ordering requirement.

Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retains
the TOWRITE tag. We now manually clear the tag only after the folio becomes
clean, via the xas operation.

Fixes: 3470da3b7d87 ("btrfs: subpage: introduce helpers for writeback status")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/subpage.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 9b63a4d1c989..2951fdc5db4e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&bfs->lock, flags);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+
+	/*
+	 * Don't clear the TOWRITE tag when starting writeback on a still-dirty
+	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
+	 * assume writeback is complete, and exit too early — violating sync
+	 * ordering guarantees.
+	 */
 	if (!folio_test_writeback(folio))
-		folio_start_writeback(folio);
+		__folio_start_writeback(folio, true);
+	if (!folio_test_dirty(folio)) {
+		struct address_space *mapping = folio_mapping(folio);
+		XA_STATE(xas, &mapping->i_pages, folio->index);
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
+	}
 	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
-- 
2.50.1


