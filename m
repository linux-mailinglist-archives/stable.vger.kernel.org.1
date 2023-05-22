Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB170C84F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjEVThz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjEVTho (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944110C0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD06629A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BA5C433EF;
        Mon, 22 May 2023 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784232;
        bh=lN3vUmCTV1/YQQ7NweRJacJZAORULakaCMgH1d6Ad9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYBxrrhFST+k+ETiWe9AxAdIfqtA3PD5o7SZTMGAj5NHyBN7p8u2nsQ1tgd1QcwwS
         2TsG8UK1jyYpW7jNqVm5fTr/fKwfb9SQB4Tth0HuXz/pdxFj+99F8VZZmY3Q2FNcF8
         19mySERg7YNuT061Sit2lTo+gBFJUVFGE4nXjyCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 014/364] net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().
Date:   Mon, 22 May 2023 20:05:19 +0100
Message-Id: <20230522190413.183529805@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit dfd9248c071a3710c24365897459538551cb7167 ]

KCSAN found a data race in sock_recv_cmsgs() where the read access
to sk->sk_stamp needs READ_ONCE().

BUG: KCSAN: data-race in packet_recvmsg / packet_recvmsg

write (marked) to 0xffff88803c81f258 of 8 bytes by task 19171 on cpu 0:
 sock_write_timestamp include/net/sock.h:2670 [inline]
 sock_recv_cmsgs include/net/sock.h:2722 [inline]
 packet_recvmsg+0xb97/0xd00 net/packet/af_packet.c:3489
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 sock_recvmsg+0x11a/0x130 net/socket.c:1040
 sock_read_iter+0x176/0x220 net/socket.c:1118
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x5e0/0x630 fs/read_write.c:470
 ksys_read+0x163/0x1a0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x41/0x50 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

read to 0xffff88803c81f258 of 8 bytes by task 19183 on cpu 1:
 sock_recv_cmsgs include/net/sock.h:2721 [inline]
 packet_recvmsg+0xb64/0xd00 net/packet/af_packet.c:3489
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 sock_recvmsg+0x11a/0x130 net/socket.c:1040
 sock_read_iter+0x176/0x220 net/socket.c:1118
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x5e0/0x630 fs/read_write.c:470
 ksys_read+0x163/0x1a0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x41/0x50 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0xffffffffc4653600 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 19183 Comm: syz-executor.5 Not tainted 6.3.0-rc7-02330-gca6270c12e20 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 6c7c98bad488 ("sock: avoid dirtying sk_stamp, if possible")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230508175543.55756-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 573f2bf7e0de7..9cd0354221507 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2718,7 +2718,7 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
-	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
+	else if (unlikely(sock_read_timestamp(sk) == SK_DEFAULT_STAMP))
 		sock_write_timestamp(sk, 0);
 }
 
-- 
2.39.2



