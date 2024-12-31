Return-Path: <stable+bounces-106611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F109FEF2B
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16BA3A300D
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC6199EBB;
	Tue, 31 Dec 2024 11:56:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE417ADE8;
	Tue, 31 Dec 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646177; cv=none; b=sPAnQpZN1GfXcS7HXtIS1CN/D05iQYR+CPbv6iy1WPEKc1ci9Sgp8+yQdoaCM6Qawk2bYnLOLruwWvNpvjKjxP6jONikyBUrElvPMjPAecmwaVyCjRWDpvPC2Y1bUiwINmkOmiV+XKyxRar+sfzMReQTH71K/4Whbgb2cGvm0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646177; c=relaxed/simple;
	bh=NEa7i0iJmD8sL0TKhPbWUW7D7ttR8j9YpUHyZm1+pfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkj5XlP45xR4AtNzQc8lBy7Efbsc/fX0+MeWOZMRJ+qnw4EtBeLHzOdk8Vs3bAzYpzJXzZMTq43hd97m2mWLpCfCSQEFX4sQbsecDySMhfiNfY1Rb00XI3vk4l0gx0zUNqHrdwhCdbKIACl3E8x46+oPolWKIFkObCQd9c0rBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id B54F42333B;
	Tue, 31 Dec 2024 14:56:03 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y] f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
Date: Tue, 31 Dec 2024 14:56:03 +0300
Message-Id: <20241231115603.1307976-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit fc01008c92f40015aeeced94750855a7111b6929 ]

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/inline.c:258!
CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Call Trace:
 f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
 f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
 do_writepages+0x35b/0x870 mm/page-writeback.c:2612
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
 wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The root cause is: inline_data inode can be fuzzed, so that there may
be valid blkaddr in its direct node, once f2fs triggers background GC
to migrate the block, it will hit f2fs_bug_on() during dirty page
writeback.

Let's add sanity check on F2FS_INLINE_DATA flag in inode during GC,
so that, it can forbid migrating inline_data inode's data block for
fixing.

Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[kovalev: Replaced f2fs_err_ratelimited() with printk_ratelimited()
to use a supported function]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-44942
Link: https://www.cve.org/CVERecord/?id=CVE-2024-44942
---
 fs/f2fs/gc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 687b2ce82c8542..8e6e91fedbf32a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1577,6 +1577,17 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
+			if (f2fs_has_inline_data(inode)) {
+				iput(inode);
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
+				printk_ratelimited("%sF2FS-fs (%s): "
+					"inode %lx has both inline_data flag and "
+					"data block, nid=%u, ofs_in_node=%u",
+					KERN_INFO, sbi->sb->s_id,
+					inode->i_ino, dni.nid, ofs_in_node);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
-- 
2.33.8


