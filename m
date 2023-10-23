Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C07D343F
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjJWLh4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjJWLhz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9CE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C189FC433C9;
        Mon, 23 Oct 2023 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061073;
        bh=oh2vqTPSyTeEZgng8UniDsAeTmcNOQHTEjekvCgmt4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3NlDgQ0ZwLT8NdcWrKpPQWzp3O6bGam2L+0h1ogKKewmYuoBRjtF2/5iMj55C7RS
         3ihxRY53SAsna34CE3sFfPEyEoMAy1RunTqkfkRB61HdYiQpz7ZfaviPAzUso5oKzq
         R7FvZnYNTKUzrfUBhiYPIW1e3Mx2yQ8VayHBiNt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 064/137] mctp: Allow local delivery to the null EID
Date:   Mon, 23 Oct 2023 12:57:01 +0200
Message-ID: <20231023104823.125179465@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit 1f6c77ac9e6ecef152fd5df94c4b3c346adb197a ]

We may need to receive packets addressed to the null EID (==0), but
addressed to us at the physical layer.

This change adds a lookup for local routes when we see a packet
addressed to EID 0, and a local phys address.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5093bbfc10ab ("mctp: perform route lookups under a RCU read-side lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/route.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 89e67399249b4..859f57fd3871f 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -480,6 +480,10 @@ static int mctp_alloc_local_tag(struct mctp_sock *msk,
 	int rc = -EAGAIN;
 	u8 tagbits;
 
+	/* for NULL destination EIDs, we may get a response from any peer */
+	if (daddr == MCTP_ADDR_NULL)
+		daddr = MCTP_ADDR_ANY;
+
 	/* be optimistic, alloc now */
 	key = mctp_key_alloc(msk, saddr, daddr, 0, GFP_KERNEL);
 	if (!key)
@@ -558,6 +562,20 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 	return rt;
 }
 
+static struct mctp_route *mctp_route_lookup_null(struct net *net,
+						 struct net_device *dev)
+{
+	struct mctp_route *rt;
+
+	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
+		if (rt->dev->dev == dev && rt->type == RTN_LOCAL &&
+		    refcount_inc_not_zero(&rt->refs))
+			return rt;
+	}
+
+	return NULL;
+}
+
 /* sends a skb to rt and releases the route. */
 int mctp_do_route(struct mctp_route *rt, struct sk_buff *skb)
 {
@@ -853,6 +871,11 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	rcu_read_unlock();
 
 	rt = mctp_route_lookup(net, cb->net, mh->dest);
+
+	/* NULL EID, but addressed to our physical address */
+	if (!rt && mh->dest == MCTP_ADDR_NULL && skb->pkt_type == PACKET_HOST)
+		rt = mctp_route_lookup_null(net, dev);
+
 	if (!rt)
 		goto err_drop;
 
-- 
2.40.1



