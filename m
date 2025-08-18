Return-Path: <stable+bounces-169991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC1B29F96
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C17D18A6DAA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23127318136;
	Mon, 18 Aug 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGxKZ/Os"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4961318133
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514217; cv=none; b=fZt7hwrLV9KKLAlXFAfuVpZTe98Uc+Yyl6NhqtfyLEj+CkjA9Kpe0eg2VPqM9sjRKjWUIUTWfZi+DbFAum5KAv45gmD19TJqVNDK1muoiQ1JqSPLG8I7FLLe/GYX54g41HcjvDVAZvqDdZfa5XWWEIJzreGTD35I6YiUTzmLaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514217; c=relaxed/simple;
	bh=vaOgbeGkUB8Tg3uLx5KkYqYvtjIY+fw/n7ZXgiYVnDk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c2C+D9UnwG2rplRCqXRktboO/0F5PWfQblJDDUrvl7k8HzE0tz2rAtJ7aE4GXwKNQeciPdY1Ka3/x1bJQdJBKucfL4/UXb7540oFR45zMrYKRqxjYNFCqdOgSS/uuXHmqHqCho9sV2NWhilnAaoISZXmvfYpdCZVsvDjo0Bmyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGxKZ/Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EA9C4CEF1;
	Mon, 18 Aug 2025 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514217;
	bh=vaOgbeGkUB8Tg3uLx5KkYqYvtjIY+fw/n7ZXgiYVnDk=;
	h=Subject:To:Cc:From:Date:From;
	b=zGxKZ/OsW29H3dMM+b6Xoo98ZgHZDR1Q6u97VzVT5017fQr5Hl37YoNdj8KgJXXhi
	 nK+HVyCDf+8k7WfgUBBsM2AMzJ/cN7w7C8D6IYFKlmJ5Fh98GO0elSoGmCGxyEPPuj
	 D59bqw+Yrj8FIn82Z5nRuFEUgyXOxuOuRC67HBTY=
Subject: FAILED: patch "[PATCH] btrfs: fix subpage deadlock in" failed to apply to 6.16-stable tree
To: loemra.dev@gmail.com,boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:50:14 +0200
Message-ID: <2025081814-monsoon-supermom-44bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x ad580dfa388fabb52af033e3f8cc5d04be985e54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081814-monsoon-supermom-44bb@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad580dfa388fabb52af033e3f8cc5d04be985e54 Mon Sep 17 00:00:00 2001
From: Leo Martins <loemra.dev@gmail.com>
Date: Mon, 21 Jul 2025 10:49:16 -0700
Subject: [PATCH] btrfs: fix subpage deadlock in
 try_release_subpage_extent_buffer()

There is a potential deadlock that can happen in
try_release_subpage_extent_buffer() because the irq-safe xarray spin
lock fs_info->buffer_tree is being acquired before the irq-unsafe
eb->refs_lock.

This leads to the potential race:
// T1 (random eb->refs user)                  // T2 (release folio)

spin_lock(&eb->refs_lock);
// interrupt
end_bbio_meta_write()
  btrfs_meta_folio_clear_writeback()
                                              btree_release_folio()
                                                folio_test_writeback() //false
                                                try_release_extent_buffer()
                                                  try_release_subpage_extent_buffer()
                                                    xa_lock_irq(&fs_info->buffer_tree)
                                                    spin_lock(&eb->refs_lock); // blocked; held by T1
  buffer_tree_clear_mark()
    xas_lock_irqsave() // blocked; held by T2

I believe that the spin lock can safely be replaced by an rcu_read_lock.
The xa_for_each loop does not need the spin lock as it's already
internally protected by the rcu_read_lock. The extent buffer is also
protected by the rcu_read_lock so it won't be freed before we take the
eb->refs_lock and check the ref count.

The rcu_read_lock is taken and released every iteration, just like the
spin lock, which means we're not protected against concurrent
insertions into the xarray. This is fine because we rely on
folio->private to detect if there are any ebs remaining in the folio.

There is already some precedent for this with find_extent_buffer_nolock,
which loads an extent buffer from the xarray with only rcu_read_lock.

lockdep warning:

            =====================================================
            WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
            6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G E    N
            -----------------------------------------------------
            kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
            ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560

and this task is already holding:
            ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
            which would create a new lock dependency:
             (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}

but this new dependency connects a HARDIRQ-irq-safe lock:
             (&buffer_xa_class){-.-.}-{3:3}

