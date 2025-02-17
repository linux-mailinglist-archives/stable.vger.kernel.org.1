Return-Path: <stable+bounces-115606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF8A34513
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D8D188C5BB
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C92222CA;
	Thu, 13 Feb 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkzL0BmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415926B095;
	Thu, 13 Feb 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458615; cv=none; b=I4+/Y27spU/loERA7hXPd8UswD0WJZUPSf4ofHW7Vhp4JO8TyHZCm2YXvIq6UUqb7hOUiSERFUxmiLkNLGZSxbvBqXcfgTsL/+ha+7DrNfqoCArynkTW2nDX8bo7kZHqto4ZnYggzoaeOVYILlAoW04/HOhpBqaNBGeUUsUj0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458615; c=relaxed/simple;
	bh=P5O5O/yBI5iJZ9iKR43ovrmAdNNmTqmbxhLw8syYz4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGUBfxMzr6d8JCBj2qbYRGiH94429F4QvURvQUe9SiEo1Dji6RcvyTnsMKxt6KwKsH8nN0M+98TEivarJN8/aMAov62NT39AsSCL0o7HRXHjNHjt6lPNGXnanz9VnLWQX/JkCOeUrvZdcdaf5xAdk5kuHbAB32xcktl8c3cubzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nkzL0BmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C33C4CED1;
	Thu, 13 Feb 2025 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458615;
	bh=P5O5O/yBI5iJZ9iKR43ovrmAdNNmTqmbxhLw8syYz4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkzL0BmF1kUbNJ0SJpU7SFNdPjW7tV0kA3lA57D39ORdnl7H0yGzlD5E0THG+Xl1R
	 u17Gqk+nZUOVSferYwUc2Ppnfs95xJdco1Cjpo26maf2Kb/5wMD+fbm7fAcpdG31HP
	 cwXxEFTNwOeFWUd0C5OljOVnzthVsjNh7juKry5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 003/443] btrfs: fix assertion failure when splitting ordered extent after transaction abort
Date: Thu, 13 Feb 2025 15:22:48 +0100
Message-ID: <20250213142440.748197324@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 0d85f5c2dd91df6b5da454406756f463ba923b69 ]

If while we are doing a direct IO write a transaction abort happens, we
mark all existing ordered extents with the BTRFS_ORDERED_IOERR flag (done
at btrfs_destroy_ordered_extents()), and then after that if we enter
btrfs_split_ordered_extent() and the ordered extent has bytes left
(meaning we have a bio that doesn't cover the whole ordered extent, see
details at btrfs_extract_ordered_extent()), we will fail on the following
assertion at btrfs_split_ordered_extent():

   ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));

because the BTRFS_ORDERED_IOERR flag is set and the definition of
BTRFS_ORDERED_TYPE_FLAGS is just the union of all flags that identify the
type of write (regular, nocow, prealloc, compressed, direct IO, encoded).

Fix this by returning an error from btrfs_extract_ordered_extent() if we
find the BTRFS_ORDERED_IOERR flag in the ordered extent. The error will
be the error that resulted in the transaction abort or -EIO if no
transaction abort happened.

This was recently reported by syzbot with the following trace:

   FAULT_INJECTION: forcing a failure.
   name failslab, interval 1, probability 0, space 0, times 1
   CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller #0
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   Call Trace:
    <TASK>
    __dump_stack lib/dump_stack.c:94 [inline]
    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
    fail_dump lib/fault-inject.c:53 [inline]
    should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
    should_failslab+0xac/0x100 mm/failslab.c:46
    slab_pre_alloc_hook mm/slub.c:4072 [inline]
    slab_alloc_node mm/slub.c:4148 [inline]
    __do_kmalloc_node mm/slub.c:4297 [inline]
    __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
    kmalloc_noprof include/linux/slab.h:905 [inline]
    kzalloc_noprof include/linux/slab.h:1037 [inline]
    btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.c:5742
    reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
    check_system_chunk fs/btrfs/block-group.c:4319 [inline]
    do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
    btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
    find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inline]
    find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
    btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
    btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
    btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:321
    btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
    iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
    __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
    btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
    btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
    btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
    do_iter_readv_writev+0x600/0x880
    vfs_writev+0x376/0xba0 fs/read_write.c:1050
    do_pwritev fs/read_write.c:1146 [inline]
    __do_sys_pwritev2 fs/read_write.c:1204 [inline]
    __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f1281f85d29
   RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
   RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
   RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
   RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
   R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
   R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
    </TASK>
   BTRFS error (device loop0 state A): Transaction aborted (error -12)
   BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chunk_item:5745: errno=-12 Out of memory
   BTRFS info (device loop0 state EA): forced readonly
   assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/btrfs/ordered-data.c:1234
   ------------[ cut here ]------------
   kernel BUG at fs/btrfs/ordered-data.c:1234!
   Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
   CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller #0
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-data.c:1234
   RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
   RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
   RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
   RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
   R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
   R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
   FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
    btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
    iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
    iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
    __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
    btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
    btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
    btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
    do_iter_readv_writev+0x600/0x880
    vfs_writev+0x376/0xba0 fs/read_write.c:1050
    do_pwritev fs/read_write.c:1146 [inline]
    __do_sys_pwritev2 fs/read_write.c:1204 [inline]
    __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f1281f85d29
   RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
   RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
   RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
   RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
   R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
   R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
    </TASK>
   Modules linked in:
   ---[ end trace 0000000000000000 ]---
   RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-data.c:1234
   RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
   RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
   RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
   RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
   R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
   R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
   FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

In this case the transaction abort was due to (an injected) memory
allocation failure when attempting to allocate a new chunk.

Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6777f2dd.050a0220.178762.0045.GAE@google.com/
Fixes: 52b1fdca23ac ("btrfs: handle completed ordered extents in btrfs_split_ordered_extent")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ordered-data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 30eceaf829a7e..4aca7475fd82c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1229,6 +1229,18 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	 */
 	if (WARN_ON_ONCE(len >= ordered->num_bytes))
 		return ERR_PTR(-EINVAL);
+	/*
+	 * If our ordered extent had an error there's no point in continuing.
+	 * The error may have come from a transaction abort done either by this
+	 * task or some other concurrent task, and the transaction abort path
+	 * iterates over all existing ordered extents and sets the flag
+	 * BTRFS_ORDERED_IOERR on them.
+	 */
+	if (unlikely(flags & (1U << BTRFS_ORDERED_IOERR))) {
+		const int fs_error = BTRFS_FS_ERROR(fs_info);
+
+		return fs_error ? ERR_PTR(fs_error) : ERR_PTR(-EIO);
+	}
 	/* We cannot split partially completed ordered extents. */
 	if (ordered->bytes_left) {
 		ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
-- 
2.39.5




