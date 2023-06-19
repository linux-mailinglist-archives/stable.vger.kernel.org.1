Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15B7352BA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjFSKhn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFSKhe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC485CC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6F060B33
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578B0C433C9;
        Mon, 19 Jun 2023 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171052;
        bh=duqtSkOJBN+2h2UdHvkOu+DahB+A4AYXWVQtbb5b6+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rj23K4ItbPEWFdGgaH3RO44VI19wUgMyMXGYEuDEjbFYAzwan+EkPLbz7LfNuDoKz
         5CuKafLpkqDiAK1C6iMvLe3IJ3ppnPA+SC5byE5RPl+oWsxk+NPCCJoX1Ifkl7rMp5
         D6NkHVW2vkOUIM7tboBvWJ/j0LiE2SwRF6tNEce8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Lee Jones <lee@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 131/187] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date:   Mon, 19 Jun 2023 12:29:09 +0200
Message-ID: <20230619102203.944644183@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Lee Jones <lee@kernel.org>

[ Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc ]

In the event of a failure in tcf_change_indev(), u32_set_parms() will
immediately return without decrementing the recently incremented
reference counter.  If this happens enough times, the counter will
rollover and the reference freed, leading to a double free which can be
used to do 'bad things'.

In order to prevent this, move the point of possible failure above the
point where the reference counter is incremented.  Also save any
meaningful return values to be applied to the return data at the
appropriate point in time.

This issue was caught with KASAN.

Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_u32.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 4e2e269f121f8..d15d50de79802 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -718,13 +718,19 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
 			 struct netlink_ext_ack *extack)
 {
-	int err;
+	int err, ifindex = -1;
 
 	err = tcf_exts_validate_ex(net, tp, tb, est, &n->exts, flags,
 				   fl_flags, extack);
 	if (err < 0)
 		return err;
 
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -759,13 +765,9 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		tcf_bind_filter(tp, &n->res, base);
 	}
 
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
+
 	return 0;
 }
 
-- 
2.39.2



