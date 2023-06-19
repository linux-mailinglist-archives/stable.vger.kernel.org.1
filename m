Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81085734C90
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFSHoR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFSHnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D7E74
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFFE614C2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD96C433C8;
        Mon, 19 Jun 2023 07:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687160617;
        bh=TBy+kbNhe/OzXTBGaFwZkf/2C2caArXEvp03JBtjDC8=;
        h=Subject:To:Cc:From:Date:From;
        b=X7YJAr5MDthY+XRUWcjWXTct6x3j94IxHg6vJTvm1/0+pxSqvTUNcWGQG8aaujU+Q
         nkC1pKWY4FaptsdFoTuaFmThFL0rTBR/7KlIB1pgbmNfSJf8Qs0z6HSBNT/jU/b9Gt
         7t6449lte6sCnQ9TI4WrOqQa3lmQZvCPcI2g7sIE=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: incorrect error path handling with" failed to apply to 5.10-stable tree
To:     pablo@netfilter.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 19 Jun 2023 09:43:33 +0200
Message-ID: <2023061933-remover-tweet-3f9b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1240eb93f0616b21c675416516ff3d74798fdc97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061933-remover-tweet-3f9b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1240eb93f0616b21c675416516ff3d74798fdc97 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 8 Jun 2023 02:32:02 +0200
Subject: [PATCH] netfilter: nf_tables: incorrect error path handling with
 NFT_MSG_NEWRULE

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

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3bb0800b3849..69bceefaa5c8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3844,7 +3844,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	if (flow)
 		nft_flow_rule_destroy(flow);
 err_release_rule:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nf_tables_rule_destroy(&ctx, rule);
 err_release_expr:
 	for (i = 0; i < n; i++) {
 		if (expr_info[i].ops) {

