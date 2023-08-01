Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2676AACA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHAIWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHAIWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:22:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AFA0;
        Tue,  1 Aug 2023 01:22:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FDD45C0199;
        Tue,  1 Aug 2023 04:22:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 01 Aug 2023 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690878134; x=1690964534; bh=zL
        gI/uNzK7BjtxKP7opAgWAxcQoVQdR3NkvIMGr2ag4=; b=KkavFvbilurztKhb/P
        GxWPsALUC60a5BVFcbzzBcyTMNRym6j4aVO1i2o3k8eWeRyuhjNrZhEiNbTJsAhI
        qGlspjNbTC6HppGbW3F8hYGMHyDN6QI0g7ZHlqfRvLq0oIQxIUKqt6y31YzoffFR
        RMkl+SAFDUtnerSrKVyctf9CW0LBaTNuFms9OeouLGUXEq/vFkqRDIXlyXVTDljh
        qAtSmX9gt0G1fmwy1BMMsFpQFfmTwvAK3eMji5ji/CcQ1IzVhc8Wc8KITuV39OwV
        Fa9Q6CvUL8OYzzQXP9wj/OpEOruvQDntNkNFjOZXncBc9c/YjgZYMgzHjZi2hCTc
        4Qlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690878134; x=1690964534; bh=zLgI/uNzK7Bjt
        xKP7opAgWAxcQoVQdR3NkvIMGr2ag4=; b=W9XAsHYprgh+0uF2SpgOdRA4DhuA6
        79GkChxs9BM77awMrc+SuP4lGjaGy5vfIILWUGEvfh+hs4NfD6H9yzlx/YB3ud49
        gTIapQbWUEkliaxXKbwv4dvaUSMA95C0Is8L5KlJTV2UnriEd1WBaZm9fNr16OSU
        AMggbG+OZ2WXckIRMILAbBeTEsuyTq6L6sbfMn6H2DEEKKa0Jhm8ujuvDkGV2GKT
        F0s+A1wMH0sbLUWd5phRCFzUP0nTxDpf2XNiwPytz2e9af56eOHR+Kj5DTiI7xBF
        wjwLU96IpaFSjordbNjBCFGVoujXKKdgwCl27TcuOiHDsUp92vuy6VBBA==
X-ME-Sender: <xms:tsDIZKw8eceU2NZ8vqqqufK9l5lS8s8_p3X-c9kG7VZ-pdN_bgElJA>
    <xme:tsDIZGR5pzkKGmILQcPauCaVmqRn5MDunXBzaAMp9Zn8FhTmTVJFef3ucZnQK8NIC
    p_pSkB3Jsg6WA>
X-ME-Received: <xmr:tsDIZMXf7pptWKy-fTeyonnkLRH8O-wCElabDSPuDkgLIgCDSOD12j-O-jnZv1VSjNC4K0-fMCHWWkNv9TwDEHwKnHZZnjR6n3W0uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:tsDIZAixP_kCg-X7zomnJoJGh-jC46C5ayj2Ha_PnQeC1r9-RbFkUA>
    <xmx:tsDIZMBUz7hzlAEoU7KjKsiWYxsC5_Bit_5cswS85lRaWPIrGtDmtA>
    <xmx:tsDIZBIyUhjyI4mqo5Dut9ysqQwArDYV2aZibd-E0fm2AcV55l6kmA>
    <xmx:tsDIZGyyfQWnjaOpuB3valQ_BCMjrUdJOEExAxHKbspfVMHxkVEp1Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 04:22:13 -0400 (EDT)
Date:   Tue, 1 Aug 2023 10:22:11 +0200
From:   Greg KH <greg@kroah.com>
To:     Shaoying Xu <shaoyi@amazon.com>
Cc:     stable@vger.kernel.org, netdev@vger.kernel.org,
        Lion <nnamrec@gmail.com>, Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 4.14,5.4] net/sched: sch_qfq: account for stab overhead
 in qfq_enqueue
Message-ID: <2023080103-zigzagged-morse-2a0f@gregkh>
References: <20230727204149.GA30816@dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204149.GA30816@dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 08:41:49PM +0000, Shaoying Xu wrote:
> [ Upstream commit 3e337087c3b5805fe0b8a46ba622a962880b5d64 ]
> 
> Lion says:
> -------
> In the QFQ scheduler a similar issue to CVE-2023-31436
> persists.
> 
> Consider the following code in net/sched/sch_qfq.c:
> 
> static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                 struct sk_buff **to_free)
> {
>      unsigned int len = qdisc_pkt_len(skb), gso_segs;
> 
>     // ...
> 
>      if (unlikely(cl->agg->lmax < len)) {
>          pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
>               cl->agg->lmax, len, cl->common.classid);
>          err = qfq_change_agg(sch, cl, cl->agg->class_weight, len);
>          if (err) {
>              cl->qstats.drops++;
>              return qdisc_drop(skb, sch, to_free);
>          }
> 
>     // ...
> 
>      }
> 
> Similarly to CVE-2023-31436, "lmax" is increased without any bounds
> checks according to the packet length "len". Usually this would not
> impose a problem because packet sizes are naturally limited.
> 
> This is however not the actual packet length, rather the
> "qdisc_pkt_len(skb)" which might apply size transformations according to
> "struct qdisc_size_table" as created by "qdisc_get_stab()" in
> net/sched/sch_api.c if the TCA_STAB option was set when modifying the qdisc.
> 
> A user may choose virtually any size using such a table.
> 
> As a result the same issue as in CVE-2023-31436 can occur, allowing heap
> out-of-bounds read / writes in the kmalloc-8192 cache.
> -------
> 
> We can create the issue with the following commands:
> 
> tc qdisc add dev $DEV root handle 1: stab mtu 2048 tsize 512 mpu 0 \
> overhead 999999999 linklayer ethernet qfq
> tc class add dev $DEV parent 1: classid 1:1 htb rate 6mbit burst 15k
> tc filter add dev $DEV parent 1: matchall classid 1:1
> ping -I $DEV 1.1.1.2
> 
> This is caused by incorrectly assuming that qdisc_pkt_len() returns a
> length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Reported-by: Lion <nnamrec@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [Backport patch for stable kernels 4.14 and 5.4. Since QFQ_MAX_LMAX is not 
> defined, replace it with 1UL << QFQ_MTU_SHIFT.]
> Cc: <stable@vger.kernel.org> # 4.14, 5.4
> Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
> 
> ---
>  net/sched/sch_qfq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
