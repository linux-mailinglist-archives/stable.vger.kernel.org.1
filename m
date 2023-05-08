Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE066FAE71
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjEHLo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjEHLof (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5F429E3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 120F96206E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F65C433A4;
        Mon,  8 May 2023 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546211;
        bh=BF0II4A0ry5/qNylK3e3ADVEGuTPlHMXERqjd/pfHBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9aiHZXNtjrI1GiMgQA+kg3ujQd0ZzLtUhRFXOWkTGx8gEI7Vy6XsS8kYn3nCeJX/
         k8feGbdgCfoBzqMdOeeqFeQNjMXUPiceMuiIahBvvKuSXbo5tbCZi17e5rgtOgn7iG
         TtkOm9VFlIs7/4vBZKUyT9vTMfH2HRYqtX829k6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 286/371] sched/fair: Use __schedstat_set() in set_next_entity()
Date:   Mon,  8 May 2023 11:48:07 +0200
Message-Id: <20230508094823.366478047@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit a2dcb276ff9287fcea103ca1a2436383e8583751 ]

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20210905143547.4668-2-laoar.shao@gmail.com
Stable-dep-of: 39afe5d6fc59 ("sched/fair: Fix inaccurate tally of ttwu_move_affine")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 591fdc81378e0..70f7a3896a90c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4691,9 +4691,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
-			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
+		__schedstat_set(se->statistics.slice_max,
+				max((u64)se->statistics.slice_max,
+				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
-- 
2.39.2



