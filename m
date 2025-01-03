Return-Path: <stable+bounces-106706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D32A00AE5
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B0A163C99
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4B11FA831;
	Fri,  3 Jan 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Nzy7uD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E21F9F73
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916121; cv=none; b=mtGAlJQlkDNAbzuQuEdGG8aEUlQQkdF3LzwXkVKADqOq6Sr7lQ3musFgRP9FzhOca8pg/E2BHqSYBnWYP6pNb2RMqQD/zUuanM90WsdDy/tCzf3d27njtQ5yiKrRWxY2Ur9YK1Unwch02xxfLG31fhx9c1FgmHongOKGGgGjIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916121; c=relaxed/simple;
	bh=lXpAmAAj3nZcalBw33BfHeqfo23aqS/fs56/ET6BntU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlwx8jC0gWG3pxN0U6HWwnWSX/PWnUDlEPeMPeeyLdPUHOoO2T0HJ/dHb+fDaj7NGZwawyDKvpC41S8geL7RtbcgmIW95qk/JTQ2sLA+mWgIGPx+qIljJVK28A+U0RVEaFeC6aGIpfUwbed8ZM58sMpVGU2EMZGX58TVUWJKq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Nzy7uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B39C4CECE;
	Fri,  3 Jan 2025 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916119;
	bh=lXpAmAAj3nZcalBw33BfHeqfo23aqS/fs56/ET6BntU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0Nzy7uDxI8rIKoOc3QI4K+y1Gu+xscK/k3tghXCppglMYjvqlNk3pzJ+Mc7BMB+2
	 dCnzEVe7MO6vXFL7J6Nx80xjGlO+StErFGXHJdYodAP2C83ShY2Y5I9sUOXkDJRPOn
	 baSOfZPMCnkJKl6wA1UhDea+6dZflfjZZkZA7oiVAIm47D31eKukPS9vKRCKOx5Nbj
	 kWUosa62L41V08angj/DuVdbq+yq6u0pzV5oPFtYpPyebCckvn5wWDncjm0f+BzzYe
	 UaEmZ9hldYalL/uapJITwdVDD12wB8hnUV5skJJ1ANbHGVUkmTarP0HmLiGw1k2SlJ
	 Qg7ihajXltPhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] x86/hyperv: Fix hv tsc page based sched_clock for hibernation
Date: Fri,  3 Jan 2025 09:55:18 -0500
Message-Id: <20250103090012-8f5cd47e22abd2fd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250103051845.1952-1-namjain@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: bcc80dec91ee745b3d66f3e48f0ec2efdea97149


Status in newer kernel trees:
6.12.y | Present (different SHA1: bacd0498dea0)
6.6.y | Present (different SHA1: 4c8d45af23c2)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bcc80dec91ee ! 1:  b992b4219991 x86/hyperv: Fix hv tsc page based sched_clock for hibernation
    @@ Commit message
         Link: https://lore.kernel.org/r/20240917053917.76787-1-namjain@linux.microsoft.com
         Signed-off-by: Wei Liu <wei.liu@kernel.org>
         Message-ID: <20240917053917.76787-1-namjain@linux.microsoft.com>
    +    (cherry picked from commit bcc80dec91ee745b3d66f3e48f0ec2efdea97149)
    +    Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
     
      ## arch/x86/kernel/cpu/mshyperv.c ##
     @@ arch/x86/kernel/cpu/mshyperv.c: static void hv_machine_crash_shutdown(struct pt_regs *regs)
      	hyperv_cleanup();
      }
    - #endif /* CONFIG_CRASH_DUMP */
    + #endif /* CONFIG_KEXEC_CORE */
     +
     +static u64 hv_ref_counter_at_suspend;
     +static void (*old_save_sched_clock_state)(void);
    @@ arch/x86/kernel/cpu/mshyperv.c: static void __init ms_hyperv_init_platform(void)
      	/* Register Hyper-V specific clocksource */
      	hv_init_clocksource();
     +	x86_setup_ops_for_tsc_pg_clock();
    - 	hv_vtl_init_platform();
      #endif
      	/*
    + 	 * TSC should be marked as unstable only after Hyper-V
     
      ## drivers/clocksource/hyperv_timer.c ##
     @@
    @@ drivers/clocksource/hyperv_timer.c
      /*
       * If false, we're using the old mechanism for stimer0 interrupts
     @@ drivers/clocksource/hyperv_timer.c: static void resume_hv_clock_tsc(struct clocksource *arg)
    - 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
    + 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
      }
      
     +/*
    @@ drivers/clocksource/hyperv_timer.c: static void resume_hv_clock_tsc(struct clock
      {
     
      ## include/clocksource/hyperv_timer.h ##
    -@@ include/clocksource/hyperv_timer.h: extern void hv_remap_tsc_clocksource(void);
    - extern unsigned long hv_get_tsc_pfn(void);
    +@@ include/clocksource/hyperv_timer.h: extern void hv_init_clocksource(void);
    + 
      extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
      
     +extern void hv_adj_sched_clock_offset(u64 offset);
     +
    - static __always_inline bool
    - hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
    - 		     u64 *cur_tsc, u64 *time)
    + static inline notrace u64
    + hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
    + {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

