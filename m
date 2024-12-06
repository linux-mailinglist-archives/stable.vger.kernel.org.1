Return-Path: <stable+bounces-99771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C019E7347
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FF81699B1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA82066D6;
	Fri,  6 Dec 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsVDu8UD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D117C208;
	Fri,  6 Dec 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498295; cv=none; b=lk/tUAP68t14m2Lj8i+0EuVbzmSrCst35P7gsoFgbI4nPZb3xHZJXQgUtLaf0CAqhT5mjUl9Y56v50m2y3qXjNJEY5D+ui5eA6bNchmfq0uBYw+inFi0/1l8mc0qRKem8U9zsO4qwPBgd+P3YmqOjll3ZPxSAsD6Pmv/00ywyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498295; c=relaxed/simple;
	bh=yJMVZAQPNwZxFEhxaLs8IWpN/Y8TZXbRBd3zF0+5f7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7BvU92dhyc8FuuYOQMKuoqVejED4yNBhLOZEBCqnIxed4zibsGnE+yhYldxyDvNjm5V/PYEKiHbdzF4vPmNmU1TWJ/PprOc54YASNQdUQiZt50MA5usVDbziJcbyGP0xxrCTf5NLSJv0UkGf39QySgIhfP6ovQwq8kQWhuoqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsVDu8UD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E6CC4CED1;
	Fri,  6 Dec 2024 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498295;
	bh=yJMVZAQPNwZxFEhxaLs8IWpN/Y8TZXbRBd3zF0+5f7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsVDu8UDZOzflch7EODIcMcoUT1kuw1Y3JF2WFzUt+1wIaCFbcjfwSEoXLQJyass2
	 CXdtIIVVXYa0z1Z0wDll1kmvSo6Z7pU24BrbnCRTe1YF7dcapZVQDcaMBmE2HObcOM
	 jpdoUe34Lah0PSRstLCd+F4+76/oME2lNlrXDY1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Aurich <paul@darkrain42.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 542/676] smb: Dont leak cfid when reconnect races with open_cached_dir
Date: Fri,  6 Dec 2024 15:36:01 +0100
Message-ID: <20241206143714.530763748@linuxfoundation.org>
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

commit 7afb86733685c64c604d32faf00fa4a1f22c2ab1 upstream.

open_cached_dir() may either race with the tcon reconnection even before
compound_send_recv() or directly trigger a reconnection via
SMB2_open_init() or SMB_query_info_init().

The reconnection process invokes invalidate_all_cached_dirs() via
cifs_mark_open_files_invalid(), which removes all cfids from the
cfids->entries list but doesn't drop a ref if has_lease isn't true. This
results in the currently-being-constructed cfid not being on the list,
but still having a refcount of 2. It leaks if returned from
open_cached_dir().

Fix this by setting cfid->has_lease when the ref is actually taken; the
cfid will not be used by other threads until it has a valid time.

Addresses these kmemleaks:

