Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD607039E7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbjEORqn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbjEORqW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED316EA6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED4B62EA5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C5C433EF;
        Mon, 15 May 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172685;
        bh=XzJ+DE1pKchvye9Q+bugsdyvn2RHAXqGcfyPvhS3E0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4qvkLS4DjfxRA0ZLZr1MJYLxUSVEcxgwFkcnIdYi6HvEZ6lXMe52oxxRMoTOvoCn
         KwsB/LGoqs3iPNHd569Z5k8HduRFMXoArWvk4BUgun38gl65GdAndnujjq3w9Oqsdy
         btoKHYIfVZ5/Ww58GzGM4HtutAT6Ma9pIE4CQofM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 234/381] perf/core: Fix hardlockup failure caused by perf throttle
Date:   Mon, 15 May 2023 18:28:05 +0200
Message-Id: <20230515161747.278006756@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 15def34e2635ab7e0e96f1bc32e1b69609f14942 ]

commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
introduces a change in throttling threshold judgment. Before this,
compare hwc->interrupts and max_samples_per_tick, then increase
hwc->interrupts by 1, but this commit reverses order of these two
behaviors, causing the semantics of max_samples_per_tick to change.
In literal sense of "max_samples_per_tick", if hwc->interrupts ==
max_samples_per_tick, it should not be throttled, therefore, the judgment
condition should be changed to "hwc->interrupts > max_samples_per_tick".

In fact, this may cause the hardlockup to fail, The minimum value of
max_samples_per_tick may be 1, in this case, the return value of
__perf_event_account_interrupt function is 1.
As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
architecture as an example, see x86_pmu_handle_irq).

Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230227023508.102230-1-yangjihong1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0df3bc0e6415..53f36bbaf0c66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8925,8 +8925,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
+		if (unlikely(throttle &&
+			     hwc->interrupts > max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
-- 
2.39.2



