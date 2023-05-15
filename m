Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C28703BB7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbjEOSFu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbjEOSFe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B011DB17
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068056308B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8FEC433EF;
        Mon, 15 May 2023 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173795;
        bh=4DM2dKMkIn4b7wyuY4d2AyBJeREPzhW4s2s1OeksAVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpNmTCOtFKf+ImfFDZlurx9R07JoqUyXnllZ1CmX+3jQj+/pPZZ1PGjRxKJ/QYQN+
         NU7mJVtOtSHsD5MvZiHVxVgiN1mAk8pA8KGP5uamm6QclNCb0INWiX3zzbRXlqW1aR
         O2/RAxOV3uqo/z+iT+zi1axz3CRUmebl1SBBHp+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 210/282] netfilter: nf_tables: deactivate anonymous set from preparation phase
Date:   Mon, 15 May 2023 18:29:48 +0200
Message-Id: <20230515161728.538626660@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit c1592a89942e9678f7d9c8030efa777c0d57edab upstream.

Toggle deleted anonymous sets as inactive in the next generation, so
users cannot perform any update on it. Clear the generation bitmask
in case the transaction is aborted.

The following KASAN splat shows a set element deletion for a bound
anonymous set that has been already removed in the same transaction.

[   64.921510] ==================================================================
[   64.923123] BUG: KASAN: wild-memory-access in nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.924745] Write of size 8 at addr dead000000000122 by task test/890
[   64.927903] CPU: 3 PID: 890 Comm: test Not tainted 6.3.0+ #253
[   64.931120] Call Trace:
[   64.932699]  <TASK>
[   64.934292]  dump_stack_lvl+0x33/0x50
[   64.935908]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.937551]  kasan_report+0xda/0x120
[   64.939186]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.940814]  nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.942452]  ? __kasan_slab_alloc+0x2d/0x60
[   64.944070]  ? nf_tables_setelem_notify+0x190/0x190 [nf_tables]
[   64.945710]  ? kasan_set_track+0x21/0x30
[   64.947323]  nfnetlink_rcv_batch+0x709/0xd90 [nfnetlink]
[   64.948898]  ? nfnetlink_rcv_msg+0x480/0x480 [nfnetlink]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    1 +
 net/netfilter/nf_tables_api.c     |   12 ++++++++++++
 net/netfilter/nft_dynset.c        |    2 +-
 net/netfilter/nft_lookup.c        |    2 +-
 net/netfilter/nft_objref.c        |    2 +-
 5 files changed, 16 insertions(+), 3 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -493,6 +493,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3909,12 +3909,24 @@ static void nf_tables_unbind_set(const s
 	}
 }
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -259,7 +259,7 @@ static void nft_dynset_activate(const st
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -129,7 +129,7 @@ static void nft_lookup_activate(const st
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -180,7 +180,7 @@ static void nft_objref_map_activate(cons
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,


