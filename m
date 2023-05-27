Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB071310E
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 02:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjE0A65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 20:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjE0A65 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 20:58:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141EE189
        for <stable@vger.kernel.org>; Fri, 26 May 2023 17:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685149136; x=1716685136;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=QEMY/Mb3OQWbCjjSnJzhZ0IBzkzjl1uqbOeP9H/DF5g=;
  b=eLnsgA2cnFa8Tr9W0JnhEzw5fRmiApTEZTu8zo0rk14gDzjujPsNI2m5
   +gks7KoYx+rxgI71bUQ1yL/dfGI73OQ6L9eqixNihdapb6gGdie6VSRjS
   Mv7Jb6zjuPklY8DFwX0bNkufinFZEbAN2JQSxLS3HtbR05v63/MU3Sb9f
   6oywHDdxnQJFWSrDL1ISq2zwFLWC1vjBILNNSKKJB84kk9WVc2bphI6DQ
   Q0CTBNTrE/zaJKGxlVOmgqvGJQ2XsnqCiBl44hie+prgdjvMpXsNjUUAg
   GHMBBLUiVuJ7hUj69y/a2EEnAWxffZQ1D8E0hRWBoWTsibQTy5wWcJXrq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="351848772"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="351848772"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="952070197"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="952070197"
Received: from jaleon-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.212.73.60])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:58:55 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     stable@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de
Subject: [PATCH 5.4.y] x86/mm: Avoid incomplete Global INVLPG flushes
Date:   Fri, 26 May 2023 17:58:51 -0700
Message-Id: <20230527005851.1312665-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023052614-ascertain-reshuffle-d127@gregkh>
References: <2023052614-ascertain-reshuffle-d127@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

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
(cherry picked from commit ce0b15d11ad837fbacc5356941712218e38a0a83)
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h |  5 +++++
 arch/x86/mm/init.c                  | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index c1d6d8bbb7dad..6fdd863198ec2 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -96,6 +96,11 @@
 #define	INTEL_FAM6_LAKEFIELD		0x8A
 #define INTEL_FAM6_ALDERLAKE		0x97
 #define INTEL_FAM6_ALDERLAKE_L		0x9A
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
+
+#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index af352e228fa2b..38e6798ce44fc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -208,6 +209,24 @@ static void __init probe_page_size_mask(void)
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
@@ -216,6 +235,12 @@ static void setup_pcid(void)
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
-- 
2.25.1

