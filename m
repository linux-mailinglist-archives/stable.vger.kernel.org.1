Return-Path: <stable+bounces-106709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A2A00AEA
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7503A42BD
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A391FA8E2;
	Fri,  3 Jan 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2VAJ4/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E91FA82F
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916130; cv=none; b=g0uunutn30rQs+hoQK3DhpNhwO06nQW+x1Bqz4Cwng409rRcwN3PP0f4wFNohXmJ26UiTNRyeFmeF5D7aMXTWC06HchOSYttuNn+Ah9nL5mIu61sf3ysoVvg3gFa2U+OuBhV85qXQy7NE75Z7Aqpa0bxeMPv0K4FImitXl7dTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916130; c=relaxed/simple;
	bh=uRNno6IZOYeyxWdazz9wgcopCZO1w2wY3Ofv8b+N7Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPN7qSELRtideLGB5yrgAkJKqaY6wJ8RI9ZFWuRYbeKMHft5fXw1NSfhlQ96J8qGAfe1v6nflaV7Maz6z1BJw9351E1PEgw1R+6juxrhugzz4lRY1G05+6Qi/kn0ZVkOFS7uxyPPsHRoFS/N35FJaSQahcxnz3Hzm/OMR4LhpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2VAJ4/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B49C4CECE;
	Fri,  3 Jan 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916128;
	bh=uRNno6IZOYeyxWdazz9wgcopCZO1w2wY3Ofv8b+N7Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2VAJ4/vcM10qGFJmXFxpKGDT3ZTPd3DacYXRJ73ijkCc8LcKsF4Zs98fAqRsXJ83
	 JC4JDTjyLJcrZ5tOwjhPIZ5r8JOUb4/teTj2VuoUZb1PaZ4uBX9N/VzmyUL+H+Xqah
	 Qy1yk++gUtelKLa2MFAhjiBTvp3UdiIw44HJIPgYUp7OuBxi+rE8EHlB87W+k7Lho8
	 b4djRKllG3ITP1PRBTLpoDcA7GkDX95SRkAo/dZL1a8ws0nJBHSNrieBK9viUwEFbX
	 QkpPgtDdKGNW1OCfIWbgkmp29LoLyopK6mrkgsydYaWrHOczGslKm3Rb6N/j/Q6Ubu
	 EQDICrp2qJ/8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/hyperv: Fix hv tsc page based sched_clock for hibernation
Date: Fri,  3 Jan 2025 09:55:26 -0500
Message-Id: <20250102144247-72dffb843cf3d817@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250102141157.1785-1-namjain@linux.microsoft.com>
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

Note: The patch differs from the upstream commit:
---
1:  bcc80dec91ee ! 1:  cc5a1702c099 x86/hyperv: Fix hv tsc page based sched_clock for hibernation
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
    @@ drivers/clocksource/hyperv_timer.c
      /*
       * If false, we're using the old mechanism for stimer0 interrupts
     @@ drivers/clocksource/hyperv_timer.c: static void resume_hv_clock_tsc(struct clocksource *arg)
    - 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
    + 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
      }
      
     +/*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

