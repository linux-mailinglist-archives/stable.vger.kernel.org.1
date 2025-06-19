Return-Path: <stable+bounces-154778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C00AE013D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A030177518
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE526E705;
	Thu, 19 Jun 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tli/WQf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0D261398
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323870; cv=none; b=njipV3acbxEQED1QleGNLr/uE3dTxy5wHksm7qlYNZYEVLxzzgRaOlRDAdHBIM4y4Xd0wyBt/J2vGNJ94GhesZuNOt803vWz0281jqewzS32F1zRwf2/eTdPbGuNj6rXqdCUymjodDzvX7xSn/HP3b3zk3pangeGHwFRXq5TqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323870; c=relaxed/simple;
	bh=Wf/l4bFh8xvHjCSBLWWDIP0OuQsw3+uFrX5mPQQZGVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQXualtJ/nZBg4MGsnQygGeYNswcVg3fGq5guKb8yNrm83mbBxVyaaXF3x3bYY2g3Rj2V13lWPM2SI948aQ6gIEERXUbMd5vhLZLwtH/8TzLUnQLQCu7nvHdZzVS6AhK25Vg3ZxX+XIpJ1a0LIIDTEB8zl8YXmQU2QJuzL5wCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tli/WQf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9ABC4CEEA;
	Thu, 19 Jun 2025 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323870;
	bh=Wf/l4bFh8xvHjCSBLWWDIP0OuQsw3+uFrX5mPQQZGVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tli/WQf9z3IcHMKak4xVGS9TfGxp4s6/PeESjGhwWUJz1kEieps8p9lnali8J+WDS
	 gaC0eZrzyG1pvOgt1z5+CGp9hS3tHxRK2rEzghZSUMdUio3eLKOw7E+kq+fCxtaJwL
	 oWjTzCJHZB/LQdW312Uba6Mv1oIlrRcjyzCe+sfovkK0bDMpu0VDxYIFT2d627Il2d
	 LqWxMWqjGuMozD/T7Jrh5yCIF9UvsYI/ctyK4ZRpojVfZHWxyV/pHFESTdzjeXxp1w
	 27CU5bcaHgDdHwGRZHoCb8dQs5VakvcGAqiNKoxrX4SF5xr2Une1UuJF5qRnUBcHu3
	 g1zmBNzJd87Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 02/16] x86/bhi: Define SPEC_CTRL_BHI_DIS_S
Date: Thu, 19 Jun 2025 05:04:28 -0400
Message-Id: <20250618165714-0c0214ee562bf47f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-2-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 0f4a837615ff925ba62648d280a861adf1582df7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Daniel Sneddon<daniel.sneddon@linux.intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c6e3d590d051)
6.1.y | Present (different SHA1: 29c50bb6fbe4)
5.15.y | Present (different SHA1: a9ca0e34a406)

Note: The patch differs from the upstream commit:
---
1:  0f4a837615ff9 ! 1:  3542cbefb1a99 x86/bhi: Define SPEC_CTRL_BHI_DIS_S
    @@ Metadata
      ## Commit message ##
         x86/bhi: Define SPEC_CTRL_BHI_DIS_S
     
    +    commit 0f4a837615ff925ba62648d280a861adf1582df7 upstream.
    +
         Newer processors supports a hardware control BHI_DIS_S to mitigate
         Branch History Injection (BHI). Setting BHI_DIS_S protects the kernel
         from userspace BHI attacks without having to manually overwrite the
    @@ Commit message
         Define MSR_SPEC_CTRL bit BHI_DIS_S and its enumeration CPUID.BHI_CTRL.
         Mitigation is enabled later.
     
    -    Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
    -    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    -    Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
         Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
         Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
    +    Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/cpufeatures.h ##
     @@
    -  */
    - #define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
    - #define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* "" Clear branch history at syscall entry using SW loop */
    -+#define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
    - 
    - /*
    -  * BUG word(s)
    + #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
    + #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
    + #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
    +-/* FREE!				(11*32+ 8) */
    ++#define X86_FEATURE_BHI_CTRL		(11*32+ 8) /* "" BHI_DIS_S HW control available */
    + /* FREE!				(11*32+ 9) */
    + #define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
    + #define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
     
      ## arch/x86/include/asm/msr-index.h ##
     @@
    @@ arch/x86/include/asm/msr-index.h
     
      ## arch/x86/kernel/cpu/scattered.c ##
     @@ arch/x86/kernel/cpu/scattered.c: static const struct cpuid_bit cpuid_bits[] = {
    + 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
      	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
    - 	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
      	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
     +	{ X86_FEATURE_BHI_CTRL,		CPUID_EDX,  4, 0x00000007, 2 },
      	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
      	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
      	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
    -
    - ## arch/x86/kvm/reverse_cpuid.h ##
    -@@ arch/x86/kvm/reverse_cpuid.h: enum kvm_only_cpuid_leafs {
    - #define X86_FEATURE_IPRED_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 1)
    - #define KVM_X86_FEATURE_RRSBA_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 2)
    - #define X86_FEATURE_DDPD_U		KVM_X86_FEATURE(CPUID_7_2_EDX, 3)
    --#define X86_FEATURE_BHI_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
    -+#define KVM_X86_FEATURE_BHI_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
    - #define X86_FEATURE_MCDT_NO		KVM_X86_FEATURE(CPUID_7_2_EDX, 5)
    - 
    - /* CPUID level 0x80000007 (EDX). */
    -@@ arch/x86/kvm/reverse_cpuid.h: static __always_inline u32 __feature_translate(int x86_feature)
    - 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
    - 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
    - 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
    -+	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
    - 	default:
    - 		return x86_feature;
    - 	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

