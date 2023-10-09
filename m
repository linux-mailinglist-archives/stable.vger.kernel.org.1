Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48C57BE051
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377296AbjJINir (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377300AbjJINio (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE510C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1936C433C7;
        Mon,  9 Oct 2023 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858716;
        bh=/UJ9uo1wAcgUwh+LN2Vplyzp7mERHfgrYW19fJxX9cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPzjyZxenGeyVEm7OfHfs9w9cVj7wvRk8wHox2i0F7DOYpTJUn8UEQmNfNW44TS0n
         8OpF7mayDdh8x7ohXvUk+hiihMTxI/7j0vi4RTVvnZFRdZZD3lHz5zQZ7XvQCXugc6
         NjwgqlTZRvfeJNnrHmvuYdaGYPHH/Dt2cJe4Myuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/226] netfilter: nft_exthdr: Support SCTP chunks
Date:   Mon,  9 Oct 2023 15:00:38 +0200
Message-ID: <20231009130128.800204293@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 133dc203d77dff617d9c4673973ef3859be2c476 ]

Chunks are SCTP header extensions similar in implementation to IPv6
extension headers or TCP options. Reusing exthdr expression to find and
extract field values from them is therefore pretty straightforward.

For now, this supports extracting data from chunks at a fixed offset
(and length) only - chunks themselves are an extensible data structure;
in order to make all fields available, a nested extension search is
needed.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 28427f368f0e ("netfilter: nft_exthdr: Fix non-linear header modification")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 +
 net/netfilter/nft_exthdr.c               | 51 ++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 98272cb5f6178..1d8dd58f83a50 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -797,11 +797,13 @@ enum nft_exthdr_flags {
  * @NFT_EXTHDR_OP_IPV6: match against ipv6 extension headers
  * @NFT_EXTHDR_OP_TCP: match against tcp options
  * @NFT_EXTHDR_OP_IPV4: match against ipv4 options
+ * @NFT_EXTHDR_OP_SCTP: match against sctp chunks
  */
 enum nft_exthdr_op {
 	NFT_EXTHDR_OP_IPV6,
 	NFT_EXTHDR_OP_TCPOPT,
 	NFT_EXTHDR_OP_IPV4,
+	NFT_EXTHDR_OP_SCTP,
 	__NFT_EXTHDR_OP_MAX
 };
 #define NFT_EXTHDR_OP_MAX	(__NFT_EXTHDR_OP_MAX - 1)
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 670dd146fb2b1..2f852ea67e5d5 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -10,8 +10,10 @@
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
+#include <linux/sctp.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/sctp/sctp.h>
 #include <net/tcp.h>
 
 struct nft_exthdr {
@@ -303,6 +305,43 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 	}
 }
 
+static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
+				 struct nft_regs *regs,
+				 const struct nft_pktinfo *pkt)
+{
+	unsigned int offset = pkt->xt.thoff + sizeof(struct sctphdr);
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+	u32 *dest = &regs->data[priv->dreg];
+	const struct sctp_chunkhdr *sch;
+	struct sctp_chunkhdr _sch;
+
+	do {
+		sch = skb_header_pointer(pkt->skb, offset, sizeof(_sch), &_sch);
+		if (!sch || !sch->length)
+			break;
+
+		if (sch->type == priv->type) {
+			if (priv->flags & NFT_EXTHDR_F_PRESENT) {
+				nft_reg_store8(dest, true);
+				return;
+			}
+			if (priv->offset + priv->len > ntohs(sch->length) ||
+			    offset + ntohs(sch->length) > pkt->skb->len)
+				break;
+
+			dest[priv->len / NFT_REG32_SIZE] = 0;
+			memcpy(dest, (char *)sch + priv->offset, priv->len);
+			return;
+		}
+		offset += SCTP_PAD4(ntohs(sch->length));
+	} while (offset < pkt->skb->len);
+
+	if (priv->flags & NFT_EXTHDR_F_PRESENT)
+		nft_reg_store8(dest, false);
+	else
+		regs->verdict.code = NFT_BREAK;
+}
+
 static const struct nla_policy nft_exthdr_policy[NFTA_EXTHDR_MAX + 1] = {
 	[NFTA_EXTHDR_DREG]		= { .type = NLA_U32 },
 	[NFTA_EXTHDR_TYPE]		= { .type = NLA_U8 },
@@ -502,6 +541,14 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.dump		= nft_exthdr_dump_set,
 };
 
+static const struct nft_expr_ops nft_exthdr_sctp_ops = {
+	.type		= &nft_exthdr_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
+	.eval		= nft_exthdr_sctp_eval,
+	.init		= nft_exthdr_init,
+	.dump		= nft_exthdr_dump,
+};
+
 static const struct nft_expr_ops *
 nft_exthdr_select_ops(const struct nft_ctx *ctx,
 		      const struct nlattr * const tb[])
@@ -532,6 +579,10 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 				return &nft_exthdr_ipv4_ops;
 		}
 		break;
+	case NFT_EXTHDR_OP_SCTP:
+		if (tb[NFTA_EXTHDR_DREG])
+			return &nft_exthdr_sctp_ops;
+		break;
 	}
 
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.40.1



