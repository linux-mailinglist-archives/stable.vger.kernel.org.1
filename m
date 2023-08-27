Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07314789D35
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 13:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjH0LNl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjH0LNN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 07:13:13 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 04:13:10 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145E109
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 04:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693134606; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ipkHu13I+/WF9k1Y4xxXianeDC1TiK3KNk57wyK28h5uRvNP3kno5kIPU3QP8faQPq
    iZ9JHFhZ1YTOxbizjT3EA/DykaRg100Wrx7+24NaMbwjt4NX54rUV8FdNBShZyJ+EAqM
    vMeb6zJYCk01YO56NiBnrQhOdqNwd05dQjFjLG151Av2h+NUTC7gjFBFb8okSBiy7+zl
    Hiri2JnZcDoi6nnCmXJGZ5+EwFeuQdD3XRYDrbRHo14T/nlaXPBEWmQPePZntOVX6KaP
    UytRgw8FAHip2XklmTlMwfDk57mBlIvov3+ogTG1E3VftSG7j2iymsVrl1Ia7BaZnnxo
    bIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693134606;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2s96uNDwJxr1cgW2n3huxU2GEF1DiSFuvfnprZ+Gnfg=;
    b=ogo1A14GkExLL603S2paCC5w3wjuiLUCoomD513VQ6sca0ot+qwDSg3dDVajOr6frN
    WiyU88anyPKU8ESgIojs9ka2vBtcxfFv01LRlVfMkb9DubfV7E0/cEqq+eIhXRJq3b4+
    bNNuWTkEI9IP3JhP1gyAeEuPgAsahZoark30YXYQJvh43sSJ/JjwjqPLC9iAr0qnoGiu
    NLbjLlw0u76SnJ9iPMsRQQr+HRpW5vZRqXubfL4YfGV3+vEUSEDq8tVC6y0ZP21RQULs
    b7/dNabuucryL4BynUdeS8nwsmgzFqsh6Q6Po9H3DZf4O4NIaAGEQb0IUhKrO7Qe5MKu
    6U1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693134606;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2s96uNDwJxr1cgW2n3huxU2GEF1DiSFuvfnprZ+Gnfg=;
    b=E8q+HHfOXKdRw0XPL3Nxc0hZGwhPRET4VcS/fJUnsW/5KZQwMby20v3ksIjkIE0XqQ
    3aKA0GsOCc5N9NUXI095UQrkqGeP2jPHA85l9wqT+OBnFUed8EDcHWTohtWHGEL121TS
    L2lkFnmUzMjq6ETK0t3loaGFJK3/YF/5VWFlF8nQqebeePB55dmn1orjdf8k2t7oTgj0
    6y/HX0SoMvXONqL5p8pQ4Dgonxoe6Yx6WYnXgKqkxNzsCL94JDzkRpB4qA7aNGi8ZZnw
    rMG+xkzate4ruk2AumqnrEsDaxiNsO11ikEYr3D87yxMrGsKSnEqUlR7iSSa4sfaFmcI
    F03g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693134606;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2s96uNDwJxr1cgW2n3huxU2GEF1DiSFuvfnprZ+Gnfg=;
    b=xv7diHXwQ9kO08zeGySrZo4023eEHqNi/hAZu4oBu3G73KXhdXE3Pjoc7Xe/9uhSUZ
    1x1SIE1Cb1bw236zihAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7RBA5EnL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 27 Aug 2023 13:10:05 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, edumazet@google.com, kuba@kernel.org,
        william.xuanziyang@huawei.com, stable@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable < v6.0] can: raw: add missing refcount for memory leak fix
Date:   Sun, 27 Aug 2023 13:09:45 +0200
Message-Id: <20230827110945.3458-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
a new reference to the CAN netdevice that has assigned CAN filters.
But this new ro->dev reference did not maintain its own refcount which
lead to another KASAN use-after-free splat found by Eric Dumazet.

This patch ensures a proper refcount for the CAN nedevice.

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index e10f59375659..26285a6c968e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -283,12 +283,14 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			dev_put(dev);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
@@ -389,14 +391,16 @@ static int raw_release(struct socket *sock)
 	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->dev)
+		if (ro->dev) {
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
-		else
+			dev_put(ro->dev);
+		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
+		}
 	}
 
 	if (ro->count > 1)
 		kfree(ro->filter);
 
@@ -443,44 +447,56 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		if (!dev) {
 			err = -ENODEV;
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
 
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
 	} else {
 		ifindex = 0;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), NULL, sk);
 	}
 
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->dev)
+			if (ro->dev) {
 				raw_disable_allfilters(dev_net(ro->dev),
 						       ro->dev, sk);
-			else
+				/* drop reference to old ro->dev */
+				dev_put(ro->dev);
+			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
+			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
+		if (ro->dev)
+			dev_hold(ro->dev);
 	}
 
- out:
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	if (dev)
+		dev_put(dev);
+out:
 	release_sock(sk);
 	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
-- 
2.39.2

