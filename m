Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF090789CFF
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjH0KdC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjH0Kcv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 06:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F121138
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 03:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23CC6152B
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 10:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0266C433C7;
        Sun, 27 Aug 2023 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693132361;
        bh=6ueKYRi/vviYZe+fJbKzBS5OqwxX9CfplbjeyaqShAo=;
        h=Subject:To:Cc:From:Date:From;
        b=0MiCVUwLeCuzc3OuXIXgNblf7mj/JJvOBFhlp+gUSJ9bULTPdm1xZSDwc1cFl5ZpX
         zUM+tgevmxpqUESlvcKaRqLuu/ilL+Y7izh8Avx/CepftrxldwheIpezXYmQpK9orZ
         H7NPNv2/gbiJ2+GYWDixK+zDnp5OKnCJgBNKwZJs=
Subject: FAILED: patch "[PATCH] can: raw: add missing refcount for memory leak fix" failed to apply to 5.15-stable tree
To:     socketcan@hartkopp.net, edumazet@google.com, kuba@kernel.org,
        william.xuanziyang@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 Aug 2023 12:32:38 +0200
Message-ID: <2023082737-cavity-bloating-1779@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c275a176e4b69868576e543409927ae75e3a3288
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082737-cavity-bloating-1779@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
ee8b94c8510c ("can: raw: fix receiver memory leak")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c275a176e4b69868576e543409927ae75e3a3288 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 21 Aug 2023 16:45:47 +0200
Subject: [PATCH] can: raw: add missing refcount for memory leak fix

Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
a new reference to the CAN netdevice that has assigned CAN filters.
But this new ro->dev reference did not maintain its own refcount which
lead to another KASAN use-after-free splat found by Eric Dumazet.

This patch ensures a proper refcount for the CAN nedevice.

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20230821144547.6658-3-socketcan@hartkopp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/can/raw.c b/net/can/raw.c
index e10f59375659..d50c3f3d892f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -85,6 +85,7 @@ struct raw_sock {
 	int bound;
 	int ifindex;
 	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
@@ -285,8 +286,10 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			netdev_put(dev, &ro->dev_tracker);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
@@ -391,10 +394,12 @@ static int raw_release(struct socket *sock)
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->dev)
+		if (ro->dev) {
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
-		else
+			netdev_put(ro->dev, &ro->dev_tracker);
+		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
+		}
 	}
 
 	if (ro->count > 1)
@@ -445,10 +450,10 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out;
 		}
 		if (dev->type != ARPHRD_CAN) {
-			dev_put(dev);
 			err = -ENODEV;
-			goto out;
+			goto out_put_dev;
 		}
+
 		if (!(dev->flags & IFF_UP))
 			notify_enetdown = 1;
 
@@ -456,7 +461,9 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
 	} else {
 		ifindex = 0;
 
@@ -467,18 +474,28 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->dev)
+			if (ro->dev) {
 				raw_disable_allfilters(dev_net(ro->dev),
 						       ro->dev, sk);
-			else
+				/* drop reference to old ro->dev */
+				netdev_put(ro->dev, &ro->dev_tracker);
+			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
+			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
+		if (ro->dev)
+			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
- out:
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	if (dev)
+		dev_put(dev);
+out:
 	release_sock(sk);
 	rtnl_unlock();
 

