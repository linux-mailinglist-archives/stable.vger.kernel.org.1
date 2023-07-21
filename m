Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0875D313
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGUTGu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjGUTGt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57A30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D662261D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACBFC433C8;
        Fri, 21 Jul 2023 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966406;
        bh=r+FlfAbIP8ckeXSsm9jCb65xvNDiJ0QbOaXot60pAl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ef0B2RZf5kpW26Y6G15GBMn3fYoqYYyReUUtZqfmQi77748pFU2E332OkFsb4kwkV
         zi/1oXgCd5g1n1aelBpJvMK6iku/x437KYPk3h/Id6E8rueK+GEUg/VwueCN0mv26d
         Ifei76lJ+x7P8TdfHv2faTTavKu+oJ8E0aTlL2H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 333/532] pptp: Fix fib lookup calls.
Date:   Fri, 21 Jul 2023 18:03:57 +0200
Message-ID: <20230721160632.485845218@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 84bef5b6037c15180ef88ac4216dc621d16df1a6 ]

PPTP uses pppox sockets (struct pppox_sock). These sockets don't embed
an inet_sock structure, so it's invalid to call inet_sk() on them.

Therefore, the ip_route_output_ports() call in pptp_connect() has two
problems:

  * The tos variable is set with RT_CONN_FLAGS(sk), which calls
    inet_sk() on the pppox socket.

  * ip_route_output_ports() tries to retrieve routing flags using
    inet_sk_flowi_flags(), which is also going to call inet_sk() on the
    pppox socket.

While PPTP doesn't use inet sockets, it's actually really layered on
top of IP and therefore needs a proper way to do fib lookups. So let's
define pptp_route_output() to get a struct rtable from a pptp socket.
Let's also replace the ip_route_output_ports() call of pptp_xmit() for
consistency.

In practice, this means that:

  * pptp_connect() sets ->flowi4_tos and ->flowi4_flags to zero instead
    of using bits of unrelated struct pppox_sock fields.

  * pptp_xmit() now respects ->sk_mark and ->sk_uid.

  * pptp_xmit() now calls the security_sk_classify_flow() security
    hook, thus allowing to set ->flowic_secid.

  * pptp_xmit() now passes the pppox socket to xfrm_lookup_route().

Found by code inspection.

Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/pptp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 0fe78826c8fa4..32183f24e63ff 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -24,6 +24,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/rcupdate.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 
 #include <net/sock.h>
@@ -128,6 +129,23 @@ static void del_chan(struct pppox_sock *sock)
 	spin_unlock(&chan_lock);
 }
 
+static struct rtable *pptp_route_output(struct pppox_sock *po,
+					struct flowi4 *fl4)
+{
+	struct sock *sk = &po->sk;
+	struct net *net;
+
+	net = sock_net(sk);
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, sk->sk_mark, 0,
+			   RT_SCOPE_UNIVERSE, IPPROTO_GRE, 0,
+			   po->proto.pptp.dst_addr.sin_addr.s_addr,
+			   po->proto.pptp.src_addr.sin_addr.s_addr,
+			   0, 0, sock_net_uid(net, sk));
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
+
+	return ip_route_output_flow(net, fl4, sk);
+}
+
 static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *) chan->private;
@@ -151,11 +169,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
 		goto tx_error;
 
-	rt = ip_route_output_ports(net, &fl4, NULL,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0, IPPROTO_GRE,
-				   RT_TOS(0), sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt))
 		goto tx_error;
 
@@ -438,12 +452,7 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	po->chan.private = sk;
 	po->chan.ops = &pptp_chan_ops;
 
-	rt = ip_route_output_ports(sock_net(sk), &fl4, sk,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0,
-				   IPPROTO_GRE, RT_CONN_FLAGS(sk),
-				   sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt)) {
 		error = -EHOSTUNREACH;
 		goto end;
-- 
2.39.2



