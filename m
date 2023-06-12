Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94FF72C083
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjFLKxI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjFLKwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5CA5C5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A555F612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62A5C433EF;
        Mon, 12 Jun 2023 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566239;
        bh=sUZbPLLTwnj6LZtp17YCUD22vsFIHCI+LNG3QDn+RIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/L2EtLbccn5bn6E6AKc0KBCQBv9iFcJC7T23vpsiRgkKb3WfLqeh/GmoicwjPxNq
         51NqHy66YfPAYklpOyCIBXTdb7pqu3XkAjtfqx/YMGRdWNsVxSNiOs2zkvkMS/jp+2
         432z8uRk+4ugd3W6tOY3cwaolbotsGD8jWk/sREE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 40/91] net: sched: act_police: fix sparse errors in tcf_police_dump()
Date:   Mon, 12 Jun 2023 12:26:29 +0200
Message-ID: <20230612101703.744080627@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 682881ee45c81daa883dcd4fe613b0b0d988bb22 ]

Fixes following sparse errors:

net/sched/act_police.c:360:28: warning: dereference of noderef expression
net/sched/act_police.c:362:45: warning: dereference of noderef expression
net/sched/act_police.c:362:45: warning: dereference of noderef expression
net/sched/act_police.c:368:28: warning: dereference of noderef expression
net/sched/act_police.c:370:45: warning: dereference of noderef expression
net/sched/act_police.c:370:45: warning: dereference of noderef expression
net/sched/act_police.c:376:45: warning: dereference of noderef expression
net/sched/act_police.c:376:45: warning: dereference of noderef expression

Fixes: d1967e495a8d ("net_sched: act_police: add 2 new attributes to support police 64bit rate and peakrate")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_police.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index d44b933b821d7..db1d021c16be8 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -366,23 +366,23 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	opt.burst = PSCHED_NS2TICKS(p->tcfp_burst);
 	if (p->rate_present) {
 		psched_ratecfg_getrate(&opt.rate, &p->rate);
-		if ((police->params->rate.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->rate.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_RATE64,
-				      police->params->rate.rate_bytes_ps,
+				      p->rate.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->peak_present) {
 		psched_ratecfg_getrate(&opt.peakrate, &p->peak);
-		if ((police->params->peak.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->peak.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_PEAKRATE64,
-				      police->params->peak.rate_bytes_ps,
+				      p->peak.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->pps_present) {
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTRATE64,
-				      police->params->ppsrate.rate_pkts_ps,
+				      p->ppsrate.rate_pkts_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTBURST64,
-- 
2.39.2



