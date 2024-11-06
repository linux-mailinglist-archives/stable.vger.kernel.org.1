Return-Path: <stable+bounces-91323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C739BED79
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427461F2527A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFB1E5714;
	Wed,  6 Nov 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lWK9j1XR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC261E501B;
	Wed,  6 Nov 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898396; cv=none; b=sLa6yQSJyBYb3cf2y8ZEyd+A0PelMOyz1OJYGkQhL2Ig83IBZHYX3n7nGmcSoZlMqiI+ib3lSBSqyVdMPFmL9Hj9W/bHtbhnLTZJgS10zyVuJhoDdsRxqrNDuvOdg/m7P6DVignx8PgI5T4+jHEDqtlu+vwz/ts9frQEY1pYsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898396; c=relaxed/simple;
	bh=9nWP/o/1pflWgRFtBXfkdnEYxX74L8elsuqRUpGJ2xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7ZI3y9IP5NRId6cHnHgXe0gyRKCPFDWm33x1L08bo8NvmFK7cbkctiL+Mrj+Wt6KaKZpLr7EujVFbqO3SHkimnYE+lpnWf+9+2D326OjPq7Sh82/RDFRqIMLh4nZCyFNWgvzyj6FYFDvjm2AT728yxOmMrcmccrymibEjtUgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lWK9j1XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A43C4CECD;
	Wed,  6 Nov 2024 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898396;
	bh=9nWP/o/1pflWgRFtBXfkdnEYxX74L8elsuqRUpGJ2xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWK9j1XRi1SCOsDE/CwhldLJ2xblm8OtwpswIeVj43HDJBNPLPI1tWmJQc5Un/Buw
	 Od8s/HtCKVhfghG/ETlzdw9JQaxOHFM9Qf9lNpevAj6FUTQ4FpHdgXIez2gYYDYPYd
	 q/XnS/DeY1/qyHrR48e5JyN3Os+om31m+7BevIvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Subject: [PATCH 5.4 223/462] jfs: Fix uaf in dbFreeBits
Date: Wed,  6 Nov 2024 13:01:56 +0100
Message-ID: <20241106120337.028906079@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234 ]

[syzbot reported]
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff8880229254b0 by task syz-executor357/5216

CPU: 0 UID: 0 PID: 5216 Comm: syz-executor357 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 dbFreeBits+0x7ea/0xd90 fs/jfs/jfs_dmap.c:2390
 dbFreeDmap fs/jfs/jfs_dmap.c:2089 [inline]
 dbFree+0x35b/0x680 fs/jfs/jfs_dmap.c:409
 dbDiscardAG+0x8a9/0xa20 fs/jfs/jfs_dmap.c:1650
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Freed by task 5218:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 dbUnmount+0x11d/0x190 fs/jfs/jfs_dmap.c:278
 jfs_mount_rw+0x4ac/0x6a0 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3d1/0x6b0 fs/jfs/super.c:454
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:263 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb6e/0xf80 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[Analysis]
There are two paths (dbUnmount and jfs_ioc_trim) that generate race
condition when accessing bmap, which leads to the occurrence of uaf.

Use the lock s_umount to synchronize them, in order to avoid uaf caused
by race condition.

Reported-and-tested-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_discard.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 575cb2ba74fc8..5f4b305030ad5 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -65,7 +65,7 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct bmap *bmp;
 	struct super_block *sb = ipbmap->i_sb;
 	int agno, agno_end;
 	u64 start, end, minlen;
@@ -83,10 +83,15 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	if (minlen == 0)
 		minlen = 1;
 
+	down_read(&sb->s_umount);
+	bmp = JFS_SBI(ip->i_sb)->bmap;
+
 	if (minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
-	    range->len < sb->s_blocksize)
+	    range->len < sb->s_blocksize) {
+		up_read(&sb->s_umount);
 		return -EINVAL;
+	}
 
 	if (end >= bmp->db_mapsize)
 		end = bmp->db_mapsize - 1;
@@ -100,6 +105,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
 	}
+
+	up_read(&sb->s_umount);
 	range->len = trimmed << sb->s_blocksize_bits;
 
 	return 0;
-- 
2.43.0




