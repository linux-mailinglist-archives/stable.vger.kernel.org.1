Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328897612D6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjGYLF4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjGYLFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D72D48
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D45F615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A521C433C8;
        Tue, 25 Jul 2023 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283019;
        bh=Z7sx/LMlKsKlgi0b4nfdQzVv+Hg1vujGoc5aCpjkY1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOQ0nxQu0FUmAxFLC5HHYruXgbwhJH5QCj2MEUwYOrvzIuOiWCU/T6OYJt6fUX4Jf
         vdyOQh9XVxbDh3YPKjPwo4lmo2wqaj6LLTynK/2KJpVlWcMjmb+d/PWgGpY98htoMv
         mqTbcrt5Dn93jtgLNB9j+ihZe0ubec/Z5YRwYZ6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/183] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
Date:   Tue, 25 Jul 2023 12:45:38 +0200
Message-ID: <20230725104511.931236420@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit b3d0e0489430735e2e7626aa37e6462cdd136e9d ]

In case an error occurred after mall_set_parms executed successfully, we
must undo the tcf_bind_filter call it issues.

Fix that by calling tcf_unbind_filter in err_replace_hw_filter label.

Fixes: ec2507d2a306 ("net/sched: cls_matchall: Fix error path")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_matchall.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 39a5d9c170def..43f8df5847414 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -157,26 +157,6 @@ static const struct nla_policy mall_policy[TCA_MATCHALL_MAX + 1] = {
 	[TCA_MATCHALL_FLAGS]		= { .type = NLA_U32 },
 };
 
-static int mall_set_parms(struct net *net, struct tcf_proto *tp,
-			  struct cls_mall_head *head,
-			  unsigned long base, struct nlattr **tb,
-			  struct nlattr *est, u32 flags, u32 fl_flags,
-			  struct netlink_ext_ack *extack)
-{
-	int err;
-
-	err = tcf_exts_validate_ex(net, tp, tb, est, &head->exts, flags,
-				   fl_flags, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_MATCHALL_CLASSID]) {
-		head->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
-		tcf_bind_filter(tp, &head->res, base);
-	}
-	return 0;
-}
-
 static int mall_change(struct net *net, struct sk_buff *in_skb,
 		       struct tcf_proto *tp, unsigned long base,
 		       u32 handle, struct nlattr **tca,
@@ -185,6 +165,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_mall_head *head = rtnl_dereference(tp->root);
 	struct nlattr *tb[TCA_MATCHALL_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_mall_head *new;
 	u32 userflags = 0;
 	int err;
@@ -224,11 +205,17 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 		goto err_alloc_percpu;
 	}
 
-	err = mall_set_parms(net, tp, new, base, tb, tca[TCA_RATE],
-			     flags, new->flags, extack);
-	if (err)
+	err = tcf_exts_validate_ex(net, tp, tb, tca[TCA_RATE],
+				   &new->exts, flags, new->flags, extack);
+	if (err < 0)
 		goto err_set_parms;
 
+	if (tb[TCA_MATCHALL_CLASSID]) {
+		new->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
+		tcf_bind_filter(tp, &new->res, base);
+		bound_to_filter = true;
+	}
+
 	if (!tc_skip_hw(new->flags)) {
 		err = mall_replace_hw_filter(tp, new, (unsigned long)new,
 					     extack);
@@ -244,6 +231,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 err_replace_hw_filter:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &new->res);
 err_set_parms:
 	free_percpu(new->pf);
 err_alloc_percpu:
-- 
2.39.2



