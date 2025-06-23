Return-Path: <stable+bounces-155488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB7AE4242
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC42188B475
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921524BBE4;
	Mon, 23 Jun 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="legY+h6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CF13A265;
	Mon, 23 Jun 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684560; cv=none; b=iAGo2La2xb0vfXYdQN6XJXH9FKOKSKlGp2fUw6hwyktcsIJIAbYbmDb2nJRJio7ph8nvRhb6fn+fBBRC3vNGufC3skuPZh3+TtcwCjr4AV1AbqYrEu+z5MdgPGEE602vacrqqdm7Um1O7J+yYpts2j4GEZlD+F9mE1RQp+Xls/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684560; c=relaxed/simple;
	bh=JQqZW7Nf71LRByFgj3nHDaVRI1pJGQ3NShtPgOpJ3ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeMGHsr+CTR1FE0p8RvhaobOYAjwwiKobl4a1xvkleem7g1NwwwkirxHQDfjfwEMqhX9btrkjjNnnenCFV3hrt6h5H19f3in1yX+7SA6toNWJiynT1Ud5DLPUpTRvMUPeCONG8dxYlM9UPubaMYLay9JCQV8AJ+RYHbdVJwT7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=legY+h6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E830C4CEEA;
	Mon, 23 Jun 2025 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684560;
	bh=JQqZW7Nf71LRByFgj3nHDaVRI1pJGQ3NShtPgOpJ3ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=legY+h6xYny7TW/ur7xR7qpRdekLrfL72BDgXQfHcb11BooAhGXXKFSqS0NLcce0M
	 u7SdJ0I8i9s8dFMjvlIQYOZmASYk9iQh1Vbj2T/6nqSfI9+tHSZxLBAlKaQaASof3+
	 YA/GfKm2oN3f4AheQcWhpoRs45MnVrqPB9gHmgLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jan Kara <jack@suse.cz>,
	Andreas Dilger <adilger@dilger.ca>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.15 112/592] ext4: inline: fix len overflow in ext4_prepare_inline_data
Date: Mon, 23 Jun 2025 15:01:10 +0200
Message-ID: <20250623130702.940828698@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit 227cb4ca5a6502164f850d22aec3104d7888b270 upstream.

When running the following code on an ext4 filesystem with inline_data
feature enabled, it will lead to the bug below.

        fd = open("file1", O_RDWR | O_CREAT | O_TRUNC, 0666);
        ftruncate(fd, 30);
        pwrite(fd, "a", 1, (1UL << 40) + 5UL);

That happens because write_begin will succeed as when
ext4_generic_write_inline_data calls ext4_prepare_inline_data, pos + len
will be truncated, leading to ext4_prepare_inline_data parameter to be 6
instead of 0x10000000006.

Then, later when write_end is called, we hit:

        BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

at ext4_write_inline_data.

Fix it by using a loff_t type for the len parameter in
ext4_prepare_inline_data instead of an unsigned int.

[   44.545164] ------------[ cut here ]------------
[   44.545530] kernel BUG at fs/ext4/inline.c:240!
[   44.545834] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   44.546172] CPU: 3 UID: 0 PID: 343 Comm: test Not tainted 6.15.0-rc2-00003-g9080916f4863 #45 PREEMPT(full)  112853fcebfdb93254270a7959841d2c6aa2c8bb
[   44.546523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   44.546523] RIP: 0010:ext4_write_inline_data+0xfe/0x100
[   44.546523] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
[   44.546523] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
[   44.546523] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
[   44.546523] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
[   44.546523] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[   44.546523] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
[   44.546523] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
[   44.546523] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
[   44.546523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.546523] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
[   44.546523] PKRU: 55555554
[   44.546523] Call Trace:
[   44.546523]  <TASK>
[   44.546523]  ext4_write_inline_data_end+0x126/0x2d0
[   44.546523]  generic_perform_write+0x17e/0x270
[   44.546523]  ext4_buffered_write_iter+0xc8/0x170
[   44.546523]  vfs_write+0x2be/0x3e0
[   44.546523]  __x64_sys_pwrite64+0x6d/0xc0
[   44.546523]  do_syscall_64+0x6a/0xf0
[   44.546523]  ? __wake_up+0x89/0xb0
[   44.546523]  ? xas_find+0x72/0x1c0
[   44.546523]  ? next_uptodate_folio+0x317/0x330
[   44.546523]  ? set_pte_range+0x1a6/0x270
[   44.546523]  ? filemap_map_pages+0x6ee/0x840
[   44.546523]  ? ext4_setattr+0x2fa/0x750
[   44.546523]  ? do_pte_missing+0x128/0xf70
[   44.546523]  ? security_inode_post_setattr+0x3e/0xd0
[   44.546523]  ? ___pte_offset_map+0x19/0x100
[   44.546523]  ? handle_mm_fault+0x721/0xa10
[   44.546523]  ? do_user_addr_fault+0x197/0x730
[   44.546523]  ? do_syscall_64+0x76/0xf0
[   44.546523]  ? arch_exit_to_user_mode_prepare+0x1e/0x60
[   44.546523]  ? irqentry_exit_to_user_mode+0x79/0x90
[   44.546523]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[   44.546523] RIP: 0033:0x7f42999c6687
[   44.546523] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   44.546523] RSP: 002b:00007ffeae4a7930 EFLAGS: 00000202 ORIG_RAX: 0000000000000012
[   44.546523] RAX: ffffffffffffffda RBX: 00007f4299934740 RCX: 00007f42999c6687
[   44.546523] RDX: 0000000000000001 RSI: 000055ea6149200f RDI: 0000000000000003
[   44.546523] RBP: 00007ffeae4a79a0 R08: 0000000000000000 R09: 0000000000000000
[   44.546523] R10: 0000010000000005 R11: 0000000000000202 R12: 0000000000000000
[   44.546523] R13: 00007ffeae4a7ac8 R14: 00007f4299b86000 R15: 000055ea61493dd8
[   44.546523]  </TASK>
[   44.546523] Modules linked in:
[   44.568501] ---[ end trace 0000000000000000 ]---
[   44.568889] RIP: 0010:ext4_write_inline_data+0xfe/0x100
[   44.569328] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
[   44.570931] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
[   44.571356] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
[   44.571959] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
[   44.572571] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[   44.573148] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
[   44.573748] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
[   44.574335] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
[   44.575027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.575520] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
[   44.576112] PKRU: 55555554
[   44.576338] Kernel panic - not syncing: Fatal exception
[   44.576517] Kernel Offset: 0x1a600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://patch.msgid.link/20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -397,7 +397,7 @@ out:
 }
 
 static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
-				    unsigned int len)
+				    loff_t len)
 {
 	int ret, size, no_expand;
 	struct ext4_inode_info *ei = EXT4_I(inode);



