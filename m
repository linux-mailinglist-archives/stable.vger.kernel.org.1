Return-Path: <stable+bounces-149526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270CACB37C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A679434FF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE0225A37;
	Mon,  2 Jun 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGTptvEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517D1B81DC;
	Mon,  2 Jun 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874224; cv=none; b=tTZ1eA/CeD94TZEKsqf/1CHQf09ARV+D1RLJFLmOWVLOn+aKtRitTPpOdBLGHzB1OVC1KHupbiWVOuaQWBGPjgMlF/NIEA4Ky9LORoliQ8/6ue2Lo2OuHtx9bRC+T402+VEFc+6QiPLo5TbQmvVQzuYIEMHQ5eH6SjCk36azatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874224; c=relaxed/simple;
	bh=GN9xcOX38iG7Qw9Q4orrPpX/LQDfn5a+eEp0jjVQvtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhK0+sip8wgMXgvkOWbbDi004TCTRGdUTfWCF7+XFxcQlu1K5ky9EDrboMGNyU9+/xyOB0d5CmVfVoEoTQP/BiMtBZvmqKKDpCNB4/ItaKeHmxCat4ma91A9MPoe+7fjjPXK1YEnjLZpAc1XoZ32gRf5Uqk3l63rZkqOiZTTuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGTptvEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4308C4CEEB;
	Mon,  2 Jun 2025 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874223;
	bh=GN9xcOX38iG7Qw9Q4orrPpX/LQDfn5a+eEp0jjVQvtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGTptvEbeuhRuudOA87wnYgbtGnNjkcZZlz+Gh/2GUi62vWU2fZUT/ssu/ZMvB1e7
	 GcqsVbx3Bu/JG7S+kfC9FzXeNaJsseXV4fahYYChGShadrqHWJItAzoh0Oi+Sk7XG2
	 6iw3MZIuOFEZeyVjYXoLcwtXzF0Iqq0Es/oor37Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Wang Zhaolong <wangzhaolong1@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 371/444] smb: client: Fix use-after-free in cifs_fill_dirent
Date: Mon,  2 Jun 2025 15:47:15 +0200
Message-ID: <20250602134355.976238505@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Zhaolong <wangzhaolong1@huawei.com>

commit a7a8fe56e932a36f43e031b398aef92341bf5ea0 upstream.

There is a race condition in the readdir concurrency process, which may
access the rsp buffer after it has been released, triggering the
following KASAN warning.

 ==================================================================
 BUG: KASAN: slab-use-after-free in cifs_fill_dirent+0xb03/0xb60 [cifs]
 Read of size 4 at addr ffff8880099b819c by task a.out/342975

 CPU: 2 UID: 0 PID: 342975 Comm: a.out Not tainted 6.15.0-rc6+ #240 PREEMPT(full)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x53/0x70
  print_report+0xce/0x640
  kasan_report+0xb8/0xf0
  cifs_fill_dirent+0xb03/0xb60 [cifs]
  cifs_readdir+0x12cb/0x3190 [cifs]
  iterate_dir+0x1a1/0x520
  __x64_sys_getdents+0x134/0x220
  do_syscall_64+0x4b/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f996f64b9f9
 Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
 f0 ff ff  0d f7 c3 0c 00 f7 d8 64 89 8
 RSP: 002b:00007f996f53de78 EFLAGS: 00000207 ORIG_RAX: 000000000000004e
 RAX: ffffffffffffffda RBX: 00007f996f53ecdc RCX: 00007f996f64b9f9
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
 RBP: 00007f996f53dea0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000207 R12: ffffffffffffff88
 R13: 0000000000000000 R14: 00007ffc8cd9a500 R15: 00007f996f51e000
  </TASK>

 Allocated by task 408:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x14/0x30
  __kasan_slab_alloc+0x6e/0x70
  kmem_cache_alloc_noprof+0x117/0x3d0
  mempool_alloc_noprof+0xf2/0x2c0
  cifs_buf_get+0x36/0x80 [cifs]
  allocate_buffers+0x1d2/0x330 [cifs]
  cifs_demultiplex_thread+0x22b/0x2690 [cifs]
  kthread+0x394/0x720
  ret_from_fork+0x34/0x70
  ret_from_fork_asm+0x1a/0x30

 Freed by task 342979:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x14/0x30
  kasan_save_free_info+0x3b/0x60
  __kasan_slab_free+0x37/0x50
  kmem_cache_free+0x2b8/0x500
  cifs_buf_release+0x3c/0x70 [cifs]
  cifs_readdir+0x1c97/0x3190 [cifs]
  iterate_dir+0x1a1/0x520
  __x64_sys_getdents64+0x134/0x220
  do_syscall_64+0x4b/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff8880099b8000
  which belongs to the cache cifs_request of size 16588
 The buggy address is located 412 bytes inside of
  freed 16588-byte region [ffff8880099b8000, ffff8880099bc0cc)

 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x99b8
 head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 anon flags: 0x80000000000040(head|node=0|zone=1)
 page_type: f5(slab)
 raw: 0080000000000040 ffff888001e03400 0000000000000000 dead000000000001
 raw: 0000000000000000 0000000000010001 00000000f5000000 0000000000000000
 head: 0080000000000040 ffff888001e03400 0000000000000000 dead000000000001
 head: 0000000000000000 0000000000010001 00000000f5000000 0000000000000000
 head: 0080000000000003 ffffea0000266e01 00000000ffffffff 00000000ffffffff
 head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff8880099b8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880099b8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff8880099b8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8880099b8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880099b8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

