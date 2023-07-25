Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD3761256
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjGYLBT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjGYLBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2244B8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BC061655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F31C433C8;
        Tue, 25 Jul 2023 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282706;
        bh=ya+qC8mljZsiAxKSO0OJZpEHNHHa44PXmdvrGQaBfvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdluV/NjloRHJAJ4uRyNfpd15JXnhsvTdUBUox5/YK6lErJ+uTzKOsb6WI3ZjzYPv
         4O0O2r7mnR1oz2ZxC5RCVo2FIvm+G4goRuND3IxLLRRDFbRcjA1hRxp4+VNWSsWV7a
         RETXFimvBXrVDP/jXuFf5IJku4icOuhuN/yGQQTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 196/227] netfilter: nf_tables: cant schedule in nft_chain_validate
Date:   Tue, 25 Jul 2023 12:46:03 +0200
Message-ID: <20230725104522.928034647@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 314c82841602a111c04a7210c21dc77e0d560242 ]

Can be called via nft set element list iteration, which may acquire
rcu and/or bh read lock (depends on set type).

BUG: sleeping function called from invalid context at net/netfilter/nf_tables_api.c:3353
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1232, name: nft
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by nft/1232:
 #0: ffff8881180e3ea8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid
 #1: ffffffff83f5f540 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire
Call Trace:
 nft_chain_validate
 nft_lookup_validate_setelem
 nft_pipapo_walk
 nft_lookup_validate
 nft_chain_validate
 nft_immediate_validate
 nft_chain_validate
 nf_tables_validate
 nf_tables_abort

No choice but to move it to nf_tables_validate().

Fixes: 81ea01066741 ("netfilter: nf_tables: add rescheduling points during loop detection walks")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 51909bcc181fa..f3a4aa9054876 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3684,8 +3684,6 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (err < 0)
 				return err;
 		}
-
-		cond_resched();
 	}
 
 	return 0;
@@ -3709,6 +3707,8 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
+
+		cond_resched();
 	}
 
 	return 0;
-- 
2.39.2



