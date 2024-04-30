Return-Path: <stable+bounces-42517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B118B7366
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7902F1F2387E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806912D1EA;
	Tue, 30 Apr 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbAsLdxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6C12C805;
	Tue, 30 Apr 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475918; cv=none; b=UldLmRXE46m+Inrz9+yKA4KACL6HWvn4UDVub5AiQEVTpOZMLfNslO/YuxZwU7feIvD7KOVgg56V0wu7CArrzzbfIJZP3br9fljVMPA+OzZzAJ6kzlk4ug3gOEYqTlAHKPvNeWLXAChPs5tItrsvk0XN6053g4e9YShac9l7UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475918; c=relaxed/simple;
	bh=tC/cEWiKCFjFItPJOL5n6uO/fAjICtNMCiZurj6py38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCHH3QYk5PnUH0Mar9Uj/E/uOFzYlYYN0/rTSUR1JWoabWT2Rj3eWO+0b4TGNNpkZrkzbtPs1CEZ2QvNyICiyEEhqP6uIz2sJmYUwSQj1WkzL5xhKLhFe9G6TFHnM6fRR21ytz2fDnVU/YXgTEt6fW79AKCuLJSAhp5qa8F0jVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbAsLdxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B98C2BBFC;
	Tue, 30 Apr 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475917;
	bh=tC/cEWiKCFjFItPJOL5n6uO/fAjICtNMCiZurj6py38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbAsLdxwpKekwqD++i3fgkjRGVR6qBDi1TA6YZ8aDZmuTO/jXMSLDRrcbr5pza3Ji
	 JC7oZdWWt0CCNxPdagGNZAp6+SZyMCWIH4+JQSjbAdMhP8ViIstQpcT9BjEPKQK9QL
	 Pvn9Z+5fCgOSqM89g58MfULHtmxg0sFGaEXcDcAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <Johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 57/80] btrfs: fix information leak in btrfs_ioctl_logical_to_ino()
Date: Tue, 30 Apr 2024 12:40:29 +0200
Message-ID: <20240430103045.102146876@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2315,20 +2315,14 @@ struct btrfs_data_container *init_data_c
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



