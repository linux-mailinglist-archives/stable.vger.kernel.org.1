Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCA713FB9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjE1TsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjE1TsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E326A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE6660FE5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF59C433EF;
        Sun, 28 May 2023 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303299;
        bh=Wz+tC9QrzHlIf8RA4G4yk/DItonXVbYFbe7VRtxMfa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mForCy3TR9+p6ApC7rHUxWQPJ2RnMnb30nn3mpMExKR1R6/C7YcarBVLh2joQaiFB
         9aYKQ1mtogWUC3w3jy4wnrzbjZsxuSRWmiZZr/26G8zueUYISPTFGQgQ7RgBpV+cp0
         0GYBFi9wT2Tw8G/1KAjgvy7qG4FB3ur7/NVy6D0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PATCH 5.15 23/69] x86/mm: Avoid incomplete Global INVLPG flushes
Date:   Sun, 28 May 2023 20:11:43 +0100
Message-Id: <20230528190829.238232533@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

commit ce0b15d11ad837fbacc5356941712218e38a0a83 upstream.

The INVLPG instruction is used to invalidate TLB entries for a
specified virtual address.  When PCIDs are enabled, INVLPG is supposed
to invalidate TLB entries for the specified address for both the
current PCID *and* Global entries.  (Note: Only kernel mappings set
Global=1.)

Unfortunately, some INVLPG implementations can leave Global
translations unflushed when PCIDs are enabled.

As a workaround, never enable PCIDs on affected processors.

I expect there to eventually be microcode mitigations to replace this
software workaround.  However, the exact version numbers where that
will happen are not known today.  Once the version numbers are set in
stone, the processor list can be tweaked to only disable PCIDs on
affected processors with affected microcode.

Note: if anyone wants a quick fix that doesn't require patching, just
stick 'nopcid' on your kernel command-line.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/intel-family.h |    5 +++++
 arch/x86/mm/init.c                  |   25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -112,6 +112,11 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
+
+#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -261,6 +262,24 @@ static void __init probe_page_size_mask(
 	}
 }
 
+#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
+			      .family  = 6,			\
+			      .model = _model,			\
+			    }
+/*
+ * INVLPG may not properly flush Global entries
+ * on these CPUs when PCIDs are enabled.
+ */
+static const struct x86_cpu_id invlpg_miss_ids[] = {
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	{}
+};
+
 static void setup_pcid(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
@@ -269,6 +288,12 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
+	if (x86_match_cpu(invlpg_miss_ids)) {
+		pr_info("Incomplete global flushes, disabling PCID");
+		setup_clear_cpu_cap(X86_FEATURE_PCID);
+		return;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		/*
 		 * This can't be cr4_set_bits_and_update_boot() -- the


