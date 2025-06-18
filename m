Return-Path: <stable+bounces-154604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C839ADE029
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA41779E0
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AAC7080D;
	Wed, 18 Jun 2025 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgmtoqW3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2C2F5301
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207494; cv=none; b=XjWyvlQP98R0/d5zYdb5AwQPnykwNUl1NATgq8aECUYq19Ql5Y9+9uVo8sLM+hyzLzBx0FH0iRoDdJ6aj+TqZIOU/4R7gLoXVvYMgaaRyqc66XqQQ5Yoa31MyVo+nPIBZuU70PqybicOFA0gzZZ87bzAKZ1bOJh0Yq1xadh2SWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207494; c=relaxed/simple;
	bh=ii1btxF1Swx/mFR1IBL9J7f5PoTmp5cEesulrraRR8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJAgzZ2JFMXJSht/IL11bMMTaInOnbCfGs1JzX3oqvZjcb39bZXF26yLuOtxiZj4/Xnr5yC5UXJBJz9Znh+tzB1Oo1iFivfsZXNsaPV5thK+UAM64KgpxhZfdpeHw6QEhYFZpC5qshFpvUkSEzrC6wcqrNW4GjN6cv1T/O8KGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgmtoqW3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207493; x=1781743493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii1btxF1Swx/mFR1IBL9J7f5PoTmp5cEesulrraRR8k=;
  b=EgmtoqW3P4Gk257p0reItHswG6MMPuG2aMqbIHHLcwxZ9E14Tj67upIM
   1WMF40mPsWsgqPunYCUelmg0JnUQerBuW8TWQl9n5M5Y6XYYo8O6Y76Og
   Qh1tbud/fmcLYjRsbjQ2kmMIHjkj7kXT6s2GBhF+C1ExTSx1BJESVbx9G
   attSVAJHRh6iIz0DNUk8TjF4xk0TkrMB4/7h2+imhXNy3ZKYn2Bm91uOD
   q0YeGa5nqMLH5eqVa9F1tgy4U2oq7mEcvmWmC8f+csqfWxCm5LFBgc6Lf
   ckRiEsLqkfaxMtyYPXsIxb22cBSTwc6JdxT1IeVhyXAZogYZYQvVIYOY+
   g==;
X-CSE-ConnectionGUID: gBLND3brRbSXHrOrBu1W5A==
X-CSE-MsgGUID: /4gOPv1aRX2PTSfh1foIqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52271768"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52271768"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:52 -0700
X-CSE-ConnectionGUID: YSysGTSAS7SXseZbL6Zp9A==
X-CSE-MsgGUID: DrFpjBbMRdSIZxXebVhqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153746310"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:52 -0700
Date: Tue, 17 Jun 2025 17:44:51 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.10 v2 03/16] x86/its: Enumerate Indirect Target Selection
 (ITS) bug
Message-ID: <20250617-its-5-10-v2-3-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

commit 159013a7ca18c271ff64192deb62a689b622d860 upstream.

ITS bug in some pre-Alderlake Intel CPUs may allow indirect branches in the
first half of a cache line get predicted to a target of a branch located in
the second half of the cache line.

Set X86_BUG_ITS on affected CPUs. Mitigation to follow in later commits.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  8 ++++++
 arch/x86/kernel/cpu/common.c       | 58 ++++++++++++++++++++++++++++++--------
 arch/x86/kvm/x86.c                 |  4 ++-
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 52810a7f6b11..b9aefb75eaff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -459,4 +459,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d6a1ad1ee86e..a479530e59ab 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -179,6 +179,14 @@
 						 * VERW clears CPU Register
 						 * File.
 						 */
+#define ARCH_CAP_ITS_NO			BIT_ULL(62) /*
+						     * Not susceptible to
+						     * Indirect Target Selection.
+						     * This bit is not set by
+						     * HW, but is synthesized by
+						     * VMMs for guests to know
+						     * their affected status.
+						     */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 840fdffec850..a5f4f8e63771 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1134,6 +1134,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define GDS		BIT(6)
 /* CPU is affected by Register File Data Sampling */
 #define RFDS		BIT(7)
+/* CPU is affected by Indirect Target Selection */
+#define ITS		BIT(8)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1145,22 +1147,25 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
@@ -1224,6 +1229,32 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (x86_arch_cap_msr & ARCH_CAP_ITS_NO)
+		return false;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	/* None of the affected CPUs have BHI_CTRL */
+	if (boot_cpu_has(X86_FEATURE_BHI_CTRL))
+		return false;
+
+	/*
+	 * If a VMM did not expose ITS_NO, assume that a guest could
+	 * be running on a vulnerable hardware or may migrate to such
+	 * hardware.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return true;
+
+	if (cpu_matches(cpu_vuln_blacklist, ITS))
+		return true;
+
+	return false;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1338,6 +1369,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
+	if (vulnerable_to_its(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_ITS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bc295439360e..b61f697479a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1390,7 +1390,7 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
 	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_ITS_NO)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1429,6 +1429,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_MDS_NO;
 	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		data |= ARCH_CAP_RFDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
+		data |= ARCH_CAP_ITS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*

-- 
2.43.0



