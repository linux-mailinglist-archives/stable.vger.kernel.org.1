Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4827BE05D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377291AbjJINjf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377340AbjJINiu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356F18D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E770CC433C8;
        Mon,  9 Oct 2023 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858722;
        bh=wqOB3EVXdtNyoMYgqql+niJiPFE6NrYEmuvMzHhaeak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzxiT1jgkzCgArnw9eNPGqwYdlWNh4YcnszVSU2iRRHimRsrprnMu1F1/MmhvLt6g
         QOsVjXwbVMjkyR1M03T8SiW2aFwAkWpR2kQlVh+w1RiTJMrBegEls6Fj2fB1klF718
         sMVpqBSnrP1IbaJhb2t5Y3kL7vSJFLIEmRfHPV6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 079/226] netfilter: nf_tables: add and use nft_thoff helper
Date:   Mon,  9 Oct 2023 15:00:40 +0200
Message-ID: <20231009130128.852502475@linuxfoundation.org>
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

[ Upstream commit 2d7b4ace0754ebaaf71c6824880178d46aa0ab33 ]

This allows to change storage placement later on without changing readers.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 28427f368f0e ("netfilter: nft_exthdr: Fix non-linear header modification")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  5 +++++
 net/netfilter/nf_tables_core.c    |  2 +-
 net/netfilter/nf_tables_trace.c   |  6 +++---
 net/netfilter/nft_exthdr.c        |  8 ++++----
 net/netfilter/nft_flow_offload.c  |  2 +-
 net/netfilter/nft_payload.c       | 10 +++++-----
 net/netfilter/nft_synproxy.c      |  4 ++--
 net/netfilter/nft_tproxy.c        |  4 ++--
 8 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 013f11c9de85a..152cd46915d6d 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -33,6 +33,11 @@ static inline struct sock *nft_sk(const struct nft_pktinfo *pkt)
 	return pkt->xt.state->sk;
 }
 
+static inline unsigned int nft_thoff(const struct nft_pktinfo *pkt)
+{
+	return pkt->xt.thoff;
+}
+
 static inline struct net *nft_net(const struct nft_pktinfo *pkt)
 {
 	return pkt->xt.state->net;
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 9dc18429ed875..b0d711d498c66 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -125,7 +125,7 @@ static bool nft_payload_fast_eval(const struct nft_expr *expr,
 	else {
 		if (!pkt->tprot_set)
 			return false;
-		ptr = skb_network_header(skb) + pkt->xt.thoff;
+		ptr = skb_network_header(skb) + nft_thoff(pkt);
 	}
 
 	ptr += priv->offset;
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 0cf3278007ba5..e4fe2f0780eb6 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -113,17 +113,17 @@ static int nf_trace_fill_pkt_info(struct sk_buff *nlskb,
 	int off = skb_network_offset(skb);
 	unsigned int len, nh_end;
 
-	nh_end = pkt->tprot_set ? pkt->xt.thoff : skb->len;
+	nh_end = pkt->tprot_set ? nft_thoff(pkt) : skb->len;
 	len = min_t(unsigned int, nh_end - skb_network_offset(skb),
 		    NFT_TRACETYPE_NETWORK_HSIZE);
 	if (trace_fill_header(nlskb, NFTA_TRACE_NETWORK_HEADER, skb, off, len))
 		return -1;
 
 	if (pkt->tprot_set) {
-		len = min_t(unsigned int, skb->len - pkt->xt.thoff,
+		len = min_t(unsigned int, skb->len - nft_thoff(pkt),
 			    NFT_TRACETYPE_TRANSPORT_HSIZE);
 		if (trace_fill_header(nlskb, NFTA_TRACE_TRANSPORT_HEADER, skb,
-				      pkt->xt.thoff, len))
+				      nft_thoff(pkt), len))
 			return -1;
 	}
 
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 2f852ea67e5d5..73f82483f2429 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -170,7 +170,7 @@ nft_tcp_header_pointer(const struct nft_pktinfo *pkt,
 	if (!pkt->tprot_set || pkt->tprot != IPPROTO_TCP)
 		return NULL;
 
-	tcph = skb_header_pointer(pkt->skb, pkt->xt.thoff, sizeof(*tcph), buffer);
+	tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt), sizeof(*tcph), buffer);
 	if (!tcph)
 		return NULL;
 
@@ -178,7 +178,7 @@ nft_tcp_header_pointer(const struct nft_pktinfo *pkt,
 	if (*tcphdr_len < sizeof(*tcph) || *tcphdr_len > len)
 		return NULL;
 
-	return skb_header_pointer(pkt->skb, pkt->xt.thoff, *tcphdr_len, buffer);
+	return skb_header_pointer(pkt->skb, nft_thoff(pkt), *tcphdr_len, buffer);
 }
 
 static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
@@ -254,7 +254,7 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 			return;
 
 		if (skb_ensure_writable(pkt->skb,
-					pkt->xt.thoff + i + priv->len))
+					nft_thoff(pkt) + i + priv->len))
 			return;
 
 		tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff,
