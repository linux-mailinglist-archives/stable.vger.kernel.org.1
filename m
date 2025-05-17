Return-Path: <stable+bounces-144655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84453ABA6E0
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0744C0121
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38589136E;
	Sat, 17 May 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq67Ar2w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633E23DE
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440158; cv=none; b=TBv1u7csPPhImFvsk+B5izrBpHqyMB1zuSBex1aUpJfqf7o6sYrtgq5UhiSgYw+Xy+K2We5SXBI7Aoq2D9GcZyP8q4vK3mamsevQ212mDUXQ8tfDX2JUXyMm8AbOZPD49lt//AtNCpYDXd3ps7F75meyTXnOisniVyyJ32e9ieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440158; c=relaxed/simple;
	bh=hj4NBIy6PDBMM89iBJXNhfY9VdfzxcGfKhmQ6x8wfE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4CC3eBcguc0wxXjPOpa+ucitl2ud01fKGXEBWzsIv0PHwqzDJGR3W3SYn/1x9dANqdrnyWY+cjdPSWFCiei0QtioQ7rC5kPTO9rklOco46cJ6KN1N8IBOcR6WCFI1wmBplE/D+kXDYWntqTeGVt5IUIrJJOj7gW+tROmKe79G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq67Ar2w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440156; x=1778976156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hj4NBIy6PDBMM89iBJXNhfY9VdfzxcGfKhmQ6x8wfE8=;
  b=Vq67Ar2wlj6F1dW/ZQQlPQ9WEAq4aCtWUDJbbHfQFb8wX1IsxP8nVcmO
   5ytD3Wct5LX8+nFemd93tJrPmcOC5Wo+y6c2+JRBlaPnlaCeg+ZFzFtw7
   RhFO3KZx6w5YtoVR2BSE7+GitwFGHti9XyvdDugRXjqIRBSZUOq8BUHgo
   xAomc5uRO9vu/JexnZP7/qfiIda59FA6LFJyLiZEkK8ElAElJrSjhvrtf
   TAz9ca4va8hT1T8Yof11eAm45u42EMYf0kp/e2pzHp+DmjSsFR5Qz7ERD
   iKTwqs4YF+M0tc2Zzr/eFsQBXVkHqnNesdpyufb8BO5l3ynmBL9BNLe2b
   A==;
X-CSE-ConnectionGUID: z25+mI43QHq5f7RNimm94w==
X-CSE-MsgGUID: 5/fNksm+Qvq20lEarJ23PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49531233"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49531233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:02:35 -0700
X-CSE-ConnectionGUID: SsxfYAP9S52HkL2+z6ASdA==
X-CSE-MsgGUID: 8oRhCekVRsap8OEj4wTdcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143705718"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:02:35 -0700
Date: Fri, 16 May 2025 17:02:35 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v3 12/16] x86/its: Add "vmexit" option to skip
 mitigation on some CPUs
Message-ID: <20250516-its-5-15-v3-12-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

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
index 3cb2a5b4230c9f084dfb922ca3f3ee42285ff8b5..63af3d73d19e5d83b16fef8c3fc9aa6e13dda832 100644
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
index 541114a2b93533f2768097fa126fa6b19b375dfd..dc15568e14d935026a8eecc5efc57aaed78699d5 100644
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
@@ -1389,8 +1391,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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



