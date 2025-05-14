Return-Path: <stable+bounces-144444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE34AB76A2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E7E176D1A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A222951A5;
	Wed, 14 May 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnDNzsQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13527703E
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253695; cv=none; b=OXL3nVoX5+vtTj5ehnyPwVIwzTBaeEYvIrdVodeWntfdEwX8BJR6V5TpSX+flR0A4tOCXEPD9euPSB2SLqh4/iTkUvLwCcicNQkxN+x0Zh6tN8jKze+kRpffDm0/TrGZupC7Xe2Jtpo8FHWyX8xYOMkFk6xU1yvhASKPFB4L0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253695; c=relaxed/simple;
	bh=XXA8jOHZzmOAOLtExdhQzsiw1UBz9Z1ghYQ2L6hk5j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT/LbDLKUbNC7WPkrItikOO+TY5G2VIy3DrXEjqR1ZUo93WatEOJmTCwwdMHaVYDdNiAu30cEMe7qHmttPzzxvOHItiDBTDh1Ri0PUaYjS5lYrYZTRqPPtcEJlzeFX/4XWTMf0pqhMSlbVLBKO2t2itHme4P4dsi7p05+MrM8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnDNzsQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B183C4CEED;
	Wed, 14 May 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253694;
	bh=XXA8jOHZzmOAOLtExdhQzsiw1UBz9Z1ghYQ2L6hk5j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnDNzsQLxdMapNH/71lslPAnz50ve6F8F24vmF4RhuxGi5gjHJlzrZiBrggUgku2s
	 x8071VN2w+1y1jgkp94yET9tKXtctCdZWl2EXlkiXWvZJg/sMk7AWIEcQoiTVUKJcB
	 0mF6K/BRGR8qnfSXmxWyyl81NDfgS69Wu6MyuX7wQcbqq7/kMSRbPEZEM7rZ17E1dV
	 unH8z9CAEhh9upQOxTv1xe/ce5FzYBQQbc+eqqsKSKYzHnRbRHZFrHwTBBZDQQvF+w
	 TYCvAyfXtYb5H/RfTMKyJyxUGGnjOpU1qWC8TcD6YmmuI+GErtrZDsUYZq/QrMYdSC
	 f/DfRTk4GwPVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 12/14] x86/its: Add "vmexit" option to skip mitigation on some CPUs
Date: Wed, 14 May 2025 16:14:50 -0400
Message-Id: <20250514113553-1b5eef9d9e5a27d9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-12-90690efdc7e0@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 2665281a07e19550944e8354a2024635a7b2714a

Status in newer kernel trees:
6.14.y | Present (different SHA1: 674e6c3bd81b)
6.12.y | Present (different SHA1: 9a93b9857c62)
6.6.y | Present (different SHA1: 9af804172aad)
6.1.y | Present (different SHA1: c25e7a395933)

Note: The patch differs from the upstream commit:
---
1:  2665281a07e19 ! 1:  0fc464693aa0b x86/its: Add "vmexit" option to skip mitigation on some CPUs
    @@ Metadata
      ## Commit message ##
         x86/its: Add "vmexit" option to skip mitigation on some CPUs
     
    +    commit 2665281a07e19550944e8354a2024635a7b2714a upstream.
    +
         Ice Lake generation CPUs are not affected by guest/host isolation part of
         ITS. If a user is only concerned about KVM guests, they can now choose a
         new cmdline option "vmexit" that will not deploy the ITS mitigation when
    @@ Documentation/admin-guide/kernel-parameters.txt
     
      ## arch/x86/include/asm/cpufeatures.h ##
     @@
    - #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
    - #define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
    - #define X86_BUG_ITS			X86_BUG(1*32 + 6) /* "its" CPU is affected by Indirect Target Selection */
    -+#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 7) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
    + #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
    + #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
    + #define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
    ++#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* CPU is affected by ITS, VMX is not affected */
      #endif /* _ASM_X86_CPUFEATURES_H */
     
      ## arch/x86/kernel/cpu/bugs.c ##
    @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
      	ITS_MITIGATION_OFF,
     +	ITS_MITIGATION_VMEXIT_ONLY,
      	ITS_MITIGATION_ALIGNED_THUNKS,
    - 	ITS_MITIGATION_RETPOLINE_STUFF,
      };
      
      static const char * const its_strings[] = {
      	[ITS_MITIGATION_OFF]			= "Vulnerable",
     +	[ITS_MITIGATION_VMEXIT_ONLY]		= "Mitigation: Vulnerable, KVM: Not affected",
      	[ITS_MITIGATION_ALIGNED_THUNKS]		= "Mitigation: Aligned branch/return thunks",
    - 	[ITS_MITIGATION_RETPOLINE_STUFF]	= "Mitigation: Retpolines, Stuffing RSB",
      };
    + 
     @@ arch/x86/kernel/cpu/bugs.c: static int __init its_parse_cmdline(char *str)
      	} else if (!strcmp(str, "force")) {
      		its_cmd = ITS_CMD_ON;
    @@ arch/x86/kernel/cpu/common.c: static const __initconst struct x86_cpu_id cpu_vul
     +#define ITS_NATIVE_ONLY	BIT(9)
      
      static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
    - 	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
    + 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
     @@ arch/x86/kernel/cpu/common.c: static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
    - 	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,		      0xc,	MMIO | RETBLEED | GDS | SRBDS),
    - 	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS | ITS),
    --	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS | ITS | ITS_NATIVE_ONLY),
    -+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS | ITS | ITS_NATIVE_ONLY),
    - 	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED | ITS),
    - 	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    --	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS | ITS),
    --	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS | ITS | ITS_NATIVE_ONLY),
    -+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS | ITS | ITS_NATIVE_ONLY),
    - 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
    --	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS),
    -+	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
    - 	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS),
    - 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
    - 	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS),
    + 	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
    + 	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
    +-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
    ++	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
    + 	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    + 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
    + 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
    +-	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS),
    +-	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
    ++	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
    + 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
    +-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
    ++	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
    + 	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
    + 	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
    + 	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
     @@ arch/x86/kernel/cpu/common.c: static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
      	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
      		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

