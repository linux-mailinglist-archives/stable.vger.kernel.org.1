Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF604726ED3
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjFGUxC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjFGUw7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F495
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 003AD64789
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5BBC433EF;
        Wed,  7 Jun 2023 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171177;
        bh=OU+0mv7D2jKk9/s8niPALQ66rLq37MwXZtGBcv1XxHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQrx5GmAzntirKoyXi1EYJlF0ujMt44QHfMvNzqrli6/roR2kxzMT3hd7Em5iNiBJ
         jBN0krLh5vGFAT2WI4yZL0mCKHMN4+gNlpCdXD4Ufu029IuwdRL8sgN3eVvYlg1Czu
         s33cfjq1Y5frnzUwQ2CrUNdXL+3/NJM4HTFrtkco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/99] net/sched: Prohibit regrafting ingress or clsact Qdiscs
Date:   Wed,  7 Jun 2023 22:16:11 +0200
Message-ID: <20230607200900.857801715@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

[ Upstream commit 9de95df5d15baa956c2b70b9e794842e790a8a13 ]

Currently, after creating an ingress (or clsact) Qdisc and grafting it
under TC_H_INGRESS (TC_H_CLSACT), it is possible to graft it again under
e.g. a TBF Qdisc:

  $ ip link add ifb0 type ifb
  $ tc qdisc add dev ifb0 handle 1: root tbf rate 20kbit buffer 1600 limit 3000
  $ tc qdisc add dev ifb0 clsact
  $ tc qdisc link dev ifb0 handle ffff: parent 1:1
  $ tc qdisc show dev ifb0
  qdisc tbf 1: root refcnt 2 rate 20Kbit burst 1600b lat 560.0ms
  qdisc clsact ffff: parent ffff:fff1 refcnt 2
                                      ^^^^^^^^

clsact's refcount has increased: it is now grafted under both
TC_H_CLSACT and 1:1.

ingress and clsact Qdiscs should only be used under TC_H_INGRESS
(TC_H_CLSACT).  Prohibit regrafting them.

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
 net/sched/sch_api.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cd6af51bd9ff2..84d371d30d444 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1579,6 +1579,11 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Invalid qdisc name");
 					return -EINVAL;
 				}
+				if (q->flags & TCQ_F_INGRESS) {
+					NL_SET_ERR_MSG(extack,
+						       "Cannot regraft ingress or clsact Qdiscs");
+					return -EINVAL;
+				}
 				if (q == p ||
 				    (p && check_loop(q, p, 0))) {
 					NL_SET_ERR_MSG(extack, "Qdisc parent/child loop detected");
-- 
2.39.2



