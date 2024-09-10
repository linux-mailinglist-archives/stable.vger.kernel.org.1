Return-Path: <stable+bounces-74287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D6972E7F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F6F1C210B6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827118B487;
	Tue, 10 Sep 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gruCQWrZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA435188CC4;
	Tue, 10 Sep 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961364; cv=none; b=UXT9X1XyNvXCdxEKUP+Ov+WBDeP+41IWTVMuIEzUH7m+G+tbRYU0tOgekYiob7p+IqhsietWw+jRFaak7hC+1JhZi5mrU+5eH5MYrvty3bf8VVPGiM+Sqe+FLcRjxUrdAxSM+nhMb9UnqEieDXaSxN8VLmDBksTefnLpIlM/W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961364; c=relaxed/simple;
	bh=3HrTE1JEcFoEeGesYAvz9f+v9T+9Or22t3SmoPyk5Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLE07VbD8U9gVW6NVXeY991GoM7IZnCtfUpJUufhzkO25Pv88PTaandUXpV0pImhsFlyV0BATcDICYKEc13v0TWBF9Gp4ZCnX+WVuJkwv8PnyR43sKRQLxXtN/+scN6v7T/xjhxxXALVuBDGLn66RzhmjTOS2GDFbWVgE/Q8I7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gruCQWrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528FBC4CEC3;
	Tue, 10 Sep 2024 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961364;
	bh=3HrTE1JEcFoEeGesYAvz9f+v9T+9Or22t3SmoPyk5Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gruCQWrZlZEEXLo1BNH8kYM5U2GQGOdenFV9umGYjoYUQWi/Sta1CLTJlTi7ejdSL
	 ri+ovXvYVW3LOh0cp1YJ2wwv4fF5QRtnFCu7O/N8MEXYqiqspNypCaNAnn//6NoTq2
	 9NWzhfc7kaveBoQ20GmcFiW+9zXCzYFT9b4WGwyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 017/375] smb: client: fix double put of @cfile in smb2_set_path_size()
Date: Tue, 10 Sep 2024 11:26:54 +0200
Message-ID: <20240910092622.845973321@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

commit f9c169b51b6ce20394594ef674d6b10efba31220 upstream.

If smb2_compound_op() is called with a valid @cfile and returned
-EINVAL, we need to call cifs_get_writable_path() before retrying it
as the reference of @cfile was already dropped by previous call.

This fixes the following KASAN splat when running fstests generic/013
against Windows Server 2022:

  CIFS: Attempting to mount //w22-fs0/scratch
  run fstests generic/013 at 2024-09-02 19:48:59
  ==================================================================
  BUG: KASAN: slab-use-after-free in detach_if_pending+0xab/0x200
  Write of size 8 at addr ffff88811f1a3730 by task kworker/3:2/176

  CPU: 3 UID: 0 PID: 176 Comm: kworker/3:2 Not tainted 6.11.0-rc6 #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40
  04/01/2014
  Workqueue: cifsoplockd cifs_oplock_break [cifs]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   ? detach_if_pending+0xab/0x200
   print_report+0x156/0x4d9
   ? detach_if_pending+0xab/0x200
   ? __virt_addr_valid+0x145/0x300
   ? __phys_addr+0x46/0x90
   ? detach_if_pending+0xab/0x200
   kasan_report+0xda/0x110
   ? detach_if_pending+0xab/0x200
   detach_if_pending+0xab/0x200
   timer_delete+0x96/0xe0
   ? __pfx_timer_delete+0x10/0x10
   ? rcu_is_watching+0x20/0x50
   try_to_grab_pending+0x46/0x3b0
   __cancel_work+0x89/0x1b0
   ? __pfx___cancel_work+0x10/0x10
   ? kasan_save_track+0x14/0x30
   cifs_close_deferred_file+0x110/0x2c0 [cifs]
   ? __pfx_cifs_close_deferred_file+0x10/0x10 [cifs]
   ? __pfx_down_read+0x10/0x10
   cifs_oplock_break+0x4c1/0xa50 [cifs]
   ? __pfx_cifs_oplock_break+0x10/0x10 [cifs]
   ? lock_is_held_type+0x85/0xf0
   ? mark_held_locks+0x1a/0x90
   process_one_work+0x4c6/0x9f0
   ? find_held_lock+0x8a/0xa0
   ? __pfx_process_one_work+0x10/0x10
   ? lock_acquired+0x220/0x550
   ? __list_add_valid_or_report+0x37/0x100
   worker_thread+0x2e4/0x570
   ? __kthread_parkme+0xd1/0xf0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x17f/0x1c0
   ? kthread+0xda/0x1c0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x31/0x60
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 1118:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0xaa/0xb0
   cifs_new_fileinfo+0xc8/0x9d0 [cifs]
   cifs_atomic_open+0x467/0x770 [cifs]
   lookup_open.isra.0+0x665/0x8b0
   path_openat+0x4c3/0x1380
   do_filp_open+0x167/0x270
   do_sys_openat2+0x129/0x160
   __x64_sys_creat+0xad/0xe0
   do_syscall_64+0xbb/0x1d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Freed by task 83:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x70
   poison_slab_object+0xe9/0x160
   __kasan_slab_free+0x32/0x50
   kfree+0xf2/0x300
   process_one_work+0x4c6/0x9f0
   worker_thread+0x2e4/0x570
   kthread+0x17f/0x1c0
   ret_from_fork+0x31/0x60
   ret_from_fork_asm+0x1a/0x30

  Last potentially related work creation:
   kasan_save_stack+0x30/0x50
   __kasan_record_aux_stack+0xad/0xc0
   insert_work+0x29/0xe0
   __queue_work+0x5ea/0x760
   queue_work_on+0x6d/0x90
   _cifsFileInfo_put+0x3f6/0x770 [cifs]
   smb2_compound_op+0x911/0x3940 [cifs]
   smb2_set_path_size+0x228/0x270 [cifs]
   cifs_set_file_size+0x197/0x460 [cifs]
   cifs_setattr+0xd9c/0x14b0 [cifs]
   notify_change+0x4e3/0x740
   do_truncate+0xfa/0x180
   vfs_truncate+0x195/0x200
   __x64_sys_truncate+0x109/0x150
   do_syscall_64+0xbb/0x1d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 71f15c90e785 ("smb: client: retry compound request without reusing lease")
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1149,6 +1149,7 @@ smb2_set_path_size(const unsigned int xi
 			      cfile, NULL, NULL, dentry);
 	if (rc == -EINVAL) {
 		cifs_dbg(FYI, "invalid lease key, resending request without lease");
+		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb,
 				      full_path, &oparms, &in_iov,
 				      &(int){SMB2_OP_SET_EOF}, 1,



