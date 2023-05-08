Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA56FABCA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjEHLR1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjEHLRZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E1437633
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C850862C19
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B868FC433EF;
        Mon,  8 May 2023 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544643;
        bh=emNMdWt3FAv3Z0+lFpCvz7Ly2tt9NTbxZP+6Hybqlfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyk6+YQCWUIjKR3meg73yD3TRQI0bUvHFvBFcWzFC2rq+oTAfFxBQpsDkYvxRD5JK
         4OTvNq1uW97nBpAlQp4/CiKqB3sD1aFYk/6YYJ8jI6gAkjti1r0ROfHdN9WluI7FoL
         74peSDB2ID7R7C3yYinJgT4XvWubO0Y0dDcNN6cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
        Eric Dumazet <edumazet@google.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 475/694] net/sched: sch_fq: fix integer overflow of "credit"
Date:   Mon,  8 May 2023 11:45:10 +0200
Message-Id: <20230508094449.240869503@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 7041101ff6c3073fd8f2e99920f535b111c929cb ]

if sch_fq is configured with "initial quantum" having values greater than
INT_MAX, the first assignment of "credit" does signed integer overflow to
a very negative value.
In this situation, the syzkaller script provided by Cristoph triggers the
CPU soft-lockup warning even with few sockets. It's not an infinite loop,
but "credit" wasn't probably meant to be minus 2Gb for each new flow.
Capping "initial quantum" to INT_MAX proved to fix the issue.

v2: validation of "initial quantum" is done in fq_policy, instead of open
    coding in fq_change() _ suggested by Jakub Kicinski

Reported-by: Christoph Paasch <cpaasch@apple.com>
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/377
Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/r/7b3a3c7e36d03068707a021760a194a8eb5ad41a.1682002300.git.dcaratti@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_fq.c                            |  6 ++++-
 .../tc-testing/tc-tests/qdiscs/fq.json        | 22 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 48d14fb90ba02..f59a2cb2c803d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -779,13 +779,17 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 	return 0;
 }
 
+static struct netlink_range_validation iq_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 	[TCA_FQ_UNSPEC]			= { .strict_start_type = TCA_FQ_TIMER_SLACK },
 
 	[TCA_FQ_PLIMIT]			= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_PLIMIT]		= { .type = NLA_U32 },
 	[TCA_FQ_QUANTUM]		= { .type = NLA_U32 },
-	[TCA_FQ_INITIAL_QUANTUM]	= { .type = NLA_U32 },
+	[TCA_FQ_INITIAL_QUANTUM]	= NLA_POLICY_FULL_RANGE(NLA_U32, &iq_range),
 	[TCA_FQ_RATE_ENABLE]		= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_DEFAULT_RATE]	= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_MAX_RATE]		= { .type = NLA_U32 },
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
index 8acb904d14193..3593fb8f79ad3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
@@ -114,6 +114,28 @@
             "$IP link del dev $DUMMY type dummy"
         ]
     },
+    {
+        "id": "10f7",
+        "name": "Create FQ with invalid initial_quantum setting",
+        "category": [
+            "qdisc",
+            "fq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq initial_quantum 0x80000000",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc fq 1: root.*initial_quantum 2048Mb",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
     {
         "id": "9398",
         "name": "Create FQ with maxrate setting",
-- 
2.39.2