... which became HARDIRQ-irq-safe at:
              lock_acquire+0x178/0x358
              _raw_spin_lock_irqsave+0x60/0x88
              buffer_tree_clear_mark+0xc4/0x160
              end_bbio_meta_write+0x238/0x398
              btrfs_bio_end_io+0x1f8/0x330
              btrfs_orig_write_end_io+0x1c4/0x2c0
              bio_endio+0x63c/0x678
              blk_update_request+0x1c4/0xa00
              blk_mq_end_request+0x54/0x88
              virtblk_request_done+0x124/0x1d0
              blk_mq_complete_request+0x84/0xa0
              virtblk_done+0x130/0x238
              vring_interrupt+0x130/0x288
              __handle_irq_event_percpu+0x1e8/0x708
              handle_irq_event+0x98/0x1b0
              handle_fasteoi_irq+0x264/0x7c0
              generic_handle_domain_irq+0xa4/0x108
              gic_handle_irq+0x7c/0x1a0
              do_interrupt_handler+0xe4/0x148
              el1_interrupt+0x30/0x50
              el1h_64_irq_handler+0x14/0x20
              el1h_64_irq+0x6c/0x70
              _raw_spin_unlock_irq+0x38/0x70
              __run_timer_base+0xdc/0x5e0
              run_timer_softirq+0xa0/0x138
              handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
              ____do_softirq.llvm.17674514681856217165+0x18/0x28
              call_on_irq_stack+0x24/0x30
              __irq_exit_rcu+0x164/0x430
              irq_exit_rcu+0x18/0x88
              el1_interrupt+0x34/0x50
              el1h_64_irq_handler+0x14/0x20
              el1h_64_irq+0x6c/0x70
              arch_local_irq_enable+0x4/0x8
              do_idle+0x1a0/0x3b8
              cpu_startup_entry+0x60/0x80
              rest_init+0x204/0x228
              start_kernel+0x394/0x3f0
              __primary_switched+0x8c/0x8958

to a HARDIRQ-irq-unsafe lock:
             (&eb->refs_lock){+.+.}-{3:3}

... which became HARDIRQ-irq-unsafe at:
            ...
              lock_acquire+0x178/0x358
              _raw_spin_lock+0x4c/0x68
              free_extent_buffer_stale+0x2c/0x170
              btrfs_read_sys_array+0x1b0/0x338
              open_ctree+0xeb0/0x1df8
              btrfs_get_tree+0xb60/0x1110
              vfs_get_tree+0x8c/0x250
              fc_mount+0x20/0x98
              btrfs_get_tree+0x4a4/0x1110
              vfs_get_tree+0x8c/0x250
              do_new_mount+0x1e0/0x6c0
              path_mount+0x4ec/0xa58
              __arm64_sys_mount+0x370/0x490
              invoke_syscall+0x6c/0x208
              el0_svc_common+0x14c/0x1b8
              do_el0_svc+0x4c/0x60
              el0_svc+0x4c/0x160
              el0t_64_sync_handler+0x70/0x100
              el0t_64_sync+0x168/0x170

other info that might help us debug this:
             Possible interrupt unsafe locking scenario:
                   CPU0                    CPU1
                   ----                    ----
              lock(&eb->refs_lock);
                                           local_irq_disable();
                                           lock(&buffer_xa_class);
                                           lock(&eb->refs_lock);
              <Interrupt>
                lock(&buffer_xa_class);

  *** DEADLOCK ***
            2 locks held by kswapd0/66:
             #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
             #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560

Link: https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A
Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
CC: stable@vger.kernel.org # 6.16+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 835b0deef9bb..f23d75986947 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4331,15 +4331,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
 	int ret;
 
-	xa_lock_irq(&fs_info->buffer_tree);
+	rcu_read_lock();
 	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
 		/*
 		 * The same as try_release_extent_buffer(), to ensure the eb
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
+		rcu_read_unlock();
+
 		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
+			rcu_read_lock();
 			continue;
 		}
 
@@ -4358,11 +4361,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * check the folio private at the end.  And
 		 * release_extent_buffer() will release the refs_lock.
 		 */
-		xa_unlock_irq(&fs_info->buffer_tree);
 		release_extent_buffer(eb);
-		xa_lock_irq(&fs_info->buffer_tree);
+		rcu_read_lock();
 	}
-	xa_unlock_irq(&fs_info->buffer_tree);
+	rcu_read_unlock();
 
 	/*
 	 * Finally to check if we have cleared folio private, as if we have
@@ -4375,7 +4377,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		ret = 0;
 	spin_unlock(&folio->mapping->i_private_lock);
 	return ret;
-
 }
 
 int try_release_extent_buffer(struct folio *folio)


