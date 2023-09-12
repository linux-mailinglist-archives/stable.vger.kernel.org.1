Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028E79B479
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbjIKWWd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjIKO6q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E41B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C6AC433C7;
        Mon, 11 Sep 2023 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444322;
        bh=GwVu1r/HLFVAcWk2ISz3RQdx5Q/iFYndl8LO9ZZmprI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbSIW3jRE/UVYeWB3Ro16i6YHNN1Kgl8oCNQQOyvNkcfxnc/Q54EziT0+0Y+Xu8Jn
         sEXw4X80vlxVyRySvQddZbmj5lpk65EDPk/7xBXnjGPivlBZkCk06XEg/chyP3svYs
         WBMqCID1ceq/Mvf+I0KXM1X1yKKGJDSdTKhXCFqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+c74fea926a78b8a91042@syzkaller.appspotmail.com,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 671/737] io_uring: Dont set affinity on a dying sqpoll thread
Date:   Mon, 11 Sep 2023 15:48:50 +0200
Message-ID: <20230911134709.282715658@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@suse.de>

commit bd6fc5da4c51107e1e0cec4a3a07963d1dae2c84 upstream.

Syzbot reported a null-ptr-deref of sqd->thread inside
io_sqpoll_wq_cpu_affinity.  It turns out the sqd->thread can go away
from under us during io_uring_register, in case the process gets a
fatal signal during io_uring_register.

It is not particularly hard to hit the race, and while I am not sure
this is the exact case hit by syzbot, it solves it.  Finally, checking
->thread is enough to close the race because we locked sqd while
"parking" the thread, thus preventing it from going away.

I reproduced it fairly consistently with a program that does:

int main(void) {
  ...
  io_uring_queue_init(RING_LEN, &ring1, IORING_SETUP_SQPOLL);
  while (1) {
    io_uring_register_iowq_aff(ring, 1, &mask);
  }
}

Executed in a loop with timeout to trigger SIGTERM:
  while true; do timeout 1 /a.out ; done

This will hit the following BUG() in very few attempts.

BUG: kernel NULL pointer dereference, address: 00000000000007a8
PGD 800000010e949067 P4D 800000010e949067 PUD 10e46e067 PMD 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 15715 Comm: dead-sqpoll Not tainted 6.5.0-rc7-next-20230825-g193296236fa0-dirty #23
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:io_sqpoll_wq_cpu_affinity+0x27/0x70
Code: 90 90 90 0f 1f 44 00 00 55 53 48 8b 9f 98 03 00 00 48 85 db 74 4f
48 89 df 48 89 f5 e8 e2 f8 ff ff 48 8b 43 38 48 85 c0 74 22 <48> 8b b8
a8 07 00 00 48 89 ee e8 ba b1 00 00 48 89 df 89 c5 e8 70
RSP: 0018:ffffb04040ea7e70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff93c010749e40 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa7653331 RDI: 00000000ffffffff
RBP: ffffb04040ea7eb8 R08: 0000000000000000 R09: c0000000ffffdfff
R10: ffff93c01141b600 R11: ffffb04040ea7d18 R12: ffff93c00ea74840
R13: 0000000000000011 R14: 0000000000000000 R15: ffff93c00ea74800
FS:  00007fb7c276ab80(0000) GS:ffff93c36f200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000007a8 CR3: 0000000111634003 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die_body+0x1a/0x60
 ? page_fault_oops+0x154/0x440
 ? do_user_addr_fault+0x174/0x7b0
 ? exc_page_fault+0x63/0x140
 ? asm_exc_page_fault+0x22/0x30
 ? io_sqpoll_wq_cpu_affinity+0x27/0x70
 __io_register_iowq_aff+0x2b/0x60
 __io_uring_register+0x614/0xa70
 __x64_sys_io_uring_register+0xaa/0x1a0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7fb7c226fec9
Code: 2e 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 97 7f 2d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe2c0674f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb7c226fec9
RDX: 00007ffe2c067530 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00007ffe2c0675d0 R08: 00007ffe2c067550 R09: 00007ffe2c067550
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2c067750 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 00000000000007a8
---[ end trace 0000000000000000 ]---

Reported-by: syzbot+c74fea926a78b8a91042@syzkaller.appspotmail.com
Fixes: ebdfefc09c6d ("io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://lore.kernel.org/r/87v8cybuo6.fsf@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/sqpoll.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -430,7 +430,9 @@ __cold int io_sqpoll_wq_cpu_affinity(str
 
 	if (sqd) {
 		io_sq_thread_park(sqd);
-		ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
+		/* Don't set affinity for a dying thread */
+		if (sqd->thread)
+			ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
 		io_sq_thread_unpark(sqd);
 	}
 


