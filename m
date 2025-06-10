Return-Path: <stable+bounces-152336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A7AD430F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE34C3A434C
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D5264A74;
	Tue, 10 Jun 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWOFqUl9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07A23183E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584610; cv=none; b=l8WjkwJ1KcCHBhiXOe5LwJ+GQZG0MlUOtQBNoWY54H+HZz2s/WrucHkXakmbeDAe8IkiulsxLutwotjA3ZLWpC5dNeXqlPtpqOrkAEJT2YBqkk6GNJsocY2+PTatrueFCxNIjSFKLtrrAvTIP4jrpDfK7zs7F8v718Vi7UiFfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584610; c=relaxed/simple;
	bh=U9dX2/GK6SIz3eIfL/OALLoB1OcWTC5UVO1NNvC+yPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2iuD0gPX5jMoJgh1eTw6burOiadUmE0AqpDvki7xt+/QhdceqxYU0lwYqhPRL69pqapJeusCKjHiVyUn3L0m/lBbcRf3dJrXKt7XcMrbLpvP+ioyeCbZrQS+NmCW9hhzORZTfC/+kf7Lg494eu70J3mFNyv/59cL9qd4lvRTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWOFqUl9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584608; x=1781120608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9dX2/GK6SIz3eIfL/OALLoB1OcWTC5UVO1NNvC+yPI=;
  b=GWOFqUl9UHSBMeXjfZvFtovSwoMy2NqifYwWTFl01ObugTAv2t5IfLdW
   0Xt6+8nIK1+0sQ7E67GYrfvJn9dmyQ0tOKqiXfGOh4jbDDWTg5X7UikpE
   SlWFra5SFyQ8Gp1dKGDWk7ltHCPJvhfUoM/2hFBrAU7XjQiWkMGlYrz+T
   qjcNesIhnK9BJpO+1ZpO/hL+iRbaULkL3Qpw77OVBgNcTyIyYYPw4LOnv
   Y8CAA/yfGGwFJW7knc7USqbeBpi4CQ5t9bNGo/ns1Fe1FIvSBMDUxp+IO
   4cbsdO2NwzGc6B5tvb+s4MQXgj/fDzlHKZSPoiA1k7B32MQsS0FbFoE9r
   g==;
X-CSE-ConnectionGUID: hYpF+KftT66dyBw2T5Mr/A==
X-CSE-MsgGUID: KxDQiC90Sce6wkEdsiTa9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55375254"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="55375254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:43:28 -0700
X-CSE-ConnectionGUID: um/QHIZJQ4CMKWtXyROySw==
X-CSE-MsgGUID: jcKjfFNmQoGbdyxKVpI+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="150786579"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:43:27 -0700
Date: Tue, 10 Jun 2025 12:43:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5.10 12/16] x86/its: Add "vmexit" option to skip
 mitigation on some CPUs
Message-ID: <20250610-its-5-10-v1-12-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/include/asm/cpufeatures.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                      | 11 +++++++++++
 arch/x86/kernel/cpu/common.c                    | 19 ++++++++++++-------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 544ab81880f09357b6e1d9b255b08b9dc70e31d2..564089fd0af0cb392400bf0a58643993cf4b667c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1859,6 +1859,8 @@
 			off:    Disable mitigation.
 			force:	Force the ITS bug and deploy default
 				mitigation.
+			vmexit: Only deploy mitigation if CPU is affected by
+				guest/host isolation part of ITS.
 
 			For details see:
 			Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a9ccd2ac2d7ae1dd5b9da90fe7d7bd31abb3df96..e2dc271e6f39583325a5bd8098c59339cc52e9c8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -460,4 +460,5 @@
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
+#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* CPU is affected by ITS, VMX is not affected */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5d555db06ff51f0a27b9a9fd40d6ba11077c2409..282995c465042947c91db71d7e684edd9dd0d5e9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1127,15 +1127,18 @@ static void __init retbleed_select_mitigation(void)
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
 
@@ -1161,6 +1164,8 @@ static int __init its_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		its_cmd = ITS_CMD_ON;
 		setup_force_cpu_bug(X86_BUG_ITS);
+	} else if (!strcmp(str, "vmexit")) {
+		its_cmd = ITS_CMD_VMEXIT;
 	} else {
 		pr_err("Ignoring unknown indirect_target_selection option (%s).", str);
 	}
@@ -1208,6 +1213,12 @@ static void __init its_select_mitigation(void)
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
index a5f4f8e637713569f2671dbddaf8203415560256..ca412c2882aa67731dab48ce97f55c142134ad01 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1136,6 +1136,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define RFDS		BIT(7)
 /* CPU is affected by Indirect Target Selection */
 #define ITS		BIT(8)
+/* CPU is affected by Indirect Target Selection, but guest-host isolation is not affected */
+#define ITS_NATIVE_ONLY	BIT(9)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1156,16 +1158,16 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
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
@@ -1369,8 +1371,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
-	if (vulnerable_to_its(ia32_cap))
+	if (vulnerable_to_its(ia32_cap)) {
 		setup_force_cpu_bug(X86_BUG_ITS);
+		if (cpu_matches(cpu_vuln_blacklist, ITS_NATIVE_ONLY))
+			setup_force_cpu_bug(X86_BUG_ITS_NATIVE_ONLY);
+	}
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;

-- 
2.34.1



