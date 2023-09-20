Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48EF7A816A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjITMp1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjITMpJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C263AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:45:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBC9C433C8;
        Wed, 20 Sep 2023 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213902;
        bh=ngc4/IW7f1CzoVfSyGHF/uKjL8yhenLUsEdt2qJHo8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyoICODXSU1hEclfXHRKm/UK0pWmTzssBCp8CtCxfcK1bNr5MJBasGZj7mJZJN/e+
         8jfxnRvhaxHOk8y7+FIAYNfnXKafSkW8UZzGxPcTaWCmCgrMp3hl1sZp+MilinrwN4
         Tp7vk4R+laFFjNXXYEV2QmMyTWEaG3OqdTeWGkxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 040/110] ARM: 9317/1: kexec: Make smp stop calls asynchronous
Date:   Wed, 20 Sep 2023 13:31:38 +0200
Message-ID: <20230920112831.868784162@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mårten Lindahl <marten.lindahl@axis.com>

[ Upstream commit 8922ba71c969d2a0c01a94372a71477d879470de ]

If a panic is triggered by a hrtimer interrupt all online cpus will be
notified and set offline. But as highlighted by commit 19dbdcb8039c
("smp: Warn on function calls from softirq context") this call should
not be made synchronous with disabled interrupts:

 softdog: Initiating panic
 Kernel panic - not syncing: Software Watchdog Timer expired
 WARNING: CPU: 1 PID: 0 at kernel/smp.c:753 smp_call_function_many_cond
   unwind_backtrace:
     show_stack
     dump_stack_lvl
     __warn
     warn_slowpath_fmt
     smp_call_function_many_cond
     smp_call_function
     crash_smp_send_stop.part.0
     machine_crash_shutdown
     __crash_kexec
     panic
     softdog_fire
     __hrtimer_run_queues
     hrtimer_interrupt

Make the smp call for machine_crash_nonpanic_core() asynchronous.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/machine_kexec.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0b..6d1938d1b4df7 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -92,16 +92,28 @@ void machine_crash_nonpanic_core(void *unused)
 	}
 }
 
+static DEFINE_PER_CPU(call_single_data_t, cpu_stop_csd) =
+	CSD_INIT(machine_crash_nonpanic_core, NULL);
+
 void crash_smp_send_stop(void)
 {
 	static int cpus_stopped;
 	unsigned long msecs;
+	call_single_data_t *csd;
+	int cpu, this_cpu = raw_smp_processor_id();
 
 	if (cpus_stopped)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(cpu_stop_csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
-- 
2.40.1



