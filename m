Return-Path: <stable+bounces-154779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F54AE0139
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D337AF593
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D927A92F;
	Thu, 19 Jun 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqVsC9bn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B021CC47
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323872; cv=none; b=MzdDct6QvRsgXZdvUTeDHBUefKkDO1iWo8Z0F6TAmmWZ9hETUcLVjq5mAAs/v5v9lvyQNyNZohuI1pNoVNYgON3uWD81/6qyw0aVAhcRe2vbyhlHYtkCcZQrenigEDqLiZ2E1StU9J2qkRKjxZeTBOI/R5JeqdY2yf9PlRKnCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323872; c=relaxed/simple;
	bh=q9QfFbDFbrLovJt9rukCgv1DTVKymEnm5D7N0maM0lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtb9PZ9TDVFPpnZ4xYi9rzJ3mDhWGbP/LIjeDwH7QvVgeMti0E23pbpclYtLWmukEtig0eWTweK5XXKfFVta+xd70s5ihWezfI//6Orih/xZV1h57+r2jBVwXsh4pI1x6A/I0CMzW7OiyUSdpCrhILSMDD6N4GhE3Rwbs+HSa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqVsC9bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B405BC4CEEA;
	Thu, 19 Jun 2025 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323872;
	bh=q9QfFbDFbrLovJt9rukCgv1DTVKymEnm5D7N0maM0lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqVsC9bnOoHvlRPBU8aosMWbEMrQZpiAba+R4E9+n7yZXTaUZpEGP8R1OJSkfGnsv
	 H7UOowMp4b675DmuMTwVs53k1Nb686hAHytMCVtu2kH1U4a/X/bMCN8ugiwMFjnjlx
	 4LSxmrLMWzaxTTBLhY8sP5rnQQ+Oi4INaxYWHHCGRfyzopMOCkCGY0bUVKF7yy8K5J
	 Xf90eaWzOUYT2/ZXd4cYz46HFvyVvDIEwLVxbqAIjuNBx/X9QcFH2Ph0JejVs7MdN2
	 FJ5+wRCnc2z0N9ijNrbJMTdy33jFRHsdpIjk0FJoO/nqczyyc/Xb+9Tkpt2wv0g1Zu
	 vW8SOoPSGmxJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 03/16] x86/its: Enumerate Indirect Target Selection (ITS) bug
Date: Thu, 19 Jun 2025 05:04:30 -0400
Message-Id: <20250618170549-44f28237a946cc4c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-3-3e925a1512a1@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 159013a7ca18c271ff64192deb62a689b622d860

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: a6f2a436e9d6)
6.6.y | Present (different SHA1: 195579752c23)
6.1.y | Present (different SHA1: 0eda20c29e12)
5.15.y | Present (different SHA1: 34be1a3100b0)

Note: The patch differs from the upstream commit:
---
1:  159013a7ca18c ! 1:  137854d52a7a4 x86/its: Enumerate Indirect Target Selection (ITS) bug
    @@ Metadata
      ## Commit message ##
         x86/its: Enumerate Indirect Target Selection (ITS) bug
     
    +    commit 159013a7ca18c271ff64192deb62a689b622d860 upstream.
    +
         ITS bug in some pre-Alderlake Intel CPUs may allow indirect branches in the
         first half of a cache line get predicted to a target of a branch located in
         the second half of the cache line.
     
         Set X86_BUG_ITS on affected CPUs. Mitigation to follow in later commits.
     
    -    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/cpufeatures.h ##
     @@
    - #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
    - #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
    - #define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
    -+#define X86_BUG_ITS			X86_BUG(1*32 + 6) /* "its" CPU is affected by Indirect Target Selection */
    + #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
    + #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
    + #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
    ++#define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
      #endif /* _ASM_X86_CPUFEATURES_H */
     
      ## arch/x86/include/asm/msr-index.h ##
    @@ arch/x86/kernel/cpu/common.c: static const __initconst struct x86_cpu_id cpu_vul
     +#define ITS		BIT(8)
      
      static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
    - 	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
    + 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
     @@ arch/x86/kernel/cpu/common.c: static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
    - 	VULNBL_INTEL_STEPS(INTEL_BROADWELL_G,	     X86_STEP_MAX,	SRBDS),
    - 	VULNBL_INTEL_STEPS(INTEL_BROADWELL_X,	     X86_STEP_MAX,	MMIO),
    - 	VULNBL_INTEL_STEPS(INTEL_BROADWELL,	     X86_STEP_MAX,	SRBDS),
    --	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
    -+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,		      0x5,	MMIO | RETBLEED | GDS),
    -+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
    - 	VULNBL_INTEL_STEPS(INTEL_SKYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
    --	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
    --	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
    -+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,		      0xb,	MMIO | RETBLEED | GDS | SRBDS),
    -+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,		      0xc,	MMIO | RETBLEED | GDS | SRBDS),
    -+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS),
    --	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
    --	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED),
    --	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
    --	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS),
    --	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
    --	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
    -+	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS),
    - 	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS),
    - 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
    - 	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS),
    -@@ arch/x86/kernel/cpu/common.c: static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
    + 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
    + 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
    + 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
    +-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
    ++	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS),
    ++	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
    + 	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
    +-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
    +-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
    ++	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS),
    ++	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
    ++	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS),
    +-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
    +-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
    +-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
    +-	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
    +-	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
    ++	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
    +-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
    ++	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
    + 	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
    + 	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
    +@@ arch/x86/kernel/cpu/common.c: static bool __init vulnerable_to_rfds(u64 ia32_cap)
      	return cpu_matches(cpu_vuln_blacklist, RFDS);
      }
      
    @@ arch/x86/kernel/cpu/common.c: static bool __init vulnerable_to_rfds(u64 x86_arch
     +
      static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
      {
    - 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
    + 	u64 ia32_cap = x86_read_arch_cap_msr();
     @@ arch/x86/kernel/cpu/common.c: static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
      	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
      		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
      
    -+	if (vulnerable_to_its(x86_arch_cap_msr))
    ++	if (vulnerable_to_its(ia32_cap))
     +		setup_force_cpu_bug(X86_BUG_ITS);
     +
      	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
    @@ arch/x86/kernel/cpu/common.c: static void __init cpu_set_bug_bits(struct cpuinfo
      
     
      ## arch/x86/kvm/x86.c ##
    -@@ arch/x86/kvm/x86.c: EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
    +@@ arch/x86/kvm/x86.c: static unsigned int num_msr_based_features;
      	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
      	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
      	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
    --	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO)
    -+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO | ARCH_CAP_ITS_NO)
    +-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
    ++	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_ITS_NO)
      
      static u64 kvm_get_arch_capabilities(void)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

