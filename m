Return-Path: <stable+bounces-127734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F9A7AA0F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A4A3B9D4A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009A25742E;
	Thu,  3 Apr 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keiCEDgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074C257429;
	Thu,  3 Apr 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706977; cv=none; b=IJCBUAD09hircTsvZHjHcbUkIgEShHJJ/yIQvUbOtQcE6Of0Yav4GPyzjOjcpBBOPP/n/EY7cWytwXMohaeMvPlqsk7RcTl29/by09nSxa3E3LQtJAxxL7x2cdvsG5LYS+mZLp4HjYpUzhzs1wz77P6J6Y/KDNLSjy7Yg9+/oHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706977; c=relaxed/simple;
	bh=549qfMrQeuNBpSjztJHEajMHuoWAKsoH8OhuOMqkqwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAUhmA8b6HqxP11WiGZcDCgfBzvBehmcC8nnawi2jAN+IZNzhIRG+MbomyA4Ubmnkh1/GST6id+L6fJ7Ts93XptApyuMkaJv2SPV2bjB4OPfsOj211+5oTLFr1lGE7qC3daMj0MTSRdbZBbDq2TJBoxyotk/FAmMPpT0s762fXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keiCEDgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D971C4CEE9;
	Thu,  3 Apr 2025 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706976;
	bh=549qfMrQeuNBpSjztJHEajMHuoWAKsoH8OhuOMqkqwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keiCEDgD/iStLQcScD0vrQc/c/dkuOSs9Vr1u1UH+La+9WYlPzIOT4VYSIFCxEa4q
	 x2EV3xfdqQJ3dBgupaDQyIdokEXkEORD6PiBlgE69vvd0uXcNMKi9W6E+8xKErrboZ
	 yE9Ucvk1sgatohPd0yyiXsKOgy1VLVMKS3VSTA/UQyfE0zoLUg2GgefEVwYbCUnFqz
	 TCzvKPWbrOFUyHsShjcEmkktOR0F7PiX9yFqpuG2D57pPmy8VgPXZq5qjyyP7Xrw9e
	 /tcYO6VIQTlMmjuaK0IjUVcURw/QqyVwR2KJLvMIlnLpNuTomIDZ1C7e/QeQ9anMwN
	 9WZfBP3exQGAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	aha310510@gmail.com,
	eadavis@qq.com,
	dmantipov@yandex.ru,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 19/54] jfs: Fix uninit-value access of imap allocated in the diMount() function
Date: Thu,  3 Apr 2025 15:01:34 -0400
Message-Id: <20250403190209.2675485-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 9629d7d66c621671d9a47afe27ca9336bfc8a9ea ]

syzbot reports that hex_dump_to_buffer is using uninit-value:

=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
diFree+0x5ba/0x4350 fs/jfs/jfs_imap.c:876
jfs_evict_inode+0x510/0x550 fs/jfs/inode.c:156
evict+0x723/0xd10 fs/inode.c:796
iput_final fs/inode.c:1946 [inline]
iput+0x97b/0xdb0 fs/inode.c:1972
txUpdateMap+0xf3e/0x1150 fs/jfs/jfs_txnmgr.c:2367
txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
jfs_lazycommit+0x627/0x11d0 fs/jfs/jfs_txnmgr.c:2733
kthread+0x6b9/0xef0 kernel/kthread.c:464
ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
slab_post_alloc_hook mm/slub.c:4121 [inline]
slab_alloc_node mm/slub.c:4164 [inline]
__kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
kmalloc_noprof include/linux/slab.h:901 [inline]
diMount+0x61/0x7f0 fs/jfs/jfs_imap.c:105
jfs_mount+0xa8e/0x11d0 fs/jfs/jfs_mount.c:176
jfs_fill_super+0xa47/0x17c0 fs/jfs/super.c:523
get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
get_tree_bdev+0x37/0x50 fs/super.c:1659
jfs_get_tree+0x34/0x40 fs/jfs/super.c:635
vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
path_mount+0x742/0x1f10 fs/namespace.c:3887
do_mount fs/namespace.c:3900 [inline]
__do_sys_mount fs/namespace.c:4111 [inline]
__se_sys_mount+0x71f/0x800 fs/namespace.c:4088
__x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
=====================================================

The reason is that imap is not properly initialized after memory
allocation. It will cause the snprintf() function to write uninitialized
data into linebuf within hex_dump_to_buffer().

Fix this by using kzalloc instead of kmalloc to clear its content at the
beginning in diMount().

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reported-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67b5d07e.050a0220.14d86d.00e6.GAE@google.com/
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_imap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320c..cf16655cd26ba 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -102,7 +102,7 @@ int diMount(struct inode *ipimap)
 	 * allocate/initialize the in-memory inode map control structure
 	 */
 	/* allocate the in-memory inode map control structure. */
-	imap = kmalloc(sizeof(struct inomap), GFP_KERNEL);
+	imap = kzalloc(sizeof(struct inomap), GFP_KERNEL);
 	if (imap == NULL)
 		return -ENOMEM;
 
-- 
2.39.5