POC is available in the link [1].

The problem triggering process is as follows:

Process 1                       Process 2
-----------------------------------------------------------------
cifs_readdir
  /* file->private_data == NULL */
  initiate_cifs_search
    cifsFile = kzalloc(sizeof(struct cifsFileInfo), GFP_KERNEL);
    smb2_query_dir_first ->query_dir_first()
      SMB2_query_directory
        SMB2_query_directory_init
        cifs_send_recv
        smb2_parse_query_directory
          srch_inf->ntwrk_buf_start = (char *)rsp;
          srch_inf->srch_entries_start = (char *)rsp + ...
          srch_inf->last_entry = (char *)rsp + ...
          srch_inf->smallBuf = true;
  find_cifs_entry
    /* if (cfile->srch_inf.ntwrk_buf_start) */
    cifs_small_buf_release(cfile->srch_inf // free

                        cifs_readdir  ->iterate_shared()
                          /* file->private_data != NULL */
                          find_cifs_entry
                            /* in while (...) loop */
                            smb2_query_dir_next  ->query_dir_next()
                              SMB2_query_directory
                                SMB2_query_directory_init
                                cifs_send_recv
                                  compound_send_recv
                                    smb_send_rqst
                                    __smb_send_rqst
                                      rc = -ERESTARTSYS;
                                      /* if (fatal_signal_pending()) */
                                      goto out;
                                      return rc
                            /* if (cfile->srch_inf.last_entry) */
                            cifs_save_resume_key()
                              cifs_fill_dirent // UAF
                            /* if (rc) */
                            return -ENOENT;

Fix this by ensuring the return code is checked before using pointers
from the srch_inf.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220131 [1]
Fixes: a364bc0b37f1 ("[CIFS] fix saving of resume key before CIFSFindNext")
Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/readdir.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -756,11 +756,11 @@ find_cifs_entry(const unsigned int xid,
 		rc = server->ops->query_dir_next(xid, tcon, &cfile->fid,
 						 search_flags,
 						 &cfile->srch_inf);
+		if (rc)
+			return -ENOENT;
 		/* FindFirst/Next set last_entry to NULL on malformed reply */
 		if (cfile->srch_inf.last_entry)
 			cifs_save_resume_key(cfile->srch_inf.last_entry, cfile);
-		if (rc)
-			return -ENOENT;
 	}
 	if (index_to_find < cfile->srch_inf.index_of_last_entry) {
 		/* we found the buffer that contains the entry */



