Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85582742C21
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjF2Sp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjF2Sp5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECCB2693
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45290615DC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5567EC433CA;
        Thu, 29 Jun 2023 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064355;
        bh=bzi7ZGMOrcTm1Cdqe2nS1pzerRZmd6vr95NvAvtHkCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YE4VQ2OwqL9JOqc8erC7CxgFM7ALf4J82OtqYsfoNHjUDoLqPgPLoHuK5dUghu8I8
         WZZ83MeV3cVwHo16vOPKA1/zErx71ej0LMbEmvuTNG398tx5hsQt4J7jQzKJvzQyWm
         2vAIhjoXknyb8PDW5Ws7BWcqkikRs3clZ7wrHats=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 08/30] x86/smp: Dont access non-existing CPUID leaf
Date:   Thu, 29 Jun 2023 20:43:27 +0200
Message-ID: <20230629184151.997771409@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
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

From: Tony Battersby <tonyb@cybernetics.com>

commit 9b040453d4440659f33dc6f0aa26af418ebfe70b upstream.

stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. Intel
CPUs return the content of the highest supported leaf when a non-existing
leaf is read, while AMD CPUs return all zeros for unsupported leafs.

So the result of the test on Intel CPUs is lottery.

While harmless it's incorrect and causes the conditional wbinvd() to be
issued where not required.

Check whether the leaf is supported before reading it.

[ tglx: Adjusted changelog ]

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
Link: https://lore.kernel.org/r/20230615193330.322186388@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/process.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -748,6 +748,7 @@ struct cpumask cpus_stop_mask;
 
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
 	unsigned int cpu = smp_processor_id();
 
 	local_irq_disable();
@@ -762,7 +763,7 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	set_cpu_online(cpu, false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -776,7 +777,7 @@ void __noreturn stop_this_cpu(void *dumm
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
 
 	/*


