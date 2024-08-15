Return-Path: <stable+bounces-68575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32976953304
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76FB28604C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0E1BB6B5;
	Thu, 15 Aug 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WviYV3P4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AA1BB69B;
	Thu, 15 Aug 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731001; cv=none; b=pGb36ASXhBKhNwRrot7yK+9re/CWC8nnEcpBNeQvqsyWXGkU8f5LDx+9yjuiddKfpbJGn0qzuQjgjb6oX2kDJ9lfeFC6CDhmGxpRvl5vrvI+Iz5U6L+GkDU9Sol+6NM+kRtlBuu/yJgNxFnQ5N71r55MytmGgKe/j13rY348oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731001; c=relaxed/simple;
	bh=RlYlK7jAqVlqNsjwItJvekmLfVlWIESu6B/yRcmg75c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SctdlH4DFnXvEv7hSKaPk8dsW0T7LdN+EpwtEZHW4qA8HUfxP6DvxBDHpBTrnhItx0A7H1/LHkkd/zI+RtHlIH/IF8MGTePznKbkCEoqWhoS1gyu1RoeovNPFxtRPjCeV2OZfyqalTQ8PMHqUEpB1jyU7IowmdPZyrwR7iV+5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WviYV3P4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E08C32786;
	Thu, 15 Aug 2024 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731001;
	bh=RlYlK7jAqVlqNsjwItJvekmLfVlWIESu6B/yRcmg75c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WviYV3P4466304fRt00HO6DAjbo1xJCRYaOmsexFMe76lfY2OXhhzUSaBGC6AVvq2
	 yQMssD2N4qdI0Rv9zpZDeYMdLm6YoLDbSc8PnqTjXeMwZ6XFO1xGlJc69T77N5a8hg
	 X5zuh/M8Cq30l0r35UqJKI0nqvnQwENg4FhmXVts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com,
	=?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 52/67] ext4: sanity check for NULL pointer after ext4_force_shutdown
Date: Thu, 15 Aug 2024 15:26:06 +0200
Message-ID: <20240815131840.308126728@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wojciech Gładysz <wojciech.gladysz@infogain.com>

[ Upstream commit 83f4414b8f84249d538905825b088ff3ae555652 ]

Test case: 2 threads write short inline data to a file.
In ext4_page_mkwrite the resulting inline data is converted.
Handling ext4_grp_locked_error with description "block bitmap
and bg descriptor inconsistent: X vs Y free clusters" calls
ext4_force_shutdown. The conversion clears
EXT4_STATE_MAY_INLINE_DATA but fails for
ext4_destroy_inline_data_nolock and ext4_mark_iloc_dirty due
to ext4_forced_shutdown. The restoration of inline data fails
for the same reason not setting EXT4_STATE_MAY_INLINE_DATA.
Without the flag set a regular process path in ext4_da_write_end
follows trying to dereference page folio private pointer that has
not been set. The fix calls early return with -EIO error shall the
pointer to private be NULL.

Sample crash report:

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 20274 Comm: syz-executor185 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
lr : __block_commit_write+0x3c/0x2b0 fs/buffer.c:2160
sp : ffff8000a1957600
x29: ffff8000a1957610 x28: dfff800000000000 x27: ffff0000e30e34b0
x26: 0000000000000000 x25: dfff800000000000 x24: dfff800000000000
x23: fffffdffc397c9e0 x22: 0000000000000020 x21: 0000000000000020
x20: 0000000000000040 x19: fffffdffc397c9c0 x18: 1fffe000367bd196
x17: ffff80008eead000 x16: ffff80008ae89e3c x15: 00000000200000c0
x14: 1fffe0001cbe4e04 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffdffc397c9c0 x4 : 0000000000000020 x3 : 0000000000000020
x2 : 0000000000000040 x1 : 0000000000000020 x0 : fffffdffc397c9c0
Call trace:
 __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
 block_write_end+0xb4/0x104 fs/buffer.c:2253
 ext4_da_do_write_end fs/ext4/inode.c:2955 [inline]
 ext4_da_write_end+0x2c4/0xa40 fs/ext4/inode.c:3028
 generic_perform_write+0x394/0x588 mm/filemap.c:3985
 ext4_buffered_write_iter+0x2c0/0x4ec fs/ext4/file.c:299
 ext4_file_write_iter+0x188/0x1780
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x968/0xc3c fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 97f85911 f94002da 91008356 d343fec8 (38796908)
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f85911 	bl	0xffffffffffe16444
   4:	f94002da 	ldr	x26, [x22]
   8:	91008356 	add	x22, x26, #0x20
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38796908 	ldrb	w8, [x8, x25] <-- trapping instruction

Reported-by: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
Link: https://lore.kernel.org/all/000000000000f19a1406109eb5c5@google.com/T/
Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
Link: https://patch.msgid.link/20240703070112.10235-1-wojciech.gladysz@infogain.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c     | 2 ++
 fs/ext4/inode.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71c693d7..ecd8b47507ff8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2179,6 +2179,8 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 	struct buffer_head *bh, *head;
 
 	bh = head = folio_buffers(folio);
+	if (!bh)
+		return;
 	blocksize = bh->b_size;
 
 	block_start = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e24afb80c0f6b..a4ffd1acac651 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2973,6 +2973,11 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	bool disksize_changed = false;
 	loff_t new_i_size;
 
+	if (unlikely(!folio_buffers(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -EIO;
+	}
 	/*
 	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
 	 * flag, which all that's needed to trigger page writeback.
-- 
2.43.0




