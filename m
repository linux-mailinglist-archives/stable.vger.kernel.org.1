Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1229075D36A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGUTKY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGUTKX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423451BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE0561D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA981C433C9;
        Fri, 21 Jul 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966621;
        bh=jpJGwnG7GCtDmh54fwCIsluWi9+vb7NSBm8GmSK4J5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhuOyqieM693giKnNo1/vdakAPB5HtEIDZwryWA0J7sLraVyoxhQo37rH3wbRNEen
         8lEIQ70YsmU+EdZRdBe7FHGjYMPND4WoxPXfSA/mrEgJnzh/EOSq4zKqOoBA1Robe3
         jM3KN9OI2UympFvPumRyDZUQ4q3bVfl6AtrX0ewE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.15 381/532] netfilter: nf_tables: do not ignore genmask when looking up chain by id
Date:   Fri, 21 Jul 2023 18:04:45 +0200
Message-ID: <20230721160635.151363309@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit 515ad530795c118f012539ed76d02bacfd426d89 upstream.

When adding a rule to a chain referring to its ID, if that chain had been
deleted on the same batch, the rule might end up referring to a deleted
chain.

This will lead to a WARNING like following:

[   33.098431] ------------[ cut here ]------------
[   33.098678] WARNING: CPU: 5 PID: 69 at net/netfilter/nf_tables_api.c:2037 nf_tables_chain_destroy+0x23d/0x260
[   33.099217] Modules linked in:
[   33.099388] CPU: 5 PID: 69 Comm: kworker/5:1 Not tainted 6.4.0+ #409
[   33.099726] Workqueue: events nf_tables_trans_destroy_work
[   33.100018] RIP: 0010:nf_tables_chain_destroy+0x23d/0x260
[   33.100306] Code: 8b 7c 24 68 e8 64 9c ed fe 4c 89 e7 e8 5c 9c ed fe 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7 c3 cc cc cc cc <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7
[   33.101271] RSP: 0018:ffffc900004ffc48 EFLAGS: 00010202
[   33.101546] RAX: 0000000000000001 RBX: ffff888006fc0a28 RCX: 0000000000000000
[   33.101920] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.102649] RBP: ffffc900004ffc78 R08: 0000000000000000 R09: 0000000000000000
[   33.103018] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880135ef500
[   33.103385] R13: 0000000000000000 R14: dead000000000122 R15: ffff888006fc0a10
[   33.103762] FS:  0000000000000000(0000) GS:ffff888024c80000(0000) knlGS:0000000000000000
[   33.104184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.104493] CR2: 00007fe863b56a50 CR3: 00000000124b0001 CR4: 0000000000770ee0
[   33.104872] PKRU: 55555554
[   33.104999] Call Trace:
[   33.105113]  <TASK>
[   33.105214]  ? show_regs+0x72/0x90
[   33.105371]  ? __warn+0xa5/0x210
[   33.105520]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.105732]  ? report_bug+0x1f2/0x200
[   33.105902]  ? handle_bug+0x46/0x90
[   33.106546]  ? exc_invalid_op+0x19/0x50
[   33.106762]  ? asm_exc_invalid_op+0x1b/0x20
[   33.106995]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.107249]  ? nf_tables_chain_destroy+0x30/0x260
[   33.107506]  nf_tables_trans_destroy_work+0x669/0x680
[   33.107782]  ? mark_held_locks+0x28/0xa0
[   33.107996]  ? __pfx_nf_tables_trans_destroy_work+0x10/0x10
[   33.108294]  ? _raw_spin_unlock_irq+0x28/0x70
[   33.108538]  process_one_work+0x68c/0xb70
[   33.108755]  ? lock_acquire+0x17f/0x420
[   33.108977]  ? __pfx_process_one_work+0x10/0x10
[   33.109218]  ? do_raw_spin_lock+0x128/0x1d0
[   33.109435]  ? _raw_spin_lock_irq+0x71/0x80
[   33.109634]  worker_thread+0x2bd/0x700
[   33.109817]  ? __pfx_worker_thread+0x10/0x10
[   33.110254]  kthread+0x18b/0x1d0
[   33.110410]  ? __pfx_kthread+0x10/0x10
[   33.110581]  ret_from_fork+0x29/0x50
[   33.110757]  </TASK>
[   33.110866] irq event stamp: 1651
[   33.111017] hardirqs last  enabled at (1659): [<ffffffffa206a209>] __up_console_sem+0x79/0xa0
[   33.111379] hardirqs last disabled at (1666): [<ffffffffa206a1ee>] __up_console_sem+0x5e/0xa0
[   33.111740] softirqs last  enabled at (1616): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112094] softirqs last disabled at (1367): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112453] ---[ end trace 0000000000000000 ]---

This is due to the nft_chain_lookup_byid ignoring the genmask. After this
change, adding the new rule will fail as it will not find the chain.

Fixes: 837830a4b439 ("netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute")
Cc: stable@vger.kernel.org
Reported-by: Mingi Cho of Theori working with ZDI
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2533,7 +2533,7 @@ err:
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2544,7 +2544,8 @@ static struct nft_chain *nft_chain_looku
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3532,7 +3533,8 @@ static int nf_tables_newrule(struct sk_b
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -9931,7 +9933,8 @@ static int nft_verdict_init(const struct
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
 			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
-						      tb[NFTA_VERDICT_CHAIN_ID]);
+						      tb[NFTA_VERDICT_CHAIN_ID],
+						      genmask);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
 		} else {


