Return-Path: <stable+bounces-81953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB4994A48
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D1B28948B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15A1DED48;
	Tue,  8 Oct 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQ+em1bH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B931DE8A0;
	Tue,  8 Oct 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390691; cv=none; b=U/wFBNSBfTE0rbdQJqrxHVB7/Nq/Oy5cRCZesQt7B/7ZSjx0pxaXKE+ibN6mU7+RFD0uEIUGkkTupxFMGpdSryrtJb6NIUuNhyc7hUlyyicEGo9AGUOpX0Nm/9vqiJkTwDEp/cyj1Qn1uO0b9QMLXybf/aj3xQKyAZJ+bmwdjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390691; c=relaxed/simple;
	bh=QZnxWvW1v/CquHFLddJiO2icf+iGqjbxPIgpydhXVI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdBPNvlHlxX9hMnZCzw+T8L0JyV2a1+eHyBHbW8pfQCM4a4S5P8f5Uwf7N8yeiserYF0utmq4u9MOw7cYoYf8H2CxBRQFqeOerHIQwxXyRaaAPBmoce19ZejCPtp7jQaEo0iEABPf9Xs/efjSgKDL52uyBtkFxnsmRvnxy5GvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQ+em1bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C23C4CEC7;
	Tue,  8 Oct 2024 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390691;
	bh=QZnxWvW1v/CquHFLddJiO2icf+iGqjbxPIgpydhXVI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ+em1bHLq+UOrpvVe/N6iLD0PxQH2lBXe9H1dzmYs9MXSiA4yU0Jaa3irF2s9GXh
	 Zn0+LWsuAWXaIjMRtVY9AXL474zCM2RCtzk9T4HGEdgHsJiJp0iE+v/yFldhWzofdk
	 VWnxajxB5ewQc7MY1QGgV8RAFa9ki3tpB6B3pOAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.10 333/482] ext4: fix access to uninitialised lock in fc replay path
Date: Tue,  8 Oct 2024 14:06:36 +0200
Message-ID: <20241008115701.530134627@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Henriques (SUSE) <luis.henriques@linux.dev>

commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream.

The following kernel trace can be triggered with fstest generic/629 when
executed against a filesystem with fast-commit feature enabled:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 866 Comm: mount Not tainted 6.10.0+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0x90
 register_lock_class+0x759/0x7d0
 __lock_acquire+0x85/0x2630
 ? __find_get_block+0xb4/0x380
 lock_acquire+0xd1/0x2d0
 ? __ext4_journal_get_write_access+0xd5/0x160
 _raw_spin_lock+0x33/0x40
 ? __ext4_journal_get_write_access+0xd5/0x160
 __ext4_journal_get_write_access+0xd5/0x160
 ext4_reserve_inode_write+0x61/0xb0
 __ext4_mark_inode_dirty+0x79/0x270
 ? ext4_ext_replay_set_iblocks+0x2f8/0x450
 ext4_ext_replay_set_iblocks+0x330/0x450
 ext4_fc_replay+0x14c8/0x1540
 ? jread+0x88/0x2e0
 ? rcu_is_watching+0x11/0x40
 do_one_pass+0x447/0xd00
 jbd2_journal_recover+0x139/0x1b0
 jbd2_journal_load+0x96/0x390
 ext4_load_and_init_journal+0x253/0xd40
 ext4_fill_super+0x2cc6/0x3180
...

In the replay path there's an attempt to lock sbi->s_bdev_wb_lock in
function ext4_check_bdev_write_error().  Unfortunately, at this point this
spinlock has not been initialized yet.  Moving it's initialization to an
earlier point in __ext4_fill_super() fixes this splat.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5332,6 +5332,8 @@ static int __ext4_fill_super(struct fs_c
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
@@ -5553,7 +5555,6 @@ static int __ext4_fill_super(struct fs_c
 	 * Save the original bdev mapping's wb_err value which could be
 	 * used to detect the metadata async write error.
 	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
 	errseq_check_and_advance(&sb->s_bdev->bd_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;



