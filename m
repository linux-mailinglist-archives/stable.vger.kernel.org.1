Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3DC7130D9
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 02:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjE0ASm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 20:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjE0ASl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 20:18:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE5A4
        for <stable@vger.kernel.org>; Fri, 26 May 2023 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685146720; x=1716682720;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1/guQ9gTy8SX9SZvo4G+Hqz3o5KZiYPxmJXVyQd9e8k=;
  b=Q6VsLgsKez8R6k15FCAV+xFqjXe4+RtZD9ea/SYJIXRILgUQ8z+cnqTj
   nxoQhanGRAGElrsBLy6WB8etXkk2Ra+z7SHywSUeXbk+wvfHAVEdXGrps
   akoVXag+ySp+Ymvuvf1ojaJagmPTz7nPXiTTP58dz80fe0pUuYD467t7V
   nsDmSkGI87manVcbDM0dvfHvQLUj8a0NMDB9QVBWQ4SgTBeC2wgrWLPzd
   t5ClY1XFLQ0UJYuUtrVqi1VsheRnsTz/1OeaC0HLngleRldqAG1+Cf7hI
   BCKB0taGJQ8luqpMd3hptHAz/MsNBcZpzFyGupQDL7e1fpay8PTkN/XRH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417817852"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="417817852"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="705384684"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="705384684"
Received: from jaleon-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.212.73.60])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 17:18:39 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     stable@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de
Subject: [PATCH 5.15.y] x86/mm: Avoid incomplete Global INVLPG flushes
Date:   Fri, 26 May 2023 17:18:34 -0700
Message-Id: <20230527001834.1208927-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023052612-reproach-snowbird-d3a2@gregkh>
References: <2023052612-reproach-snowbird-d3a2@gregkh>
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
index fc12d970a07c0..d975c60f863a2 100644
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
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 0e3667e529abb..34a08f6a528e9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -261,6 +262,24 @@ static void __init probe_page_size_mask(void)
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
-- 
2.25.1

