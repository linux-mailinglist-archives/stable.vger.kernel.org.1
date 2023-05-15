Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFC7033CC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbjEOQlg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbjEOQlf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF840F4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A53B62893
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E824C433D2;
        Mon, 15 May 2023 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168893;
        bh=KdGpZpbIX6f0OquNJ5x7N6DyhgBfakoFzDaoFMxzAdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGsm7MWbyzaPopASC0oe8oxbcKr/mOjbrmcxOt+124kIA/wnwfc2aBSPgASHnholk
         rt6zXSXAdD9rmEz2QSkvREAZhgKTdK+VvUlmWneiQLRlOjXOPKfhpcEX+5OUTtjE4Z
         Z3B8St5v2y3f2zUOmszX0N36frCoz9oj3ZVzzdWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/191] netfilter: nf_tables: dont write table validation state without mutex
Date:   Mon, 15 May 2023 18:25:12 +0200
Message-Id: <20230515161709.993295539@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 9a32e9850686599ed194ccdceb6cd3dd56b2d9b9 ]

The ->cleanup callback needs to be removed, this doesn't work anymore as
the transaction mutex is already released in the ->abort function.

Just do it after a successful validation pass, this either happens
from commit or abort phases where transaction mutex is held.

Fixes: f102d66b335a ("netfilter: nf_tables: use dedicated mutex to guard transactions")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/nfnetlink.h | 1 -
 net/netfilter/nf_tables_api.c       | 8 ++------
 net/netfilter/nfnetlink.c           | 2 --
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index e713476ff29db..a806803fbe37a 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -32,7 +32,6 @@ struct nfnetlink_subsystem {
 	struct module *owner;
 	int (*commit)(struct net *net, struct sk_buff *skb);
 	int (*abort)(struct net *net, struct sk_buff *skb);
-	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 079f768496937..d7a082d5cd70e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6241,6 +6241,8 @@ static int nf_tables_validate(struct net *net)
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
+
+		nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 		break;
 	}
 
@@ -6767,11 +6769,6 @@ static int __nf_tables_abort(struct net *net)
 	return 0;
 }
 
-static void nf_tables_cleanup(struct net *net)
-{
-	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
-}
-
 static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 {
 	int ret = __nf_tables_abort(net);
@@ -6802,7 +6799,6 @@ static const struct nfnetlink_subsystem nf_tables_subsys = {
 	.cb		= nf_tables_cb,
 	.commit		= nf_tables_commit,
 	.abort		= nf_tables_abort,
-	.cleanup	= nf_tables_cleanup,
 	.valid_genid	= nf_tables_valid_genid,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 9bacddc761ba4..39e369e18cb87 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -495,8 +495,6 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	} else {
 		ss->abort(net, oskb);
 	}
-	if (ss->cleanup)
-		ss->cleanup(net);
 
 	nfnl_err_deliver(&err_list, oskb);
 	kfree_skb(skb);
-- 
2.39.2



