Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5821175D43F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGUTT2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjGUTTS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF226359B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F40B61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD5AC433CA;
        Fri, 21 Jul 2023 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967153;
        bh=BfOuTSw8XdqEtJ8WZRztFCoe7C0lQWiq0BmbnpI6K0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS8cU86XTXLMcbiGEsZeqpbTHZwdpNZ+Ao/gCF4pth7CF9KLXGZgI299Sq3dAuxDf
         fZlBKrJRXjo2kR9Dli+Il0B7Wo+ixOkpZ7NtyIPFizZUR/ZOODih0H3mbQp5E66Yct
         9BxrATKeTZmSd5zDsqVZ4C6s0XNh7fDnoSB/7ZhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lion <nnamrec@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/223] net/sched: sch_qfq: account for stab overhead in qfq_enqueue
Date:   Fri, 21 Jul 2023 18:05:16 +0200
Message-ID: <20230721160523.546968061@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pedro Tammela <pctammela@mojatatu.com>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_qfq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2f3629c851584..d5610e145da20 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -381,8 +381,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
 
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > QFQ_MAX_LMAX)
+		return -EINVAL;
+
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
-- 
2.39.2



