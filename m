Return-Path: <stable+bounces-84409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F599D00A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405C2B245DF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC91AE001;
	Mon, 14 Oct 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5fGT9jq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB81AD403;
	Mon, 14 Oct 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917910; cv=none; b=pBtk0XqK46fmlLxhc0jJ0UMEQtE2gCcPMEGde8EQ/p4olMbQR+2mw8AUr8xGAIJ9N4nN2mn2PgbDomsqBAqEbjEPaOn33PbYJA6ilklS4cxSukmEf7eWW+QcR6d/PRebdev77r2HIw+GyenGv1s2J3IAWmKDVgu79tObRCkGR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917910; c=relaxed/simple;
	bh=Xor2D8qt3YVJLye8274XfD4ripV7YVdUCcZxzJAh1To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU+G2r3tGMSWpXf5YCEK0KvhCy+J6AcnFA44kFZIjs6QZ4+YEXOIJxVTs+PsgKpfsVdMyr7bP6WpAM9RD2d/JFSmD2UJluEDKp6XvQBWzJQagYMmUbtwOI50SsyNqJ9vp1nDMIQU4ECzDfrlGJUyzwj2dfPjUDFv58yOPRCD3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5fGT9jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23416C4CEC3;
	Mon, 14 Oct 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917909;
	bh=Xor2D8qt3YVJLye8274XfD4ripV7YVdUCcZxzJAh1To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5fGT9jqi3ZkOD0U1YbXcGXlPPyyKIwR5lungSFxmMJK38W4uy7ZLqJs031fXd1oQ
	 2BUbGPPXrUupH3U3f5fk9y52vX+lKGzYSBcS3GIWyWov9R518aRJbMm03WSZyx4JRi
	 RmummNNbMi5cmXljsW0uMAg2LEvDQjRIZN3B13rY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 170/798] ext4: avoid OOB when system.data xattr changes underneath the filesystem
Date: Mon, 14 Oct 2024 16:12:04 +0200
Message-ID: <20241014141224.604914190@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit c6b72f5d82b1017bad80f9ebf502832fc321d796 ]

When looking up for an entry in an inlined directory, if e_value_offs is
changed underneath the filesystem by some change in the block device, it
will lead to an out-of-bounds access that KASAN detects as an UAF.

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
loop0: detected capacity change from 2048 to 2047
==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf2/0x1c0 fs/ext4/namei.c:1500
Read of size 1 at addr ffff88803e91130f by task syz-executor269/5103

CPU: 0 UID: 0 PID: 5103 Comm: syz-executor269 Not tainted 6.11.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ext4_search_dir+0xf2/0x1c0 fs/ext4/namei.c:1500
 ext4_find_inline_entry+0x4be/0x5e0 fs/ext4/inline.c:1697
 __ext4_find_entry+0x2b4/0x1b30 fs/ext4/namei.c:1573
 ext4_lookup_entry fs/ext4/namei.c:1727 [inline]
 ext4_lookup+0x15f/0x750 fs/ext4/namei.c:1795
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:3980
 do_symlinkat+0xf9/0x3a0 fs/namei.c:4587
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4607
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e73ced469
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4d40c258 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 0032656c69662f2e RCX: 00007f3e73ced469
RDX: 0000000020000200 RSI: 00000000ffffff9c RDI: 00000000200001c0
RBP: 0000000000000000 R08: 00007fff4d40c290 R09: 00007fff4d40c290
R10: 0023706f6f6c2f76 R11: 0000000000000246 R12: 00007fff4d40c27c
R13: 0000000000000003 R14: 431bde82d7b634db R15: 00007fff4d40c2b0
 </TASK>

Calling ext4_xattr_ibody_find right after reading the inode with
ext4_get_inode_loc will lead to a check of the validity of the xattrs,
avoiding this problem.

Reported-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c2508114d912a54ee79
Fixes: e8e948e7802a ("ext4: let ext4_find_entry handle inline data")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://patch.msgid.link/20240821152324.3621860-5-cascardo@igalia.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inline.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e6c2650335a9f..7c9efc9330fe1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1693,25 +1693,36 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 					struct ext4_dir_entry_2 **res_dir,
 					int *has_inline_data)
 {
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
 	int ret;
-	struct ext4_iloc iloc;
 	void *inline_start;
 	int inline_size;
 
-	ret = ext4_get_inode_loc(dir, &iloc);
+	ret = ext4_get_inode_loc(dir, &is.iloc);
 	if (ret)
 		return ERR_PTR(ret);
 
 	down_read(&EXT4_I(dir)->xattr_sem);
+
+	ret = ext4_xattr_ibody_find(dir, &i, &is);
+	if (ret)
+		goto out;
+
 	if (!ext4_has_inline_data(dir)) {
 		*has_inline_data = 0;
 		goto out;
 	}
 
-	inline_start = (void *)ext4_raw_inode(&iloc)->i_block +
+	inline_start = (void *)ext4_raw_inode(&is.iloc)->i_block +
 						EXT4_INLINE_DOTDOT_SIZE;
 	inline_size = EXT4_MIN_INLINE_DATA_SIZE - EXT4_INLINE_DOTDOT_SIZE;
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
@@ -1721,23 +1732,23 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	if (ext4_get_inline_size(dir) == EXT4_MIN_INLINE_DATA_SIZE)
 		goto out;
 
-	inline_start = ext4_get_inline_xattr_pos(dir, &iloc);
+	inline_start = ext4_get_inline_xattr_pos(dir, &is.iloc);
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
 
-	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
+	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 
 out:
-	brelse(iloc.bh);
+	brelse(is.iloc.bh);
 	if (ret < 0)
-		iloc.bh = ERR_PTR(ret);
+		is.iloc.bh = ERR_PTR(ret);
 	else
-		iloc.bh = NULL;
+		is.iloc.bh = NULL;
 out_find:
 	up_read(&EXT4_I(dir)->xattr_sem);
-	return iloc.bh;
+	return is.iloc.bh;
 }
 
 int ext4_delete_inline_entry(handle_t *handle,
-- 
2.43.0




