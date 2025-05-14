Return-Path: <stable+bounces-144325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A2AB62C4
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C44819E003D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647941F428C;
	Wed, 14 May 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUvZKZIm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC31F5E6
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202990; cv=none; b=el5cVvmvCqhHRwMmqABgj+YTlskSdQ/MBz3WiK2dl5IICLxkc+naqRFEoZu6ODapZ1ZxyphSSiIQbsX83wUCcZ+3Cz5fn/+KM/3e+1lwEB3sky/flzqTQNVZF9/M6G3Qlz8aoOxWageQoGUhDN3twRCBfLCblX1RaN9GBaJq42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202990; c=relaxed/simple;
	bh=bu5hzugLSeNygU08AiIOoVMlt6JqKUgvAoHB7WgDwiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFoF8TZA+9eJWOCxnaHoIzDl1Q4cT8nCpJXuKjeyiJ6TrBzxdEKCTq4KVKw+WFqT+TGP9S8lbRtIdctJ79eoVnW22OABJqzWiuyxI0Ka4tfKynzYLFErs8zU4WkWh32gBuyF5NiZmvU2nce2NiT4ANTRvsVKNIPGwddFI6a2Ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUvZKZIm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202989; x=1778738989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bu5hzugLSeNygU08AiIOoVMlt6JqKUgvAoHB7WgDwiM=;
  b=FUvZKZImH5K6Xnnt/uhC+OFuJfJVM0eOMIv6sN8AS3r2jjgrIc+3HZwO
   9ka7EuzQLecSeToziqgcko6FyPlzzys0DgomMNwvAIvm1HzwqT4CB99Xd
   KI5/GyK2BE4PF3Kyq+OybsLYsr8rE2EtMYOjUeW5Y2pCoZjBX+TEqQFoh
   TThLIX9pXSSVbkv2F+x5Jo5nmj0WFvPoPl7ZfEwhzVNHf1AcCF0OlRmjY
   mB1r0GsRoVMi2sIM/4GicrTEsNj59a99pAzsPlTRFbHCYG2etbb7y3VuW
   Hc4QA+p3WPVDy2oonnErIsylN/pycutcV265GhsuXLjwfE64sUj9ujpnG
   A==;
X-CSE-ConnectionGUID: WsQSUA1OTre5MlpIvX2KQw==
X-CSE-MsgGUID: ox2oLDO2Qp+Q2zGb52LkNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59712971"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="59712971"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:09:45 -0700
X-CSE-ConnectionGUID: 8cwhRfIUSFe6NyGp+9RFYQ==
X-CSE-MsgGUID: Et0bX2PzS9qQDGLeyPSZfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142883962"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:09:45 -0700
Date: Tue, 13 May 2025 23:09:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v2 12/14] x86/its: Add "vmexit" option to skip
 mitigation on some CPUs
Message-ID: <20250513-its-5-15-v2-12-90690efdc7e0@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>

commit 2665281a07e19550944e8354a2024635a7b2714a upstream.

Ice Lake generation CPUs are not affected by guest/host isolation part of
ITS. If a user is only concerned about KVM guests, they can now choose a
new cmdline option "vmexit" that will not deploy the ITS mitigation when
CPU is not affected by guest/host isolation. This saves the performance
overhead of ITS mitigation on Ice Lake gen CPUs.

When "vmexit" option selected, if the CPU is affected by ITS guest/host
isolation, the default ITS mitigation is deployed.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/include/asm/cpufeatures.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                      | 11 +++++++++++
 arch/x86/kernel/cpu/common.c                    | 19 ++++++++++++-------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3619e868c884ca4bd786d6049d407c28e0fd994..4bc5d8c97d097b3ee6b8ff99f3958429f0352e59 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1934,6 +1934,8 @@
 			off:    Disable mitigation.
 			force:	Force the ITS bug and deploy default
 				mitigation.
+			vmexit: Only deploy mitigation if CPU is affected by
+				guest/host isolation part of ITS.
 
 			For details see:
 			Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a268028a6ac7b71e6968356f622663c561d65153..e2bf1cba02cdde7458f59d1e3e03075a339517af 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -485,4 +485,5 @@
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
+#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* CPU is affected by ITS, VMX is not affected */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8e3fe0514144f5518755f2bc0579260e1b88d776..0b07526670ee6fb14f78ceca5d4728807d505fa0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1158,15 +1158,18 @@ static void __init retbleed_select_mitigation(void)
 enum its_mitigation_cmd {
 	ITS_CMD_OFF,
 	ITS_CMD_ON,
+	ITS_CMD_VMEXIT,
 };
 
 enum its_mitigation {
 	ITS_MITIGATION_OFF,
+	ITS_MITIGATION_VMEXIT_ONLY,
 	ITS_MITIGATION_ALIGNED_THUNKS,
 };
 
 static const char * const its_strings[] = {
 	[ITS_MITIGATION_OFF]			= "Vulnerable",
+	[ITS_MITIGATION_VMEXIT_ONLY]		= "Mitigation: Vulnerable, KVM: Not affected",
 	[ITS_MITIGATION_ALIGNED_THUNKS]		= "Mitigation: Aligned branch/return thunks",
 };
 
@@ -1192,6 +1195,8 @@ static int __init its_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		its_cmd = ITS_CMD_ON;
 		setup_force_cpu_bug(X86_BUG_ITS);
+	} else if (!strcmp(str, "vmexit")) {
+		its_cmd = ITS_CMD_VMEXIT;
 	} else {
 		pr_err("Ignoring unknown indirect_target_selection option (%s).", str);
 	}
@@ -1239,6 +1244,12 @@ static void __init its_select_mitigation(void)
 	case ITS_CMD_OFF:
 		its_mitigation = ITS_MITIGATION_OFF;
 		break;
+	case ITS_CMD_VMEXIT:
+		if (boot_cpu_has_bug(X86_BUG_ITS_NATIVE_ONLY)) {
+			its_mitigation = ITS_MITIGATION_VMEXIT_ONLY;
+			goto out;
+		}
+		fallthrough;
 	case ITS_CMD_ON:
 		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
 		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 57c530eac69f37dd288c8eba695456c75cf0bd96..cc9a6617e7fa9a9b72e9c5739a15b5b6997f9018 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1143,6 +1143,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define RFDS		BIT(7)
 /* CPU is affected by Indirect Target Selection */
 #define ITS		BIT(8)
+/* CPU is affected by Indirect Target Selection, but guest-host isolation is not affected */
+#define ITS_NATIVE_ONLY	BIT(9)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1163,16 +1165,16 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
@@ -1386,8 +1388,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
-	if (vulnerable_to_its(x86_arch_cap_msr))
+	if (vulnerable_to_its(x86_arch_cap_msr)) {
 		setup_force_cpu_bug(X86_BUG_ITS);
+		if (cpu_matches(cpu_vuln_blacklist, ITS_NATIVE_ONLY))
+			setup_force_cpu_bug(X86_BUG_ITS_NATIVE_ONLY);
+	}
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;

-- 
2.34.1