@@ -309,7 +309,7 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
 {
-	unsigned int offset = pkt->xt.thoff + sizeof(struct sctphdr);
+	unsigned int offset = nft_thoff(pkt) + sizeof(struct sctphdr);
 	struct nft_exthdr *priv = nft_expr_priv(expr);
 	u32 *dest = &regs->data[priv->dreg];
 	const struct sctp_chunkhdr *sch;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index d868eade60176..a44340dd3ce64 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -90,7 +90,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
-		tcph = skb_header_pointer(pkt->skb, pkt->xt.thoff,
+		tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt),
 					  sizeof(_tcph), &_tcph);
 		if (unlikely(!tcph || tcph->fin || tcph->rst))
 			goto out;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 74c220eeec1a8..b2b63c3653d49 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -110,7 +110,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
 		if (!pkt->tprot_set)
 			goto err;
-		offset = pkt->xt.thoff;
+		offset = nft_thoff(pkt);
 		break;
 	default:
 		BUG();
@@ -510,7 +510,7 @@ static int nft_payload_l4csum_offset(const struct nft_pktinfo *pkt,
 		*l4csum_offset = offsetof(struct tcphdr, check);
 		break;
 	case IPPROTO_UDP:
-		if (!nft_payload_udp_checksum(skb, pkt->xt.thoff))
+		if (!nft_payload_udp_checksum(skb, nft_thoff(pkt)))
 			return -1;
 		fallthrough;
 	case IPPROTO_UDPLITE:
@@ -523,7 +523,7 @@ static int nft_payload_l4csum_offset(const struct nft_pktinfo *pkt,
 		return -1;
 	}
 
-	*l4csum_offset += pkt->xt.thoff;
+	*l4csum_offset += nft_thoff(pkt);
 	return 0;
 }
 
@@ -615,7 +615,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
 		if (!pkt->tprot_set)
 			goto err;
-		offset = pkt->xt.thoff;
+		offset = nft_thoff(pkt);
 		break;
 	default:
 		BUG();
@@ -646,7 +646,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	if (priv->csum_type == NFT_PAYLOAD_CSUM_SCTP &&
 	    pkt->tprot == IPPROTO_SCTP &&
 	    skb->ip_summed != CHECKSUM_PARTIAL) {
-		if (nft_payload_csum_sctp(skb, pkt->xt.thoff))
+		if (nft_payload_csum_sctp(skb, nft_thoff(pkt)))
 			goto err;
 	}
 
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 59c4dfaf2ea1f..1133e06f3c40e 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -109,7 +109,7 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 {
 	struct synproxy_options opts = {};
 	struct sk_buff *skb = pkt->skb;
-	int thoff = pkt->xt.thoff;
+	int thoff = nft_thoff(pkt);
 	const struct tcphdr *tcp;
 	struct tcphdr _tcph;
 
@@ -123,7 +123,7 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 		return;
 	}
 
-	tcp = skb_header_pointer(skb, pkt->xt.thoff,
+	tcp = skb_header_pointer(skb, thoff,
 				 sizeof(struct tcphdr),
 				 &_tcph);
 	if (!tcp) {
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index c49d318f8e6ed..f8d277e05ef4f 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -88,9 +88,9 @@ static void nft_tproxy_eval_v6(const struct nft_expr *expr,
 	const struct nft_tproxy *priv = nft_expr_priv(expr);
 	struct sk_buff *skb = pkt->skb;
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
-	struct in6_addr taddr;
-	int thoff = pkt->xt.thoff;
+	int thoff = nft_thoff(pkt);
 	struct udphdr _hdr, *hp;
+	struct in6_addr taddr;
 	__be16 tport = 0;
 	struct sock *sk;
 	int l4proto;
-- 
2.40.1



