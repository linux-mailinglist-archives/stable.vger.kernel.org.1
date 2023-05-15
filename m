Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8F703A6E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbjEORvH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbjEORul (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFA1B0B2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5504C62F14
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451B4C4339E;
        Mon, 15 May 2023 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172925;
        bh=aleVvIC/cMH7FGD8Cf8+HOrwEPMgwqaeTDjFnh4RZZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JA45qtteRImnLGhKBKjZJZLA1tw8LZm2pNEosouHpONlhr0m1nIjiu8IvkeQV4TRE
         blH+R/l0V4jlGNsiLQwge7csHqXDDWxHTs9+7sgTUUU7hkKIJVjoRjwKb0fKpm6jN2
         JbSmOMKh5B/Zv5bSzRmCZJgqzDvplx0DpfmzfW4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Palash Oswal <oswalpalash@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 311/381] sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()
Date:   Mon, 15 May 2023 18:29:22 +0200
Message-Id: <20230515161750.879459667@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cong Wang <cong.wang@bytedance.com>

[ Upstream commit c88f8d5cd95fd039cff95d682b8e71100c001df0 ]

When a tunnel device is bound with the underlying device, its
dev->needed_headroom needs to be updated properly. IPv4 tunnels
already do the same in ip_tunnel_bind_dev(). Otherwise we may
not have enough header room for skb, especially after commit
b17f709a2401 ("gue: TX support for using remote checksum offload option").

Fixes: 32b8a8e59c9c ("sit: add IPv4 over IPv4 support")
Reported-by: Palash Oswal <oswalpalash@gmail.com>
Link: https://lore.kernel.org/netdev/CAGyP=7fDcSPKu6nttbGwt7RXzE3uyYxLjCSE97J64pRxJP8jPA@mail.gmail.com/
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/sit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 1ce486a9bc076..9806bd56b95f1 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1094,12 +1094,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 	struct net_device *tdev = NULL;
-	struct ip_tunnel *tunnel;
+	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	tunnel = netdev_priv(dev);
 	iph = &tunnel->parms.iph;
 
 	if (iph->daddr) {
@@ -1122,14 +1123,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
-		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 		int mtu;
 
 		mtu = tdev->mtu - t_hlen;
 		if (mtu < IPV6_MIN_MTU)
 			mtu = IPV6_MIN_MTU;
 		WRITE_ONCE(dev->mtu, mtu);
+		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+	dev->needed_headroom = t_hlen + hlen;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
-- 
2.39.2



