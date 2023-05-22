Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C068C70C5D2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjEVTMp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEVTMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D4CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64704622BC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806A9C433D2;
        Mon, 22 May 2023 19:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782762;
        bh=s+RRK57V59oA3R1kFgtT9f/2v2YNuMPZfzRcVo6xZ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDsNko8xqbIgkGdr9B5TKPPkl5M6GXVYi6VhnQMQJ8jTI0pT45As8aMrMGCXUsg8I
         tcfgbSoFOgZgsZWhxkjZUJ+l3KzNQ5eJv5jfakf+imVn7Dzj5OXtuGF4hteMwRkxuX
         d0gYQ1ivRoWqJgaSE37HN/o4lhsH+2LQPZFxh2po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/203] netfilter: conntrack: fix possible bug_on with enable_hooks=1
Date:   Mon, 22 May 2023 20:07:15 +0100
Message-Id: <20230522190355.261958210@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit e72eeab542dbf4f544e389e64fa13b82a1b6d003 ]

I received a bug report (no reproducer so far) where we trip over

712         rcu_read_lock();
713         ct_hook = rcu_dereference(nf_ct_hook);
714         BUG_ON(ct_hook == NULL);  // here

In nf_conntrack_destroy().

First turn this BUG_ON into a WARN.  I think it was triggered
via enable_hooks=1 flag.

When this flag is turned on, the conntrack hooks are registered
before nf_ct_hook pointer gets assigned.
This opens a short window where packets enter the conntrack machinery,
can have skb->_nfct set up and a subsequent kfree_skb might occur
before nf_ct_hook is set.

Call nf_conntrack_init_end() to set nf_ct_hook before we register the
pernet ops.

Fixes: ba3fbe663635 ("netfilter: nf_conntrack: provide modparam to always register conntrack hooks")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/core.c                    | 6 ++++--
 net/netfilter/nf_conntrack_standalone.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index cca0762a90102..8eed6536e7e7b 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -675,9 +675,11 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 
 	rcu_read_lock();
 	ct_hook = rcu_dereference(nf_ct_hook);
-	BUG_ON(ct_hook == NULL);
-	ct_hook->destroy(nfct);
+	if (ct_hook)
+		ct_hook->destroy(nfct);
 	rcu_read_unlock();
+
+	WARN_ON(!ct_hook);
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 338f02a12076b..7515705583bcf 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1229,11 +1229,12 @@ static int __init nf_conntrack_standalone_init(void)
 	nf_conntrack_htable_size_user = nf_conntrack_htable_size;
 #endif
 
+	nf_conntrack_init_end();
+
 	ret = register_pernet_subsys(&nf_conntrack_net_ops);
 	if (ret < 0)
 		goto out_pernet;
 
-	nf_conntrack_init_end();
 	return 0;
 
 out_pernet:
-- 
2.39.2



