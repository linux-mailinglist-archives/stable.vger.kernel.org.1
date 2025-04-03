Return-Path: <stable+bounces-127880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8949A7ACA8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2EF7A7041
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A46281506;
	Thu,  3 Apr 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS3WYJ9g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB328137E;
	Thu,  3 Apr 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707301; cv=none; b=Af2FjgYWkQNE0bXjU5Q1rr/XGmt7xun4+v0NnoB9VkUU5xdcWaZb9/WGP21KE50EgC9bYnZcVhBCG8qVXGQCmt9vEjZNfaV0Z0sf4q+bOSlDnZtiZ43upWy8MnHEaS643E0GpPdkvSmDfHLVDkNHNiA43MY0N3PFQ0XohzrzmZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707301; c=relaxed/simple;
	bh=o/RE6Pq0biWl9XpOsNg8l1IOp1SAIm5gTZGWKOVv3ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJBK0trWnKlBZGhPJoTfL1zY7aAcwS4Lp8gPUtI2QhLCLnkA0n8TsAeUetobUNgBhjYQj6Yp/0nTjHuTmTNAwWMN0QqTiH93vDIFavw7z8Qx4zLkcvTCT7uytc/nPyRUsrZMl75HObHnQKK4qHtaokzTeOSnLCieRGY+9oKyPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS3WYJ9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57401C4CEE3;
	Thu,  3 Apr 2025 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707301;
	bh=o/RE6Pq0biWl9XpOsNg8l1IOp1SAIm5gTZGWKOVv3ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AS3WYJ9gYqf/owq5TJadY8zM8PjKHJ5hhHGc5FWTDwjjj5Y+YesLc77NsN8dO2qY7
	 d8EN7HdUJrEIdbqmWNqpJhBajPvWbW4bft1WLL26GftjRIm6r9b06VYeHw7HuN4i6d
	 H7QUrdvc207wK1uS6eUp62XrY05Bm40nhewoXSzJcc3yXlzfK9+vnMZ7yHEijKcjpR
	 fs42+0gDynk6dLc4nnmAclFwjiyv8oatEBlTKZjenkev34wdBqYC7cG6mc+mfn9NXX
	 5kv0DkspapYO/SrAjxpt1buJHEswAwRH7KoPikqTOa1zKgUEL6FuG57MMxun2J3INy
	 mdO8KQF2dMQeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 15/26] f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
Date: Thu,  3 Apr 2025 15:07:34 -0400
Message-Id: <20250403190745.2677620-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit e6494977bd4a83862118a05f57a8df40256951c0 ]

syzbot reports an UBSAN issue as below:

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/f2fs/node.h:381:10
index 18446744073709550692 is out of range for type '__le32[5]' (aka 'unsigned int[5]')
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 get_nid fs/f2fs/node.h:381 [inline]
 f2fs_truncate_inode_blocks+0xa5e/0xf60 fs/f2fs/node.c:1181
 f2fs_do_truncate_blocks+0x782/0x1030 fs/f2fs/file.c:808
 f2fs_truncate_blocks+0x10d/0x300 fs/f2fs/file.c:836
 f2fs_truncate+0x417/0x720 fs/f2fs/file.c:886
 f2fs_file_write_iter+0x1bdb/0x2550 fs/f2fs/file.c:5093
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x171/0x2e0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f238798cde9

index 18446744073709550692 (decimal, unsigned long long)
= 0xfffffffffffffc64 (hexadecimal, unsigned long long)
= -924 (decimal, long long)

In f2fs_truncate_inode_blocks(), UBSAN detects that get_nid() tries to
access .i_nid[-924], it means both offset[0] and level should zero.

The possible case should be in f2fs_do_truncate_blocks(), we try to
truncate inode size to zero, however, dn.ofs_in_node is zero and
dn.node_page is not an inode page, so it fails to truncate inode page,
and then pass zeroed free_from to f2fs_truncate_inode_blocks(), result
in this issue.

	if (dn.ofs_in_node || IS_INODE(dn.node_page)) {
		f2fs_truncate_data_blocks_range(&dn, count);
		free_from += count;
	}

I guess the reason why dn.node_page is not an inode page could be: there
are multiple nat entries share the same node block address, once the node
block address was reused, f2fs_get_node_page() may load a non-inode block.

Let's add a sanity check for such condition to avoid out-of-bounds access
issue.

Reported-by: syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/66fdcdf3.050a0220.40bef.0025.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dedba481b66d0..d93282c1ed384 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1134,7 +1134,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
 	level = get_node_path(inode, from, offset, noffset);
-	if (level < 0) {
+	if (level <= 0) {
+		if (!level) {
+			level = -EFSCORRUPTED;
+			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
+					__func__, inode->i_ino,
+					from, ADDRS_PER_INODE(inode));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 		trace_f2fs_truncate_inode_blocks_exit(inode, level);
 		return level;
 	}
-- 
2.39.5


