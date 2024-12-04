Return-Path: <stable+bounces-98488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C139E4207
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5B216473D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC52204A1B;
	Wed,  4 Dec 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfepGsIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986862066D6;
	Wed,  4 Dec 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332324; cv=none; b=jQb5fPoa+dtzOcTSOfWYQlDmk8BG2mhLqeBFJ3fjkalhQEmh/8Dsmyby/n0hT39aunmypvNwH9RqF/jol9+CbLI7iCeCwsyQQNAgP/QpC/IxsAWwd/G8oFPJxHBKQoaDzE/NSeFDCq852oYnewOuidrUOsR8FKKDnVNjQt7aeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332324; c=relaxed/simple;
	bh=6vSbdDFo4mdH4hRvP2BxrQuvJQs6hXMlu5wxbHYxU4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSbl2ekcF/ZE49ebn6xen3H8+Ad2L7+VbUd9jMZX74TqSDeV1/YQU/fn/g/TkMr/Dp/mf6tK0u9iI9zkeXp8GvQ3eTBEy0znWpcVoPzRRkhuDEOGUYc1gZEUc/1F0ju6t+UbwGbC1J7Zehhj2SEy5GarNVfmRhA8awJswd/GhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfepGsIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A370EC4CECD;
	Wed,  4 Dec 2024 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332324;
	bh=6vSbdDFo4mdH4hRvP2BxrQuvJQs6hXMlu5wxbHYxU4k=;
	h=From:To:Cc:Subject:Date:From;
	b=TfepGsIk8GGCeQexoJHEj3cSBL+9+bDpmmDYiVFdqfiWlvF7NQEpUhcPMCZziFR2o
	 1rWbHjctrWC4/mIDabKdQp/2Lz/l8caglmuamvG/ERKvievlH8tNCGi+sGie4ZFoTn
	 6n+KiA/bNsa2LwJSWHm+yCs6uujJHWsO3EX1Cm+7Zd5rcihH2mYKS4PAvulEmVnXaB
	 hHDNCkEjg/vn3I6LWmgWdE6e/yj5RtcjeYDkYL+ZydDYnMgDB9jHkLEkZk4nGQgDTX
	 wwEK3txV2S4Tchvnb+tGR+PlpR9vl9uy+6+nJK0itMNfcNK0/HzZfxKQVtrUH9pz8O
	 VCGG0cJ8lot3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qi Han <hanqi@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 01/13] f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
Date: Wed,  4 Dec 2024 11:00:26 -0500
Message-ID: <20241204160044.2216380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 4729c49bf6d7e..b0676e8338334 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -775,8 +775,10 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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


