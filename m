Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B305A713F31
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjE1Tm5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjE1Tmz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93845A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D38C61F0C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C407C433EF;
        Sun, 28 May 2023 19:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302972;
        bh=h67YwGsBDeTa94CobgOOyHgk/AS9UF/cKa9jzmBNIFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8yz1s7MWDbiTv8u4JuiWM+QQAxcd8jWi/V3E8HMAeYdBvcbg8utLiovrTDPgBisk
         qwQ9/sue3ym3qfGXTb6n3iTI6rgOr7r6zSxSvlLCxxT5bj7BXO8lw+lSCTfdqGboTE
         v3EqSG2b4qrAeKd9kAFcKnt5a+H50w+MHZ0HK+4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Traynor <ktraynor@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 102/211] erspan: get the proto with the md version for collect_md
Date:   Sun, 28 May 2023 20:10:23 +0100
Message-Id: <20230528190846.122258352@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d80fc101d2eb9b3188c228d61223890aeea480a4 ]

In commit 20704bd1633d ("erspan: build the header with the right proto
according to erspan_ver"), it gets the proto with t->parms.erspan_ver,
but t->parms.erspan_ver is not used by collect_md branch, and instead
it should get the proto with md->version for collect_md.

Thanks to Kevin for pointing this out.

Fixes: 20704bd1633d ("erspan: build the header with the right proto according to erspan_ver")
Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")
Reported-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 2332b5b81c551..7b50e1811678e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1015,12 +1015,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					    ntohl(tun_id),
 					    ntohl(md->u.index), truncate,
 					    false);
+			proto = htons(ETH_P_ERSPAN);
 		} else if (md->version == 2) {
 			erspan_build_header_v2(skb,
 					       ntohl(tun_id),
 					       md->u.md2.dir,
 					       get_hwid(&md->u.md2),
 					       truncate, false);
+			proto = htons(ETH_P_ERSPAN2);
 		} else {
 			goto tx_err;
 		}
@@ -1043,24 +1045,25 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			break;
 		}
 
-		if (t->parms.erspan_ver == 1)
+		if (t->parms.erspan_ver == 1) {
 			erspan_build_header(skb, ntohl(t->parms.o_key),
 					    t->parms.index,
 					    truncate, false);
-		else if (t->parms.erspan_ver == 2)
+			proto = htons(ETH_P_ERSPAN);
+		} else if (t->parms.erspan_ver == 2) {
 			erspan_build_header_v2(skb, ntohl(t->parms.o_key),
 					       t->parms.dir,
 					       t->parms.hwid,
 					       truncate, false);
-		else
+			proto = htons(ETH_P_ERSPAN2);
+		} else {
 			goto tx_err;
+		}
 
 		fl6.daddr = t->parms.raddr;
 	}
 
 	/* Push GRE header. */
-	proto = (t->parms.erspan_ver == 1) ? htons(ETH_P_ERSPAN)
-					   : htons(ETH_P_ERSPAN2);
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-- 
2.39.2



