Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9D6FAC3F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjEHLW1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjEHLWX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA0391AA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAAC62CA6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E266C433EF;
        Mon,  8 May 2023 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544934;
        bh=QHiXMgLzhHOMmXf0BcYXLN65yHpQUQ3MLv1U70y5V98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1TId0DHYn/v6Eu7IvzqCxbNi06/qowb16XJm+RXyZQAVENthRMXEVY+Nhide3MQz
         gKBDt79r8O+NuXwYpOmBoAp0E5+MQZ5jlNybUALl4liMM4W6gxgbEnRaItIWx3dTGM
         7Lut5lWFiKmr1zMY1uAkUHD3kIfkkTkR3HKrE3sA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Thompson <dev@aaront.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 570/694] sched/clock: Fix local_clock() before sched_clock_init()
Date:   Mon,  8 May 2023 11:46:45 +0200
Message-Id: <20230508094453.326201626@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Aaron Thompson <dev@aaront.org>

[ Upstream commit f31dcb152a3d0816e2f1deab4e64572336da197d ]

Have local_clock() return sched_clock() if sched_clock_init() has not
yet run. sched_clock_cpu() has this check but it was not included in the
new noinstr implementation of local_clock().

The effect can be seen on x86 with CONFIG_PRINTK_TIME enabled, for
instance. scd->clock quickly reaches the value of TICK_NSEC and that
value is returned until sched_clock_init() runs.

dmesg without this patch:

    [    0.000000] kvm-clock: ...
    [    0.000002] kvm-clock: ...
    [    0.000672] clocksource: ...
    [    0.001000] tsc: ...
    [    0.001000] e820: ...
    [    0.001000] e820: ...
     ...
    [    0.001000] ..TIMER: ...
    [    0.001000] clocksource: ...
    [    0.378956] Calibrating delay loop ...
    [    0.379955] pid_max: ...

dmesg with this patch:

    [    0.000000] kvm-clock: ...
    [    0.000001] kvm-clock: ...
    [    0.000675] clocksource: ...
    [    0.002685] tsc: ...
    [    0.003331] e820: ...
    [    0.004190] e820: ...
     ...
    [    0.421939] ..TIMER: ...
    [    0.422842] clocksource: ...
    [    0.424582] Calibrating delay loop ...
    [    0.425580] pid_max: ...

Fixes: 776f22913b8e ("sched/clock: Make local_clock() noinstr")
Signed-off-by: Aaron Thompson <dev@aaront.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230413175012.2201-1-dev@aaront.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 5732fa75ebab2..b5cc2b53464de 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -300,6 +300,9 @@ noinstr u64 local_clock(void)
 	if (static_branch_likely(&__sched_clock_stable))
 		return sched_clock() + __sched_clock_offset;
 
+	if (!static_branch_likely(&sched_clock_running))
+		return sched_clock();
+
 	preempt_disable_notrace();
 	clock = sched_clock_local(this_scd());
 	preempt_enable_notrace();
-- 
2.39.2



