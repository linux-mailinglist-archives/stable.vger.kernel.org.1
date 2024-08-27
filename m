Return-Path: <stable+bounces-70797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3C961018
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD32B1F23E31
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D801C8719;
	Tue, 27 Aug 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZlkh2y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574F1C57A9;
	Tue, 27 Aug 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771092; cv=none; b=XT12vTZVNIrAng09SKGRTWjG7OdGZiljyOLl4CFVBGGYFq9lMWb7r3CAOeb2ubXy6p9NmEwAOpdKFQLsBW4DagpCwt9AZ2/OnhweG30vn/3v2HLh8Jiw0LUS0q7AsXG88+V0gYZnwbM3FKfzNX9RiuCKe9k4DD8xSDrLeoB86vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771092; c=relaxed/simple;
	bh=HKuDf2tiIjMvubiCm1Cb3RbX+5WVieJBEi6DPmec+Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC1G6F7IMxhHzDcwuKl66emZ92sydwYf9y53iEnI9o4AcA+8FGDBIQY08zMxhsma/XJIL733sbPDL+tPEMpuqDUrHQekSPjKhC05H7HWdYUsnAHkyQ3q6mVXDFDk0HL4vcQ9eiRMNTsYCo6ZBDbcZ9m4NfKENgTYwQGZvTQgJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZlkh2y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346D6C6105B;
	Tue, 27 Aug 2024 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771092;
	bh=HKuDf2tiIjMvubiCm1Cb3RbX+5WVieJBEi6DPmec+Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZlkh2y4ndhomlZ3GiYEUCB7FlzwMD3t/sGUx080sAuLVZeCubjRhqv/raRShLyQ5
	 Pef6lbOUHuXmUrIIjaU/x4Rg9Dg8/bEAf8Tlq3+zxK6+MNGDPjDrYxac6vYfTKXRmq
	 8THhWZl7L3GmqSZKa+c9rqctVI3sZFADDfyBmb/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 084/273] btrfs: fix invalid mapping of extent xarray state
Date: Tue, 27 Aug 2024 16:36:48 +0200
Message-ID: <20240827143836.609839425@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 6252690f7e1b173b86a4c27dfc046b351ab423e7 ]

