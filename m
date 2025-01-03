Return-Path: <stable+bounces-106674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F3A00363
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 05:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED4F162BE9
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42E186E20;
	Fri,  3 Jan 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="DanxVdyG"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454333DF
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735877442; cv=none; b=SoTyJFCgZ6bzPk0sUQr5sxPuDNnMlb8odypBrXo1NFt2PMJbrBdvew7hOp6rA27S58h2wykzGkaTF906XEeg8ukTrxB77RDT7eFhC6pHXHIeLpe8NMHByK+SzhgnuKsxkSw7MpizxrtR6YpazhTbheJJ1UbYC01RVw1lFMgF1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735877442; c=relaxed/simple;
	bh=6y6aJHuj5P7GIBxHqb1AiCp60iqqSjMYgi0ZXO7m5q0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=AswE8XkJkDphK7RNUKTmgIWzEPpDXyx4ly+Wkc5W6JiyhtB+RVdI6B44SPdBrI+g6tgT8IvnzAocCR3MBf3/gY4LquCftl+1eI5nBtVj6BEYIeyRiSIh1ijZGz9KaqT06rJqou9LgjBYek9iUaUMmIhOc50dU1M9hPV74nxNajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=DanxVdyG; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1735877430;
	bh=e3Wa0re1xDQTsbGLFbpvZyCYTpl5tRP3ydwpSsTHf/M=;
	h=From:To:Cc:Subject:Date;
	b=DanxVdyG23nxZDtu62Ke4dmQCIC3Z8FR7+fNOOzUxoXc0SfGLd88JFtOwV0RhLQlf
	 weTb1EG52iF5o5taRA2bx/y7jbtiQnV5eRlef44dgV8UQZH7Rt+LTXi7FHXnT/sX65
	 Hf0oRXIHjejTWMGvaAtruRcXaPuGMa7f4Reqmork=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.82])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 23525437; Fri, 03 Jan 2025 12:08:53 +0800
X-QQ-mid: xmsmtpt1735877333tw7b34276
Message-ID: <tencent_E8A406095A8B9A9E0F174978EB429C011807@qq.com>
X-QQ-XMAILINFO: N/tkE0oBJLbnc7sZvKBgJxX35CSXnu3/SI1iD2W74hoImRqhfKQoY5PYLuKaXL
	 L4iLjLpyVbxWk0LzHTvmyjqTzosCpx/AaheG3flCjmluk3mC1e/Z8bhpPmxKBLG3IiPrBLCo8hsH
	 6oK/02EmgvQxUBiS39qSC6ZCY2hZbsM+oAcOGv4fHCGySXqnUQFfHVF9epu9cLAG5TgghOFfoqNK
	 uz14PfVxfOPCxCG8PhqydGCrL/5Oxd91mo/VETjrUm4tSJJ2dzI/Vqnuw5MC6O5juqCAvluL3u0F
	 O3stTVlUejmbZMNlWkS3fAEBg1e0rzHIVg53k2IMNPeceVchKDJvcfDj729O72Z8g/Vv2vlSx63C
	 iRCOHdUxf7i7apMpu/l3talAGVtmwJdl3TORwpasFDOLZFTLLWZyLS/k6l02r7sG7Pk+L/acWoi4
	 9AvfVDJXDsDhOjlubJJ3rnJbz9a9hj+STOTSWKpEyQ1gXZQOwJYg5Ut83J9zDz0ysIWMpf86LNZ7
	 +Y3+xp1scZmBBXdNarEN/A34JcJo1illTd5Lj2AlHEWU55HkEkbZjZufuLrSMOMHi+Hz15tlNlnW
	 AmLsUR2fMi3TPNatv4mgNDbRfRN6ZKdzD5t/TLks4NuxGgESdFAwdhidzqtzR+P0bpa9m60k8DMZ
	 Ilgz2fYh2ueq3K4DA1ng8gpnPTwTUVbVZeojS5JKx32R6WLh4ugZK3sSHRsKcote/Ui2BA5pkQLD
	 NDaDy+ophpfgWgp5NlKdaFdLFMIVsS+2qUJuJ7hAwskFUMQL7YsrYeES4Z5ravIOyDSRGe4yaWrI
	 jMroPJquulN9EuQqKzGAoTKgpfVl+5h+Ia+KtM3hKjHv4BE1cxgJgdRvy3ovGCOMCJnLHA6hUvXf
	 iYcGw3HaJKa/mqcbjPwkfg+GY1SMZesSQG2oyFgUVtMsCXqfichYo6EAJr3/I4RtaVXd6KnYRoCt
	 i2ao1nnVPWLnrRcKaD18pP8xIe9kiRamfZyuksjTnD7XotSrtvfszMs9ztpeGwtzwsLXx5Jeby4d
	 PYCBGFeU1ZSzQoFYtt
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Alva Lan <alvalan9@foxmail.com>
To: stable@vger.kernel.org,
	johannes.thumshirn@wdc.com
