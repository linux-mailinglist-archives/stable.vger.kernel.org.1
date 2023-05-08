Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0706FA8D6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjEHKpr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEHKpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94826EBD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A803862881
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72239C433EF;
        Mon,  8 May 2023 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542672;
        bh=BB/x7sx8ESRYntH1lKbOq1SVp52HiynEVOxbR7ZeH2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjOLhni3/EcXLIFNCS4dZM5chjcG/V6xKbySWQy49mHhVaTNx5p93UpFUE3hUy07L
         /34zWOIGGtr1Ts9b+nvv3AbKoRBsJKKuwi+RR8JoKyEHp5tWO1O9BO6vpG+pIvZSjA
         V1WPTBfa91XVF39CMChjN1Aiv0ZbPqUHMmYPflQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Libo Chen <libo.chen@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 510/663] sched/fair: Fix inaccurate tally of ttwu_move_affine
Date:   Mon,  8 May 2023 11:45:36 +0200
Message-Id: <20230508094445.244988165@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Libo Chen <libo.chen@oracle.com>

[ Upstream commit 39afe5d6fc59237ff7738bf3ede5a8856822d59d ]

There are scenarios where non-affine wakeups are incorrectly counted as
affine wakeups by schedstats.

When wake_affine_idle() returns prev_cpu which doesn't equal to
nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
in wake_affine() and be counted as if target == this_cpu in schedstats.

Replace target == nr_cpumask_bits with target != this_cpu to make sure
affine wakeups are accurately tallied.

Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20220810223313.386614-1-libo.chen@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 661226e38835d..6f1c7a8fa12ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6487,7 +6487,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	if (target != this_cpu)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
-- 
2.39.2



