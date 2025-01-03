Return-Path: <stable+bounces-106708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F27A00AE8
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D13A42AD
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DE1FA84A;
	Fri,  3 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VucTsBGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDAE17FE
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916124; cv=none; b=OMeICBp+i+M1C3h9gu7QXkU0MzECEtfs2jJ0nx0TkIa/q2Mwe8UX1S+M7oSoYSpz9/xKv66k6ipUCnEep0XZmYbcx9Ui77aCbPV8w3qhuFhoserHblk7TzR7k78NlmOiiISd7NMU0WoI7uXadkjgXrOcvzsq2EpjHhy78kSRalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916124; c=relaxed/simple;
	bh=Ljy7zt/OBwHaAK54VLv+PyMwGgLa1TzCjDdM2Bk7c2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDtxLNU1m88vIgUGPnEJcSK5utU9JgnRsv5expKZnrs/6oN5/0B4mni1I+dL9zlDz/fy4VTirJpeHgFnMv1jDCP3cOJFrjUtZJu63dba73UQoV5+ilpAwTgi2J9o54aZbl8uerFxqw02R5y+gmvl+pDe+r6CtgSGXiJO1rjl9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VucTsBGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1824C4CECE;
	Fri,  3 Jan 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916124;
	bh=Ljy7zt/OBwHaAK54VLv+PyMwGgLa1TzCjDdM2Bk7c2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VucTsBGaj9DabHZq3T51vsEjvp1UlJ80Z7v7z/8h05SGmRtcdUjWdEEUl9m4/IEGM
	 ewNLzKJjMCbdxahCd82luysegUugrW0ajNWwJ4kHJIrDpKwNL9FoWZE0DeSDsB9g94
	 F6KEsM8OaFl7zFdEWotif2QmSmiL1dFAlHrSLx+wuy/Pe18yJxEQDGs8Imeuc7hzRV
	 hncKTK/350VTu6c+tdEZwRHMNnum9t2YZW/MGxzSdtIHru1wRKJAyd3EKhbStK/OJX
	 R4gEymXefWuHTTh3d+B+83VSCQ7qUohbdNmBiMFlFNRwCAIwkZbcwCpqLQID+c4J/R
	 nEyuFik8Z1YlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] x86/hyperv: Fix hv tsc page based sched_clock for hibernation
Date: Fri,  3 Jan 2025 09:55:22 -0500
Message-Id: <20250102145407-b7cbcab3100755ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250102144218.1848-1-namjain@linux.microsoft.com>
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

Note: The patch differs from the upstream commit:
---
1:  bcc80dec91ee ! 1:  549d5b40b85d x86/hyperv: Fix hv tsc page based sched_clock for hibernation
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
    + 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
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
| stable/linux-6.1.y        |  Success    |  Success   |

