Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED771314B
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjE0BHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 21:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjE0BHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 21:07:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F8135
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685149670; x=1716685670;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NX2CCzX9vzXEFzl+oPHWkCpuW4q7xXdvgairCpvv1Ws=;
  b=F7yiVhHMVkHAfC13mURxJcB77iDc8GARIXEOVc/DusZZmnQzhtohif5U
   7uBS2bZklzHcoLJHkvHhgJnr0nbWIkGGcd3uA3zxD3JSM3PDD1DnS5dwo
   vp0MsACPVPAVUgCZfkbQsK5ObV3DItcQEamhXP57rHhhhrx5IWuRi21j6
   w/HCN+53TO66j0zySXwUT7YTwgYwFBzLw60zkL78gFvSjzNJscMEuwnkd
   KbcFfeP9zSS1XzhjXlBjwSP6zp0bbXr5YdEIrcCg8Hk7+6ZPFAzFL/PU8
   sWKPNoY/Tp8Wh9mOayt7v7F69OLxMC6X9T3UIEomr+aiLXDLcnEN0QGFP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="354356614"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="354356614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 18:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="770482831"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="770482831"
Received: from jaleon-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.212.73.60])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 18:07:50 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     stable@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de
Subject: [PATCH 4.19.y] x86/mm: Avoid incomplete Global INVLPG flushes
Date:   Fri, 26 May 2023 18:07:45 -0700
Message-Id: <20230527010745.1348761-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023052615-manila-armoire-d077@gregkh>
References: <2023052615-manila-armoire-d077@gregkh>
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
index 1f2f52a340868..ccf07426a84df 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -74,6 +74,11 @@
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
index b1dba0987565e..2c84c5595cf46 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -207,6 +208,24 @@ static void __init probe_page_size_mask(void)
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
@@ -215,6 +234,12 @@ static void setup_pcid(void)
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

