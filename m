Return-Path: <stable+bounces-148128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21940AC85C5
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 02:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE10C4E2E0C
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1258405F7;
	Fri, 30 May 2025 00:54:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8FAD5E
	for <stable@vger.kernel.org>; Fri, 30 May 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748566480; cv=none; b=b9EFFjFkyA6UNEaanJ1QpE7or41V+80ORULroK7tAbsMlXS43D6ehR2S1nocH82S62W1vLdICg3NmDr42p5lMJM0ua8K0L85c5Hc96QMkcYIJZ9lc3ggP0JRNoSeLru8lgB9H5TtzRzt1YoSFumxRjmPKIfcKYdzMnOVCgYlO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748566480; c=relaxed/simple;
	bh=w2xmo95BRrvXJubyC/nXNeWIDOzeFA7AjT1r8wHZ7UE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jA1jCSU40/AfQys4aKBqRx8zf4NtOsma+wN4BP231wZocxnhuVIyj7kpBVMLeuFkQBnOWi8lx0v0aFffmMg0GYUOeSuaTxFmomQh64haY5qCifN73JQBnjlZ+dQ6SrjQzEQuuR9n6RdcrARXy7o0R8T/P8z1wKoHO5gmWEmVZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b7lCK1CX9z27j1M
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:55:25 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E22921402C3
	for <stable@vger.kernel.org>; Fri, 30 May 2025 08:54:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 08:54:34 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.4.y 1/2] smb: client: Fix use-after-free in cifs_fill_dirent
Date: Fri, 30 May 2025 08:54:33 +0800
Message-ID: <20250530005434.773389-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <2025052437-platform-elastic-f5d2@gregkh>
References: <2025052437-platform-elastic-f5d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg500010.china.huawei.com (7.202.181.71)

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
(cherry picked from commit a7a8fe56e932a36f43e031b398aef92341bf5ea0)
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 fs/cifs/readdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 3925a7bfc74d..157aae931a18 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -642,15 +642,15 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 	       (rc == 0) && !cfile->srch_inf.endOfSearch) {
 		cifs_dbg(FYI, "calling findnext2\n");
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
 		/* scan and find it */
 		int i;
-- 
2.34.3


