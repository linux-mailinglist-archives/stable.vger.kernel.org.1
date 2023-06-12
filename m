Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7D72C185
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjFLKzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjFLKy0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A2171E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6B7612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D59C433D2;
        Mon, 12 Jun 2023 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566440;
        bh=IFpJBjxH8ZPldww8IV9mGVyoBIWXMkcWtp8/JS0Y3YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rarnnmyKQKDDCj+qXg518ARkc8pzgLJPTrSJFBpXT+ljfanEhIr5nyJlkxeuUw++
         XopihMUxeFCgc9uTaxGu2bGoLqV/94i7mma8P+gNb3iXbJhp5Y2kJKuCIkmIyULViA
         S4H3/U63JAoiUMLy+B2WkH1NJkJyQrvXld9Tj5aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/132] bpf, sockmap: Avoid potential NULL dereference in sk_psock_verdict_data_ready()
Date:   Mon, 12 Jun 2023 12:25:43 +0200
Message-ID: <20230612101710.708255444@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b320a45638296b63be8d9a901ca8bc43716b1ae1 ]

syzbot found sk_psock(sk) could return NULL when called
from sk_psock_verdict_data_ready().

Just make sure to handle this case.

[1]
general protection fault, probably for non-canonical address 0xdffffc000000005c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000002e0-0x00000000000002e7]
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc3-syzkaller-00588-g4781e965e655 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
RIP: 0010:sk_psock_verdict_data_ready+0x19f/0x3c0 net/core/skmsg.c:1213
Code: 4c 89 e6 e8 63 70 5e f9 4d 85 e4 75 75 e8 19 74 5e f9 48 8d bb e0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 07 02 00 00 48 89 ef ff 93 e0 02 00 00 e8 29 fd
RSP: 0018:ffffc90000147688 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: 000000000000005c RSI: ffffffff8825ceb7 RDI: 00000000000002e0
RBP: ffff888076518c40 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000008000 R15: ffff888076518c40
FS: 0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f901375bab0 CR3: 000000004bf26000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
tcp_data_ready+0x10a/0x520 net/ipv4/tcp_input.c:5006
tcp_data_queue+0x25d3/0x4c50 net/ipv4/tcp_input.c:5080
tcp_rcv_established+0x829/0x1f90 net/ipv4/tcp_input.c:6019
tcp_v4_do_rcv+0x65a/0x9c0 net/ipv4/tcp_ipv4.c:1726
tcp_v4_rcv+0x2cbf/0x3340 net/ipv4/tcp_ipv4.c:2148
ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x2ec/0x520 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:303 [inline]
NF_HOOK include/linux/netfilter.h:297 [inline]
ip_local_deliver+0x1ae/0x200 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:468 [inline]
ip_rcv_finish+0x1cf/0x2f0 net/ipv4/ip_input.c:449
NF_HOOK include/linux/netfilter.h:303 [inline]
NF_HOOK include/linux/netfilter.h:297 [inline]
ip_rcv+0xae/0xd0 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5491
__netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5605
process_backlog+0x101/0x670 net/core/dev.c:5933
__napi_poll+0xb7/0x6f0 net/core/dev.c:6499
napi_poll net/core/dev.c:6566 [inline]
net_rx_action+0x8a9/0xcb0 net/core/dev.c:6699
__do_softirq+0x1d4/0x905 kernel/softirq.c:571
run_ksoftirqd kernel/softirq.c:939 [inline]
run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
kthread+0x344/0x440 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
</TASK>

Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20230530195149.68145-1-edumazet@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9e0f694515636..65fb6f5b21b28 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1205,7 +1205,8 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		psock->saved_data_ready(sk);
+		if (psock)
+			psock->saved_data_ready(sk);
 		rcu_read_unlock();
 	}
 }
-- 
2.39.2



