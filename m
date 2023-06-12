Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1072BF78
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFLKo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjFLKoE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA840E564
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA777622B1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0892BC433D2;
        Mon, 12 Jun 2023 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565736;
        bh=lR4CLoo5OoBvBxrrLCT340/L35CbBPLJKJcm1d5o/14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7yJpWkgUfoHaSVh1NSV1fQxDU9RMomTUhgixaYlSDnCaN7Eoay1F3rbq4Prd2iFr
         k9hZHeAhBxiHfd5qlb0Vfp6UZpj25j1T9FBwwa0HX56hJAqMGymPcOosdRvbpsJxnp
         Gz1Ff/KNHV3liWTH8IibVE+I/7uOX8tJD3rh8FKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/21] net: sched: move rtm_tca_policy declaration to include file
Date:   Mon, 12 Jun 2023 12:26:03 +0200
Message-ID: <20230612101651.352385750@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
References: <20230612101651.048240731@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 886bc7d6ed3357975c5f1d3c784da96000d4bbb4 ]

rtm_tca_policy is used from net/sched/sch_api.c and net/sched/cls_api.c,
thus should be declared in an include file.

This fixes the following sparse warning:
net/sched/sch_api.c:1434:25: warning: symbol 'rtm_tca_policy' was not declared. Should it be static?

Fixes: e331473fee3d ("net/sched: cls_api: add missing validation of netlink attributes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/pkt_sched.h | 2 ++
 net/sched/cls_api.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index b3869f97d37d7..85e059d3bc233 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -126,6 +126,8 @@ static inline __be16 tc_skb_protocol(const struct sk_buff *skb)
 	return skb->protocol;
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 32819d1e20754..8808133e78a37 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -31,8 +31,6 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
-- 
2.39.2



