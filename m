Return-Path: <stable+bounces-42654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8F8B7402
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91681C233A4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737E12C805;
	Tue, 30 Apr 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1QUFMl5M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01912CDAE;
	Tue, 30 Apr 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476355; cv=none; b=qM9K8ks/DSjyGde+gUVe3+rDbAvLEkPebuiU6DaAccOKVhsA2Zr7u7i7x3dCkiL1gBu0ynos+CQfkHOKTSZehmJCOX1xte1eSMAxn9EuVAuUYrejJMt1k+98bTvGRIkpGtrKncprLlADD0wJFVdWQNuAmo0E/XkqUxwvyI8ZAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476355; c=relaxed/simple;
	bh=DVC1Jz2IDRBWYFT760/NhZ8IcWhNN/XghmMJZmMiANw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB873n0aqAegdWOnWpqkZxe7xaaW4SD2alCj1UrAum8Ibn2pnfThYTHkowH09lH+MomAOCDnPEIYVOZhLIX2XOG54oEbokvAWMJ6tHwvmbrjMUQ3nPRihWk34aara9QR5Ao02gEcNmCbkh4qnlsKDbrTShpCGuu7XuHp2ANi+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1QUFMl5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB9C4AF19;
	Tue, 30 Apr 2024 11:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476355;
	bh=DVC1Jz2IDRBWYFT760/NhZ8IcWhNN/XghmMJZmMiANw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1QUFMl5M+llg8+EAoiIHREvUfRyJwPUbqGVuRZF9J19KOGtLXCWUBUjQfOkXoaU0z
	 2Fbtg+sR4uVt5efakzzjXGYx50ZPHuAYpucERuSBI9j8y0HGSIuxo9CvudHc6/OVoA
	 Ft7W9oPCVWqO70YU6tnUP8m9x+N1tkQgb+BKWvjM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <Johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 090/107] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
Date: Tue, 30 Apr 2024 12:40:50 +0200
Message-ID: <20240430103047.313938871@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 2f7ef5bb4a2f3e481ef05fab946edb97c84f67cf upstream.

Syzbot reported the following information leak for in
btrfs_ioctl_logical_to_ino():

  BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
  BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
   instrument_copy_to_user include/linux/instrumented.h:114 [inline]
   _copy_to_user+0xbc/0x110 lib/usercopy.c:40
   copy_to_user include/linux/uaccess.h:191 [inline]
   btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
   btrfs_ioctl+0x714/0x1260
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:904 [inline]
   __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
   __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
   x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Uninit was created at:
   __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
   __do_kmalloc_node mm/slub.c:3954 [inline]
   __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
   kmalloc_node include/linux/slab.h:648 [inline]
   kvmalloc_node+0xc0/0x2d0 mm/util.c:634
   kvmalloc include/linux/slab.h:766 [inline]
   init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
   btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
   btrfs_ioctl+0x714/0x1260
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:904 [inline]
   __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
   __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
   x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Bytes 40-65535 of 65536 are uninitialized
  Memory access of size 65536 starts at ffff888045a40000

This happens, because we're copying a 'struct btrfs_data_container' back
to user-space. This btrfs_data_container is allocated in
'init_data_container()' via kvmalloc(), which does not zero-fill the
memory.

Fix this by using kvzalloc() which zeroes out the memory on allocation.

CC: stable@vger.kernel.org # 4.14+
Reported-by:  <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/backref.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2291,20 +2291,14 @@ struct btrfs_data_container *init_data_c
 	size_t alloc_bytes;
 
 	alloc_bytes = max_t(size_t, total_bytes, sizeof(*data));
-	data = kvmalloc(alloc_bytes, GFP_KERNEL);
+	data = kvzalloc(alloc_bytes, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	if (total_bytes >= sizeof(*data)) {
+	if (total_bytes >= sizeof(*data))
 		data->bytes_left = total_bytes - sizeof(*data);
-		data->bytes_missing = 0;
-	} else {
+	else
 		data->bytes_missing = sizeof(*data) - total_bytes;
-		data->bytes_left = 0;
-	}
-
-	data->elem_cnt = 0;
-	data->elem_missed = 0;
 
 	return data;
 }



