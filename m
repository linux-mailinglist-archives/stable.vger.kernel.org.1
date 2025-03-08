Return-Path: <stable+bounces-121549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBBFA57C8D
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FE416C951
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC631DD0D5;
	Sat,  8 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ST7AOBk8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB41A2C27
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741456500; cv=none; b=Ngr/FjyPY6AE31N172Fo23qV3eteGGYCX4IAW6L5PXC9FqFvh/EtbqDbUv/fJlgUr7Ex8yWZQGYVuW7SAg2uvVjwVimY/wmU49YjQkUmXa3IxIJ5LWqSyu/xoWoL7ruX5JudFjq1olALIynYGYrdVVFQK+XR8H/GsuiXCVaRvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741456500; c=relaxed/simple;
	bh=tCsVWaRlJ7nqidGcvAFmfCWoB5bS4vA0O0zNrGbw55k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rvuGySdswRO8Wt3pVgQlwRLLELdGGX/iX+Aal6mo5DyfF9aKxZXuweEBReTJC2cX0xkzNQFUJl3lXqpgOeEoo1MOapmonxVks8b7e/jDo/8zL/3OD/OtoTGngEHjiZ6Xut1MJuGkDWQujr/yxkqO89xQLfGszYa57UFWAwgcIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ST7AOBk8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741456499; x=1772992499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tCsVWaRlJ7nqidGcvAFmfCWoB5bS4vA0O0zNrGbw55k=;
  b=ST7AOBk8TYoDKwy33LeuUbs6o+lGMys9gBtIlNbYeJfTV/Sekv4VrgLB
   m59lcQ147R0yVjK8rKJBIunruEca+L6h2fpmldV0x91gCjGJbi+sLNe8+
   5stzrkgc5MSvF51WzqMtE5Q6zOas9np2B3clrGUFf9NeOOlqicPBSUHSj
   TFd5Bx8BQO4FKsSu3VvRNEjSUz8dSRVXiym9Y9TpQEMq+QLPfeG2HapJw
   NYYpbcOTEBx2BBUI+cLvGWbI+WM6Ti+YfpIxp5A9CbivtF4ALoyE8UeWm
   1P3aKjLRCHmYd/KFcnzU1T9kcNAVBWufFSoxHu7MmwBBiXLp02RqpAMSn
   w==;
X-CSE-ConnectionGUID: kFzIRzPFT7azK97cO4AUtg==
X-CSE-MsgGUID: YovyqAStT260orbUfeCwmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="30073174"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="30073174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 09:54:58 -0800
X-CSE-ConnectionGUID: zgznhRNSQfuoHECNza/K6Q==
X-CSE-MsgGUID: ym1moXeSQFWbZjVx6P9KWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="124186606"
Received: from mupadhya-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.181])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 09:54:58 -0800
Date: Sat, 8 Mar 2025 09:54:57 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 5.4] x86/mm: Don't disable PCID when INVLPG has been fixed by
 microcode
Message-ID: <20250308-clear-pcid-5-4-v1-1-e8bd7c402503@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAA6EzGcC/x3MQQqAIBBA0avErJuwUpKuEi1sGmsgKhQiEO+et
 HyL/xNEDsIRxipB4EeiXGdBW1dAuzs3RlmLoVOdUb2ySAe7gDfJigY1Eg12Ye29cx5KdAf28v7
 DCUyjYc75Ay8l98xlAAAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Xi Ruoyao <xry111@xry111.site>

commit f24f669d03f884a6ef95cca84317d0f329e93961 upstream.

Per the "Processor Specification Update" documentations referred by
the intel-microcode-20240312 release note, this microcode release has
fixed the issue for all affected models.

So don't disable PCID if the microcode is new enough.  The precise
minimum microcode revision fixing the issue was provided by Pawan
Intel.

[ dhansen: comment and changelog tweaks ]
[ pawan: backported to 5.4
	 s/ATOM_GRACEMONT/ALDERLAKE_N/
	 added microcode matching to INTEL_MATCH() and invlpg_miss_ids ]

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Link: https://lore.kernel.org/all/20240522020625.69418-1-xry111%40xry111.site
---
 arch/x86/mm/init.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 086b274fa60f..b3bed9a9f78d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -211,33 +211,39 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
+#define INTEL_MATCH(_model, ucode) { .vendor  = X86_VENDOR_INTEL,	\
+				     .family  = 6,			\
+				     .model = _model,			\
+				     .driver_data = ucode,		\
+				   }
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N,	0x11),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;

---
base-commit: 856a224845f949243d6719165c88a70e4b473ec4
change-id: 20250308-clear-pcid-5-4-cc78be4ffaaf

Best regards,
-- 
Thanks,
Pawan



