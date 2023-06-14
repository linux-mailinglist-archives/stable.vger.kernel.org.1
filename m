Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1301726EFB
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjFGUyc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjFGUyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EF2132
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A709C647C2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4DEC4339B;
        Wed,  7 Jun 2023 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171254;
        bh=/rBeYQlibcqn5fzQSak2topt9pj/KiQJNTyVZ/Oqy+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZB/Si9dEfoHTUsu9l1qP2oZP8IfEkI1y5IIJnSpD7G/b8HeZblEZCRyDzGdNasS6
         CO2OgQBDUxH1ho7vNBOreXzUuPDdQ+SZhZmncPUQmEGixxxuHjCummLkqkr6UNUbFJ
         arOFu9a2uHntAnln9jKqiyyRRZgoCw8RuCEGGP2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 18/99] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
Date:   Wed,  7 Jun 2023 22:16:10 +0200
Message-ID: <20230607200900.826926556@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 67d6bc97e5fe9..cd6af51bd9ff2 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1214,7 +1214,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
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
 	} else {
 		if (handle == 0) {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 9f1ed810b7b89..28168799ca1b8 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -133,7 +133,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.cl_ops			=	&ingress_class_ops,
 	.id			=	"ingress",
 	.priv_size		=	sizeof(struct ingress_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	ingress_init,
 	.destroy		=	ingress_destroy,
 	.dump			=	ingress_dump,
@@ -272,7 +272,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
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