Cc: shinichiro.kawasaki@wdc.com,
	Damien.LeMoal@wdc.com,
	fdmanana@suse.com,
	wqu@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.6.y] btrfs: fix use-after-free in btrfs_encoded_read_endio()
Date: Fri,  3 Jan 2025 12:08:52 +0800
X-OQ-MSGID: <20250103040852.2917-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 05b36b04d74a517d6675bf2f90829ff1ac7e28dc ]

Shinichiro reported the following use-after free that sometimes is
happening in our CI system when running fstests' btrfs/284 on a TCMU
runner device:

  BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
  Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219

  CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kts+ #15
  Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6e/0xa0
   ? lock_release+0x708/0x780
   print_report+0x174/0x505
   ? lock_release+0x708/0x780
   ? __virt_addr_valid+0x224/0x410
   ? lock_release+0x708/0x780
   kasan_report+0xda/0x1b0
   ? lock_release+0x708/0x780
   ? __wake_up+0x44/0x60
   lock_release+0x708/0x780
   ? __pfx_lock_release+0x10/0x10
   ? __pfx_do_raw_spin_lock+0x10/0x10
   ? lock_is_held_type+0x9a/0x110
   _raw_spin_unlock_irqrestore+0x1f/0x60
   __wake_up+0x44/0x60
   btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
   btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
   ? lock_release+0x1b0/0x780
   ? trace_lock_acquire+0x12f/0x1a0
   ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
   ? process_one_work+0x7e3/0x1460
   ? lock_acquire+0x31/0xc0
   ? process_one_work+0x7e3/0x1460
   process_one_work+0x85c/0x1460
   ? __pfx_process_one_work+0x10/0x10
   ? assign_work+0x16c/0x240
   worker_thread+0x5e6/0xfc0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x2c3/0x3a0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x31/0x70
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 3661:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0xaa/0xb0
   btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
   send_extent_data+0xf0f/0x24a0 [btrfs]
   process_extent+0x48a/0x1830 [btrfs]
   changed_cb+0x178b/0x2ea0 [btrfs]
   btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
   _btrfs_ioctl_send+0x117/0x330 [btrfs]
   btrfs_ioctl+0x184a/0x60a0 [btrfs]
   __x64_sys_ioctl+0x12e/0x1a0
   do_syscall_64+0x95/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

  Freed by task 3661:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x70
   __kasan_slab_free+0x4f/0x70
   kfree+0x143/0x490
   btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
   send_extent_data+0xf0f/0x24a0 [btrfs]
   process_extent+0x48a/0x1830 [btrfs]
   changed_cb+0x178b/0x2ea0 [btrfs]
   btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
   _btrfs_ioctl_send+0x117/0x330 [btrfs]
   btrfs_ioctl+0x184a/0x60a0 [btrfs]
   __x64_sys_ioctl+0x12e/0x1a0
   do_syscall_64+0x95/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

  The buggy address belongs to the object at ffff888106a83f00
   which belongs to the cache kmalloc-rnd-07-96 of size 96
  The buggy address is located 24 bytes inside of
   freed 96-byte region [ffff888106a83f00, ffff888106a83f60)

  The buggy address belongs to the physical page:
  page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888106a83800 pfn:0x106a83
  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
  page_type: f5(slab)
  raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 0000000000000004
  raw: ffff888106a83800 0000000080200019 00000001f5000000 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
   ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                              ^
   ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
   ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ==================================================================

