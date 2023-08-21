Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC17831E0
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHUUFf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjHUUFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21903129
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD03260FA3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDCC433C8;
        Mon, 21 Aug 2023 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648332;
        bh=IGhRNM6Xf4NAbw763ygPjmsSfyQ2MkN1Y4bfZyKT6O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEgZmu0a1twgf1Ud17/B5waAOSLwPrBX0lbHoJDb2rBuOQOldtWyq/XH3q06kuNoO
         7ylKocAww2Sh02xrkucMzVcNBY0Pn+ENchCTrke0/jCVMZ/Wo4/dV5Uhwr3HgzDCuZ
         LQPT12eU5E/g2vf1dGzAQdiUNrlqjpLcFuYNr3cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 138/234] ip_vti: fix potential slab-use-after-free in decode_session6
Date:   Mon, 21 Aug 2023 21:41:41 +0200
Message-ID: <20230821194134.934593080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 6018a266279b1a75143c7c0804dd08a5fc4c3e0b ]

When ip_vti device is set to the qdisc of the sfb type, the cb field
of the sent skb may be modified during enqueuing. Then,
slab-use-after-free may occur when ip_vti device sends IPv6 packets.
As commit f855691975bb ("xfrm6: Fix the nexthdr offset in
_decode_session6.") showed, xfrm_decode_session was originally intended
only for the receive path. IP6CB(skb)->nhoff is not set during
transmission. Therefore, set the cb field in the skb to 0 before
sending packets.

Fixes: f855691975bb ("xfrm6: Fix the nexthdr offset in _decode_session6.")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_vti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 53bfd8af69203..d1e7d0ceb7edd 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -287,12 +287,12 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	default:
 		goto tx_err;
-- 
2.40.1



