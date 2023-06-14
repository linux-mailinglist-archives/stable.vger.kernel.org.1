Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E893472C1FB
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjFLLBw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbjFLLB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BE46AB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD05624CB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E16DC433EF;
        Mon, 12 Jun 2023 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566927;
        bh=LzMkqhlDIrVJK2Kh1K9TEk1LXkIDnQPcN3/Pa2Zgg54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tzz59Qy/OcW49USBY1GTfpvvV/ehvAFcJBkaafxKyf+zcioYFP5cVSnvPc4W48mqe
         FonoN5p5Kcdifg7zHBtOcdeBlilXp8vDMoGrsaPV0YqQRT22B2ku1pBHtG1B6ubIDo
         TPfhOT/LwYGyzK+KLmyj4LrzvDnRk2uVc7xYXxwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 056/160] net: sched: act_police: fix sparse errors in tcf_police_dump()
Date:   Mon, 12 Jun 2023 12:26:28 +0200
Message-ID: <20230612101717.579566178@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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
index 227cba58ce9f3..2e9dce03d1ecc 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -357,23 +357,23 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
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