In __extent_writepage_io(), we call btrfs_set_range_writeback() ->
folio_start_writeback(), which clears PAGECACHE_TAG_DIRTY mark from the
mapping xarray if the folio is not dirty. This worked fine before commit
97713b1a2ced ("btrfs: do not clear page dirty inside
extent_write_locked_range()").

After the commit, however, the folio is still dirty at this point, so the
mapping DIRTY tag is not cleared anymore. Then, __extent_writepage_io()
calls btrfs_folio_clear_dirty() to clear the folio's dirty flag. That
results in the page being unlocked with a "strange" state. The page is not
PageDirty, but the mapping tag is set as PAGECACHE_TAG_DIRTY.

This strange state looks like causing a hang with a call trace below when
running fstests generic/091 on a null_blk device. It is waiting for a folio
lock.

While I don't have an exact relation between this hang and the strange
state, fixing the state also fixes the hang. And, that state is worth
fixing anyway.

This commit reorders btrfs_folio_clear_dirty() and
btrfs_set_range_writeback() in __extent_writepage_io(), so that the
PAGECACHE_TAG_DIRTY tag is properly removed from the xarray.

  [464.274] task:fsx             state:D stack:0     pid:3034  tgid:3034  ppid:2853   flags:0x00004002
  [464.286] Call Trace:
  [464.291]  <TASK>
  [464.295]  __schedule+0x10ed/0x6260
  [464.301]  ? __pfx___blk_flush_plug+0x10/0x10
  [464.308]  ? __submit_bio+0x37c/0x450
  [464.314]  ? __pfx___schedule+0x10/0x10
  [464.321]  ? lock_release+0x567/0x790
  [464.327]  ? __pfx_lock_acquire+0x10/0x10
  [464.334]  ? __pfx_lock_release+0x10/0x10
  [464.340]  ? __pfx_lock_acquire+0x10/0x10
  [464.347]  ? __pfx_lock_release+0x10/0x10
  [464.353]  ? do_raw_spin_lock+0x12e/0x270
  [464.360]  schedule+0xdf/0x3b0
  [464.365]  io_schedule+0x8f/0xf0
  [464.371]  folio_wait_bit_common+0x2ca/0x6d0
  [464.378]  ? folio_wait_bit_common+0x1cc/0x6d0
  [464.385]  ? __pfx_folio_wait_bit_common+0x10/0x10
  [464.392]  ? __pfx_filemap_get_folios_tag+0x10/0x10
  [464.400]  ? __pfx_wake_page_function+0x10/0x10
  [464.407]  ? __pfx___might_resched+0x10/0x10
  [464.414]  ? do_raw_spin_unlock+0x58/0x1f0
  [464.420]  extent_write_cache_pages+0xe49/0x1620 [btrfs]
  [464.428]  ? lock_acquire+0x435/0x500
  [464.435]  ? __pfx_extent_write_cache_pages+0x10/0x10 [btrfs]
  [464.443]  ? btrfs_do_write_iter+0x493/0x640 [btrfs]
  [464.451]  ? orc_find.part.0+0x1d4/0x380
  [464.457]  ? __pfx_lock_release+0x10/0x10
  [464.464]  ? __pfx_lock_release+0x10/0x10
  [464.471]  ? btrfs_do_write_iter+0x493/0x640 [btrfs]
  [464.478]  btrfs_writepages+0x1cc/0x460 [btrfs]
  [464.485]  ? __pfx_btrfs_writepages+0x10/0x10 [btrfs]
  [464.493]  ? is_bpf_text_address+0x6e/0x100
  [464.500]  ? kernel_text_address+0x145/0x160
  [464.507]  ? unwind_get_return_address+0x5e/0xa0
  [464.514]  ? arch_stack_walk+0xac/0x100
  [464.521]  do_writepages+0x176/0x780
  [464.527]  ? lock_release+0x567/0x790
  [464.533]  ? __pfx_do_writepages+0x10/0x10
  [464.540]  ? __pfx_lock_acquire+0x10/0x10
  [464.546]  ? __pfx_stack_trace_save+0x10/0x10
  [464.553]  ? do_raw_spin_lock+0x12e/0x270
  [464.560]  ? do_raw_spin_unlock+0x58/0x1f0
  [464.566]  ? _raw_spin_unlock+0x23/0x40
  [464.573]  ? wbc_attach_and_unlock_inode+0x3da/0x7d0
  [464.580]  filemap_fdatawrite_wbc+0x113/0x180
  [464.587]  ? prepare_pages.constprop.0+0x13c/0x5c0 [btrfs]
  [464.596]  __filemap_fdatawrite_range+0xaf/0xf0
  [464.603]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
  [464.611]  ? trace_irq_enable.constprop.0+0xce/0x110
  [464.618]  ? kasan_quarantine_put+0xd7/0x1e0
  [464.625]  btrfs_start_ordered_extent+0x46f/0x570 [btrfs]
  [464.633]  ? __pfx_btrfs_start_ordered_extent+0x10/0x10 [btrfs]
  [464.642]  ? __clear_extent_bit+0x2c0/0x9d0 [btrfs]
  [464.650]  btrfs_lock_and_flush_ordered_range+0xc6/0x180 [btrfs]
  [464.659]  ? __pfx_btrfs_lock_and_flush_ordered_range+0x10/0x10 [btrfs]
  [464.669]  btrfs_read_folio+0x12a/0x1d0 [btrfs]
  [464.676]  ? __pfx_btrfs_read_folio+0x10/0x10 [btrfs]
  [464.684]  ? __pfx_filemap_add_folio+0x10/0x10
  [464.691]  ? __pfx___might_resched+0x10/0x10
  [464.698]  ? __filemap_get_folio+0x1c5/0x450
  [464.705]  prepare_uptodate_page+0x12e/0x4d0 [btrfs]
  [464.713]  prepare_pages.constprop.0+0x13c/0x5c0 [btrfs]
  [464.721]  ? fault_in_iov_iter_readable+0xd2/0x240
  [464.729]  btrfs_buffered_write+0x5bd/0x12f0 [btrfs]
  [464.737]  ? __pfx_btrfs_buffered_write+0x10/0x10 [btrfs]
  [464.745]  ? __pfx_lock_release+0x10/0x10
  [464.752]  ? generic_write_checks+0x275/0x400
  [464.759]  ? down_write+0x118/0x1f0
  [464.765]  ? up_write+0x19b/0x500
  [464.770]  btrfs_direct_write+0x731/0xba0 [btrfs]
  [464.778]  ? __pfx_btrfs_direct_write+0x10/0x10 [btrfs]
  [464.785]  ? __pfx___might_resched+0x10/0x10
  [464.792]  ? lock_acquire+0x435/0x500
  [464.798]  ? lock_acquire+0x435/0x500
  [464.804]  btrfs_do_write_iter+0x494/0x640 [btrfs]
  [464.811]  ? __pfx_btrfs_do_write_iter+0x10/0x10 [btrfs]
  [464.819]  ? __pfx___might_resched+0x10/0x10
  [464.825]  ? rw_verify_area+0x6d/0x590
  [464.831]  vfs_write+0x5d7/0xf50
  [464.837]  ? __might_fault+0x9d/0x120
  [464.843]  ? __pfx_vfs_write+0x10/0x10
  [464.849]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [464.856]  ? lock_release+0x567/0x790
  [464.862]  ksys_write+0xfb/0x1d0
  [464.867]  ? __pfx_ksys_write+0x10/0x10
  [464.873]  ? _raw_spin_unlock+0x23/0x40
  [464.879]  ? btrfs_getattr+0x4af/0x670 [btrfs]
  [464.886]  ? vfs_getattr_nosec+0x79/0x340
  [464.892]  do_syscall_64+0x95/0x180
  [464.898]  ? __do_sys_newfstat+0xde/0xf0
  [464.904]  ? __pfx___do_sys_newfstat+0x10/0x10
  [464.911]  ? trace_irq_enable.constprop.0+0xce/0x110
  [464.918]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [464.925]  ? do_syscall_64+0xa1/0x180
  [464.931]  ? trace_irq_enable.constprop.0+0xce/0x110
  [464.939]  ? trace_irq_enable.constprop.0+0xce/0x110
  [464.946]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [464.953]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [464.960]  ? do_syscall_64+0xa1/0x180
  [464.966]  ? btrfs_file_llseek+0xb1/0xfb0 [btrfs]
  [464.973]  ? trace_irq_enable.constprop.0+0xce/0x110
  [464.980]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [464.987]  ? __pfx_btrfs_file_llseek+0x10/0x10 [btrfs]
  [464.995]  ? trace_irq_enable.constprop.0+0xce/0x110
  [465.002]  ? __pfx_btrfs_file_llseek+0x10/0x10 [btrfs]
  [465.010]  ? do_syscall_64+0xa1/0x180
  [465.016]  ? lock_release+0x567/0x790
  [465.022]  ? __pfx_lock_acquire+0x10/0x10
  [465.028]  ? __pfx_lock_release+0x10/0x10
  [465.034]  ? trace_irq_enable.constprop.0+0xce/0x110
  [465.042]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [465.049]  ? do_syscall_64+0xa1/0x180
  [465.055]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [465.062]  ? do_syscall_64+0xa1/0x180
  [465.068]  ? syscall_exit_to_user_mode+0xac/0x2a0
  [465.075]  ? do_syscall_64+0xa1/0x180
  [465.081]  ? clear_bhb_loop+0x25/0x80
  [465.087]  ? clear_bhb_loop+0x25/0x80
  [465.093]  ? clear_bhb_loop+0x25/0x80
  [465.099]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [465.106] RIP: 0033:0x7f093b8ee784
  [465.111] RSP: 002b:00007ffc29d31b28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  [465.122] RAX: ffffffffffffffda RBX: 0000000000006000 RCX: 00007f093b8ee784
  [465.131] RDX: 000000000001de00 RSI: 00007f093b6ed200 RDI: 0000000000000003
  [465.141] RBP: 000000000001de00 R08: 0000000000006000 R09: 0000000000000000
  [465.150] R10: 0000000000023e00 R11: 0000000000000202 R12: 0000000000006000
  [465.160] R13: 0000000000023e00 R14: 0000000000023e00 R15: 0000000000000001
  [465.170]  </TASK>
  [465.174] INFO: lockdep is turned off.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 97713b1a2ced ("btrfs: do not clear page dirty inside extent_write_locked_range()")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0486b1f911248..3bad7c0be1f10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1420,6 +1420,13 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		free_extent_map(em);
 		em = NULL;
 
+		/*
+		 * Although the PageDirty bit might be cleared before entering
+		 * this function, subpage dirty bit is not cleared.
+		 * So clear subpage dirty bit here so next time we won't submit
+		 * page for range already written to disk.
+		 */
+		btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, iosize);
 		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
@@ -1427,13 +1434,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		/*
-		 * Although the PageDirty bit is cleared before entering this
-		 * function, subpage dirty bit is not cleared.
-		 * So clear subpage dirty bit here so next time we won't submit
-		 * page for range already written to disk.
-		 */
-		btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, iosize);
 
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 				   cur - page_offset(page));
-- 
2.43.0




