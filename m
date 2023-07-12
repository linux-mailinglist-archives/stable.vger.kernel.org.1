Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF174FDA1
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGLDUF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLDUE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 23:20:04 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F7133
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:20:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3270:4fa0:68e8:99a6:210:534d])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id B1FDA280F80;
        Wed, 12 Jul 2023 11:12:37 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     stable@vger.kernel.org
Cc:     chuck.lever@oracle.com, gregkh@linuxfoundation.org,
        Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 4.14.y] SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
Date:   Wed, 12 Jul 2023 11:12:01 +0800
Message-Id: <20230712031201.13103-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2023071119-underdone-monotype-f516@gregkh>
References: <2023071119-underdone-monotype-f516@gregkh>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS00fVh5CH09KSEtJGEpDTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEtBTx0aS0FNQx5DQUJCGk1BSUpLQU5ITx9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Tid: 0a89481623d32eb1kusnb1fda280f80
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Mxw*GD1PTBgyF0sUKw8U
        NyMaFAtVSlVKTUNCSkhKTk5DQkpNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxLQU8dGktBTUMeQ0FCQhpNQUlKS0FOSE8fWVdZCAFZQU5NSE43Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

After the listener svc_sock is freed, and before invoking svc_tcp_accept()
for the established child sock, there is a window that the newsock
retaining a freed listener svc_sock in sk_user_data which cloning from
parent. In the race window, if data is received on the newsock, we will
observe use-after-free report in svc_tcp_listen_data_ready().

Reproduce by two tasks:

1. while :; do rpc.nfsd 0 ; rpc.nfsd; done
2. while :; do echo "" | ncat -4 127.0.0.1 2049 ; done

KASAN report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in svc_tcp_listen_data_ready+0x1cf/0x1f0 [sunrpc]
  Read of size 8 at addr ffff888139d96228 by task nc/102553
  CPU: 7 PID: 102553 Comm: nc Not tainted 6.3.0+ #18
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x33/0x50
   print_address_description.constprop.0+0x27/0x310
   print_report+0x3e/0x70
   kasan_report+0xae/0xe0
   svc_tcp_listen_data_ready+0x1cf/0x1f0 [sunrpc]
   tcp_data_queue+0x9f4/0x20e0
   tcp_rcv_established+0x666/0x1f60
   tcp_v4_do_rcv+0x51c/0x850
   tcp_v4_rcv+0x23fc/0x2e80
   ip_protocol_deliver_rcu+0x62/0x300
   ip_local_deliver_finish+0x267/0x350
   ip_local_deliver+0x18b/0x2d0
   ip_rcv+0x2fb/0x370
   __netif_receive_skb_one_core+0x166/0x1b0
   process_backlog+0x24c/0x5e0
   __napi_poll+0xa2/0x500
   net_rx_action+0x854/0xc90
   __do_softirq+0x1bb/0x5de
   do_softirq+0xcb/0x100
   </IRQ>
   <TASK>
   ...
   </TASK>

  Allocated by task 102371:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_kmalloc+0x7b/0x90
   svc_setup_socket+0x52/0x4f0 [sunrpc]
   svc_addsock+0x20d/0x400 [sunrpc]
   __write_ports_addfd+0x209/0x390 [nfsd]
   write_ports+0x239/0x2c0 [nfsd]
   nfsctl_transaction_write+0xac/0x110 [nfsd]
   vfs_write+0x1c3/0xae0
   ksys_write+0xed/0x1c0
   do_syscall_64+0x38/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

  Freed by task 102551:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x50
   __kasan_slab_free+0x106/0x190
   __kmem_cache_free+0x133/0x270
   svc_xprt_free+0x1e2/0x350 [sunrpc]
   svc_xprt_destroy_all+0x25a/0x440 [sunrpc]
   nfsd_put+0x125/0x240 [nfsd]
   nfsd_svc+0x2cb/0x3c0 [nfsd]
   write_threads+0x1ac/0x2a0 [nfsd]
   nfsctl_transaction_write+0xac/0x110 [nfsd]
   vfs_write+0x1c3/0xae0
   ksys_write+0xed/0x1c0
   do_syscall_64+0x38/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fix the UAF by simply doing nothing in svc_tcp_listen_data_ready()
if state != TCP_LISTEN, that will avoid dereferencing svsk for all
child socket.

Link: https://lore.kernel.org/lkml/20230507091131.23540-1-dinghui@sangfor.com.cn/
Fixes: fa9251afc33c ("SUNRPC: Call the default socket callbacks instead of open coding")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit fc80fc2d4e39137869da3150ee169b40bf879287)
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 net/sunrpc/svcsock.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d6771f3b715b..1f717654b4cb 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -766,12 +766,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	dprintk("svc: socket %p TCP (listen) state change %d\n",
 		sk, sk->sk_state);
 
-	if (svsk) {
-		/* Refer to svc_setup_socket() for details. */
-		rmb();
-		svsk->sk_odata(sk);
-	}
-
 	/*
 	 * This callback may called twice when a new connection
 	 * is established as a child socket inherits everything
@@ -780,15 +774,20 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	 *    when one of child sockets become ESTABLISHED.
 	 * 2) data_ready method of the child socket may be called
 	 *    when it receives data before the socket is accepted.
-	 * In case of 2, we should ignore it silently.
+	 * In case of 2, we should ignore it silently and DO NOT
+	 * dereference svsk.
 	 */
-	if (sk->sk_state == TCP_LISTEN) {
-		if (svsk) {
-			set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
-			svc_xprt_enqueue(&svsk->sk_xprt);
-		} else
-			printk("svc: socket %p: no user data\n", sk);
-	}
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
+		svc_xprt_enqueue(&svsk->sk_xprt);
+	} else
+		printk("svc: socket %p: no user data\n", sk);
 }
 
 /*
-- 
2.17.1

