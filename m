Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E696775B65
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjHILRH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjHILRH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF3FA;
        Wed,  9 Aug 2023 04:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4919F63164;
        Wed,  9 Aug 2023 11:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51288C433C7;
        Wed,  9 Aug 2023 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579825;
        bh=Xh+qNotRh0Do15wMY7NuH5TWHy+729x+0BEayb2P+z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yl4jb3AOg01/ApveFqf40svagToe4GyOsU5HTc9OL7EkCH9kkLCg0RqxRkuV587L9
         oF/+vYVy96XLvSEC5UnxGae6pEExcZCaUxM6eOnWfvR4SpmxCdIF4qGZPOxA+FEspX
         VYgXnqTFcGLOYACYVc8U00yLY8e12AzjJqb3nQFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 129/323] netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
Date:   Wed,  9 Aug 2023 12:39:27 +0200
Message-ID: <20230809103704.028373891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ 1240eb93f0616b21c675416516ff3d74798fdc97 ]

In case of error when adding a new rule that refers to an anonymous set,
deactivate expressions via NFT_TRANS_PREPARE state, not NFT_TRANS_RELEASE.
Thus, the lookup expression marks anonymous sets as inactive in the next
generation to ensure it is not reachable in this transaction anymore and
decrement the set refcount as introduced by c1592a89942e ("netfilter:
nf_tables: deactivate anonymous set from preparation phase"). The abort
step takes care of undoing the anonymous set.

This is also consistent with rule deletion, where NFT_TRANS_PREPARE is
used. Note that this error path is exercised in the preparation step of
the commit protocol. This patch replaces nf_tables_rule_release() by the
deactivate and destroy calls, this time with NFT_TRANS_PREPARE.

Due to this incorrect error handling, it is possible to access a
dangling pointer to the anonymous set that remains in the transaction
list.

[1009.379054] BUG: KASAN: use-after-free in nft_set_lookup_global+0x147/0x1a0 [nf_tables]
[1009.379106] Read of size 8 at addr ffff88816c4c8020 by task nft-rule-add/137110
[1009.379116] CPU: 7 PID: 137110 Comm: nft-rule-add Not tainted 6.4.0-rc4+ #256
[1009.379128] Call Trace:
[1009.379132]  <TASK>
[1009.379135]  dump_stack_lvl+0x33/0x50
[1009.379146]  ? nft_set_lookup_global+0x147/0x1a0 [nf_tables]
[1009.379191]  print_address_description.constprop.0+0x27/0x300
[1009.379201]  kasan_report+0x107/0x120
[1009.379210]  ? nft_set_lookup_global+0x147/0x1a0 [nf_tables]
[1009.379255]  nft_set_lookup_global+0x147/0x1a0 [nf_tables]
[1009.379302]  nft_lookup_init+0xa5/0x270 [nf_tables]
[1009.379350]  nf_tables_newrule+0x698/0xe50 [nf_tables]
[1009.379397]  ? nf_tables_rule_release+0xe0/0xe0 [nf_tables]
[1009.379441]  ? kasan_unpoison+0x23/0x50
[1009.379450]  nfnetlink_rcv_batch+0x97c/0xd90 [nfnetlink]
[1009.379470]  ? nfnetlink_rcv_msg+0x480/0x480 [nfnetlink]
[1009.379485]  ? __alloc_skb+0xb8/0x1e0
[1009.379493]  ? __alloc_skb+0xb8/0x1e0
[1009.379502]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
[1009.379509]  ? unwind_get_return_address+0x2a/0x40
[1009.379517]  ? write_profile+0xc0/0xc0
[1009.379524]  ? avc_lookup+0x8f/0xc0
[1009.379532]  ? __rcu_read_unlock+0x43/0x60

Fixes: 958bee14d071 ("netfilter: nf_tables: use new transaction infrastructure to handle sets")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2784,7 +2784,8 @@ static int nf_tables_newrule(struct net
 
 	return 0;
 err2:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops) {


