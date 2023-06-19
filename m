Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8357354A3
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjFSK6I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFSK5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA1421B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB706068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22109C433C0;
        Mon, 19 Jun 2023 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172139;
        bh=0c7/zlWBZ4NZBcT7D+E8immAqTfgUwzTkxjbnahOlx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuW/mUo8q+9HUBm52MuNnwHBRANoOYtMTLpB3+8x7zkk4H4YB4EhaNm5IUuVurr4b
         yivMMqlQ0y7rsenboQqu2epHt/RmAfAsRaR2Wqc74DB+whjEymHknTahReEXPqf064
         pwnZ2RNBw1Yy7pcsBz4Nlb2Pn96GesSDQOeAow0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Lee Jones <lee@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 50/89] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date:   Mon, 19 Jun 2023 12:30:38 +0200
Message-ID: <20230619102140.556845984@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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
index da042bc8b239d..1ac8ff445a6d3 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -716,12 +716,18 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct nlattr *est, bool ovr,
 			 struct netlink_ext_ack *extack)
 {
-	int err;
+	int err, ifindex = -1;
 
 	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr, true, extack);
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
@@ -756,13 +762,9 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
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



