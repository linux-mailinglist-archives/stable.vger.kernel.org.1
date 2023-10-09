Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5587BDDE3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbjJINOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbjJINNn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3D1BE
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E140AC433C9;
        Mon,  9 Oct 2023 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857199;
        bh=iqyQ3fthpqtzIKss3Iqo5j2P/1Q9N0wAAFIB2fN18eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnrBWyonTC3gGHQxqDHqQ4FicmS1tve0R45b3ksAZ/WTdM9CNQ3bgbAzDzxOgAvS+
         xWTgtNv1QQxTtKeV03XnmBeAkeFwjPRcq2FvIYDS11gXTnD/sI9H4VRFQj7WkK1bme
         A3CCM67MVPdBKpObnIPa3+jV+S4BG1y8kDd2An+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 130/163] netlink: annotate data-races around sk->sk_err
Date:   Mon,  9 Oct 2023 15:01:34 +0200
Message-ID: <20231009130127.632807236@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d0f95894fda7d4f895b29c1097f92d7fee278cb2 ]

syzbot caught another data-race in netlink when
setting sk->sk_err.

Annotate all of them for good measure.

BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg

write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0x00000016

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231003183455.3410550-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 20082171f24a3..9c6bc47bc7f7b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -352,7 +352,7 @@ static void netlink_overrun(struct sock *sk)
 	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
-			sk->sk_err = ENOBUFS;
+			WRITE_ONCE(sk->sk_err, ENOBUFS);
 			sk_error_report(sk);
 		}
 	}
@@ -1577,7 +1577,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 		goto out;
 	}
 
-	sk->sk_err = p->code;
+	WRITE_ONCE(sk->sk_err, p->code);
 	sk_error_report(sk);
 out:
 	return ret;
@@ -1966,7 +1966,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
-			sk->sk_err = -ret;
+			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
 		}
 	}
@@ -2485,7 +2485,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 err_bad_put:
 	nlmsg_free(skb);
 err_skb:
-	NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
+	WRITE_ONCE(NETLINK_CB(in_skb).sk->sk_err, ENOBUFS);
 	sk_error_report(NETLINK_CB(in_skb).sk);
 }
 EXPORT_SYMBOL(netlink_ack);
-- 
2.40.1



