Return-Path: <stable+bounces-48037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700348FCB80
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C71F24C93
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7C61A0DF5;
	Wed,  5 Jun 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPXb9FFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1E1A0DEC;
	Wed,  5 Jun 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588303; cv=none; b=u4DUiuwkT2+UPlcCxs/aqfENw+Zn2Z28nWjh4QtBTcjplsidfwikbHszAybd/l6sz/LsLQbjtKaw6/7vk6q1jHFntnfb9LAXY/pbdJUL75oh2xmcGhu39xXzz4h5ICD370tVVKCJr44z5Um0tUCyUfmNv2o1vDKKM59E23Q7KI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588303; c=relaxed/simple;
	bh=5ESzbzLr3c0iZ5RB9q1kArjcC2Aj3Pqfx7KDrR3mhBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZICjN6ggfzxXF3sfnRm77VDFjZDx6+4j+Q0BvHLXBujwnKLGExXbxDIJZtmqrTd+HybS5sA8efLwD4JJawLZgbttAA84SMky+jILENLB/ufDfduj57Jqvhjuvp1+drUKMAnptOa2XZNrnh2JjW2Cx1nnEgvpqtp95F8eS5ryNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPXb9FFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A61C3277B;
	Wed,  5 Jun 2024 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588302;
	bh=5ESzbzLr3c0iZ5RB9q1kArjcC2Aj3Pqfx7KDrR3mhBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPXb9FFHwmgNqyXpwY/pb/S6e/aoevg3/VRJiKf2LvGxfwP9nzDEQWvvD4WGITb+U
	 vfIOUYvmKh+Upe+gUzNsYOxo64+G3oo+/XNvtDh9FEhlSBpoWjnwlK9tXW/FcosTcV
	 CekNwWHvRc+JPL1LaF7S/K//YFhI/8QCGEEXx9Kre4C1mW6rIHMKdmgFPXRPOwr1OI
	 tUfZi6teg6loD0pQYbzIUiwCVljF6QJlsAAiZ2gW6qqlK8tIWTqplwoE/MnYyicimw
	 YYkxHrygwKWbhWZ+YpNFJHIGQy78LJXenfleU4K1sIG5TUejB51G8/AcnV8wz3T1wQ
	 K/3DQ8wZRoMSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.8 16/24] f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()
Date: Wed,  5 Jun 2024 07:50:26 -0400
Message-ID: <20240605115101.2962372-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 20faaf30e55522bba2b56d9c46689233205d7717 ]

syzbot reports a kernel bug as below:

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
==================================================================
BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076

CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
 f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
 f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is we missed to do sanity check on i_xattr_nid during
f2fs_iget(), so that in fiemap() path, current_nat_addr() will access
nat_bitmap w/ offset from invalid i_xattr_nid, result in triggering
kasan bug report, fix it.

Reported-and-tested-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000094036c0616e72a1d@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c26effdce9aa7..2af50bc34fcd7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -361,6 +361,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.43.0


