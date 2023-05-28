Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE490713F6E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjE1TpW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjE1TpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758E9B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92EB61F37
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A41C433D2;
        Sun, 28 May 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303119;
        bh=LSj1NRi+OAB7QMA0noVR+cMyJZmhzmi9psbIKWPkXFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJLzKDHRcyc5GjSvKSDJaTr9caLj4dcumcCNzxiaZvj0Zs5BAacBsAas5xR9UuzmJ
         AXoAiwzDrW3Nsv5eVF9fgDW/5WD5lUb87e/xORwUwvBV9e7GJ7cIV7HL1ho5e/a00H
         LVBYOx0fSJSckuFq2VH99Zs0HKPTqMp9P7njCWdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, wenxu <wenxu@ucloud.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: [PATCH 5.10 162/211] net/sched: act_mirred: refactor the handle of xmit
Date:   Sun, 28 May 2023 20:11:23 +0100
Message-Id: <20230528190847.526060623@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

[ Upstream commit fa6d639930ee5cd3f932cc314f3407f07a06582d ]

This one is prepare for the next patch.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[DP: adjusted context for linux-5.10.y]
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sch_generic.h |    5 -----
 net/sched/act_mirred.c    |   21 +++++++++++++++------
 2 files changed, 15 insertions(+), 11 deletions(-)

--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1320,11 +1320,6 @@ void mini_qdisc_pair_init(struct mini_Qd
 void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
 				struct tcf_block *block);
 
-static inline int skb_tc_reinsert(struct sk_buff *skb, struct tcf_result *res)
-{
-	return res->ingress ? netif_receive_skb(skb) : dev_queue_xmit(skb);
-}
-
 /* Make sure qdisc is no longer in SCHED state. */
 static inline void qdisc_synchronize(const struct Qdisc *q)
 {
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -206,6 +206,18 @@ release_idr:
 	return err;
 }
 
+static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+{
+	int err;
+
+	if (!want_ingress)
+		err = dev_queue_xmit(skb);
+	else
+		err = netif_receive_skb(skb);
+
+	return err;
+}
+
 static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 			  struct tcf_result *res)
 {
@@ -295,18 +307,15 @@ static int tcf_mirred_act(struct sk_buff
 		/* let's the caller reinsert the packet, if possible */
 		if (use_reinsert) {
 			res->ingress = want_ingress;
-			if (skb_tc_reinsert(skb, res))
+			err = tcf_mirred_forward(res->ingress, skb);
+			if (err)
 				tcf_action_inc_overlimit_qstats(&m->common);
 			__this_cpu_dec(mirred_rec_level);
 			return TC_ACT_CONSUMED;
 		}
 	}
 
-	if (!want_ingress)
-		err = dev_queue_xmit(skb2);
-	else
-		err = netif_receive_skb(skb2);
-
+	err = tcf_mirred_forward(want_ingress, skb2);
 	if (err) {
 out:
 		tcf_action_inc_overlimit_qstats(&m->common);


