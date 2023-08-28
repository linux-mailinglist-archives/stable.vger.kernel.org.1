Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7FA78AD0D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjH1KpW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjH1KpI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E4CD7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9846B641FF
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD957C433C8;
        Mon, 28 Aug 2023 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219479;
        bh=+/xeHPbeUrNqNRozkvYHAbyUsjk3GpvSzKOUQzdgo3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lVGmWwgkcWUlvNUoASpVC1NbMndwWvZ9oumvCjAYNLpWUANZvNH4+T/6+frpCVrF
         OWeddWqOQw5m8XTz8s3Lk2dGDbkwB1U2cx+1sFWq4h7eSMT1/PWiRoPakyypRDtERA
         v0ilVip0Pq8aydHsK1qrmct8H670Vvs2lQkezaSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 21/89] can: raw: fix receiver memory leak
Date:   Mon, 28 Aug 2023 12:13:22 +0200
Message-ID: <20230828101150.876309269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit ee8b94c8510ce64afe0b87ef548d23e00915fb10 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/raw.c | 57 ++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 7105fa4824e4b..afa76ce0bf608 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,6 +83,7 @@ struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
@@ -275,7 +276,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->ifindex != dev->ifindex)
+	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
@@ -290,6 +291,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 		ro->ifindex = 0;
 		ro->bound = 0;
+		ro->dev = NULL;
 		ro->count = 0;
 		release_sock(sk);
 
@@ -335,6 +337,7 @@ static int raw_init(struct sock *sk)
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
+	ro->dev              = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -382,19 +385,13 @@ static int raw_release(struct socket *sock)
 
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
@@ -402,8 +399,10 @@ static int raw_release(struct socket *sock)
 
 	ro->ifindex = 0;
 	ro->bound = 0;
+	ro->dev = NULL;
 	ro->count = 0;
 	free_percpu(ro->uniq);
+	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -419,6 +418,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net_device *dev = NULL;
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -428,14 +428,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -464,26 +463,20 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -549,9 +542,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -592,7 +585,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -610,9 +602,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -636,7 +628,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
-- 
2.40.1



