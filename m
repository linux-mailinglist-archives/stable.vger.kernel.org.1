Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAD6FAC36
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjEHLWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjEHLWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579536CED
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7606362CA6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C98C433EF;
        Mon,  8 May 2023 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544920;
        bh=KKaTh1zmrCDMN3uNSky8CZv08N6Wd4oA0DIPAXX3DvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVZX/SNrBZrrcYUAtEL2BGZVKFk6+gUbfFOxLcSnPXQWHwGR+nyoWWFqjSnsfbjJp
         BFq+W4lEdwgnT4kil2TC70VWvGaKuT454FJYY60XTOMlY0VKmUgftfQPxkbUMAMCCn
         1LJCFxjbqYwCa5w9Jp/MSVns6prZenSwLxu6xjlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 566/694] perf/core: Fix hardlockup failure caused by perf throttle
Date:   Mon,  8 May 2023 11:46:41 +0200
Message-Id: <20230508094453.138840073@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 435815d3be3f8..68baa8194d9f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9433,8 +9433,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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



