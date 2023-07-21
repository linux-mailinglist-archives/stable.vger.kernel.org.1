Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49275D39F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjGUTMm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGUTMk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D849830E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7624461D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B624C433C8;
        Fri, 21 Jul 2023 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966758;
        bh=P3SYDAzCQaPMnYd9lZIdQHSfLSWc+b2JHQIgrAcHj80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbrAyrnOWZgoiayzMRLT3Rao5/3diI7SHuUCAUTbtJ6j+m6pCmGZ2zP6OKPmWiBdD
         OwXJslX6nUhfzLlSxFBcSowxGhesmR8r0D0NlGrcqSszOKQE869SwMmh5Pqru75pa1
         QoL9xFgrZ5pyN+9Hso5X3qy07/mLzokZ1wPcsa4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 440/532] net/sched: sch_qfq: refactor parsing of netlink parameters
Date:   Fri, 21 Jul 2023 18:05:44 +0200
Message-ID: <20230721160638.427744966@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 25369891fcef373540f8b4e0b3bccf77a04490d5 ]

Two parameters can be transformed into netlink policies and
validated while parsing the netlink message.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 3e337087c3b5 ("net/sched: sch_qfq: account for stab overhead in qfq_enqueue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_qfq.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 4c51aeb78f141..8fb30b20425f8 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -113,6 +113,7 @@
 
 #define QFQ_MTU_SHIFT		16	/* to support TSO/GSO */
 #define QFQ_MIN_LMAX		512	/* see qfq_slot_insert */
+#define QFQ_MAX_LMAX		(1UL << QFQ_MTU_SHIFT)
 
 #define QFQ_MAX_AGG_CLASSES	8 /* max num classes per aggregate allowed */
 
@@ -214,9 +215,14 @@ static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 	return container_of(clc, struct qfq_class, common);
 }
 
+static struct netlink_range_validation lmax_range = {
+	.min = QFQ_MIN_LMAX,
+	.max = QFQ_MAX_LMAX,
+};
+
 static const struct nla_policy qfq_policy[TCA_QFQ_MAX + 1] = {
-	[TCA_QFQ_WEIGHT] = { .type = NLA_U32 },
-	[TCA_QFQ_LMAX] = { .type = NLA_U32 },
+	[TCA_QFQ_WEIGHT] = NLA_POLICY_RANGE(NLA_U32, 1, QFQ_MAX_WEIGHT),
+	[TCA_QFQ_LMAX] = NLA_POLICY_FULL_RANGE(NLA_U32, &lmax_range),
 };
 
 /*
@@ -408,17 +414,13 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_QFQ_MAX, tca[TCA_OPTIONS],
-					  qfq_policy, NULL);
+					  qfq_policy, extack);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_QFQ_WEIGHT]) {
+	if (tb[TCA_QFQ_WEIGHT])
 		weight = nla_get_u32(tb[TCA_QFQ_WEIGHT]);
-		if (!weight || weight > (1UL << QFQ_MAX_WSHIFT)) {
-			pr_notice("qfq: invalid weight %u\n", weight);
-			return -EINVAL;
-		}
-	} else
+	else
 		weight = 1;
 
 	if (tb[TCA_QFQ_LMAX])
@@ -426,11 +428,6 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	else
 		lmax = psched_mtu(qdisc_dev(sch));
 
-	if (lmax < QFQ_MIN_LMAX || lmax > (1UL << QFQ_MTU_SHIFT)) {
-		pr_notice("qfq: invalid max length %u\n", lmax);
-		return -EINVAL;
-	}
-
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
 
-- 
2.39.2



