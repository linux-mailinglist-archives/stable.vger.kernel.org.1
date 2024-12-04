Return-Path: <stable+bounces-98530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83239E45C9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D3CB6545C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377D2101A5;
	Wed,  4 Dec 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/+KBFfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEC237594;
	Wed,  4 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332428; cv=none; b=okivpPMNeYf7mMXHeFnkh7VP2EpapVNvBreFaMk+aDogjOvq95iEqlPSs4AC8vZZQ5O4l6YXLoxNtoL/uRzGc3p/3ZElH84s0Fa6h9rGRamBh016S2BFPk6/NrOVh2tC2j78Mwu3gsfNWqH3S4O8wQPYopqFWQ7rnMHJBWOiP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332428; c=relaxed/simple;
	bh=ad6UmUYhmMl1O+IfDWma9JgsNLXjIHywrXQY2P24+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx/zeOHgDtdBXffByFu7wlwp6TLWzbWcy0qSOU9yLzU418acz3KFa9xKHeZlLPc/JA+jFNITUZqq9Ld/xBqumyu4V3GqYGKnjP07uHF6nS+eTmUrerVOy/KNoUOhtg+jTH4dfZTRc3upkZZXz8Vv5C069ug8PFNqIERu9/W1B7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/+KBFfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B3AC4CECD;
	Wed,  4 Dec 2024 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332427;
	bh=ad6UmUYhmMl1O+IfDWma9JgsNLXjIHywrXQY2P24+Y4=;
	h=From:To:Cc:Subject:Date:From;
	b=s/+KBFfRyOnwGjf/FY+k/kiLOZf6VMV3TGijrD9dwROXQkdF5lEzPsBMgg4HOgQ+r
	 wLJcPAPXJfG0XbQGMDHtU/wMivsO9Lybs6qn5IXFCvfyv8mDwje6HDOwpS22h9tgLB
	 ioO4ygPC1cM82Dp3AfFxtWuTsxXbBT8mI3NP4sC7ucm94AkraaETdLOXQ6B1fM2nYy
	 Xiw9wELsgwKkzFVicvRSE4lzrG9J9ZFRjQOcCZOjK+8+9+BUc5GJ2Xc3UeKcWLZnIj
	 37AuPUboGYlGYkCeSVqstZdNmwU8heTAOTwSIIJZGhSmtCo4dK+WHXA0HsNW/XVNGc
	 Ztvz5wtaqJfyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qi Han <hanqi@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 1/4] f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
Date: Wed,  4 Dec 2024 11:02:22 -0500
Message-ID: <20241204160227.2217428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Qi Han <hanqi@vivo.com>

[ Upstream commit d5c367ef8287fb4d235c46a2f8c8d68715f3a0ca ]

creating a large files during checkpoint disable until it runs out of
space and then delete it, then remount to enable checkpoint again, and
then unmount the filesystem triggers the f2fs_bug_on as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:896!
CPU: 2 UID: 0 PID: 1286 Comm: umount Not tainted 6.11.0-rc7-dirty #360
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:f2fs_evict_inode+0x58c/0x610
Call Trace:
 __die_body+0x15/0x60
 die+0x33/0x50
 do_trap+0x10a/0x120
 f2fs_evict_inode+0x58c/0x610
 do_error_trap+0x60/0x80
 f2fs_evict_inode+0x58c/0x610
 exc_invalid_op+0x53/0x60
 f2fs_evict_inode+0x58c/0x610
 asm_exc_invalid_op+0x16/0x20
 f2fs_evict_inode+0x58c/0x610
 evict+0x101/0x260
 dispose_list+0x30/0x50
 evict_inodes+0x140/0x190
 generic_shutdown_super+0x2f/0x150
 kill_block_super+0x11/0x40
 kill_f2fs_super+0x7d/0x140
 deactivate_locked_super+0x2a/0x70
 cleanup_mnt+0xb3/0x140
 task_work_run+0x61/0x90

The root cause is: creating large files during disable checkpoint
period results in not enough free segments, so when writing back root
inode will failed in f2fs_enable_checkpoint. When umount the file
system after enabling checkpoint, the root inode is dirty in
f2fs_evict_inode function, which triggers BUG_ON. The steps to
reproduce are as follows:

dd if=/dev/zero of=f2fs.img bs=1M count=55
mount f2fs.img f2fs_dir -o checkpoint=disable:10%
dd if=/dev/zero of=big bs=1M count=50
sync
rm big
mount -o remount,checkpoint=enable f2fs_dir
umount f2fs_dir

Let's redirty inode when there is not free segments during checkpoint
is disable.

Signed-off-by: Qi Han <hanqi@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 53e1a757e4e17..b0cbb01df8cba 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -631,8 +631,10 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
-	if (!f2fs_is_checkpoint_ready(sbi))
+	if (!f2fs_is_checkpoint_ready(sbi)) {
+		f2fs_mark_inode_dirty_sync(inode, true);
 		return -ENOSPC;
+	}
 
 	/*
 	 * We need to balance fs here to prevent from producing dirty node pages
-- 
2.43.0


