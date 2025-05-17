Return-Path: <stable+bounces-144678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF1ABAA35
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594C34A5052
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E61F4191;
	Sat, 17 May 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/FoMhUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56836155393
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487299; cv=none; b=PuWacFehfui7wgBuKG7SnBCDr94LfKQtkolTnJ9CKR3KCZ5JJKPY1WMrQypWnzF8+IekZxmvLro4id3Q8Wu3AdZDR1Obli3VJrOOXPAQ05qBTCpiiV6gggSL0qSDlrL7ZvgNdjeNyFuvxWqfuz3HSANc2BFJyV31OggKsi4LY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487299; c=relaxed/simple;
	bh=9dynFoXgGeyGoYHSJD96i1OitGASzH1EwoVBBC7LHdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvvEtOnfpclW1OEszPUaj3JqPNiEz8vJ6bovWSm4Xa7FE00szsktlrRXN6oHtvUHKy3YOf9WvTBh2HZf19yInwa3kyRbHOvFGpjkI6WAAUHe4KAILMbQJtKwKt0LTdw0pATepf1ZKqaHD9qFAlhWtNGeDe2cRe15BEloukeD55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/FoMhUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A8C4CEE9;
	Sat, 17 May 2025 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487298;
	bh=9dynFoXgGeyGoYHSJD96i1OitGASzH1EwoVBBC7LHdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/FoMhUPHR8n/FxEqh8q+KfIOEenrX4M6jQ4c6DyuvMIf4pgdsUsoKt/fM7otmiRS
	 YsIHZw746i27twb+JuzcKDYg0VWTATFeqsdnFbsbG2tUE1hnAkD3VBgpAC3iskK0rA
	 /468Wa6pGLwnNywFWjnpCqfTa49sFnSOw9Y0ncfosnOFXi+bIi2SBPJW3OOlBhCLG2
	 f6GRMFaF1m0CB8zMO8R19ZJFWC90L3tDhsoBu6anmFPTg6RQIi7t255unen7fcaHaT
	 pVbNIJJkmqsuZxYznG7As5FXN4tmrAb3+qTE6qx7eq53yPiekxt1Gru5Azls+XH70H
	 Vr8uhnO7jwwxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 06/16] x86/its: Enumerate Indirect Target Selection (ITS) bug
Date: Sat, 17 May 2025 09:08:17 -0400
Message-Id: <20250516214043-15182180cdbdbd73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-6-16fcdaaea544@linux.intel.com>
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
6.14.y | Present (different SHA1: 6826e2ec2d88)
6.12.y | Present (different SHA1: d89cff63d3eb)
6.6.y | Present (different SHA1: 81b9dc008193)
6.1.y | Present (different SHA1: 527651c1e381)

Note: The patch differs from the upstream commit:
---
1:  159013a7ca18c ! 1:  796d194a26dde x86/its: Enumerate Indirect Target Selection (ITS) bug
    @@ Metadata
      ## Commit message ##
         x86/its: Enumerate Indirect Target Selection (ITS) bug
     
    +    commit 159013a7ca18c271ff64192deb62a689b622d860 upstream.
    +
         ITS bug in some pre-Alderlake Intel CPUs may allow indirect branches in the
         first half of a cache line get predicted to a target of a branch located in
         the second half of the cache line.
    @@ Commit message
     
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
     @@ arch/x86/kernel/cpu/common.c: static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
      	return cpu_matches(cpu_vuln_blacklist, RFDS);
      }
    @@ arch/x86/kernel/cpu/common.c: static void __init cpu_set_bug_bits(struct cpuinfo
      
     
      ## arch/x86/kvm/x86.c ##
    -@@ arch/x86/kvm/x86.c: EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
    +@@ arch/x86/kvm/x86.c: static unsigned int num_msr_based_features;
      	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
      	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
      	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

