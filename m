Return-Path: <stable+bounces-118495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92CA3E311
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5339618977C6
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23949213E60;
	Thu, 20 Feb 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5amIv4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDC213248
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073979; cv=none; b=Gn90RMQpLTNjqDwp+9To2vPYohwNxB+iA9WyhXxTXuE8ABOF1xcZ0XEJDlfIMZAJ2DvCDtgGAOqIG3dS/LRrEc/QsB0dPhqFIQ/ofG4A1bWhQt78+5V9VZZ8IPmHxT3MKsPy/T4//HvQE9NyYPF6iQngP9MyDusQGNiS57+XNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073979; c=relaxed/simple;
	bh=PGZF7KXHTFCRXjwnjV3iglI7JZ+RilJzbgse6IZnRUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4uy67x+lQkiqe/nXm0NYVv33rzz+roz+DcNwO/BmZsupsyQkyR0tAUubZ3oIQwOF+g5IBY5L+/6kGt3Dba3EdLWPersp5ZELWikIKuj/Lswda2KK0hH/dQUD9tlg+SjSt9STG5QLYDTmKI7I2p2pPcPQc5j4hBdH35DdA4yOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5amIv4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC35C4CED1;
	Thu, 20 Feb 2025 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740073979;
	bh=PGZF7KXHTFCRXjwnjV3iglI7JZ+RilJzbgse6IZnRUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5amIv4rQRnNVnl6s21A568A78e35mziE4ycv5ozzyavPW3VRBc/935upAGIDM4OE
	 bnHQ2UalZkfwdQe6IaGWt4c7Ns2sRB8Im9/H6/OaLGBbdAiSFfRwbEeOKVqw9vSzdX
	 LlxHC7F/Fwzj84htkYxGhHPdotgUjn7Pses7E9/syHijHJGzed+QBL4Zt0X1FC0FBq
	 V8j9/d4veu0w188h2a8UcxgAOMUaKoeBgWKyiIPul/4+r6KccFFunahSv0v4wWvgca
	 iAr/6crfKRtzX6OXHcQCOm1geF6UdP6ZComBtH5YRA+zDigJcawnqd2oQqdKeyU34J
	 EPDvUCdCfKsbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kan.liang@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 20 Feb 2025 12:52:55 -0500
Message-Id: <20250220125125-1b78676eee2a15b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250220163146.3030320-1-kan.liang@linux.intel.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 47a973fd75639fe80d59f9e1860113bb2a0b112b

Note: The patch differs from the upstream commit:
---
1:  47a973fd75639 ! 1:  23cc70d16b75c perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
    @@ Commit message
         Link: https://lkml.kernel.org/r/20250129154820.3755948-3-kan.liang@linux.intel.com
     
      ## arch/x86/events/intel/core.c ##
    -@@ arch/x86/events/intel/core.c: static inline bool intel_pmu_broken_perf_cap(void)
    +@@ arch/x86/events/intel/core.c: static void intel_pmu_check_num_counters(int *num_counters,
      
      static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
      {
    --	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
    +-	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
    +-	unsigned int eax, ebx, ecx, edx;
     +	unsigned int cntr, fixed_cntr, ecx, edx;
     +	union cpuid35_eax eax;
     +	union cpuid35_ebx ebx;
      
    --	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
    -+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
    - 
    --	if (ebx & ARCH_PERFMON_EXT_UMASK2)
    -+	if (ebx.split.umask2)
    - 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
    --	if (ebx & ARCH_PERFMON_EXT_EQ)
    -+	if (ebx.split.eq)
    - 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
    - 
     -	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
    ++	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
    ++
     +	if (eax.split.cntr_subleaf) {
      		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
     -			    &eax, &ebx, &ecx, &edx);
    --		pmu->cntr_mask64 = eax;
    --		pmu->fixed_cntr_mask64 = ebx;
    +-		pmu->num_counters = fls(eax);
    +-		pmu->num_counters_fixed = fls(ebx);
     +			    &cntr, &fixed_cntr, &ecx, &edx);
    -+		pmu->cntr_mask64 = cntr;
    -+		pmu->fixed_cntr_mask64 = fixed_cntr;
    ++		pmu->num_counters = fls(cntr);
    ++		pmu->num_counters_fixed = fls(fixed_cntr);
    + 		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
    +-					     &pmu->intel_ctrl, ebx);
    ++					     &pmu->intel_ctrl, fixed_cntr);
      	}
    + }
      
    - 	if (!intel_pmu_broken_perf_cap()) {
     
      ## arch/x86/include/asm/perf_event.h ##
     @@ arch/x86/include/asm/perf_event.h: union cpuid10_edx {
       * detection/enumeration details:
       */
      #define ARCH_PERFMON_EXT_LEAF			0x00000023
    --#define ARCH_PERFMON_EXT_UMASK2			0x1
    --#define ARCH_PERFMON_EXT_EQ			0x2
     -#define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
      #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

