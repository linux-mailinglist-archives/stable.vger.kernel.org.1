Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2575569F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGPUwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85C0D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EB860DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B19AC433C8;
        Sun, 16 Jul 2023 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540739;
        bh=3PgARpoWSwEpNQz1h07/Ra0r2oN1jwiPWQOElYi2O1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNzA0dGHZQYICTqYxs8cjyvH4ChGZlKRPRYKOaafU9y59CrKcLBwsUPC7KkwiBq3b
         dUpLd/TdTzoCn6CNofq6QzSKqH47gfPfsaekHWbyf9C4LglOlTVNShOhevu1dXQy/5
         Z0UBFb6ytEPSikB3qOu7zRnZsI7ppFmkdeMjTO4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 471/591] net/sched: act_ipt: add sanity checks on table name and hook locations
Date:   Sun, 16 Jul 2023 21:50:10 +0200
Message-ID: <20230716194936.092319534@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit b4ee93380b3c891fea996af8d1d3ca0e36ad31f0 ]

Looks like "tc" hard-codes "mangle" as the only supported table
name, but on kernel side there are no checks.

This is wrong.  Not all xtables targets are safe to call from tc.
E.g. "nat" targets assume skb has a conntrack object assigned to it.
Normally those get called from netfilter nat core which consults the
nat table to obtain the address mapping.

"tc" userspace either sets PRE or POSTROUTING as hook number, but there
is no validation of this on kernel side, so update netlink policy to
reject bogus numbers.  Some targets may assume skb_dst is set for
input/forward hooks, so prevent those from being used.

act_ipt uses the hook number in two places:
1. the state hook number, this is fine as-is
2. to set par.hook_mask

The latter is a bit mask, so update the assignment to make
xt_check_target() to the right thing.

Followup patch adds required checks for the skb/packet headers before
calling the targets evaluation function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ipt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 1625e10374161..dc92975a9374f 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -47,7 +47,7 @@ static int ipt_init_target(struct net *net, struct xt_entry_target *t,
 	par.entryinfo = &e;
 	par.target    = target;
 	par.targinfo  = t->data;
-	par.hook_mask = hook;
+	par.hook_mask = 1 << hook;
 	par.family    = NFPROTO_IPV4;
 
 	ret = xt_check_target(&par, t->u.target_size - sizeof(*t), 0, false);
@@ -84,7 +84,8 @@ static void tcf_ipt_release(struct tc_action *a)
 
 static const struct nla_policy ipt_policy[TCA_IPT_MAX + 1] = {
 	[TCA_IPT_TABLE]	= { .type = NLA_STRING, .len = IFNAMSIZ },
-	[TCA_IPT_HOOK]	= { .type = NLA_U32 },
+	[TCA_IPT_HOOK]	= NLA_POLICY_RANGE(NLA_U32, NF_INET_PRE_ROUTING,
+					   NF_INET_NUMHOOKS),
 	[TCA_IPT_INDEX]	= { .type = NLA_U32 },
 	[TCA_IPT_TARG]	= { .len = sizeof(struct xt_entry_target) },
 };
@@ -157,15 +158,27 @@ static int __tcf_ipt_init(struct net *net, unsigned int id, struct nlattr *nla,
 			return -EEXIST;
 		}
 	}
+
+	err = -EINVAL;
 	hook = nla_get_u32(tb[TCA_IPT_HOOK]);
+	switch (hook) {
+	case NF_INET_PRE_ROUTING:
+		break;
+	case NF_INET_POST_ROUTING:
+		break;
+	default:
+		goto err1;
+	}
+
+	if (tb[TCA_IPT_TABLE]) {
+		/* mangle only for now */
+		if (nla_strcmp(tb[TCA_IPT_TABLE], "mangle"))
+			goto err1;
+	}
 
-	err = -ENOMEM;
-	tname = kmalloc(IFNAMSIZ, GFP_KERNEL);
+	tname = kstrdup("mangle", GFP_KERNEL);
 	if (unlikely(!tname))
 		goto err1;
-	if (tb[TCA_IPT_TABLE] == NULL ||
-	    nla_strscpy(tname, tb[TCA_IPT_TABLE], IFNAMSIZ) >= IFNAMSIZ)
-		strcpy(tname, "mangle");
 
 	t = kmemdup(td, td->u.target_size, GFP_KERNEL);
 	if (unlikely(!t))
-- 
2.39.2



