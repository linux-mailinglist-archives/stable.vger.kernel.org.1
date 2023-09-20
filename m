Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3C7A7E77
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjITMSF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjITMSE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EB100
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD44C433C9;
        Wed, 20 Sep 2023 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212271;
        bh=xvAT5RjmW1C53hLaNjeNO5QOyg08gIqXZ71V96vNpAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6R3S+rKdNfBwXRGTl5aqlHE1sZYaHJxVFfKTt7yOO7/+sVsUyRbcrWPERDRGvbTN
         y9koLxAFj+HTy01oZO8pVwETVuKhAGIkAECFGYWW0iC1uQYobC5NUY4M6m2XO2YWAm
         U1xCN7xURKFe3Pte4gHBUkAN1mKYmmvwAtTx329g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 215/273] af_unix: Fix data-race around unix_tot_inflight.
Date:   Wed, 20 Sep 2023 13:30:55 +0200
Message-ID: <20230920112853.096420093@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit ade32bd8a738d7497ffe9743c46728db26740f78 ]

unix_tot_inflight is changed under spin_lock(unix_gc_lock), but
unix_release_sock() reads it locklessly.

Let's use READ_ONCE() for unix_tot_inflight.

Note that the writer side was marked by commit 9d6d7f1cb67c ("af_unix:
annote lockless accesses to unix_tot_inflight & gc_in_progress")

BUG: KCSAN: data-race in unix_inflight / unix_release_sock

write (marked) to 0xffffffff871852b8 of 4 bytes by task 123 on cpu 1:
 unix_inflight+0x130/0x180 net/unix/scm.c:64
 unix_attach_fds+0x137/0x1b0 net/unix/scm.c:123
 unix_scm_to_skb net/unix/af_unix.c:1832 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1955
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:747
 ____sys_sendmsg+0x4e4/0x610 net/socket.c:2493
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2547
 __sys_sendmsg+0x94/0x140 net/socket.c:2576
 __do_sys_sendmsg net/socket.c:2585 [inline]
 __se_sys_sendmsg net/socket.c:2583 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2583
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

read to 0xffffffff871852b8 of 4 bytes by task 4891 on cpu 0:
 unix_release_sock+0x608/0x910 net/unix/af_unix.c:671
 unix_release+0x59/0x80 net/unix/af_unix.c:1058
 __sock_release+0x7d/0x170 net/socket.c:653
 sock_close+0x19/0x30 net/socket.c:1385
 __fput+0x179/0x5e0 fs/file_table.c:321
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x116/0x1a0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x174/0x180 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1a/0x30 kernel/entry/common.c:297
 do_syscall_64+0x4b/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 4891 Comm: systemd-coredum Not tainted 6.4.0-rc5-01219-gfa0e21fa4443 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 9305cfa4443d ("[AF_UNIX]: Make unix_tot_inflight counter non-atomic")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 402060cf3198c..0632b494d329b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -594,7 +594,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 *	  What the above comment does talk about? --ANK(980817)
 	 */
 
-	if (unix_tot_inflight)
+	if (READ_ONCE(unix_tot_inflight))
 		unix_gc();		/* Garbage collect fds */
 }
 
-- 
2.40.1



