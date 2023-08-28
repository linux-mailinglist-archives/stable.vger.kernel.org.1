Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2578ABDC
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjH1Kem (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjH1KeY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C254A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45D063D24
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAAFC433C9;
        Mon, 28 Aug 2023 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218861;
        bh=d7PYB6n1RBTGvEYlefvWJqwFexPsLJlByIaCIVwjqU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfhef+e47NKkE+kzlV1GBohoFQiHXjp9GAO8auI+a1fkKCxGC+JKREqsxw9688vio
         wxpOh7Ner19RsXiiCwytHs3cs2laMpmXzdoXBT4IyK7VTszkEXzh6VCFJbwisyRaDx
         /T8SYHjoKROM+zEXG6nHIaP7b+7xxt0BZ6GNeD7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 109/122] can: raw: add missing refcount for memory leak fix
Date:   Mon, 28 Aug 2023 12:13:44 +0200
Message-ID: <20230828101200.048328158@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit c275a176e4b69868576e543409927ae75e3a3288 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/raw.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

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
@@ -285,8 +286,10 @@ static void raw_notify(struct raw_sock *
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
@@ -391,10 +394,12 @@ static int raw_release(struct socket *so
 
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
@@ -445,10 +450,10 @@ static int raw_bind(struct socket *sock,
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
 
@@ -456,7 +461,9 @@ static int raw_bind(struct socket *sock,
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
 	} else {
 		ifindex = 0;
 
@@ -467,18 +474,28 @@ static int raw_bind(struct socket *sock,
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
 


