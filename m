Return-Path: <stable+bounces-144426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05568AB768C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477188C5B8F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6490295510;
	Wed, 14 May 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snr8idrr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CE295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253616; cv=none; b=IH2Kr6S7V+JBq8KKaL64U6XtcWsTx4yIU510jcrIXeoT5IpAoJySkfNNGqW8eSBc04+/3xANey2hJOt2PWNxP+9/ieWQUmclM3jkhQ5czfSZCSPHVIUZsaIBicAJ97pgbRCIW1CLIb4+fyN3LUVMOR77xwEbIpOcm7wFl5oAcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253616; c=relaxed/simple;
	bh=ynW6C8X3AIwBMF7wZD2NOC+ANgkNZ9cdsuIeHZZaFKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5dubQB39mYb3pAdWzEJEg40xCQTYV4qa3OQNSoKT6BUXCtuKa3a7cfaaiK9DyP06hAUE1mStIYxDlE250ZgtPHGR1YaSEiZx6BwFSD1hxaL42FbmgTt8YpSW5x/NxY4mgOd4bVUKsAm5FGjaRydV5f6Pun22lhaeEsvELHGFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snr8idrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4393C4CEE3;
	Wed, 14 May 2025 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253616;
	bh=ynW6C8X3AIwBMF7wZD2NOC+ANgkNZ9cdsuIeHZZaFKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snr8idrrT0ckpHxlrp+50XSoL9HKdtHn3+vi6e0Uu4nvYyrPHjx15pIcv+aORvZC7
	 qK0U8OSNFpHOdOdU8yvgPuL1nw5C7hmWCetE3J1z57Z5lNpNuwYrJ2cKDDAKWlMrqm
	 qF6HfQrOwHUoqa4pcvZXyIFgp6xJ6ZFKmw8A6wlrs+mQMpLKGIR70ai87fLgl4AsX9
	 dje0LBp27vgdqZQzq81NoJeDQZ3DGjURObODC1lodn1aETUCiu6MORYdq/LNclIjSr
	 evncVskpr8U8DE2cajdxfh3KF5piD8vnAynqyMoe1rb3mzYbPbYBB2li79OwE2dl1/
	 yo/oOl2RTzpEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 06/14] x86/its: Enumerate Indirect Target Selection (ITS) bug
Date: Wed, 14 May 2025 16:13:34 -0400
Message-Id: <20250514111224-56ddad7b0a9de49b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-6-90690efdc7e0@linux.intel.com>
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
6.14.y | Present (different SHA1: 617f853a91e2)
6.12.y | Present (different SHA1: 7e48b06f89fd)
6.6.y | Present (different SHA1: daed6f610a3f)
6.1.y | Present (different SHA1: db884b7863a5)

Note: The patch differs from the upstream commit:
---
1:  159013a7ca18c ! 1:  6e3a785c926a0 x86/its: Enumerate Indirect Target Selection (ITS) bug
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

