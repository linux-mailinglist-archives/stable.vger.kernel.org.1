Return-Path: <stable+bounces-133348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B2A92542
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5570B8A48C8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7D25A64D;
	Thu, 17 Apr 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lL9ocEWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCA2566DE;
	Thu, 17 Apr 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912803; cv=none; b=uU+es805OGHZU4UCcl1mjoaiBxE+iSw+ALAekT/jWZC7lZKfy4PDeM8jltxJEcoyBB7ZsMFXXq94nf5j96b3WpVpd32wVQyzMFsSMa5s57UunoBLtsRhOAdVickA/etInQrufPV1plJ1DexPeCJTQXY1VfZz/lStF5bycVraDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912803; c=relaxed/simple;
	bh=rUhSCOzTHbdIyapa3s+ipaCAVysGUs38vBmesP8ZXSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTGtLDQ2II/9fdys9EYGY51sG1KHqj4KBFclMmqXdS8spydGfCbjR9LjBcLLxcigJ2M1c7WbUMIjd0Y/WoZ0wgIuMJHSCqchSrzE9viiQxNSVXevHnJr03vwUtm9E4iOFS4jLevA/FfhBzp1rkqB3+RteIJLjnDwkdf/5D5xKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lL9ocEWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C9C4CEE4;
	Thu, 17 Apr 2025 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912803;
	bh=rUhSCOzTHbdIyapa3s+ipaCAVysGUs38vBmesP8ZXSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lL9ocEWrHyvi+cevd7lSQkmOlghp6+DnbQlF2Ckggx5zQmgMw9gqz5fnP0cCoQtw9
	 ibsBaqt8wwMl9djVjW2w0wrpsuv2FQU6wSemrBW1Q1dr99M4UII6gIRQLG/N6EhfTv
	 2PArSv5NqpHu6e8A2KK+3ubCYfkdIaG3k5H1NtsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Bhupesh <bhupesh@igalia.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 128/449] ext4: ignore xattrs past end
Date: Thu, 17 Apr 2025 19:46:56 +0200
Message-ID: <20250417175123.117806049@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bhupesh <bhupesh@igalia.com>

[ Upstream commit c8e008b60492cf6fd31ef127aea6d02fd3d314cd ]

Once inside 'ext4_xattr_inode_dec_ref_all' we should
ignore xattrs entries past the 'end' entry.

This fixes the following KASAN reported issue:

==================================================================
BUG: KASAN: slab-use-after-free in ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
Read of size 4 at addr ffff888012c120c4 by task repro/2065

CPU: 1 UID: 0 PID: 2065 Comm: repro Not tainted 6.13.0-rc2+ #11
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1fd/0x300
 ? tcp_gro_dev_warn+0x260/0x260
 ? _printk+0xc0/0x100
 ? read_lock_is_recursive+0x10/0x10
 ? irq_work_queue+0x72/0xf0
 ? __virt_addr_valid+0x17b/0x4b0
 print_address_description+0x78/0x390
 print_report+0x107/0x1f0
 ? __virt_addr_valid+0x17b/0x4b0
 ? __virt_addr_valid+0x3ff/0x4b0
 ? __phys_addr+0xb5/0x160
 ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 kasan_report+0xcc/0x100
 ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 ? ext4_xattr_delete_inode+0xd30/0xd30
 ? __ext4_journal_ensure_credits+0x5f0/0x5f0
 ? __ext4_journal_ensure_credits+0x2b/0x5f0
 ? inode_update_timestamps+0x410/0x410
 ext4_xattr_delete_inode+0xb64/0xd30
 ? ext4_truncate+0xb70/0xdc0
 ? ext4_expand_extra_isize_ea+0x1d20/0x1d20
 ? __ext4_mark_inode_dirty+0x670/0x670
 ? ext4_journal_check_start+0x16f/0x240
 ? ext4_inode_is_fast_symlink+0x2f2/0x3a0
 ext4_evict_inode+0xc8c/0xff0
 ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
 ? do_raw_spin_unlock+0x53/0x8a0
 ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
 evict+0x4ac/0x950
 ? proc_nr_inodes+0x310/0x310
 ? trace_ext4_drop_inode+0xa2/0x220
 ? _raw_spin_unlock+0x1a/0x30
 ? iput+0x4cb/0x7e0
 do_unlinkat+0x495/0x7c0
 ? try_break_deleg+0x120/0x120
 ? 0xffffffff81000000
 ? __check_object_size+0x15a/0x210
 ? strncpy_from_user+0x13e/0x250
 ? getname_flags+0x1dc/0x530
 __x64_sys_unlinkat+0xc8/0xf0
 do_syscall_64+0x65/0x110
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x434ffd
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 8
RSP: 002b:00007ffc50fa7b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007ffc50fa7e18 RCX: 0000000000434ffd
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007ffc50fa7be0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc50fa7e08 R14: 00000000004bbf30 R15: 0000000000000001
 </TASK>

The buggy address belongs to the object at ffff888012c12000
 which belongs to the cache filp of size 360
The buggy address is located 196 bytes inside of
 freed 360-byte region [ffff888012c12000, ffff888012c12168)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c12
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x40(head|node=0|zone=0)
page_type: f5(slab)
raw: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 0000000000000001 ffffea00004b0481 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888012c11f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888012c12000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888012c12080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888012c12100: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff888012c12180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Reported-by: syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b244bda78289b00204ed
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Bhupesh <bhupesh@igalia.com>
Link: https://patch.msgid.link/20250128082751.124948-2-bhupesh@igalia.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index a10fb8a9d02dc..8ced9beba2f7e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1159,15 +1159,24 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
+	struct ext4_iloc iloc;
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
 	int credits;
+	void *end;
+
+	if (block_csum)
+		end = (void *)bh->b_data + bh->b_size;
+	else {
+		ext4_get_inode_loc(parent, &iloc);
+		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
+	}
 
 	/* One credit for dec ref on ea_inode, one for orphan list addition, */
 	credits = 2 + extra_credits;
 
-	for (entry = first; !IS_LAST_ENTRY(entry);
+	for (entry = first; (void *)entry < end && !IS_LAST_ENTRY(entry);
 	     entry = EXT4_XATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
-- 
2.39.5




