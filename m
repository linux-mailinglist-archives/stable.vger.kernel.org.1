Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2675E234
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGWOAB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGWOAA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5D1BE
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 06:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D96260C1F
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E29C433C8;
        Sun, 23 Jul 2023 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120798;
        bh=z3GmOLEYCpLoLdEfzhBERM55+S1nVhFgDg5pvg6ocDQ=;
        h=Subject:To:Cc:From:Date:From;
        b=iKMdNiYN9kSXV0efU2bfw7yM0IvKppzJ4c72NAlX3PK7d6L/YlBuicNHFcsqfEB+P
         kjJiauRgFNx4xUUcJj5RrLQ3SmxC3GD7Qx+gIl+aLUcz73ZrRM3LegmKPCnFWzMCs+
         X2vidQ+xdHtZK7ezO3yFH3FqgImdyqlAqOII/HdQ=
Subject: FAILED: patch "[PATCH] can: raw: fix receiver memory leak" failed to apply to 5.10-stable tree
To:     william.xuanziyang@huawei.com, mkl@pengutronix.de,
        socketcan@hartkopp.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 15:59:55 +0200
Message-ID: <2023072355-alongside-hatchet-2655@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ee8b94c8510ce64afe0b87ef548d23e00915fb10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072355-alongside-hatchet-2655@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ee8b94c8510c ("can: raw: fix receiver memory leak")
1160dfa178eb ("net: Remove redundant if statements")
54f93336d000 ("can: raw: raw_setsockopt(): fix raw_rcv panic for sock UAF")
e032f7c9c7ce ("net/packet: annotate accesses to po->ifindex")
c7d2ef5dd4b0 ("net/packet: annotate accesses to po->bind")
8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
eeff3000f240 ("netfilter: flowtable: add offload support for xmit path types")
3d453f53c786 ("net/smc: Add diagnostic information to smc ib-device")
ddc992866f13 ("net/smc: Add link counters for IB device ports")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee8b94c8510ce64afe0b87ef548d23e00915fb10 Mon Sep 17 00:00:00 2001
From: Ziyang Xuan <william.xuanziyang@huawei.com>
Date: Tue, 11 Jul 2023 09:17:37 +0800
Subject: [PATCH] can: raw: fix receiver memory leak

Got kmemleak errors with the following ltp can_filter testcase:

for ((i=1; i<=100; i++))
do
        ./can_filter &
        sleep 0.1
done

==============================================================
[<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
[<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
[<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
[<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
[<00000000fd468496>] do_syscall_64+0x33/0x40
[<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

It's a bug in the concurrent scenario of unregister_netdevice_many()
and raw_release() as following:

             cpu0                                        cpu1
unregister_netdevice_many(can_dev)
  unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
  net_set_todo(can_dev)
						raw_release(can_socket)
						  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
						  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
						    raw_disable_allfilters(, dev, );
						    dev_put(dev);
						  }
						  ...
						  ro->bound = 0;
						  ...

call_netdevice_notifiers(NETDEV_UNREGISTER, )
  raw_notify(, NETDEV_UNREGISTER, )
    if (ro->bound) // invalid because ro->bound has been set 0
      raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed

Add a net_device pointer member in struct raw_sock to record bound
can_dev, and use rtnl_lock to serialize raw_socket members between
raw_bind(), raw_release(), raw_setsockopt() and raw_notify(). Use
ro->dev to decide whether to free receivers in dev_rcv_lists.

Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Link: https://lore.kernel.org/all/20230711011737.1969582-1-william.xuanziyang@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/net/can/raw.c b/net/can/raw.c
index 15c79b079184..2302e4882967 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -84,6 +84,7 @@ struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
@@ -277,7 +278,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->ifindex != dev->ifindex)
+	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
@@ -292,6 +293,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 		ro->ifindex = 0;
 		ro->bound = 0;
+		ro->dev = NULL;
 		ro->count = 0;
 		release_sock(sk);
 
@@ -337,6 +339,7 @@ static int raw_init(struct sock *sk)
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
+	ro->dev              = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -385,19 +388,13 @@ static int raw_release(struct socket *sock)
 
 	lock_sock(sk);
 
+	rtnl_lock();
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (dev) {
-				raw_disable_allfilters(dev_net(dev), dev, sk);
-				dev_put(dev);
-			}
-		} else {
+		if (ro->dev)
+			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+		else
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
-		}
 	}
 
 	if (ro->count > 1)
@@ -405,8 +402,10 @@ static int raw_release(struct socket *sock)
 
 	ro->ifindex = 0;
 	ro->bound = 0;
+	ro->dev = NULL;
 	ro->count = 0;
 	free_percpu(ro->uniq);
+	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -422,6 +421,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net_device *dev = NULL;
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -431,14 +431,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
-		struct net_device *dev;
-
 		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
 		if (!dev) {
 			err = -ENODEV;
@@ -467,26 +466,20 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->ifindex) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(sock_net(sk),
-						       ro->ifindex);
-				if (dev) {
-					raw_disable_allfilters(dev_net(dev),
-							       dev, sk);
-					dev_put(dev);
-				}
-			} else {
+			if (ro->dev)
+				raw_disable_allfilters(dev_net(ro->dev),
+						       ro->dev, sk);
+			else
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
-			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		ro->dev = dev;
 	}
 
  out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -553,9 +546,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				if (count > 1)
 					kfree(filter);
 				err = -ENODEV;
@@ -596,7 +589,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -614,9 +606,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				err = -ENODEV;
 				goto out_err;
 			}
@@ -640,7 +632,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 

