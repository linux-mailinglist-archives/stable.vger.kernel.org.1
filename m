Return-Path: <stable+bounces-203588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DBCE6F4F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1C5530181A9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7F23F294;
	Mon, 29 Dec 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAHa4sPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49920DD52
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016810; cv=none; b=Ju52pkAKxob0vkJTWQTYcBx7oToST/sllDOuiMZRXaBphjH3iAwNBDCz332IDf4SjFf88ODKdwxDN4Aeb6rNE4n8P7PSL7mWyJ+jdbOSfwpCTPUFN4kHAneAAysAinsnvcVtNtY1M8z4GaRn9fof1zzFq2lzNFQAzst0RFnQ4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016810; c=relaxed/simple;
	bh=GMgg9H1gMxJ5g4n88Ch7au804HnivFxMTs6LLzKRsEg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jRa+PD7ERjS1x+6QRSy1GjvpSrXM/ts70hZoLxvMU6TOgpk3ZMimi5shmRtpKDRIwr4qAYViVF6CghY+v+D/bwgUnx1Vw/+U88zTPwnbI5AsxUJILIwV34g7+D78pMCPlb+0TafKfBXKm6Iq+LGWKP0wyTXVkklpDBL57HVbRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAHa4sPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F99C4CEF7;
	Mon, 29 Dec 2025 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016810;
	bh=GMgg9H1gMxJ5g4n88Ch7au804HnivFxMTs6LLzKRsEg=;
	h=Subject:To:Cc:From:Date:From;
	b=fAHa4sPblB4vVWx5GVRwk3pP6u4Fh1s0CNyqQKFprOrqwQ7C2FZPHqD8eilL1M5Pb
	 5ez9WPnfucrymq89f57AwLQ1ZAEh3p3p5fD6OuEU/+y45iL97PyfrhRHhmNRwnl4pk
	 4dHk1g/3306D7rSNGS1sik3hZ2j0Z8e5eThm0+cg=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid updating zero-sized extent in extent cache" failed to apply to 6.1-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:59:59 +0100
Message-ID: <2025122959-opposing-shabby-fc70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7c37c79510329cd951a4dedf3f7bf7e2b18dccec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122959-opposing-shabby-fc70@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c37c79510329cd951a4dedf3f7bf7e2b18dccec Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 20 Oct 2025 10:42:12 +0800
Subject: [PATCH] f2fs: fix to avoid updating zero-sized extent in extent cache

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

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffa045b39c01..c045e38e60ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1654,8 +1654,11 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
-	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
-	f2fs_update_age_extent_cache_range(dn, start, index - start);
+	if (index > start) {
+		f2fs_update_read_extent_cache_range(dn, start, 0,
+							index - start);
+		f2fs_update_age_extent_cache_range(dn, start, index - start);
+	}
 
 	return ret;
 }


