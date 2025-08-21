Return-Path: <stable+bounces-172020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB9B2F986
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C6AE2ADF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CE2DA76E;
	Thu, 21 Aug 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9o3N1Hj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E581F4CAC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781269; cv=none; b=NfDFhB3Kx8MTVSKa8u2xmF961+5sCi7JhhpYSSYn9igcswkneUM9keM23tIWN/oGBhd4ho4zpwCO551cNaNfN/NaQHAqS+A4jHWEuvNGBVBMAxETcYQTxsyeGJeEm14zAgeiwTIRdj9QSCXPFVqyAnMIR9z6VpTDmUIpreKU88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781269; c=relaxed/simple;
	bh=kC65jMpunWaTbLiG8MSnl0BuImFxfN/6aKNcelt6Nds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FAfVYFYTmGZo7yMOqi+/QuvATDC3nVASYKEX0/6HNBWv7cSKnrWStWbW359DeE/ADhVuoodzPZP7NlI+NefZAR6LgEoWHYMNdtaI5jqoMTaIhRKhDs04xlGW6vjDyVr/eIlH20v/I06bCvPwiOYEB6tKle5dUP7tRRjEAewvEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9o3N1Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B57EC4CEEB;
	Thu, 21 Aug 2025 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781268;
	bh=kC65jMpunWaTbLiG8MSnl0BuImFxfN/6aKNcelt6Nds=;
	h=Subject:To:Cc:From:Date:From;
	b=e9o3N1HjqEig/mfgADyC2EdQ8+Xx43gAfEXepiEdjPs4zddlfDqC5IX/9CfN2OJ99
	 mL2tVHP1sO/CrPtKMYVmt1UzqAwzzUYaSPtRGC32Q0u2G0t/Tvh7MId/2o3K03H9Cw
	 YkksUIQfJ3GXuem3rBv49wU3hFphUQmKymtNlmvU=
Subject: FAILED: patch "[PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned" failed to apply to 6.12-stable tree
To: naohiro.aota@wdc.com,dsterba@suse.com,johannes.thumshirn@wdc.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:01:03 +0200
Message-ID: <2025082102-scoff-lasso-16ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b1511360c8ac882b0c52caa263620538e8d73220
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082102-scoff-lasso-16ce@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1511360c8ac882b0c52caa263620538e8d73220 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Thu, 31 Jul 2025 12:46:56 +0900
Subject: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned

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

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index c9b3821957f7..cb4f97833dc3 100644
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
 


