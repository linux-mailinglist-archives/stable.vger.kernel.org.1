Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B178AB9F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjH1Kc7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjH1Kct (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0C19B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6F263D2A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012CFC433C9;
        Mon, 28 Aug 2023 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218706;
        bh=brNCZzUPzw30BOGgpZXeQ2yW/TrGPcI1/vCREIR8x4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBED2+/kzg0duC08fEvv4HBox/CXERrlbUYi+CWTlpA9sh9i2Phxv5h+7ww+31GJo
         XbY8/OiAywXgGelgi074LeYwXNfr1LzDFn9IO0eWg3spQc+c60Nevs/xBkISjj/R9b
         sMNl0ktYJmFecwxvG5RJf3IZprzaKAxI/ZW4EOYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/122] can: raw: fix receiver memory leak
Date:   Mon, 28 Aug 2023 12:12:11 +0200
Message-ID: <20230828101156.992105058@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 4abab2c3011a3..1cd2c8748c26a 100644
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
@@ -552,9 +545,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -595,7 +588,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -613,9 +605,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -639,7 +631,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
-- 
2.40.1



