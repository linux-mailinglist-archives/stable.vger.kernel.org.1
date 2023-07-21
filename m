Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAF75D4C7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGUTYy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGUTYw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4C30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 511E061D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63173C433C8;
        Fri, 21 Jul 2023 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967486;
        bh=ETcLymgxzLQXn26PND6ImJaxZ2zQ1tSbxzdIkZ0y2iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIjtn9DInvHXp5Pw2xmBwNh9/UjZXacNfXceVRosV1hHSW4sSvDBgOXxzfLNbnElv
         9xUcbsZ9hpDchiG3s8P5qXv2ob18SI3526NNTqpRc6kImMUZrhjTq/O65W4uRI8Nf2
         b7wRk6IO9UvDbxgsVs5jVgqHad/+gylnupRoOaVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Lin <eric.lin@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 180/223] perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()
Date:   Fri, 21 Jul 2023 18:07:13 +0200
Message-ID: <20230721160528.554309652@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Lin <eric.lin@sifive.com>

commit 66843b14fb71825fdd73ab12f6594f2243b402be upstream.

Since commit 096b52fd2bb4 ("perf: RISC-V: throttle perf events") the
perf_sample_event_took() function was added to report time spent in
overflow interrupts. If the interrupt takes too long, the perf framework
will lower the sysctl_perf_event_sample_rate and max_samples_per_tick.
When hwc->interrupts is larger than max_samples_per_tick, the
hwc->interrupts will be set to MAX_INTERRUPTS, and events will be
throttled within the __perf_event_account_interrupt() function.

However, the RISC-V PMU driver doesn't call riscv_pmu_stop() to update the
PERF_HES_STOPPED flag after perf_event_overflow() in pmu_sbi_ovf_handler()
function to avoid throttling. When the perf framework unthrottled the event
in the timer interrupt handler, it triggers riscv_pmu_start() function
and causes a WARN_ON_ONCE() warning, as shown below:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c:184 riscv_pmu_start+0x7c/0x8e
 Modules linked in:
 CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d0788e9ef2 #1
 Hardware name: SiFive (DT)
 epc : riscv_pmu_start+0x7c/0x8e
  ra : riscv_pmu_start+0x28/0x8e
 epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ffff8f80004db6f0
  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ffff8f80004db6c0
  t1 : 0000000000000000 t2 : 000000000000001f s0 : ffff8f80004db720
  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 0000000000000000
  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 0000000000000000
  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 0000000000000030
  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ffffaf800424da00
  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 0000000000000000
  s8 : 0000000000000006 s9 : 0000000000000001 s10: ffffaf807efbc340
  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 00000000dbfbb796
  t5 : 0000000700000000 t6 : ffffaf8005269870
 status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
 [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
 [<ffffffff80185b56>] perf_adjust_freq_unthr_context+0x15e/0x174
 [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
 [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
 [<ffffffff800b5640>] update_process_times+0x9a/0xba
 [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
 [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
 [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f4
 [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
 [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
 [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x1d2
 [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/0x36

After referring other PMU drivers like Arm, Loongarch, Csky, and Mips,
they don't call *_pmu_stop() to update with PERF_HES_STOPPED flag
after perf_event_overflow() function nor do they add PERF_HES_STOPPED
flag checking in *_pmu_start() which don't cause this warning.

Thus, it's recommended to remove this unnecessary check in
riscv_pmu_start() function to prevent this warning.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Link: https://lore.kernel.org/r/20230710154328.19574-1-eric.lin@sifive.com
Fixes: 096b52fd2bb4 ("perf: RISC-V: throttle perf events")
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/riscv_pmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..56897d4d4fd3 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -181,9 +181,6 @@ void riscv_pmu_start(struct perf_event *event, int flags)
 	uint64_t max_period = riscv_pmu_ctr_get_width_mask(event);
 	u64 init_val;
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
-		return;
-
 	if (flags & PERF_EF_RELOAD)
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
 
-- 
2.41.0



