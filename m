Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7C7A397D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjIQTuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjIQTty (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C386E7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A5DC433C8;
        Sun, 17 Sep 2023 19:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980188;
        bh=9lrfTbkBx26M8D/VKaSXa7Wz15s1OK3G1TcfOaqbTRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TojAR1oPd8VU1E+cuYo8SXQuC6paE6qqC6NmKXulAL1NF7KRjI9oMZeNvUzxF/xNs
         ktwTygEi7AsvMOE2IxLkBOYntl9v5bvXh/q5jAihPLMzWzd/rur+aA7UDJ0f0LcmiT
         Q8N+eCNlK6ab/euersLHOGNX1oQSMj11WBKjPWwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 118/285] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
Date:   Sun, 17 Sep 2023 21:11:58 +0200
Message-ID: <20230917191055.752485064@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 82ba0ff7bf0483d962e592017bef659ae022d754 ]

We should not call trace_handshake_cmd_done_err() if socket lookup has failed.

Also we should call trace_handshake_cmd_done_err() before releasing the file,
otherwise dereferencing sock->sk can return garbage.

This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local variable")

Unable to handle kernel paging request at virtual address dfff800000000003
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Mem abort info:
ESR = 0x0000000096000005
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x05: level 1 translation fault
Data abort info:
ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000003] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 5986 Comm: syz-executor292 Not tainted 6.5.0-rc7-syzkaller-gfe4469582053 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
lr : handshake_nl_done_doit+0x180/0x9c8
sp : ffff800096e37180
x29: ffff800096e37200 x28: 1ffff00012dc6e34 x27: dfff800000000000
x26: ffff800096e373d0 x25: 0000000000000000 x24: 00000000ffffffa8
x23: ffff800096e373f0 x22: 1ffff00012dc6e38 x21: 0000000000000000
x20: ffff800096e371c0 x19: 0000000000000018 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800080516cc4 x15: 0000000000000001
x14: 1fffe0001b14aa3b x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000003
x8 : 0000000000000003 x7 : ffff800080afe47c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080a88078
x2 : 0000000000000001 x1 : 00000000ffffffa8 x0 : 0000000000000000
Call trace:
handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
genl_rcv_msg+0x96c/0xc50 net/netlink/genetlink.c:1067
netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2549
genl_rcv+0x38/0x50 net/netlink/genetlink.c:1078
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x56c/0x840 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmsg+0x26c/0x33c net/socket.c:2577
__do_sys_sendmsg net/socket.c:2586 [inline]
__se_sys_sendmsg net/socket.c:2584 [inline]
__arm64_sys_sendmsg+0x80/0x94 net/socket.c:2584
__invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 12800108 b90043e8 910062b3 d343fe68 (387b6908)

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/handshake/netlink.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 1086653e1fada..d0bc1dd8e65a8 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -157,26 +157,24 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
-	struct handshake_req *req = NULL;
-	struct socket *sock = NULL;
+	struct handshake_req *req;
+	struct socket *sock;
 	int fd, status, err;
 
 	if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_DONE_SOCKFD))
 		return -EINVAL;
 	fd = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_SOCKFD]);
 
-	err = 0;
 	sock = sockfd_lookup(fd, &err);
-	if (err) {
-		err = -EBADF;
-		goto out_status;
-	}
+	if (!sock)
+		return err;
 
 	req = handshake_req_hash_lookup(sock->sk);
 	if (!req) {
 		err = -EBUSY;
+		trace_handshake_cmd_done_err(net, req, sock->sk, err);
 		fput(sock->file);
-		goto out_status;
+		return err;
 	}
 
 	trace_handshake_cmd_done(net, req, sock->sk, fd);
@@ -188,10 +186,6 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 	handshake_complete(req, status, info);
 	fput(sock->file);
 	return 0;
-
-out_status:
-	trace_handshake_cmd_done_err(net, req, sock->sk, err);
-	return err;
 }
 
 static unsigned int handshake_net_id;
-- 
2.40.1



