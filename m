Return-Path: <stable+bounces-204255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D6CEA454
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5A73017EC0
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C432ED38;
	Tue, 30 Dec 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H42rxEje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB62223DE5
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114386; cv=none; b=oiN+pJ9wlozmw82p+tPDqqxN/ljRSJSMwhQVJ0qMJT658anGhYddWXV7UwB2qVfoLvQY0SwZVOicRPk0Rew7sfOihOpgMAbDx1p7JTZe1GW0hPhprp4V9vZ3JAPVroaI0SeRYp1rhX9Zn7U749TKE5bWCuaMSGG3v7pz02457hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114386; c=relaxed/simple;
	bh=ADrq5DKJUHkjNsS2q0fC0LWCwPV5atNzsz3PTYahaME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBzLpheWIAytRqO+hqwM0glAMc2FNJj1FmCwIF1FUOIGeJ/rcoTdAUlZT78yShPhYkUmcdq66i+xXEAjiLH8hPwoETgyeFMNicC8TnRUJnGUIg4sMOGpox2sSOBXj5seHa+1aeh60C50tLX2RDQW5yv2n+nVzjwg7KtuAtS8DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H42rxEje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD9CC116C6;
	Tue, 30 Dec 2025 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114386;
	bh=ADrq5DKJUHkjNsS2q0fC0LWCwPV5atNzsz3PTYahaME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H42rxEje4bceXmy2uEFieUTsPOBUCHKspGyL/x27dl9pm20WofhtDEFMD10P9GTQT
	 wQEUJiSjuKY0BjHInBJOOE0KA4QqBCEyMRqWo0u1nFi3OX2ArRyb1vgfxGA8uRfjO5
	 p8VLc6g7xXPdtepBlE7/sHTWFZ9BkA/WjCMn4gyfyvAdTBkWB0EezTQZohjgKlCrZ/
	 dKuTG80QRRH0Ahl7zf4HcDTRisqIWeVegCJjAJ3ZdBCsm7nEFMt5bX47e9a1KEngnR
	 i0+MwAuWtW7b0Td+E6zC682EmDxMxxqWczTQM0vAjRcGG4/YtpbmeB6SkYA+tg+gtO
	 8r6W2kfugE3KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to avoid updating zero-sized extent in extent cache
Date: Tue, 30 Dec 2025 12:06:23 -0500
Message-ID: <20251230170624.2337217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122959-opposing-shabby-fc70@gregkh>
References: <2025122959-opposing-shabby-fc70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7c37c79510329cd951a4dedf3f7bf7e2b18dccec ]

As syzbot reported:

F2FS-fs (loop0): __update_extent_tree_range: extent len is zero, type: 0, extent [0, 0, 0], age [0, 0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:678!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
Call Trace:
 <TASK>
 f2fs_update_read_extent_cache_range+0x192/0x3e0 fs/f2fs/extent_cache.c:1085
 f2fs_do_zero_range fs/f2fs/file.c:1657 [inline]
 f2fs_zero_range+0x10c1/0x1580 fs/f2fs/file.c:1737
 f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ioctl_preallocate fs/ioctl.c:289 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07bc58eec9

In error path of f2fs_zero_range(), it may add a zero-sized extent
into extent cache, it should be avoided.

Fixes: 6e9619499f53 ("f2fs: support in batch fzero in dnode page")
Cc: stable@kernel.org
Reported-by: syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68e5d698.050a0220.256323.0032.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ adapted patch to only guard f2fs_update_read_extent_cache_range() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6228a4827de3..584596e9008e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1552,7 +1552,9 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
-	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
+	if (index > start)
+		f2fs_update_read_extent_cache_range(dn, start, 0,
+							index - start);
 
 	return ret;
 }
-- 
2.51.0


