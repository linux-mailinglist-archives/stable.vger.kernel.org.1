Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555F70C784
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjEVTa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjEVTa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F3FA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D28A628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFFAC433D2;
        Mon, 22 May 2023 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783825;
        bh=QtkgcGf1W3mOwB8xJrkWew1rMav0BABgRoE34v8Ync8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0T+vJmS76BoCY5G99l6K6tTYk6eqsmIxpvkGvvpxXrzPCfoI+QkfEIZNLk+t99K7d
         gjlRaKLHQX0REEfn7EfrdvjJIykePzXBLAbIogfeyYTESaO/7bmLwbYeIgRpr6eThk
         gpPn9HF83CoNvUK0Vw/14MCTnjzYf6nVmz874oMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeroen Roovers <jer@xs4all.nl>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 147/292] parisc: Replace regular spinlock with spin_trylock on panic path
Date:   Mon, 22 May 2023 20:08:24 +0100
Message-Id: <20230522190409.638792431@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

[ Upstream commit 829632dae8321787525ee37dc4828bbe6edafdae ]

The panic notifiers' callbacks execute in an atomic context, with
interrupts/preemption disabled, and all CPUs not running the panic
function are off, so it's very dangerous to wait on a regular
spinlock, there's a risk of deadlock.

Refactor the panic notifier of parisc/power driver to make use
of spin_trylock - for that, we've added a second version of the
soft-power function. Also, some comments were reorganized and
trailing white spaces, useless header inclusion and blank lines
were removed.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jeroen Roovers <jer@xs4all.nl>
Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/pdc.h |  1 +
 arch/parisc/kernel/firmware.c | 27 +++++++++++++++++++++++----
 drivers/parisc/power.c        | 16 ++++++++++------
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index fcbcf9a96c111..77622558bf651 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -80,6 +80,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
 int pdc_do_reset(void);
 int pdc_soft_power_info(unsigned long *power_reg);
 int pdc_soft_power_button(int sw_control);
+int pdc_soft_power_button_panic(int sw_control);
 void pdc_io_reset(void);
 void pdc_io_reset_devices(void);
 int pdc_iodc_getc(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index bd325f2b5349e..3e051a973e9b2 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long *power_reg)
 }
 
 /*
- * pdc_soft_power_button - Control the soft power button behaviour
- * @sw_control: 0 for hardware control, 1 for software control 
+ * pdc_soft_power_button{_panic} - Control the soft power button behaviour
+ * @sw_control: 0 for hardware control, 1 for software control
  *
  *
  * This PDC function places the soft power button under software or
  * hardware control.
- * Under software control the OS may control to when to allow to shut 
- * down the system. Under hardware control pressing the power button 
+ * Under software control the OS may control to when to allow to shut
+ * down the system. Under hardware control pressing the power button
  * powers off the system immediately.
+ *
+ * The _panic version relies on spin_trylock to prevent deadlock
+ * on panic path.
  */
 int pdc_soft_power_button(int sw_control)
 {
@@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
 	return retval;
 }
 
+int pdc_soft_power_button_panic(int sw_control)
+{
+	int retval;
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
+		pr_emerg("Couldn't enable soft power button\n");
+		return -EBUSY; /* ignored by the panic notifier */
+	}
+
+	retval = mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE, __pa(pdc_result), sw_control);
+	spin_unlock_irqrestore(&pdc_lock, flags);
+
+	return retval;
+}
+
 /*
  * pdc_io_reset - Hack to avoid overlapping range registers of Bridges devices.
  * Primarily a problem on T600 (which parisc-linux doesn't support) but
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee66..6f5e5f0230d39 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -37,7 +37,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
@@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void *x)
 
 
 
-/* parisc_panic_event() is called by the panic handler.
- * As soon as a panic occurs, our tasklets above will not be
- * executed any longer. This function then re-enables the 
- * soft-power switch and allows the user to switch off the system
+/*
+ * parisc_panic_event() is called by the panic handler.
+ *
+ * As soon as a panic occurs, our tasklets above will not
+ * be executed any longer. This function then re-enables
+ * the soft-power switch and allows the user to switch off
+ * the system. We rely in pdc_soft_power_button_panic()
+ * since this version spin_trylocks (instead of regular
+ * spinlock), preventing deadlocks on panic path.
  */
 static int parisc_panic_event(struct notifier_block *this,
 		unsigned long event, void *ptr)
 {
 	/* re-enable the soft-power switch */
-	pdc_soft_power_button(0);
+	pdc_soft_power_button_panic(0);
 	return NOTIFY_DONE;
 }
 
-- 
2.39.2



