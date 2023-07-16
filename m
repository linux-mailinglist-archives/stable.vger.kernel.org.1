Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152907551E8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGPUBg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGPUBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF9F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD3660EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E21C433C9;
        Sun, 16 Jul 2023 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537692;
        bh=F/TQIVCVl8w6w2WERB43IQbSXfyLUNd846AMwbg1K/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6QiOoJHTWl/+cKtOE/3ST2+TTMTokmjr5bW114DTGQvLM14FXN8rFfEPAGcH7jb/
         yV5Ygijiq+B7yoEwrR19h/h0UbtSXlzYvOqhTN29IVREfQyQBIpXFyQ1oAOKqtodLM
         gk/r8evZLJllno36hqPbGC4LlT/A/RVzFX1v/jiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Colin Cross <ccross@android.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <groeck@chromium.org>,
        Ian Rogers <irogers@google.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 187/800] watchdog/perf: adapt the watchdog_perf interface for async model
Date:   Sun, 16 Jul 2023 21:40:40 +0200
Message-ID: <20230716194953.448689609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

[ Upstream commit 930d8f8dbab97cb05dba30e67a2dfa0c6dbf4bc7 ]

When lockup_detector_init()->watchdog_hardlockup_probe(), PMU may be not
ready yet.  E.g.  on arm64, PMU is not ready until
device_initcall(armv8_pmu_driver_init).  And it is deeply integrated with
the driver model and cpuhp.  Hence it is hard to push this initialization
before smp_init().

But it is easy to take an opposite approach and try to initialize the
watchdog once again later.  The delayed probe is called using workqueues.
It need to allocate memory and must be proceed in a normal context.  The
delayed probe is able to use if watchdog_hardlockup_probe() returns
non-zero which means the return code returned when PMU is not ready yet.

Provide an API - lockup_detector_retry_init() for anyone who needs to
delayed init lockup detector if they had ever failed at
lockup_detector_init().

The original assumption is: nobody should use delayed probe after
lockup_detector_check() which has __init attribute.  That is, anyone uses
this API must call between lockup_detector_init() and
lockup_detector_check(), and the caller must have __init attribute

Link: https://lkml.kernel.org/r/20230519101840.v5.16.If4ad5dd5d09fb1309cebf8bcead4b6a5a7758ca7@changeid
Reviewed-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Suggested-by: Petr Mladek <pmladek@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Colin Cross <ccross@android.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tzung-Bi Shih <tzungbi@chromium.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9ec272c586b0 ("watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 600a61c65a9a9..c4f58baf7ccb2 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 void lockup_detector_init(void);
+void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
 
@@ -32,6 +33,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
+static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 06ea59c05ee94..f2e991894af62 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -175,7 +175,13 @@ void __weak watchdog_hardlockup_disable(unsigned int cpu)
 	hardlockup_detector_perf_disable();
 }
 
-/* Return 0, if a hardlockup watchdog is available. Error code otherwise */
+/*
+ * Watchdog-detector specific API.
+ *
+ * Return 0 when hardlockup watchdog is available, negative value otherwise.
+ * Note that the negative value means that a delayed probe might
+ * succeed later.
+ */
 int __weak __init watchdog_hardlockup_probe(void)
 {
 	return hardlockup_detector_perf_init();
@@ -904,6 +910,62 @@ static void __init watchdog_sysctl_init(void)
 #define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static void __init lockup_detector_delay_init(struct work_struct *work);
+static bool allow_lockup_detector_init_retry __initdata;
+
+static struct work_struct detector_work __initdata =
+		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
+
+static void __init lockup_detector_delay_init(struct work_struct *work)
+{
+	int ret;
+
+	ret = watchdog_hardlockup_probe();
+	if (ret) {
+		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
+		pr_info("Hard watchdog permanently disabled\n");
+		return;
+	}
+
+	allow_lockup_detector_init_retry = false;
+
+	watchdog_hardlockup_available = true;
+	lockup_detector_setup();
+}
+
+/*
+ * lockup_detector_retry_init - retry init lockup detector if possible.
+ *
+ * Retry hardlockup detector init. It is useful when it requires some
+ * functionality that has to be initialized later on a particular
+ * platform.
+ */
+void __init lockup_detector_retry_init(void)
+{
+	/* Must be called before late init calls */
+	if (!allow_lockup_detector_init_retry)
+		return;
+
+	schedule_work(&detector_work);
+}
+
+/*
+ * Ensure that optional delayed hardlockup init is proceed before
+ * the init code and memory is freed.
+ */
+static int __init lockup_detector_check(void)
+{
+	/* Prevent any later retry. */
+	allow_lockup_detector_init_retry = false;
+
+	/* Make sure no work is pending. */
+	flush_work(&detector_work);
+
+	return 0;
+
+}
+late_initcall_sync(lockup_detector_check);
+
 void __init lockup_detector_init(void)
 {
 	if (tick_nohz_full_enabled())
@@ -914,6 +976,9 @@ void __init lockup_detector_init(void)
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;
+	else
+		allow_lockup_detector_init_retry = true;
+
 	lockup_detector_setup();
 	watchdog_sysctl_init();
 }
-- 
2.39.2



