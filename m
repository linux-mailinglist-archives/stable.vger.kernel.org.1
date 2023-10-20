Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE297D16FB
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjJTU1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJTU1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:27:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5FD6A
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B76C433C7;
        Fri, 20 Oct 2023 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833664;
        bh=zsdIvisNqEeuIXJRiv75rcZYUeZdR9lynAwg/2mA+rI=;
        h=Subject:To:Cc:From:Date:From;
        b=okw0K11ehbD86iQpWDs6uXnvN2v2iTM77uFNmXnLIefmA6hgXlCEXNGqBISVaL6fY
         L2DR4G7tvcZD46dVzJqUbSsvAyXdrnobcBcsp4CWOfyo2X4YEDZY09yDc8ROvPhzTa
         KILbNXVDY/7YIzsBxuGd9w9+t6MW5IX5lsgvSbOs=
Subject: FAILED: patch "[PATCH] ipv4: fib: annotate races around nh->nh_saddr_genid and" failed to apply to 4.14-stable tree
To:     edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
        kuba@kernel.org, syzkaller@googlegroups.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:27:32 +0200
Message-ID: <2023102032-fang-urban-2541@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 195374d893681da43a39796e53b30ac4f20400c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102032-fang-urban-2541@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 195374d893681da43a39796e53b30ac4f20400c4 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Oct 2023 19:23:04 +0000
Subject: [PATCH] ipv4: fib: annotate races around nh->nh_saddr_genid and
 nh->nh_saddr

syzbot reported a data-race while accessing nh->nh_saddr_genid [1]

Add annotations, but leave the code lazy as intended.

[1]
BUG: KCSAN: data-race in fib_select_path / fib_select_path

write to 0xffff8881387166f0 of 4 bytes by task 6778 on cpu 1:
fib_info_update_nhc_saddr net/ipv4/fib_semantics.c:1334 [inline]
fib_result_prefsrc net/ipv4/fib_semantics.c:1354 [inline]
fib_select_path+0x292/0x330 net/ipv4/fib_semantics.c:2269
ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
__ip_route_output_key include/net/route.h:134 [inline]
ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read to 0xffff8881387166f0 of 4 bytes by task 6759 on cpu 0:
fib_result_prefsrc net/ipv4/fib_semantics.c:1350 [inline]
fib_select_path+0x1cb/0x330 net/ipv4/fib_semantics.c:2269
ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
__ip_route_output_key include/net/route.h:134 [inline]
ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x959d3217 -> 0x959d3218

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 6759 Comm: kworker/u4:15 Not tainted 6.6.0-rc4-syzkaller-00029-gcbf3a2cb156a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker

Fixes: 436c3b66ec98 ("ipv4: Invalidate nexthop cache nh_saddr more correctly.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20231017192304.82626-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1ea82bc33ef1..5eb1b8d302bb 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1325,15 +1325,18 @@ __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
 				 unsigned char scope)
 {
 	struct fib_nh *nh;
+	__be32 saddr;
 
 	if (nhc->nhc_family != AF_INET)
 		return inet_select_addr(nhc->nhc_dev, 0, scope);
 
 	nh = container_of(nhc, struct fib_nh, nh_common);
-	nh->nh_saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
-	nh->nh_saddr_genid = atomic_read(&net->ipv4.dev_addr_genid);
+	saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
 
-	return nh->nh_saddr;
+	WRITE_ONCE(nh->nh_saddr, saddr);
+	WRITE_ONCE(nh->nh_saddr_genid, atomic_read(&net->ipv4.dev_addr_genid));
+
+	return saddr;
 }
 
 __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
@@ -1347,8 +1350,9 @@ __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
 		struct fib_nh *nh;
 
 		nh = container_of(nhc, struct fib_nh, nh_common);
-		if (nh->nh_saddr_genid == atomic_read(&net->ipv4.dev_addr_genid))
-			return nh->nh_saddr;
+		if (READ_ONCE(nh->nh_saddr_genid) ==
+		    atomic_read(&net->ipv4.dev_addr_genid))
+			return READ_ONCE(nh->nh_saddr);
 	}
 
 	return fib_info_update_nhc_saddr(net, nhc, res->fi->fib_scope);

