Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE787831D6
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHUTzv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHUTzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8510E
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF217627AA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECA4C433C8;
        Mon, 21 Aug 2023 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647737;
        bh=rQgHTJSY07SYNiK/m8K6gwE8ld+M0KAuDYu8h4Yd2D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLEKZp2cL/ikre5GgHiS9sUIYaIUN24tsSaaOQ5Up+/HnQQ3bsSYstBLY9gGYwUgY
         ryKLHA7L4pMbBXkJWgG9Y67HlCF5jxwFvbjMIkGsmRJaMWMKxxgf06f3e1hwp6vJiX
         0GEWFMeT+C7mECfeTLbAznxR/k1Jr9O+EurJYHDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 120/194] netfilter: nf_tables: fix false-positive lockdep splat
Date:   Mon, 21 Aug 2023 21:41:39 +0200
Message-ID: <20230821194127.980951276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit b9f052dc68f69dac89fe1e24693354c033daa091 ]

->abort invocation may cause splat on debug kernels:

WARNING: suspicious RCU usage
net/netfilter/nft_set_pipapo.c:1697 suspicious rcu_dereference_check() usage!
[..]
rcu_scheduler_active = 2, debug_locks = 1
1 lock held by nft/133554: [..] (nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid
[..]
 lockdep_rcu_suspicious+0x1ad/0x260
 nft_pipapo_abort+0x145/0x180
 __nf_tables_abort+0x5359/0x63d0
 nf_tables_abort+0x24/0x40
 nfnetlink_rcv+0x1a0a/0x22c0
 netlink_unicast+0x73c/0x900
 netlink_sendmsg+0x7f0/0xc20
 ____sys_sendmsg+0x48d/0x760

Transaction mutex is held, so parallel updates are not possible.
Switch to _protected and check mutex is held for lockdep enabled builds.

Fixes: 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a81829c10feab..32cfd0a84b0e2 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1665,6 +1665,17 @@ static void nft_pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -1673,7 +1684,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	if (!priv->dirty)
 		return;
 
-	m = rcu_dereference(priv->match);
+	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
 	if (IS_ERR(new_clone))
-- 
2.40.1