Further analyzing the trace and the crash dump's vmcore file shows that
the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
the wait_queue that is in the private data passed to the end_io handler.

Commit 4ff47df40447 ("btrfs: move priv off stack in
btrfs_encoded_read_regular_fill_pages()") moved 'struct
btrfs_encoded_read_private' off the stack.

Before that commit one can see a corruption of the private data when
analyzing the vmcore after a crash:

*(struct btrfs_encoded_read_private *)0xffff88815626eec8 = {
	.wait = (wait_queue_head_t){
		.lock = (spinlock_t){
			.rlock = (struct raw_spinlock){
				.raw_lock = (arch_spinlock_t){
					.val = (atomic_t){
						.counter = (int)-2005885696,
					},
					.locked = (u8)0,
					.pending = (u8)157,
					.locked_pending = (u16)40192,
					.tail = (u16)34928,
				},
				.magic = (unsigned int)536325682,
				.owner_cpu = (unsigned int)29,
				.owner = (void *)__SCT__tp_func_btrfs_transaction_commit+0x0 = 0x0,
				.dep_map = (struct lockdep_map){
					.key = (struct lock_class_key *)0xffff8881575a3b6c,
					.class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
					.name = (const char *)0xffff88815626f100 = "",
					.wait_type_outer = (u8)37,
					.wait_type_inner = (u8)178,
					.lock_type = (u8)154,
				},
			},
			.__padding = (u8 [24]){ 0, 157, 112, 136, 50, 174, 247, 31, 29 },
			.dep_map = (struct lockdep_map){
				.key = (struct lock_class_key *)0xffff8881575a3b6c,
				.class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
				.name = (const char *)0xffff88815626f100 = "",
				.wait_type_outer = (u8)37,
				.wait_type_inner = (u8)178,
				.lock_type = (u8)154,
			},
		},
		.head = (struct list_head){
			.next = (struct list_head *)0x112cca,
			.prev = (struct list_head *)0x47,
		},
	},
	.pending = (atomic_t){
		.counter = (int)-1491499288,
	},
	.status = (blk_status_t)130,
}

Here we can see several indicators of in-memory data corruption, e.g. the
large negative atomic values of ->pending or
->wait->lock->rlock->raw_lock->val, as well as the bogus spinlock magic
0x1ff7ae32 (decimal 536325682 above) instead of 0xdead4ead or the bogus
pointer values for ->wait->head.

To fix this, change atomic_dec_return() to atomic_dec_and_test() to fix the
corruption, as atomic_dec_return() is defined as two instructions on
x86_64, whereas atomic_dec_and_test() is defined as a single atomic
operation. This can lead to a situation where counter value is already
decremented but the if statement in btrfs_encoded_read_endio() is not
completely processed, i.e. the 0 test has not completed. If another thread
continues executing btrfs_encoded_read_regular_fill_pages() the
atomic_dec_return() there can see an already updated ->pending counter and
continues by freeing the private data. Continuing in the endio handler the
test for 0 succeeds and the wait_queue is woken up, resulting in a
use-after-free.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6767f728c07..eb9319d856f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9972,7 +9972,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (!atomic_dec_return(&priv->pending))
+	if (atomic_dec_and_test(&priv->pending))
 		wake_up(&priv->wait);
 	bio_put(&bbio->bio);
 }
-- 
2.43.0


