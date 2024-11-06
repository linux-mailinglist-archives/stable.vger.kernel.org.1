Return-Path: <stable+bounces-91199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AE09BECE7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FB11C23777
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFC1F76A6;
	Wed,  6 Nov 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUoMAwsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297391EBFE4;
	Wed,  6 Nov 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898033; cv=none; b=Qk35WzoFdOnAZUZsX0CzQFcNPsZQt/oZj8ThMpdRylfPLHGSD6sxarbI+0U2p3FY/eCllYFHQ2SHrnZsm2Bk2gJ2Liq5VDEtrRJJEkZ9yDT0dmwyoPPgIdmWjZWP9oJhOfyhTS/FE2E5do7FG/biP6S6CsUKJ5fRdedXiSK1PWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898033; c=relaxed/simple;
	bh=pcE8zkCfOuM95HtLW0ufdKw+eyb+P9Bw2p9ENb6PTjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYLNAo9e4p6jRJSKiWjN8/Bo1zMaeJms2dEdWFtPMDfD10wXtrv+fMyvcTmBPiH5ybLm5I2wy8yBFSHcgKZkonY0wVuxpoXuPI2GfR1OKfTm9xGdPA+OJ4pv4RQHBifnZH5qIbiQITzmKK8+n5+MBv+6IkWA//LkXhTF7dtmgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUoMAwsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3496DC4CED3;
	Wed,  6 Nov 2024 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898032;
	bh=pcE8zkCfOuM95HtLW0ufdKw+eyb+P9Bw2p9ENb6PTjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUoMAwsXkWL9Q/OB1Y1To17T4ZrrmifbNPYKpbxKJwgUVDP44dvWyMbxjo7vTVro2
	 MBgwNdsMhGP56hLb7rkHCp+h0trLYZvt9Koa+55QPOzjVvKPWrqLugwtwFKIT9/mNy
	 6fbUGwCLJdLYeZZKtzmCWyxva+OfaIKpzjtbsQ68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 100/462] ext4: avoid OOB when system.data xattr changes underneath the filesystem
Date: Wed,  6 Nov 2024 12:59:53 +0100
Message-ID: <20241106120333.977293348@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 95ac5bcb2882e..7e250ceacb8eb 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1646,25 +1646,36 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
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
@@ -1674,23 +1685,23 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
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




