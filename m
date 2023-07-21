Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73675CD5C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjGUQKi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGUQKh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A672D71
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2D1861D32
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E4C433C8;
        Fri, 21 Jul 2023 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955824;
        bh=ai/EerMe1VtJaD2RV1j8gyKVaoPZ4jlZDLWP4ZKmp3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmORo+yG3F95Rqqb42yBp0zHZTH3TT/DjaZo969bLisyfKjiPrc7on/ctO7ZjYiLo
         kCQEP2g1ESEUOa4nIR6tA+P1bOj/oXoyQCOpoGU/XAsvGI3qZzl6PrQUvtBd7xfnoM
         hIgNKGF91UOAS8T9mgRVxjRS25+80PpMvpfP9YtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 018/292] netfilter: conntrack: dont fold port numbers into addresses before hashing
Date:   Fri, 21 Jul 2023 18:02:07 +0200
Message-ID: <20230721160529.590549528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit eaf9e7192ec9af2fbf1b6eb2299dd0feca6c5f7e ]

Originally this used jhash2() over tuple and folded the zone id,
the pernet hash value, destination port and l4 protocol number into the
32bit seed value.

When the switch to siphash was done, I used an on-stack temporary
buffer to build a suitable key to be hashed via siphash().

But this showed up as performance regression, so I got rid of
the temporary copy and collected to-be-hashed data in 4 u64 variables.

This makes it easy to build tuples that produce the same hash, which isn't
desirable even though chain lengths are limited.

Switch back to plain siphash, but just like with jhash2(), take advantage
of the fact that most of to-be-hashed data is already in a suitable order.

Use an empty struct as annotation in 'struct nf_conntrack_tuple' to mark
last member that can be used as hash input.

The only remaining data that isn't present in the tuple structure are the
zone identifier and the pernet hash: fold those into the key.

Fixes: d2c806abcf0b ("netfilter: conntrack: use siphash_4u64")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_tuple.h |  3 +++
 net/netfilter/nf_conntrack_core.c          | 20 +++++++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_tuple.h b/include/net/netfilter/nf_conntrack_tuple.h
index 9334371c94e2b..f7dd950ff2509 100644
--- a/include/net/netfilter/nf_conntrack_tuple.h
+++ b/include/net/netfilter/nf_conntrack_tuple.h
@@ -67,6 +67,9 @@ struct nf_conntrack_tuple {
 		/* The protocol. */
 		u_int8_t protonum;
 
+		/* The direction must be ignored for the tuplehash */
+		struct { } __nfct_hash_offsetend;
+
 		/* The direction (for tuplehash) */
 		u_int8_t dir;
 	} dst;
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d119f1d4c2fc8..992393102d5f5 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -211,24 +211,18 @@ static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
 			      unsigned int zoneid,
 			      const struct net *net)
 {
-	u64 a, b, c, d;
+	siphash_key_t key;
 
 	get_random_once(&nf_conntrack_hash_rnd, sizeof(nf_conntrack_hash_rnd));
 
-	/* The direction must be ignored, handle usable tuplehash members manually */
-	a = (u64)tuple->src.u3.all[0] << 32 | tuple->src.u3.all[3];
-	b = (u64)tuple->dst.u3.all[0] << 32 | tuple->dst.u3.all[3];
+	key = nf_conntrack_hash_rnd;
 
-	c = (__force u64)tuple->src.u.all << 32 | (__force u64)tuple->dst.u.all << 16;
-	c |= tuple->dst.protonum;
+	key.key[0] ^= zoneid;
+	key.key[1] ^= net_hash_mix(net);
 
-	d = (u64)zoneid << 32 | net_hash_mix(net);
-
-	/* IPv4: u3.all[1,2,3] == 0 */
-	c ^= (u64)tuple->src.u3.all[1] << 32 | tuple->src.u3.all[2];
-	d += (u64)tuple->dst.u3.all[1] << 32 | tuple->dst.u3.all[2];
-
-	return (u32)siphash_4u64(a, b, c, d, &nf_conntrack_hash_rnd);
+	return siphash((void *)tuple,
+			offsetofend(struct nf_conntrack_tuple, dst.__nfct_hash_offsetend),
+			&key);
 }
 
 static u32 scale_hash(u32 hash)
-- 
2.39.2



