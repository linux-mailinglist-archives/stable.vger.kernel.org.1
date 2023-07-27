Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56F765D85
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjG0Ul7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Ul6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 16:41:58 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937B2D45;
        Thu, 27 Jul 2023 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690490518; x=1722026518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WLNg3ybLSGLXd9RmQLt1k/NytHNJA5YP1EVjXUFQdvo=;
  b=eFz6oiDF68ekHW/M7mEscNlkg1HBW176W9Xs42HZXkoksH5Wlk+nvgte
   JPhz9irxT79QQSCac8rSCoxzz9L5gAR1+cOKHXMkfnrAXEgbREJhwMNSp
   B7RYtk53FED2KSu8rICT3GF9OrBHfdXjjqnQ1CgeL10NgC7Mnro0G+DZ+
   w=;
X-IronPort-AV: E=Sophos;i="6.01,235,1684800000"; 
   d="scan'208";a="342172117"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 20:41:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 2863640DC3;
        Thu, 27 Jul 2023 20:41:55 +0000 (UTC)
Received: from EX19D046UWB002.ant.amazon.com (10.13.139.181) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 20:41:50 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D046UWB002.ant.amazon.com (10.13.139.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 20:41:49 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 27 Jul 2023 20:41:49 +0000
Received: by dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (Postfix, from userid 13116433)
        id 512B722508; Thu, 27 Jul 2023 20:41:49 +0000 (UTC)
Date:   Thu, 27 Jul 2023 20:41:49 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Shaoying Xu <shaoyi@amazon.com>,
        Lion <nnamrec@gmail.com>, Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 4.14,5.4] net/sched: sch_qfq: account for stab overhead in
 qfq_enqueue
Message-ID: <20230727204149.GA30816@dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 3e337087c3b5805fe0b8a46ba622a962880b5d64 ]

Lion says:
-------
In the QFQ scheduler a similar issue to CVE-2023-31436
persists.

Consider the following code in net/sched/sch_qfq.c:

static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                struct sk_buff **to_free)
{
     unsigned int len = qdisc_pkt_len(skb), gso_segs;

    // ...

     if (unlikely(cl->agg->lmax < len)) {
         pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
              cl->agg->lmax, len, cl->common.classid);
         err = qfq_change_agg(sch, cl, cl->agg->class_weight, len);
         if (err) {
             cl->qstats.drops++;
             return qdisc_drop(skb, sch, to_free);
         }

    // ...

     }

Similarly to CVE-2023-31436, "lmax" is increased without any bounds
checks according to the packet length "len". Usually this would not
impose a problem because packet sizes are naturally limited.

This is however not the actual packet length, rather the
"qdisc_pkt_len(skb)" which might apply size transformations according to
"struct qdisc_size_table" as created by "qdisc_get_stab()" in
net/sched/sch_api.c if the TCA_STAB option was set when modifying the qdisc.

A user may choose virtually any size using such a table.

As a result the same issue as in CVE-2023-31436 can occur, allowing heap
out-of-bounds read / writes in the kmalloc-8192 cache.
-------

We can create the issue with the following commands:

tc qdisc add dev $DEV root handle 1: stab mtu 2048 tsize 512 mpu 0 \
overhead 999999999 linklayer ethernet qfq
tc class add dev $DEV parent 1: classid 1:1 htb rate 6mbit burst 15k
tc filter add dev $DEV parent 1: matchall classid 1:1
ping -I $DEV 1.1.1.2

This is caused by incorrectly assuming that qdisc_pkt_len() returns a
length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: Lion <nnamrec@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Backport patch for stable kernels 4.14 and 5.4. Since QFQ_MAX_LMAX is not 
defined, replace it with 1UL << QFQ_MTU_SHIFT.]
Cc: <stable@vger.kernel.org> # 4.14, 5.4
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>

---
 net/sched/sch_qfq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 603bd3097bd8..34a54dcd95f2 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -375,8 +375,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
 
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > (1UL << QFQ_MTU_SHIFT))
+		return -EINVAL;
+
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
-- 
2.40.1

