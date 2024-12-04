Return-Path: <stable+bounces-98513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73459E45DC
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3082BC43BA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10C23367B;
	Wed,  4 Dec 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnkOQ8q+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A5233682;
	Wed,  4 Dec 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332382; cv=none; b=hYy73E0tvw0Do2rmdn1ZyUzjMYrOngi7EfV/f0cq7SLJ+0FYLQBCTFbZ2RMiP3M1tNpY7hlM93uSOo6gocV4cE8Pz9VHlJhNlEbzuFdKuKvdUCzwX8iCwe+nCY06XOUXKeSALDumEIuCeNN/KCN26byX7RfIT7LfYiC9BREUWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332382; c=relaxed/simple;
	bh=nbUSKLOVCskGwS+rrDWhi086fbtxWW3E6+M68LdtxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h92Ov5QzahEMOehN/0TSJzLZXqNCGZXxS6plsnVQRqYXhHpkLgL21a7H8arCidR+F8fs8Tk/jNK2dlseIFlJnNom93Y7F8N+zlGTupyF6E0ZRCQWO4uMcrJFmY4vqW0xPtQ+lf1xWNMpe5SnygzXH1j/kVdPRlnLJzDkWqKBZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnkOQ8q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C3C4CECD;
	Wed,  4 Dec 2024 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332382;
	bh=nbUSKLOVCskGwS+rrDWhi086fbtxWW3E6+M68LdtxCs=;
	h=From:To:Cc:Subject:Date:From;
	b=PnkOQ8q+ShGNuqUoAHuuZUGBQpsw9lsPIDtchQ4DZ+ELBVmEIc/4d8wzPPFE0zQ87
	 H6mBVzgZ9Rq2Oq6WGzZaFWz/qSyMboWbUzTEiw1ERg//QqQO3SPvYP7oLAGyH2m2as
	 9xxKidgZ/dCcmBnNu0N8+GN2I1Co1aPx6jV+6qzTE7rFv7Ps1BK1RnzaKRhbNGJMYq
	 LdMkYuh7t2lrBnGdNb4RMXXTtwUGI+rBc3wgXy7/20mGmu4mb2X/4bLB3056V9lZjW
	 RJV/FvUbzCaBDx39Y3ZAEhx36mmCVB7d8AfMjID3s5Y6+n13NPK63BlCrMLJMtEmry
	 OT2LGZDuAXVQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qi Han <hanqi@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 1/6] f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
Date: Wed,  4 Dec 2024 11:01:33 -0500
Message-ID: <20241204160142.2217017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 5b672df194a99..0f350368dea73 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -719,8 +719,10 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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


