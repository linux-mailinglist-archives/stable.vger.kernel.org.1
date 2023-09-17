Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0284B7A3B29
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjIQUOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbjIQUNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B97191
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:13:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B650DC433AD;
        Sun, 17 Sep 2023 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981606;
        bh=djoTz2LX9wHV9S9r/D3hMoG0MDy6snLLWUTc98JMalU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2k1HeJnM80EwDsgsQmk9/ZcumkyaqM2tQ9nxtLUOG1XJ+JroykbjPjHpTZSVmPYmo
         yL8DfKCzi8M8MWfqVczkM3WiHbQmy9y6RszciWzOflaVqol3uezD5gkQV/hIbQSXEt
         aH3VHP+AaelwHt0my0sokRnjpM4neKav5QYqruL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com
Subject: [PATCH 6.1 146/219] f2fs: flush inode if atomic file is aborted
Date:   Sun, 17 Sep 2023 21:14:33 +0200
Message-ID: <20230917191046.298190356@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit a3ab55746612247ce3dcaac6de66f5ffc055b9df upstream.

Let's flush the inode being aborted atomic operation to avoid stale dirty
inode during eviction in this call stack:

  f2fs_mark_inode_dirty_sync+0x22/0x40 [f2fs]
  f2fs_abort_atomic_write+0xc4/0xf0 [f2fs]
  f2fs_evict_inode+0x3f/0x690 [f2fs]
  ? sugov_start+0x140/0x140
  evict+0xc3/0x1c0
  evict_inodes+0x17b/0x210
  generic_shutdown_super+0x32/0x120
  kill_block_super+0x21/0x50
  deactivate_locked_super+0x31/0x90
  cleanup_mnt+0x100/0x160
  task_work_run+0x59/0x90
  do_exit+0x33b/0xa50
  do_group_exit+0x2d/0x80
  __x64_sys_exit_group+0x14/0x20
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

This triggers f2fs_bug_on() in f2fs_evict_inode:
 f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));

This fixes the syzbot report:

loop0: detected capacity change from 0 to 131072
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:869!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5014 Comm: syz-executor220 Not tainted 6.4.0-syzkaller-11479-g6cd06ab12d1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:f2fs_evict_inode+0x172d/0x1e00 fs/f2fs/inode.c:869
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 6a 06 00 00 8b 75 40 ba 01 00 00 00 4c 89 e7 e8 6d ce 06 00 e9 aa fc ff ff e8 63 22 e2 fd <0f> 0b e8 5c 22 e2 fd 48 c7 c0 a8 3a 18 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880273b8000 RSI: ffffffff83a2bd0d RDI: 0000000000000007
RBP: ffff888077db91b0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888029a3c000
R13: ffff888077db9660 R14: ffff888029a3c0b8 R15: ffff888077db9c50
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1909bb9000 CR3: 00000000276a9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:665
 dispose_list+0x117/0x1e0 fs/inode.c:698
 evict_inodes+0x345/0x440 fs/inode.c:748
 generic_shutdown_super+0xaf/0x480 fs/super.c:478
 kill_block_super+0x64/0xb0 fs/super.c:1417
 kill_f2fs_super+0x2af/0x3c0 fs/f2fs/super.c:4704
 deactivate_locked_super+0x98/0x160 fs/super.c:330
 deactivate_super+0xb1/0xd0 fs/super.c:361
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1254
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa9a/0x29a0 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f309be71a09
Code: Unable to access opcode bytes at 0x7f309be719df.
RSP: 002b:00007fff171df518 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f309bef7330 RCX: 00007f309be71a09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f309bef1e40
R10: 0000000000010600 R11: 0000000000000246 R12: 00007f309bef7330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x172d/0x1e00 fs/f2fs/inode.c:869
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 6a 06 00 00 8b 75 40 ba 01 00 00 00 4c 89 e7 e8 6d ce 06 00 e9 aa fc ff ff e8 63 22 e2 fd <0f> 0b e8 5c 22 e2 fd 48 c7 c0 a8 3a 18 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880273b8000 RSI: ffffffff83a2bd0d RDI: 0000000000000007
RBP: ffff888077db91b0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888029a3c000
R13: ffff888077db9660 R14: ffff888029a3c0b8 R15: ffff888077db9c50
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1909bb9000 CR3: 00000000276a9000 CR4: 0000000000350ef0

Cc: <stable@vger.kernel.org>
Reported-and-tested-by: syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -204,6 +204,8 @@ void f2fs_abort_atomic_write(struct inod
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
+	/* avoid stale dirty inode during eviction */
+	sync_inode_metadata(inode, 0);
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,


