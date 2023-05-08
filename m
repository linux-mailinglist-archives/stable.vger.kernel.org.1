Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80CD6FA5A9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjEHKLu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjEHKLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F073988D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB92623E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4FC433EF;
        Mon,  8 May 2023 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540702;
        bh=PvaZ7+2ShJiQ46b6sWmLiBr49DaxkPQE4Y5D0nPmBN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGzgIKwkpbOFoDiiaVdgLfnu40qUxYIYhUsosLSCNGsKzIAtN+yD9c2YyQiLLxpii
         22+r7XGHOisackRXRIUHs/+F00P3pXgfAX1g0BDuJSoujkZDS2cKi+y3lkGJgYBU7Q
         k8z5TvHjUdWZTGjjMVb31ZMf13iu/9xGV1L60KyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 466/611] perf/core: Fix hardlockup failure caused by perf throttle
Date:   Mon,  8 May 2023 11:45:08 +0200
Message-Id: <20230508094437.277166946@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index 7699b99706ad4..934332b3eb541 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9254,8 +9254,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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



