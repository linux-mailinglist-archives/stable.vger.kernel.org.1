Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED7726C86
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjFGUeL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjFGUeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13C1BD4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B81E6454A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23076C433EF;
        Wed,  7 Jun 2023 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170035;
        bh=owOQLC3vysDMNq0Z0TmQmBUfaroyWlW8a5SPKvKZTPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8rl+mzqwRf5jlA90a0A7j+VaKpCEnDS/vP+V6Se5jIWZ2FRjOiMbRBSNJEgv6Jil
         hK0qwVe3kT/faAfHN29e6t6TGAQ+hcmwFUVEoTHGC/YZ/8jsvSMzXvtDdmlmK8dmfX
         LeB61HTEGtg+8tqaYJSAfcypPxNggFZS/Io25/NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/88] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
Date:   Wed,  7 Jun 2023 22:15:37 +0200
Message-ID: <20230607200859.572925090@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peilin Ye <peilin.ye@bytedance.com>

[ Upstream commit f85fa45d4a9408d98c46c8fa45ba2e3b2f4bf219 ]

Currently it is possible to add e.g. an HTB Qdisc under ffff:fff1
(TC_H_INGRESS, TC_H_CLSACT):

  $ ip link add name ifb0 type ifb
  $ tc qdisc add dev ifb0 parent ffff:fff1 htb
  $ tc qdisc add dev ifb0 clsact
  Error: Exclusivity flag on, cannot modify.
  $ drgn
  ...
  >>> ifb0 = netdev_get_by_name(prog, "ifb0")
  >>> qdisc = ifb0.ingress_queue.qdisc_sleeping
  >>> print(qdisc.ops.id.string_().decode())
  htb
  >>> qdisc.flags.value_() # TCQ_F_INGRESS
  2

Only allow ingress and clsact Qdiscs under ffff:fff1.  Return -EINVAL
for everything else.  Make TCQ_F_INGRESS a static flag of ingress and
clsact Qdiscs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
Tested-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c     | 7 ++++++-
 net/sched/sch_ingress.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 41c67cfd264fb..d6b4710aa69d3 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1148,7 +1148,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	sch->parent = parent;
 
 	if (handle == TC_H_INGRESS) {
-		sch->flags |= TCQ_F_INGRESS;
+		if (!(sch->flags & TCQ_F_INGRESS)) {
+			NL_SET_ERR_MSG(extack,
+				       "Specified parent ID is reserved for ingress and clsact Qdiscs");
+			err = -EINVAL;
+			goto err_out3;
+		}
 		handle = TC_H_MAKE(TC_H_INGRESS, 0);
 		lockdep_set_class(qdisc_lock(sch), &qdisc_rx_lock);
 	} else {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index e120dadc259a9..834960cc755e2 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -136,7 +136,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.cl_ops			=	&ingress_class_ops,
 	.id			=	"ingress",
 	.priv_size		=	sizeof(struct ingress_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	ingress_init,
 	.destroy		=	ingress_destroy,
 	.dump			=	ingress_dump,
@@ -274,7 +274,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
 	.cl_ops			=	&clsact_class_ops,
 	.id			=	"clsact",
 	.priv_size		=	sizeof(struct clsact_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	clsact_init,
 	.destroy		=	clsact_destroy,
 	.dump			=	ingress_dump,
-- 
2.39.2