unreferenced object 0xffff8881090c4000 (size 1024):
  comm "bash", pid 1860, jiffies 4295126592
  hex dump (first 32 bytes):
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
    00 ca 45 22 81 88 ff ff f8 dc 4f 04 81 88 ff ff  ..E"......O.....
  backtrace (crc 6f58c20f):
    [<ffffffff8b895a1e>] __kmalloc_cache_noprof+0x2be/0x350
    [<ffffffff8bda06e3>] open_cached_dir+0x993/0x1fb0
    [<ffffffff8bdaa750>] cifs_readdir+0x15a0/0x1d50
    [<ffffffff8b9a853f>] iterate_dir+0x28f/0x4b0
    [<ffffffff8b9a9aed>] __x64_sys_getdents64+0xfd/0x200
    [<ffffffff8cf6da05>] do_syscall_64+0x95/0x1a0
    [<ffffffff8d00012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881044fdcf8 (size 8):
  comm "bash", pid 1860, jiffies 4295126592
  hex dump (first 8 bytes):
    00 cc cc cc cc cc cc cc                          ........
  backtrace (crc 10c106a9):
    [<ffffffff8b89a3d3>] __kmalloc_node_track_caller_noprof+0x363/0x480
    [<ffffffff8b7d7256>] kstrdup+0x36/0x60
    [<ffffffff8bda0700>] open_cached_dir+0x9b0/0x1fb0
    [<ffffffff8bdaa750>] cifs_readdir+0x15a0/0x1d50
    [<ffffffff8b9a853f>] iterate_dir+0x28f/0x4b0
    [<ffffffff8b9a9aed>] __x64_sys_getdents64+0xfd/0x200
    [<ffffffff8cf6da05>] do_syscall_64+0x95/0x1a0
    [<ffffffff8d00012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

And addresses these BUG splats when unmounting the SMB filesystem:

BUG: Dentry ffff888140590ba0{i=1000000000080,n=/}  still in use (2) [unmount of cifs cifs]
WARNING: CPU: 3 PID: 3433 at fs/dcache.c:1536 umount_check+0xd0/0x100
Modules linked in:
CPU: 3 UID: 0 PID: 3433 Comm: bash Not tainted 6.12.0-rc4-g850925a8133c-dirty #49
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
RIP: 0010:umount_check+0xd0/0x100
Code: 8d 7c 24 40 e8 31 5a f4 ff 49 8b 54 24 40 41 56 49 89 e9 45 89 e8 48 89 d9 41 57 48 89 de 48 c7 c7 80 e7 db ac e8 f0 72 9a ff <0f> 0b 58 31 c0 5a 5b 5d 41 5c 41 5d 41 5e 41 5f e9 2b e5 5d 01 41
RSP: 0018:ffff88811cc27978 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888140590ba0 RCX: ffffffffaaf20bae
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8881f6fb6f40
RBP: ffff8881462ec000 R08: 0000000000000001 R09: ffffed1023984ee3
R10: ffff88811cc2771f R11: 00000000016cfcc0 R12: ffff888134383e08
R13: 0000000000000002 R14: ffff8881462ec668 R15: ffffffffaceab4c0
FS:  00007f23bfa98740(0000) GS:ffff8881f6f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556de4a6f808 CR3: 0000000123c80000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 d_walk+0x6a/0x530
 shrink_dcache_for_umount+0x6a/0x200
 generic_shutdown_super+0x52/0x2a0
 kill_anon_super+0x22/0x40
 cifs_kill_sb+0x159/0x1e0
 deactivate_locked_super+0x66/0xe0
 cleanup_mnt+0x140/0x210
 task_work_run+0xfb/0x170
 syscall_exit_to_user_mode+0x29f/0x2b0
 do_syscall_64+0xa1/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f23bfb93ae7
Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 0d 11 93 0d 00 f7 d8 64 89 01 b8 ff ff ff ff eb bf 0f 1f 44 00 00 b8 50 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 92 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffee9138598 EFLAGS: 00000246 ORIG_RAX: 0000000000000050
RAX: 0000000000000000 RBX: 0000558f1803e9a0 RCX: 00007f23bfb93ae7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000558f1803e9a0
RBP: 0000558f1803e600 R08: 0000000000000007 R09: 0000558f17fab610
R10: d91d5ec34ab757b0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000015 R15: 0000000000000000
 </TASK>
irq event stamp: 1163486
hardirqs last  enabled at (1163485): [<ffffffffac98d344>] _raw_spin_unlock_irqrestore+0x34/0x60
hardirqs last disabled at (1163486): [<ffffffffac97dcfc>] __schedule+0xc7c/0x19a0
softirqs last  enabled at (1163482): [<ffffffffab79a3ee>] __smb_send_rqst+0x3de/0x990
softirqs last disabled at (1163480): [<ffffffffac2314f1>] release_sock+0x21/0xf0
---[ end trace 0000000000000000 ]---

VFS: Busy inodes after unmount of cifs (cifs)
------------[ cut here ]------------
kernel BUG at fs/super.c:661!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 3433 Comm: bash Tainted: G        W          6.12.0-rc4-g850925a8133c-dirty #49
Tainted: [W]=WARN
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
RIP: 0010:generic_shutdown_super+0x290/0x2a0
Code: e8 15 7c f7 ff 48 8b 5d 28 48 89 df e8 09 7c f7 ff 48 8b 0b 48 89 ee 48 8d 95 68 06 00 00 48 c7 c7 80 7f db ac e8 00 69 af ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90
RSP: 0018:ffff88811cc27a50 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffffae994420 RCX: 0000000000000027
RDX: 0000000000000000 RSI: ffffffffab06180e RDI: ffff8881f6eb18c8
RBP: ffff8881462ec000 R08: 0000000000000001 R09: ffffed103edd6319
R10: ffff8881f6eb18cb R11: 00000000016d3158 R12: ffff8881462ec9c0
R13: ffff8881462ec050 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f23bfa98740(0000) GS:ffff8881f6e80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8364005d68 CR3: 0000000123c80000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kill_anon_super+0x22/0x40
 cifs_kill_sb+0x159/0x1e0
 deactivate_locked_super+0x66/0xe0
 cleanup_mnt+0x140/0x210
 task_work_run+0xfb/0x170
 syscall_exit_to_user_mode+0x29f/0x2b0
 do_syscall_64+0xa1/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f23bfb93ae7
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x290/0x2a0
Code: e8 15 7c f7 ff 48 8b 5d 28 48 89 df e8 09 7c f7 ff 48 8b 0b 48 89 ee 48 8d 95 68 06 00 00 48 c7 c7 80 7f db ac e8 00 69 af ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90
RSP: 0018:ffff88811cc27a50 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffffae994420 RCX: 0000000000000027
RDX: 0000000000000000 RSI: ffffffffab06180e RDI: ffff8881f6eb18c8
RBP: ffff8881462ec000 R08: 0000000000000001 R09: ffffed103edd6319
R10: ffff8881f6eb18cb R11: 00000000016d3158 R12: ffff8881462ec9c0
R13: ffff8881462ec050 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f23bfa98740(0000) GS:ffff8881f6e80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8364005d68 CR3: 0000000123c80000 CR4: 0000000000350ef0

This reproduces eventually with an SMB mount and two shells running
these loops concurrently

- while true; do
      cd ~; sleep 1;
      for i in {1..3}; do cd /mnt/test/subdir;
          echo $PWD; sleep 1; cd ..; echo $PWD; sleep 1;
      done;
      echo ...;
  done
- while true; do
      iptables -F OUTPUT; mount -t cifs -a;
      for _ in {0..2}; do ls /mnt/test/subdir/ | wc -l; done;
      iptables -I OUTPUT -p tcp --dport 445 -j DROP;
      sleep 10
      echo "unmounting"; umount -l -t cifs -a; echo "done unmounting";
      sleep 20
      echo "recovering"; iptables -F OUTPUT;
      sleep 10;
  done

Fixes: ebe98f1447bb ("cifs: enable caching of directories for which a lease is held")
Fixes: 5c86919455c1 ("smb: client: fix use-after-free in smb2_query_info_compound()")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -59,6 +59,16 @@ static struct cached_fid *find_or_create
 	list_add(&cfid->entry, &cfids->entries);
 	cfid->on_list = true;
 	kref_get(&cfid->refcount);
+	/*
+	 * Set @cfid->has_lease to true during construction so that the lease
+	 * reference can be put in cached_dir_lease_break() due to a potential
+	 * lease break right after the request is sent or while @cfid is still
+	 * being cached, or if a reconnection is triggered during construction.
+	 * Concurrent processes won't be to use it yet due to @cfid->time being
+	 * zero.
+	 */
+	cfid->has_lease = true;
+
 	spin_unlock(&cfids->cfid_list_lock);
 	return cfid;
 }
@@ -176,12 +186,12 @@ replay_again:
 		return -ENOENT;
 	}
 	/*
-	 * Return cached fid if it has a lease.  Otherwise, it is either a new
-	 * entry or laundromat worker removed it from @cfids->entries.  Caller
-	 * will put last reference if the latter.
+	 * Return cached fid if it is valid (has a lease and has a time).
+	 * Otherwise, it is either a new entry or laundromat worker removed it
+	 * from @cfids->entries.  Caller will put last reference if the latter.
 	 */
 	spin_lock(&cfids->cfid_list_lock);
-	if (cfid->has_lease) {
+	if (cfid->has_lease && cfid->time) {
 		spin_unlock(&cfids->cfid_list_lock);
 		*ret_cfid = cfid;
 		kfree(utf16_path);
@@ -267,15 +277,6 @@ replay_again:
 
 	smb2_set_related(&rqst[1]);
 
-	/*
-	 * Set @cfid->has_lease to true before sending out compounded request so
-	 * its lease reference can be put in cached_dir_lease_break() due to a
-	 * potential lease break right after the request is sent or while @cfid
-	 * is still being cached.  Concurrent processes won't be to use it yet
-	 * due to @cfid->time being zero.
-	 */
-	cfid->has_lease = true;
-
 	if (retries) {
 		smb2_set_replay(server, &rqst[0]);
 		smb2_set_replay(server, &rqst[1]);



