Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DCC726C82
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjFGUd6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjFGUdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2B1BD4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 207F764565
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3980AC433A4;
        Wed,  7 Jun 2023 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170027;
        bh=MtLFGGdfVD8voEQjUVBWPh5UYCcmvwrNGZHzw9DVQnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2RZcgVpyA4neygvsbDR8jNtMotzNV5CdRjcF++IAn0WD4htOH9pXg2aaZS4aD7pz
         nWHW+plj0DGTPKn9HSyJhclxUrqBIFPCQypWoL9Vv3pkEmJNzet+zkXr0bblBxH7uq
         QV7qcUgyWtE2uarE/XtqLMsGfSop1fAZnN4FWZdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/88] net/sched: sch_ingress: Only create under TC_H_INGRESS
Date:   Wed,  7 Jun 2023 22:15:35 +0200
Message-ID: <20230607200859.335342878@linuxfoundation.org>
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

[ Upstream commit c7cfbd115001f94de9e4053657946a383147e803 ]

ingress Qdiscs are only supposed to be created under TC_H_INGRESS.
Return -EOPNOTSUPP if 'parent' is not TC_H_INGRESS, similar to
mq_init().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000006cf87705f79acf1a@google.com/
Tested-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_ingress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index ce3f55259d0d1..2abc87a74ce40 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -83,6 +83,9 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 	struct ingress_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 
+	if (sch->parent != TC_H_INGRESS)
+		return -EOPNOTSUPP;
+
 	net_inc_ingress_queue();
 
 	mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
@@ -98,6 +101,9 @@ static void ingress_destroy(struct Qdisc *sch)
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
 
+	if (sch->parent != TC_H_INGRESS)
+		return;
+
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 	net_dec_ingress_queue();
 }
-- 
2.39.2



