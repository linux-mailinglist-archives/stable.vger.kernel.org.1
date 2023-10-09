Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AD7BE052
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377262AbjJINiv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377304AbjJINiq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DD12B
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE540C433C7;
        Mon,  9 Oct 2023 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858719;
        bh=ZTS7FeudJkuUbsKRCtLDEyM7tyyoNpPpnvu9xmR9CiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSu/X8jmJc/3POVs1V7nWaSicsuRZBKk4WKHBHxTn5BYLxZGdd80dLJfNP58PapMl
         p0b79qKwkknZHG0ExiwoEz1t2rGpx9uAfkdEM3sWtXlx17lwWL8ETW8lyYgfgTbEQH
         zPNaCP19KRyMUFFIwlg7guIeGq5qD6Jp1XSPhduo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/226] netfilter: nf_tables: add and use nft_sk helper
Date:   Mon,  9 Oct 2023 15:00:39 +0200
Message-ID: <20231009130128.827076229@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 85554eb981e5a8b0b8947611193aef1737081ef2 ]

This allows to change storage placement later on without changing readers.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 28427f368f0e ("netfilter: nft_exthdr: Fix non-linear header modification")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h    | 5 +++++
 net/ipv4/netfilter/nft_reject_ipv4.c | 2 +-
 net/ipv6/netfilter/nft_reject_ipv6.c | 2 +-
 net/netfilter/nft_reject_inet.c      | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 5619642b9ad47..013f11c9de85a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -28,6 +28,11 @@ struct nft_pktinfo {
 	struct xt_action_param		xt;
 };
 
+static inline struct sock *nft_sk(const struct nft_pktinfo *pkt)
+{
+	return pkt->xt.state->sk;
+}
+
 static inline struct net *nft_net(const struct nft_pktinfo *pkt)
 {
 	return pkt->xt.state->net;
diff --git a/net/ipv4/netfilter/nft_reject_ipv4.c b/net/ipv4/netfilter/nft_reject_ipv4.c
index ff437e4ed6db0..55fc23a8f7a70 100644
--- a/net/ipv4/netfilter/nft_reject_ipv4.c
+++ b/net/ipv4/netfilter/nft_reject_ipv4.c
@@ -27,7 +27,7 @@ static void nft_reject_ipv4_eval(const struct nft_expr *expr,
 		nf_send_unreach(pkt->skb, priv->icmp_code, nft_hook(pkt));
 		break;
 	case NFT_REJECT_TCP_RST:
-		nf_send_reset(nft_net(pkt), pkt->xt.state->sk, pkt->skb,
+		nf_send_reset(nft_net(pkt), nft_sk(pkt), pkt->skb,
 			      nft_hook(pkt));
 		break;
 	default:
diff --git a/net/ipv6/netfilter/nft_reject_ipv6.c b/net/ipv6/netfilter/nft_reject_ipv6.c
index 7969d1f3018dc..ed69c768797ec 100644
--- a/net/ipv6/netfilter/nft_reject_ipv6.c
+++ b/net/ipv6/netfilter/nft_reject_ipv6.c
@@ -28,7 +28,7 @@ static void nft_reject_ipv6_eval(const struct nft_expr *expr,
 				 nft_hook(pkt));
 		break;
 	case NFT_REJECT_TCP_RST:
-		nf_send_reset6(nft_net(pkt), pkt->xt.state->sk, pkt->skb,
+		nf_send_reset6(nft_net(pkt), nft_sk(pkt), pkt->skb,
 			       nft_hook(pkt));
 		break;
 	default:
diff --git a/net/netfilter/nft_reject_inet.c b/net/netfilter/nft_reject_inet.c
index 36b219e2e896c..c00b94a166824 100644
--- a/net/netfilter/nft_reject_inet.c
+++ b/net/netfilter/nft_reject_inet.c
@@ -28,7 +28,7 @@ static void nft_reject_inet_eval(const struct nft_expr *expr,
 					nft_hook(pkt));
 			break;
 		case NFT_REJECT_TCP_RST:
-			nf_send_reset(nft_net(pkt), pkt->xt.state->sk,
+			nf_send_reset(nft_net(pkt), nft_sk(pkt),
 				      pkt->skb, nft_hook(pkt));
 			break;
 		case NFT_REJECT_ICMPX_UNREACH:
@@ -45,7 +45,7 @@ static void nft_reject_inet_eval(const struct nft_expr *expr,
 					 priv->icmp_code, nft_hook(pkt));
 			break;
 		case NFT_REJECT_TCP_RST:
-			nf_send_reset6(nft_net(pkt), pkt->xt.state->sk,
+			nf_send_reset6(nft_net(pkt), nft_sk(pkt),
 				       pkt->skb, nft_hook(pkt));
 			break;
 		case NFT_REJECT_ICMPX_UNREACH:
-- 
2.40.1



