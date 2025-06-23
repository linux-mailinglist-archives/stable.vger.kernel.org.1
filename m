Return-Path: <stable+bounces-156841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A484AE515C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65638441BB0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C422068B;
	Mon, 23 Jun 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HF0UG/PF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA201DDC04;
	Mon, 23 Jun 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714397; cv=none; b=lPTbMX3/QoI1Urz39c9iGU+JkZVdXl0eEa6FoN3ORlaVossEbifWd4ZkapY4GdvAqzbdVqAzri3yd6P5Jrg4kt85viaWULN7+wOxgmwgRyIKxYO6zNysGaGwLBFpSLvdo/LeIInVHU34NfZViwH0m0KnWreFF8RW8gDAAD+zIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714397; c=relaxed/simple;
	bh=03dSJbTlFbF2loXrbpdePQmukLIVcYmR5BoF+7Zv2t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9RCUaQtH4i6fhGT4FaDgAzQN8WF+cG/8P8NFoa8PAImZV1Ty9VRPTEMuRIh+wezs0EVHqGypEEZjCjnNTL6L4l3hwRd0RoD/BhjUGfXbbrYVNf/p4QK2/JkGkx7bpKz29/vUCuCioIaOn9B9Mgc/cfo9S5z0jzUg/+yG0E5Zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HF0UG/PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACABC4CEEA;
	Mon, 23 Jun 2025 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714397;
	bh=03dSJbTlFbF2loXrbpdePQmukLIVcYmR5BoF+7Zv2t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF0UG/PF6BSn7Fny/w+y/P7qeWeM4igC3/8+HnVOE31ZjeJhVyNTjtnxHE/LeKvjz
	 blXfvXcCqeI0NF7vMNia5AZsohL23ExPiPE5GVfTTe7hCjF0kYAcYRITOTHkLBkPAd
	 UKJwSowiwF4L6PGcwrj90QWjM7gtBwJa9RUqnbbY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.12 100/414] f2fs: prevent kernel warning due to negative i_nlink from corrupted image
Date: Mon, 23 Jun 2025 15:03:57 +0200
Message-ID: <20250623130644.603396485@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 42cb74a92adaf88061039601ddf7c874f58b554e upstream.

WARNING: CPU: 1 PID: 9426 at fs/inode.c:417 drop_nlink+0xac/0xd0
home/cc/linux/fs/inode.c:417
Modules linked in:
CPU: 1 UID: 0 PID: 9426 Comm: syz-executor568 Not tainted
6.14.0-12627-g94d471a4f428 #2 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:drop_nlink+0xac/0xd0 home/cc/linux/fs/inode.c:417
Code: 48 8b 5d 28 be 08 00 00 00 48 8d bb 70 07 00 00 e8 f9 67 e6 ff
f0 48 ff 83 70 07 00 00 5b 5d e9 9a 12 82 ff e8 95 12 82 ff 90
&lt;0f&gt; 0b 90 c7 45 48 ff ff ff ff 5b 5d e9 83 12 82 ff e8 fe 5f e6
ff
RSP: 0018:ffffc900026b7c28 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8239710f
RDX: ffff888041345a00 RSI: ffffffff8239717b RDI: 0000000000000005
RBP: ffff888054509ad0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff9ab36f08 R12: ffff88804bb40000
R13: ffff8880545091e0 R14: 0000000000008000 R15: ffff8880545091e0
FS:  000055555d0c5880(0000) GS:ffff8880eb3e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f915c55b178 CR3: 0000000050d20000 CR4: 0000000000352ef0
Call Trace:
 <task>
 f2fs_i_links_write home/cc/linux/fs/f2fs/f2fs.h:3194 [inline]
 f2fs_drop_nlink+0xd1/0x3c0 home/cc/linux/fs/f2fs/dir.c:845
 f2fs_delete_entry+0x542/0x1450 home/cc/linux/fs/f2fs/dir.c:909
 f2fs_unlink+0x45c/0x890 home/cc/linux/fs/f2fs/namei.c:581
 vfs_unlink+0x2fb/0x9b0 home/cc/linux/fs/namei.c:4544
 do_unlinkat+0x4c5/0x6a0 home/cc/linux/fs/namei.c:4608
 __do_sys_unlink home/cc/linux/fs/namei.c:4654 [inline]
 __se_sys_unlink home/cc/linux/fs/namei.c:4652 [inline]
 __x64_sys_unlink+0xc5/0x110 home/cc/linux/fs/namei.c:4652
 do_syscall_x64 home/cc/linux/arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc7/0x250 home/cc/linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb3d092324b
Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05
&lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01
48
RSP: 002b:00007ffdc232d938 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb3d092324b
RDX: 00007ffdc232d960 RSI: 00007ffdc232d960 RDI: 00007ffdc232d9f0
RBP: 00007ffdc232d9f0 R08: 0000000000000001 R09: 00007ffdc232d7c0
R10: 00000000fffffffd R11: 0000000000000206 R12: 00007ffdc232eaf0
R13: 000055555d0cebb0 R14: 00007ffdc232d958 R15: 0000000000000001
 </task>

Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/namei.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -560,6 +560,15 @@ static int f2fs_unlink(struct inode *dir
 		goto fail;
 	}
 
+	if (unlikely(inode->i_nlink == 0)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		err = -EFSCORRUPTED;
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		f2fs_put_page(page, 0);
+		goto fail;
+	}
+
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);



