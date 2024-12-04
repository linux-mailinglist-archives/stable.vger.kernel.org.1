Return-Path: <stable+bounces-98501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9C9E4234
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B657BC2B0E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7E22FD6B;
	Wed,  4 Dec 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clQAYRY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898F22FD78;
	Wed,  4 Dec 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332355; cv=none; b=cJtpQ0gdV4/unbjrv+lNrNKXd+L/YIaINpSilU06DZvKq7vO2fEksG2MPUskdUcdK/AGCcW2KeNINszGFgXVCW3luDLM9eEM88Dtdqzf5qiDkrE1tDeQoEt2OoPullhHpAn1pjCZ0JIKWjjNDJowRXplaJrOgfIhTSIdiq0e2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332355; c=relaxed/simple;
	bh=Ecb2xP1M0ahpfio66Drn0zqM7f8flqfdYAgcLDqoQis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWyaLIBcMOodUz/ertDGJGEnwFiO8uVPlKy6MP3ijevegg+XpqyIbMJGYqfnF0L6++Sa/3rt1faQxImhKrtnVMlqKyDaIPNZU8QS0tpZNTp9sql22hjwCp0GLueTgWcaLP3ERFvunill9B32XfjxcCbso2L/Jm38CBsmOH43nPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clQAYRY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA00C4CECD;
	Wed,  4 Dec 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332355;
	bh=Ecb2xP1M0ahpfio66Drn0zqM7f8flqfdYAgcLDqoQis=;
	h=From:To:Cc:Subject:Date:From;
	b=clQAYRY1XQ4RnHF5elzhrxn/31I1ucvqOrQiNtyeR36RD8K9fEfmVllUuFkK0Yw8x
	 fI8GZWuTLYKJZ2kr9EDzMUuFIUqERwlKj7ut3Na9DvvoocNilXahsYXj9+MuTu9RE2
	 3e2dzyRq1g2IOkTYynozSnJPKOcVx8ynhORsP2MSVnidFxW7lQij62oM436x40yXFd
	 J3IxwUBMkQy21r1shg6dXqdEr8wBsTdSkVe+pz1MozFwCNsgz3VQ2pyLO8zZOP6vI0
	 +qVwDcQqd+RJd3SMmlPlNZ/pXD1AUcb5/8IhiPHR7U2EShgBiD7yfRbq5TbQvAg4dJ
	 /efKCb68X6KXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qi Han <hanqi@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 01/12] f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
Date: Wed,  4 Dec 2024 11:00:58 -0500
Message-ID: <20241204160115.2216718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index a3e0c92735433..7ad4a92417591 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -788,8 +788,10 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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


