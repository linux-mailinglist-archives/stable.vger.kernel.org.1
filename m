Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AB7A3D02
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjIQUhy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbjIQUh2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:37:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F06D115
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:37:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA05DC433CB;
        Sun, 17 Sep 2023 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983041;
        bh=vNZaTyq0vbKUpj5Exxe337JPmzC99qNNzCG4P06pLWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q895pmDYabaQ4WDKx3mL1tsEoufspr8aIwnQFhUFQd0IEnFFS8NCUgWzLRj3ws48y
         p9xaJNWX+dKP5UrA+tEHSYL/RMcNxCB3pdACDuJrmlxULeGcWOub9daMWxEwHicHEH
         e21QvQRN6QosNiBGQmtIiLrfiUqQznECl1WcMYJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 428/511] ipv4: annotate data-races around fi->fib_dead
Date:   Sun, 17 Sep 2023 21:14:15 +0200
Message-ID: <20230917191124.104628466@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fce92af1c29d90184dfec638b5738831097d66e9 ]

syzbot complained about a data-race in fib_table_lookup() [1]

Add appropriate annotations to document it.

[1]
BUG: KCSAN: data-race in fib_release_info / fib_table_lookup

write to 0xffff888150f31744 of 1 bytes by task 1189 on cpu 0:
fib_release_info+0x3a0/0x460 net/ipv4/fib_semantics.c:281
fib_table_delete+0x8d2/0x900 net/ipv4/fib_trie.c:1777
fib_magic+0x1c1/0x1f0 net/ipv4/fib_frontend.c:1106
fib_del_ifaddr+0x8cf/0xa60 net/ipv4/fib_frontend.c:1317
fib_inetaddr_event+0x77/0x200 net/ipv4/fib_frontend.c:1448
notifier_call_chain kernel/notifier.c:93 [inline]
blocking_notifier_call_chain+0x90/0x200 kernel/notifier.c:388
__inet_del_ifa+0x4df/0x800 net/ipv4/devinet.c:432
inet_del_ifa net/ipv4/devinet.c:469 [inline]
inetdev_destroy net/ipv4/devinet.c:322 [inline]
inetdev_event+0x553/0xaf0 net/ipv4/devinet.c:1606
notifier_call_chain kernel/notifier.c:93 [inline]
raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
call_netdevice_notifiers_info net/core/dev.c:1962 [inline]
call_netdevice_notifiers_mtu+0xd2/0x130 net/core/dev.c:2037
dev_set_mtu_ext+0x30b/0x3e0 net/core/dev.c:8673
do_setlink+0x5be/0x2430 net/core/rtnetlink.c:2837
rtnl_setlink+0x255/0x300 net/core/rtnetlink.c:3177
rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6445
netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2549
rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6463
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x56f/0x640 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x665/0x770 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
sock_write_iter+0x1aa/0x230 net/socket.c:1129
do_iter_write+0x4b4/0x7b0 fs/read_write.c:860
vfs_writev+0x1a8/0x320 fs/read_write.c:933
do_writev+0xf8/0x220 fs/read_write.c:976
__do_sys_writev fs/read_write.c:1049 [inline]
__se_sys_writev fs/read_write.c:1046 [inline]
__x64_sys_writev+0x45/0x50 fs/read_write.c:1046
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888150f31744 of 1 bytes by task 21839 on cpu 1:
fib_table_lookup+0x2bf/0xd50 net/ipv4/fib_trie.c:1585
fib_lookup include/net/ip_fib.h:383 [inline]
ip_route_output_key_hash_rcu+0x38c/0x12c0 net/ipv4/route.c:2751
ip_route_output_key_hash net/ipv4/route.c:2641 [inline]
__ip_route_output_key include/net/route.h:134 [inline]
ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2869
send4+0x1e7/0x500 drivers/net/wireguard/socket.c:61
wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work+0x434/0x860 kernel/workqueue.c:2600
worker_thread+0x5f2/0xa10 kernel/workqueue.c:2751
kthread+0x1d7/0x210 kernel/kthread.c:389
ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 21839 Comm: kworker/u4:18 Tainted: G W 6.5.0-syzkaller #0

Fixes: dccd9ecc3744 ("ipv4: Do not use dead fib_info entries.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230830095520.1046984-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_semantics.c | 5 ++++-
 net/ipv4/fib_trie.c      | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 607a4f8161555..799370bcc70c1 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -276,7 +276,8 @@ void fib_release_info(struct fib_info *fi)
 				hlist_del(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
-		fi->fib_dead = 1;
+		/* Paired with READ_ONCE() from fib_table_lookup() */
+		WRITE_ONCE(fi->fib_dead, 1);
 		fib_info_put(fi);
 	}
 	spin_unlock_bh(&fib_info_lock);
@@ -1598,6 +1599,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 link_it:
 	ofi = fib_find_info(fi);
 	if (ofi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 		refcount_inc(&ofi->fib_treeref);
@@ -1636,6 +1638,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 failure:
 	if (fi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 52f9f69f57b32..22531aac0ccbf 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1578,7 +1578,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 		}
 		if (fa->fa_tos && fa->fa_tos != flp->flowi4_tos)
 			continue;
-		if (fi->fib_dead)
+		/* Paired with WRITE_ONCE() in fib_release_info() */
+		if (READ_ONCE(fi->fib_dead))
 			continue;
 		if (fa->fa_info->fib_scope < flp->flowi4_scope)
 			continue;
-- 
2.40.1



