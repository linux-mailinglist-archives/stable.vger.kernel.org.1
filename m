Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD467034DC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbjEOQxW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbjEOQxD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2276598
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A7A629AB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03034C433D2;
        Mon, 15 May 2023 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169559;
        bh=b+Zqpf+UemNrQVrTk6iN1UmXfl7Vo8U1lgbApfJx9qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrcE/a8oUq7g3hBq3VKAEHwzE4cYmmh61UcI5l3S1mxO76JoYx6LfzxDAtxm+sj5i
         iVopFLf4RLThVmhPWfNFyrkWgs2qMB7bdL3Fuh3X5X/VYcl/qQV/1QbodcRnXBfdyM
         TWRqOfh/bDa7BRQ85BWh9PFapMra1ypQNPJQ2/SQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 097/246] net/sched: flower: fix error handler on replace
Date:   Mon, 15 May 2023 18:25:09 +0200
Message-Id: <20230515161725.497084932@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit fd741f0d9f702c193b2b44225c004f8c5d5be163 ]

When replacing a filter (i.e. 'fold' pointer is not NULL) the insertion of
new filter to idr is postponed until later in code since handle is already
provided by the user. However, the error handling code in fl_change()
always assumes that the new filter had been inserted into idr. If error
handler is reached when replacing existing filter it may remove it from idr
therefore making it unreachable for delete or dump afterwards. Fix the
issue by verifying that 'fold' argument wasn't provided by caller before
calling idr_remove().

Fixes: 08a0063df3ae ("net/sched: flower: Move filter handle initialization earlier")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index d62947eef9727..72edaa6277ce1 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2339,7 +2339,8 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 errout_mask:
 	fl_mask_put(head, fnew->mask);
 errout_idr:
-	idr_remove(&head->handle_idr, fnew->handle);
+	if (!fold)
+		idr_remove(&head->handle_idr, fnew->handle);
 	__fl_put(fnew);
 errout_tb:
 	kfree(tb);
-- 
2.39.2



