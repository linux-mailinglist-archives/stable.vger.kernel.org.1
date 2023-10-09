Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1917BE061
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377311AbjJINjh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377382AbjJINi4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE110E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F02AC433CB;
        Mon,  9 Oct 2023 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858728;
        bh=wE19Sfbl1wx0rX9mxUIWeAViSR6UjrFrMB7cpehj59A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeOzvZBExXSsy6ayxqLSDZEMPmRXRNFBMpDpw+yn942NEK5uk4WXYXRjCJL5pm3Z+
         aclO+tZkdjjUA/zR3C2O6BBlEPIUtLsATuRHY2p2qPy6dRUzbVtfcRilhJwfqFvhPA
         QHc21FkbSAH797n8jMaWlVGROBpPGJcbbNQ8mWYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 081/226] netfilter: exthdr: add support for tcp option removal
Date:   Mon,  9 Oct 2023 15:00:42 +0200
Message-ID: <20231009130128.905135223@linuxfoundation.org>
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

[ Upstream commit 7890cbea66e78a3a6037b2a12827118d7243270b ]

This allows to replace a tcp option with nop padding to selectively disable
a particular tcp option.

Optstrip mode is chosen when userspace passes the exthdr expression with
neither a source nor a destination register attribute.

This is identical to xtables TCPOPTSTRIP extension.
The only difference is that TCPOPTSTRIP allows to pass in a bitmap
of options to remove rather than a single number.

Unlike TCPOPTSTRIP this expression can be used multiple times
in the same rule to get the same effect.

We could add a new nested attribute later on in case there is a
use case for single-expression-multi-remove.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 28427f368f0e ("netfilter: nft_exthdr: Fix non-linear header modification")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 96 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 10a510fef75c5..7a00867aa64ba 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -308,6 +308,63 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 	regs->verdict.code = NFT_BREAK;
 }
 
+static void nft_exthdr_tcp_strip_eval(const struct nft_expr *expr,
+				      struct nft_regs *regs,
+				      const struct nft_pktinfo *pkt)
+{
+	u8 buff[sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE];
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+	unsigned int i, tcphdr_len, optl;
+	struct tcphdr *tcph;
+	u8 *opt;
+
+	tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
+	if (!tcph)
+		goto err;
+
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto drop;
+
+	opt = (u8 *)nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
+	if (!opt)
+		goto err;
+	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
+		unsigned int j;
+
+		optl = optlen(opt, i);
+		if (priv->type != opt[i])
+			continue;
+
+		if (i + optl > tcphdr_len)
+			goto drop;
+
+		for (j = 0; j < optl; ++j) {
+			u16 n = TCPOPT_NOP;
+			u16 o = opt[i+j];
+
+			if ((i + j) % 2 == 0) {
+				o <<= 8;
+				n <<= 8;
+			}
+			inet_proto_csum_replace2(&tcph->check, pkt->skb, htons(o),
+						 htons(n), false);
+		}
+		memset(opt + i, TCPOPT_NOP, optl);
+		return;
+	}
+
+	/* option not found, continue. This allows to do multiple
+	 * option removals per rule.
+	 */
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+	return;
+drop:
+	/* can't remove, no choice but to drop */
+	regs->verdict.code = NF_DROP;
+}
+
 static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -452,6 +509,28 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 				       priv->len);
 }
 
+static int nft_exthdr_tcp_strip_init(const struct nft_ctx *ctx,
+				     const struct nft_expr *expr,
+				     const struct nlattr * const tb[])
+{
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	if (tb[NFTA_EXTHDR_SREG] ||
+	    tb[NFTA_EXTHDR_DREG] ||
+	    tb[NFTA_EXTHDR_FLAGS] ||
+	    tb[NFTA_EXTHDR_OFFSET] ||
+	    tb[NFTA_EXTHDR_LEN])
+		return -EINVAL;
+
+	if (!tb[NFTA_EXTHDR_TYPE])
+		return -EINVAL;
+
+	priv->type = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
+	priv->op = NFT_EXTHDR_OP_TCPOPT;
+
+	return 0;
+}
+
 static int nft_exthdr_ipv4_init(const struct nft_ctx *ctx,
 				const struct nft_expr *expr,
 				const struct nlattr * const tb[])
@@ -512,6 +591,13 @@ static int nft_exthdr_dump_set(struct sk_buff *skb, const struct nft_expr *expr)
 	return nft_exthdr_dump_common(skb, priv);
 }
 
+static int nft_exthdr_dump_strip(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	const struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	return nft_exthdr_dump_common(skb, priv);
+}
+
 static const struct nft_expr_ops nft_exthdr_ipv6_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -544,6 +630,14 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.dump		= nft_exthdr_dump_set,
 };
 
+static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
+	.type		= &nft_exthdr_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
+	.eval		= nft_exthdr_tcp_strip_eval,
+	.init		= nft_exthdr_tcp_strip_init,
+	.dump		= nft_exthdr_dump_strip,
+};
+
 static const struct nft_expr_ops nft_exthdr_sctp_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -571,7 +665,7 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 			return &nft_exthdr_tcp_set_ops;
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_tcp_ops;
-		break;
+		return &nft_exthdr_tcp_strip_ops;
 	case NFT_EXTHDR_OP_IPV6:
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_ipv6_ops;
-- 
2.40.1



