Return-Path: <stable+bounces-132165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBFA84906
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09EB1895C39
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C831EB5E6;
	Thu, 10 Apr 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZme/JOM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFE1E98FC
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300506; cv=none; b=DiAwtO/ntYIhQvC4BB2Dix49ZQy8T3i4zJD/QPbZbCI+smwjF8khDiNq9NY1SnHZkGj7IC8bIGpRM10YPf5ic/Oq3V2AK0HmqXZwrjzqyFcWQmBgZFHs9TtJlePAneOnSlsUYAO/yq+rq/moxZMZvdpr+ecOE6Sf2CoJDrFgfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300506; c=relaxed/simple;
	bh=SGkQBSQdcea13+tRcMAbtqCw080CzRG14B9wSvTbLUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIhCq5CNpKy05m72hnljYuhCLnyEKJ9Iqg86QcGczQBgiifVFIj8qYSl5LsCpHLfdHPh1Uq3T/wMDtNd1bIMcSH9Opb7h70sCwj/P9+L+6ltGv7dBgaP8x69xYeDIvvYYpTwykd+NmiMQg6XEUOYX5AFSRCMXbB4Y3+iVwiVO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZme/JOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071F3C4CEDD;
	Thu, 10 Apr 2025 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300506;
	bh=SGkQBSQdcea13+tRcMAbtqCw080CzRG14B9wSvTbLUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZme/JOMyvgo2UjHpKuW/7+0ajlk9D9KHXjMHsstOSe8uTMPR44vdxe5lP+woMk56
	 TAGgRZS5zx+Pm+v0/jmdBxQEQHnY2P3rE9nTKJBhOd9TLN5pR/mcIxRHZiP1FfjsAo
	 T7RS6ezCWTWsd1gWRF6n2l6I6QbPiysQn/1GXcqNV5D+pv7h1N0rgm+wfEPheEJDgo
	 NfrqWTBPJUzj7qZeiddfmOXtZj5oYsmnt85QikATuUXsonG4tU4UkL02WCpnpsCZN4
	 UsEIQuUT1YYFRikYPAkyA90qZNzj2TEBkBLnoXl62zHtltMyToiCaO37tc2M5YQSEK
	 8FFZ19d643hBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vannapurve@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
Date: Thu, 10 Apr 2025 11:55:04 -0400
Message-Id: <20250409225828-b7a54078f1a739bb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408134717.304476-1-vannapurve@google.com>
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

Found matching upstream commit: 9f98a4f4e7216dbe366010b4cdcab6b220f229c4

Status in newer kernel trees:
6.14.y | Present (different SHA1: 8defd0d8678b)
6.13.y | Present (different SHA1: f88759f8f742)
6.12.y | Present (different SHA1: 7aff5ffe2c87)

Note: The patch differs from the upstream commit:
---
1:  9f98a4f4e7216 ! 1:  882c95e29bbba x86/tdx: Fix arch_safe_halt() execution for TDX VMs
    @@ Commit message
         Cc: Josh Poimboeuf <jpoimboe@redhat.com>
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250228014416.3925664-3-vannapurve@google.com
    +    (cherry picked from commit 9f98a4f4e7216dbe366010b4cdcab6b220f229c4)
     
      ## arch/x86/Kconfig ##
     @@ arch/x86/Kconfig: config INTEL_TDX_GUEST
    @@ arch/x86/coco/tdx/tdx.c
      #include <asm/insn-eval.h>
     +#include <asm/paravirt_types.h>
      #include <asm/pgtable.h>
    - #include <asm/set_memory.h>
      #include <asm/traps.h>
    + 
     @@ arch/x86/coco/tdx/tdx.c: static int handle_halt(struct ve_info *ve)
      	return ve_instr_len(ve);
      }
    @@ arch/x86/coco/tdx/tdx.c: void __cpuidle tdx_safe_halt(void)
     +
      static int read_msr(struct pt_regs *regs, struct ve_info *ve)
      {
    - 	struct tdx_module_args args = {
    + 	struct tdx_hypercall_args args = {
     @@ arch/x86/coco/tdx/tdx.c: void __init tdx_early_init(void)
    - 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
    - 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
    + 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
    + 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
      
     +	/*
     +	 * Avoid "sti;hlt" execution in TDX guests as HLT induces a #VE that
    @@ arch/x86/include/asm/tdx.h: void tdx_get_ve_info(struct ve_info *ve);
      
      bool tdx_early_handle_ve(struct pt_regs *regs);
      
    -@@ arch/x86/include/asm/tdx.h: void __init tdx_dump_td_ctls(u64 td_ctls);
    +@@ arch/x86/include/asm/tdx.h: int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
      #else
      
      static inline void tdx_early_init(void) { };
    @@ arch/x86/include/asm/tdx.h: void __init tdx_dump_td_ctls(u64 td_ctls);
      
     
      ## arch/x86/kernel/process.c ##
    -@@ arch/x86/kernel/process.c: void __init select_idle_routine(void)
    +@@ arch/x86/kernel/process.c: void select_idle_routine(const struct cpuinfo_x86 *c)
      		static_call_update(x86_idle, mwait_idle);
      	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
      		pr_info("using TDX aware idle routine\n");
     -		static_call_update(x86_idle, tdx_safe_halt);
     +		static_call_update(x86_idle, tdx_halt);
    - 	} else {
    + 	} else
      		static_call_update(x86_idle, default_idle);
    - 	}
    + }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

