Return-Path: <stable+bounces-189770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD5C0A9CC
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC23A2F5E
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642C257437;
	Sun, 26 Oct 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iqw55hvk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14C225A3B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488416; cv=none; b=LobslfqaEzWqZ95nsajzP2sqLG6XjVHvreKQhad5YGPZ6Xi3H6XCbWK+pFBN6rzBLVWmW8oDRHvukxt2hKydidb6gt/R6AfbIemVrq+PThgfQS8km/Lr2Ziyryckw6GBJh3vkyO8tWFQCRLrIL8YIlEUOkJJQwGNr/ynEaWwOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488416; c=relaxed/simple;
	bh=/fAqn/Dv5y0U+6dscxHEEWI9qUTqcJn/hnNZgYPHVAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dKc0jFgUxAYKIM0t/tIY76XAscWItL58gUkbQxf49IuwHyZv8G+DAz6AnKgdXAlXuyB5vA78UC0vtlXshyx93VjI0GOdTLsUTu5ABtuevQWzzNtw+Mf0Gyp9CXSvKvm8AvU1dyEyJn7aXdmCKsUX6AKyBdqLieql8/OV+LY+eLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iqw55hvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E295C4CEE7;
	Sun, 26 Oct 2025 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488415;
	bh=/fAqn/Dv5y0U+6dscxHEEWI9qUTqcJn/hnNZgYPHVAc=;
	h=Subject:To:Cc:From:Date:From;
	b=Iqw55hvkgs0jQoOTEcK0oAgtKWmBBfH81SL6j3aVNqdLyzsxgJ8C4WzH72o7w6dk+
	 PA1KP0PZ7e1nbafqGalIWyTJlOcIpCdprJ+7FqenWoqAGTm6VGLDyoCN2VIVAF6WwT
	 pB2ybZ2jY+D/+B8P/mpKVHbcylacZPcxYHuoHjmA=
Subject: FAILED: patch "[PATCH] fs/notify: call exportfs_encode_fid with s_umount" failed to apply to 6.6-stable tree
To: acsjakub@amazon.de,amir73il@gmail.com,brauner@kernel.org,jack@suse.cz,miklos@szeredi.hu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:20:12 +0100
Message-ID: <2025102612-kissing-atrocious-4949@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102612-kissing-atrocious-4949@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a Mon Sep 17 00:00:00 2001
From: Jakub Acs <acsjakub@amazon.de>
Date: Wed, 1 Oct 2025 10:09:55 +0000
Subject: [PATCH] fs/notify: call exportfs_encode_fid with s_umount

Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
the overlayfs is being unmounted, can lead to dereferencing NULL ptr.

This issue was found by syzkaller.

Race Condition Diagram:

Thread 1                           Thread 2
--------                           --------

generic_shutdown_super()
 shrink_dcache_for_umount
  sb->s_root = NULL

                    |
                    |             vfs_read()
                    |              inotify_fdinfo()
                    |               * inode get from mark *
                    |               show_mark_fhandle(m, inode)
                    |                exportfs_encode_fid(inode, ..)
                    |                 ovl_encode_fh(inode, ..)
                    |                  ovl_check_encode_origin(inode)
                    |                   * deref i_sb->s_root *
                    |
                    |
                    v
 fsnotify_sb_delete(sb)

Which then leads to:

[   32.133461] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted 6.17.0-rc6 #22 PREEMPT(none)

<snip registers, unreliable trace>

[   32.143353] Call Trace:
[   32.143732]  ovl_encode_fh+0xd5/0x170
[   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
[   32.144425]  show_mark_fhandle+0xbe/0x1f0
[   32.145805]  inotify_fdinfo+0x226/0x2d0
[   32.146442]  inotify_show_fdinfo+0x1c5/0x350
[   32.147168]  seq_show+0x530/0x6f0
[   32.147449]  seq_read_iter+0x503/0x12a0
[   32.148419]  seq_read+0x31f/0x410
[   32.150714]  vfs_read+0x1f0/0x9e0
[   32.152297]  ksys_read+0x125/0x240

IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
to NULL in the unmount path.

Fix it by protecting calling exportfs_encode_fid() from
show_mark_fhandle() with s_umount lock.

This form of fix was suggested by Amir in [1].

[1]: https://lore.kernel.org/all/CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com/

Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1161eabf11ee..9cc7eb863643 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 
 	size = f->handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 


