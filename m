Return-Path: <stable+bounces-127932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B2A7AD5D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A801B3AF659
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CDC2C376B;
	Thu,  3 Apr 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6g66xbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D092C3764;
	Thu,  3 Apr 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707421; cv=none; b=HXUthccoR48kgepCpbEg3MzZWeR/oDXMii8q9AQ831r+PizTSPc82nkt6Cq3CORRI+LRQ40ZhPNC/p+/8W7hlfMTjQiL+Z2OL8+qkMNXy3nU/ySoWMG9zJX4xIQvCCPPLD51XXH2L0/N2OD7brW2Nuo3geCDDJDLecJ6rru9s3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707421; c=relaxed/simple;
	bh=RDZQYGGkqpJdsQ73Q6r1yW5EKOxH8EsrHW31yJCgSRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQiAClftmMZsS5noRZmmqgRhP17zKWD9Y31h6Nj+6tanWU+wZlunYY5ileSLenSYDP6cSD8aN0n43Mb5wi1Dw5UNsOohufi6CHvXudq8wJ3fToe6EgOUfXww1uLmoZl6pFlp8AkO3Crt7k2Mbxd3MYmJbyiqB59mqIlG6P4mo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6g66xbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8582BC4CEE8;
	Thu,  3 Apr 2025 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707421;
	bh=RDZQYGGkqpJdsQ73Q6r1yW5EKOxH8EsrHW31yJCgSRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6g66xbPd3ePK8a29lBFuGh3sT/ODJEkM+s2YpkSxIfVXGZbydzbSlsgFY7B1BlIN
	 0+oLXIUSXdJeIpT1jF4kJxD8mFg/84inK5uoQHfprg+xLsz2OMpPB0KpC2WD15HuuU
	 sCyBhOAZ9S6LELt+waLe4Q1q9iyjLclxTVsbBjshUqwNuF4TxI+aB1eoOAp+xLTEQR
	 Rj62i+A4DYVJw5pm8RaPn393250fe5zjW5Mi5Jxcht6b2mqw7LuoE4+qJOsb3/U/h0
	 a/G/qeYJNBFH06JfNM7eeuXyVNvivkp0cnUk+6mRn7GyIUxijABbLS9H7NYUuDY1jn
	 g/V6U5JHPrVQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 07/15] f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
Date: Thu,  3 Apr 2025 15:09:54 -0400
Message-Id: <20250403191002.2678588-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 348ad1d6199ff..57baaba17174d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1047,7 +1047,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
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


