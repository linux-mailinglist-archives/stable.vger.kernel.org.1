Return-Path: <stable+bounces-99772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA89E7348
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B498A16A7E4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D6206F3B;
	Fri,  6 Dec 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSz6uZBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907841527AC;
	Fri,  6 Dec 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498298; cv=none; b=adriD5ll6OGF/60p9AsHhkRy1YOk/M0oIDqlBaISJG0WryOA8+TJtqa2yvPSv6IoQVsnSfaLX+LsllX9J8ujX6OHtvpGtQEP4vJ93hDCsz9lIvVDdO0vFKbp9ERQLriHziCmgnsZUrBK5zmlhChSn91CsnH+lGyZQWySQDclh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498298; c=relaxed/simple;
	bh=Y8ftVIwwbncsJhL5HC7LCtCjrMV+bUiTmwvecE6wcgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0SWMpCtaHBLD5pEbpjSonN0Urlc0fapmpWVv9lTvyOdhVbRjUliOu8Y52CCf4dAjrtiR2VhtNZzwwJmBh4anNO4ifhOTHRCR98i3MZ+wemZwJi/6P7TE6BO5o+7vfOIAGnLhVoy5UkCfK+1FLf1X0P8LvN9BiehFCnILSvxMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSz6uZBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CF4C4CED1;
	Fri,  6 Dec 2024 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498298;
	bh=Y8ftVIwwbncsJhL5HC7LCtCjrMV+bUiTmwvecE6wcgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSz6uZBz74OvW8rY17Q+BVb107p1008EhqQZGUtBslV625abQpOpfDsJAXuZLyFTB
	 gOicBDP8cAxVJ22y1uMIbMpGZf8gSB8WpNlWg1i4S5/8+SkJr+A0sdoGHVym8dbFFS
	 p0inTzvzYrASLGNwML6NzbmX0nydq2xpcktiO91c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Aurich <paul@darkrain42.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 543/676] smb: prevent use-after-free due to open_cached_dir error paths
Date: Fri,  6 Dec 2024 15:36:02 +0100
Message-ID: <20241206143714.569336809@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Aurich <paul@darkrain42.org>

commit a9685b409a03b73d2980bbfa53eb47555802d0a9 upstream.

If open_cached_dir() encounters an error parsing the lease from the
server, the error handling may race with receiving a lease break,
resulting in open_cached_dir() freeing the cfid while the queued work is
pending.

Update open_cached_dir() to drop refs rather than directly freeing the
cfid.

Have cached_dir_lease_break(), cfids_laundromat_worker(), and
invalidate_all_cached_dirs() clear has_lease immediately while still
holding cfids->cfid_list_lock, and then use this to also simplify the
reference counting in cfids_laundromat_worker() and
invalidate_all_cached_dirs().

Fixes this KASAN splat (which manually injects an error and lease break
in open_cached_dir()):

==================================================================
BUG: KASAN: slab-use-after-free in smb2_cached_lease_break+0x27/0xb0
Read of size 8 at addr ffff88811cc24c10 by task kworker/3:1/65

CPU: 3 UID: 0 PID: 65 Comm: kworker/3:1 Not tainted 6.12.0-rc6-g255cf264e6e5-dirty #87
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
Workqueue: cifsiod smb2_cached_lease_break
Call Trace:
 <TASK>
 dump_stack_lvl+0x77/0xb0
 print_report+0xce/0x660
 kasan_report+0xd3/0x110
 smb2_cached_lease_break+0x27/0xb0
 process_one_work+0x50a/0xc50
 worker_thread+0x2ba/0x530
 kthread+0x17c/0x1c0
 ret_from_fork+0x34/0x60
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 open_cached_dir+0xa7d/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x51/0x70
 kfree+0x174/0x520
 open_cached_dir+0x97f/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 __kasan_record_aux_stack+0xad/0xc0
 insert_work+0x32/0x100
 __queue_work+0x5c9/0x870
 queue_work_on+0x82/0x90
 open_cached_dir+0x1369/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff88811cc24c00
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
 freed 1024-byte region [ffff88811cc24c00, ffff88811cc25000)

