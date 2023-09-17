Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C157A3975
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbjIQTtw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjIQTtV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FFDC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08FC433C8;
        Sun, 17 Sep 2023 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980155;
        bh=hMEletprRqEIdeMQWJ2ikzpmvq7A/K03EOMTNoEhL4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSexr2C1onfpREVCHoT0O6EL//OSukMSxO2hofbpPkO/CCaW+c5ore7TBxu91v3dE
         IpCCJOk9dUpZ9OUpoW0g92mqLBgZTJB50g9DSrP/5T1hLoBvd09oSLXV1yMhRZttF9
         a54peUxq7C1Re6T6uzKOGKzIAN5dNMp6hjJDzfxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stanislav Fomichev <sdf@google.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Florian Westphal <fw@strlen.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 111/285] net: fib: avoid warn splat in flow dissector
Date:   Sun, 17 Sep 2023 21:11:51 +0200
Message-ID: <20230917191055.501113839@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 8aae7625ff3f0bd5484d01f1b8d5af82e44bec2d ]

New skbs allocated via nf_send_reset() have skb->dev == NULL.

fib*_rules_early_flow_dissect helpers already have a 'struct net'
argument but its not passed down to the flow dissector core, which
will then WARN as it can't derive a net namespace to use:

 WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0xa91/0x1cd0
 [..]
  ip_route_me_harder+0x143/0x330
  nf_send_reset+0x17c/0x2d0 [nf_reject_ipv4]
  nft_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
  nft_do_chain+0x198/0x5d0 [nf_tables]
  nft_do_chain_inet+0xa4/0x110 [nf_tables]
  nf_hook_slow+0x41/0xc0
  ip_local_deliver+0xce/0x110
  ..

Cc: Stanislav Fomichev <sdf@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Fixes: 812fa71f0d96 ("netfilter: Dissect flow after packet mangling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217826
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230830110043.30497-1-fw@strlen.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip6_fib.h | 5 ++++-
 include/net/ip_fib.h  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 05e6f756feafe..9ba6413fd2e3e 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -604,7 +604,10 @@ static inline bool fib6_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv6.fib6_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl6->fl6_sport = flkeys->ports.src;
 	fl6->fl6_dport = flkeys->ports.dst;
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a378eff827c74..f0c13864180e2 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -418,7 +418,10 @@ static inline bool fib4_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv4.fib_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl4->fl4_sport = flkeys->ports.src;
 	fl4->fl4_dport = flkeys->ports.dst;
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-- 
2.40.1



