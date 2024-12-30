Return-Path: <stable+bounces-106270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24569FE3CD
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7981018827C5
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71C1A0BD1;
	Mon, 30 Dec 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ErTK97dc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9401A0BC9
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547989; cv=none; b=Nhc9SS4LQ6RBZDL2GDOhMWkXH9otBuP2FaaMWXyNbbxR4GWWoXYQEdrDQ6Z0OP0172oldDfKlVeY9haE8dK1PDWrzBXeuhJeqiNgxbU7pmFNxKRrN0DE0kfZOTBsFue5SYgiY9UP485zrc7qy2gAFfQ/+0n6AjE1QJbgDyy7S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547989; c=relaxed/simple;
	bh=hxwYTYB92ggVdjNI3KeCPvrW7Ds1iOKhsZUiu68w+1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I1S/DmwiUQQnFU6h8RPwVtZGX/WLQfG7mNZ9jEihhjrsmk1N30cljuBnHy4UOKoMd9vt2WMo3swrfUk9HNaJN/6e13q+KYJwnRr5ERuEvIItKvRs2KDP5leXiTYAruBlQSyhsnDEgOEAdi+QWEnwOCRJc4oqobDIu3pKIWfFdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ErTK97dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BE7C4CED0;
	Mon, 30 Dec 2024 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547989;
	bh=hxwYTYB92ggVdjNI3KeCPvrW7Ds1iOKhsZUiu68w+1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=ErTK97dce/zpTPx5Gmpz2KZteRY9r7ItUeqCOoFMHKhyuLzH/nLAwl7NcaouDgn8n
	 /EGOqM2lcQM49geGIKTqBpPPCPodbYtAqmittdYgdpYJwRQaAP59uLf+d5qN5TkuVw
	 08NrSL+q38LswHh3+9jhBzOh8M3lSjZGzItpWSP8=
Subject: FAILED: patch "[PATCH] btrfs: check folio mapping after unlock in" failed to apply to 6.1-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:39:46 +0100
Message-ID: <2024123045-parka-sublet-a95d@gregkh>
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
git cherry-pick -x 3e74859ee35edc33a022c3f3971df066ea0ca6b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123045-parka-sublet-a95d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e74859ee35edc33a022c3f3971df066ea0ca6b9 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 13 Dec 2024 12:22:32 -0800
Subject: [PATCH] btrfs: check folio mapping after unlock in
 relocate_one_folio()

When we call btrfs_read_folio() to bring a folio uptodate, we unlock the
folio. The result of that is that a different thread can modify the
mapping (like remove it with invalidate) before we call folio_lock().
This results in an invalid page and we need to try again.

In particular, if we are relocating concurrently with aborting a
transaction, this can result in a crash like the following:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 76 PID: 1411631 Comm: kworker/u322:5
  Workqueue: events_unbound btrfs_reclaim_bgs_work
  RIP: 0010:set_page_extent_mapped+0x20/0xb0
  RSP: 0018:ffffc900516a7be8 EFLAGS: 00010246
  RAX: ffffea009e851d08 RBX: ffffea009e0b1880 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffc900516a7b90 RDI: ffffea009e0b1880
  RBP: 0000000003573000 R08: 0000000000000001 R09: ffff88c07fd2f3f0
  R10: 0000000000000000 R11: 0000194754b575be R12: 0000000003572000
  R13: 0000000003572fff R14: 0000000000100cca R15: 0000000005582fff
  FS:  0000000000000000(0000) GS:ffff88c07fd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000407d00f002 CR4: 00000000007706f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
  <TASK>
  ? __die+0x78/0xc0
  ? page_fault_oops+0x2a8/0x3a0
  ? __switch_to+0x133/0x530
  ? wq_worker_running+0xa/0x40
  ? exc_page_fault+0x63/0x130
  ? asm_exc_page_fault+0x22/0x30
  ? set_page_extent_mapped+0x20/0xb0
  relocate_file_extent_cluster+0x1a7/0x940
  relocate_data_extent+0xaf/0x120
  relocate_block_group+0x20f/0x480
  btrfs_relocate_block_group+0x152/0x320
  btrfs_relocate_chunk+0x3d/0x120
  btrfs_reclaim_bgs_work+0x2ae/0x4e0
  process_scheduled_works+0x184/0x370
  worker_thread+0xc6/0x3e0
  ? blk_add_timer+0xb0/0xb0
  kthread+0xae/0xe0
  ? flush_tlb_kernel_range+0x90/0x90
  ret_from_fork+0x2f/0x40
  ? flush_tlb_kernel_range+0x90/0x90
  ret_from_fork_asm+0x11/0x20
  </TASK>

This occurs because cleanup_one_transaction() calls
destroy_delalloc_inodes() which calls invalidate_inode_pages2() which
takes the folio_lock before setting mapping to NULL. We fail to check
this, and subsequently call set_extent_mapping(), which assumes that
mapping != NULL (in fact it asserts that in debug mode)

Note that the "fixes" patch here is not the one that introduced the
race (the very first iteration of this code from 2009) but a more recent
change that made this particular crash happen in practice.

Fixes: e7f1326cc24e ("btrfs: set page extent mapped after read_folio in relocate_one_page")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf267bdfa8f8..db8b42f674b7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2902,6 +2902,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 	const bool use_rst = btrfs_need_stripe_tree_update(fs_info, rc->block_group->flags);
 
 	ASSERT(index <= last_index);
+again:
 	folio = filemap_lock_folio(inode->i_mapping, index);
 	if (IS_ERR(folio)) {
 
@@ -2937,6 +2938,11 @@ static int relocate_one_folio(struct reloc_control *rc,
 			ret = -EIO;
 			goto release_folio;
 		}
+		if (folio->mapping != inode->i_mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto again;
+		}
 	}
 
 	/*