Cc: stable@vger.kernel.org
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |   70 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -348,6 +348,7 @@ oshr_free:
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+out:
 	if (rc) {
 		spin_lock(&cfids->cfid_list_lock);
 		if (cfid->on_list) {
@@ -359,23 +360,14 @@ oshr_free:
 			/*
 			 * We are guaranteed to have two references at this
 			 * point. One for the caller and one for a potential
-			 * lease. Release the Lease-ref so that the directory
-			 * will be closed when the caller closes the cached
-			 * handle.
+			 * lease. Release one here, and the second below.
 			 */
 			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
 			kref_put(&cfid->refcount, smb2_close_cached_fid);
-			goto out;
 		}
 		spin_unlock(&cfids->cfid_list_lock);
-	}
-out:
-	if (rc) {
-		if (cfid->is_open)
-			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
-				   cfid->fid.volatile_fid);
-		free_cached_dir(cfid);
+
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	} else {
 		*ret_cfid = cfid;
 		atomic_inc(&tcon->num_remote_opens);
@@ -513,25 +505,24 @@ void invalidate_all_cached_dirs(struct c
 		cfids->num_entries--;
 		cfid->is_open = false;
 		cfid->on_list = false;
-		/* To prevent race with smb2_cached_lease_break() */
-		kref_get(&cfid->refcount);
+		if (cfid->has_lease) {
+			/*
+			 * The lease was never cancelled from the server,
+			 * so steal that reference.
+			 */
+			cfid->has_lease = false;
+		} else
+			kref_get(&cfid->refcount);
 	}
 	spin_unlock(&cfids->cfid_list_lock);
 
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
 		list_del(&cfid->entry);
 		cancel_work_sync(&cfid->lease_break);
-		if (cfid->has_lease) {
-			/*
-			 * We lease was never cancelled from the server so we
-			 * need to drop the reference.
-			 */
-			spin_lock(&cfids->cfid_list_lock);
-			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
-		}
-		/* Drop the extra reference opened above*/
+		/*
+		 * Drop the ref-count from above, either the lease-ref (if there
+		 * was one) or the extra one acquired.
+		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 }
@@ -542,9 +533,6 @@ smb2_cached_lease_break(struct work_stru
 	struct cached_fid *cfid = container_of(work,
 				struct cached_fid, lease_break);
 
-	spin_lock(&cfid->cfids->cfid_list_lock);
-	cfid->has_lease = false;
-	spin_unlock(&cfid->cfids->cfid_list_lock);
 	kref_put(&cfid->refcount, smb2_close_cached_fid);
 }
 
@@ -562,6 +550,7 @@ int cached_dir_lease_break(struct cifs_t
 		    !memcmp(lease_key,
 			    cfid->fid.lease_key,
 			    SMB2_LEASE_KEY_SIZE)) {
+			cfid->has_lease = false;
 			cfid->time = 0;
 			/*
 			 * We found a lease remove it from the list
@@ -639,8 +628,14 @@ static void cfids_laundromat_worker(stru
 			cfid->on_list = false;
 			list_move(&cfid->entry, &entry);
 			cfids->num_entries--;
-			/* To prevent race with smb2_cached_lease_break() */
-			kref_get(&cfid->refcount);
+			if (cfid->has_lease) {
+				/*
+				 * Our lease has not yet been cancelled from the
+				 * server. Steal that reference.
+				 */
+				cfid->has_lease = false;
+			} else
+				kref_get(&cfid->refcount);
 		}
 	}
 	spin_unlock(&cfids->cfid_list_lock);
@@ -652,17 +647,10 @@ static void cfids_laundromat_worker(stru
 		 * with it.
 		 */
 		cancel_work_sync(&cfid->lease_break);
-		if (cfid->has_lease) {
-			/*
-			 * Our lease has not yet been cancelled from the server
-			 * so we need to drop the reference.
-			 */
-			spin_lock(&cfids->cfid_list_lock);
-			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
-		}
-		/* Drop the extra reference opened above */
+		/*
+		 * Drop the ref-count from above, either the lease-ref (if there
+		 * was one) or the extra one acquired.
+		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 	queue_delayed_work(cifsiod_wq, &cfids->laundromat_work,



