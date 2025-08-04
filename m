Return-Path: <stable+bounces-166486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1AB1A3B8
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7663A7B9A
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514319258E;
	Mon,  4 Aug 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9DqGPSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029F257AF4;
	Mon,  4 Aug 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315090; cv=none; b=TbfpRCJm5XrKoQfFvBqvvzannlKYOBg8zUhfXPOO2qlHVNiH3nX/mfQP++0iSwa4ioblYZgUdiV7K1yzRbK1974D2Fr5/wxThewOwFo8zG8TbC/I+LZ+qN+MaJx4laVzm+kHjnNcxQMAIBN+FTldO4UyyrmlE1pQwTykYPiAU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315090; c=relaxed/simple;
	bh=ifyiaZ6ohicvjWnFAQooekE+FOO+AJ1tV8600HZz4TI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=EPwGpVEe/4fFWFBnY1riXndUQnX4fWxaoqlsjObTTpp1WOBNeXWuFz8NO5x/ztg8S3/FRb/82sngIgSGbsnRwoecTQ/fyutqYTum+pZhpMlFElgYMn6YrJjYxfYwKwQfinoVI1styrOUHm8GFrFEHwFWArOLJg3rwzuDdzqoYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9DqGPSm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31ec95ad016so3493127a91.3;
        Mon, 04 Aug 2025 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754315088; x=1754919888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbjHGtxazHcgW4FC0Q6CPW53runGoMNDTkyj1NYqusc=;
        b=E9DqGPSmTI61ZbTQtX2+KXLBzBtYiAbryQU/o5d3iDqScCTDijSAryhAdJk4G0f4q/
         qtNDF58jCqvsCo/8eVsFmGhilhbonVbviKlqxjvBDza+4PmJmV4RYOTGdZEgv7ofl5KP
         2pS0QS2aIDb5U4b34/GHhOtyIejrMtoFCkTa3WWKKnXyjc0RFItDrwKQ9riMAAvHVmQE
         Lh1n7ROEmcPhTEI0dqA+fRhVqWKuRz5whcboOivkRhOv6EjH5l0LVb4dHRFJpHdvgnWW
         W+WOtIOI8P1xCwhSXQkKK2wm5vvppAQzgPfiOYhlx0Qc3X4LBjMETGLFfyknZ1x2PHih
         TRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315088; x=1754919888;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbjHGtxazHcgW4FC0Q6CPW53runGoMNDTkyj1NYqusc=;
        b=DuQ7sClfPCoRkmBES87C3Cw4/j8hWblJCd9jx+oTiWLqJg53H2df4qHsYajoJYlMEx
         ca4WkTG/Vpc5/wRqpBq60hFoVgxtrRcce6zw+FT5bnnmzu7NB9PYK/L8rNcaXN9JRF2s
         /regyRLTjOg/e/zY3Svtj3WUmMoYlCQSGGBOVyCcNUFpP13PtkYQy6r67ZCe233EdYEb
         cywQR+5o7SeEDj4r9EqVlf4lDHLNeCO2N7WudpwWb6lPexaGy4hWxvvSQaJYgyilUZqa
         cuP/q2I8TYbNvG+S7gRO63eVXbY3fYSaxrx5wHRn+hdjsQ0hsmQKvMmOiTkBxFq1SELX
         FwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6o1Z+7zgOg05c0XP9D0LOOilsm2CUHeA+NmAgGLwnUSY/HlHloAhJfdW0KjVpyazmRW25vjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGb3eZ5JxEJuDjxoV/0CM3eN5a5CMXWpBBM6RKt5HaHL/cToC
	GcE/usDr4KpPV/SV/zt1yBmMCO4YC1HRNduj9y2r5cO8P+XGsEAeMplXeqNryw==
X-Gm-Gg: ASbGnctN3v8i5g5FdJx6ZeEZHYTfV8vMwP8z1dkM68thXlB9JoPjNvLWWhkcr9xr+Cx
	jhZUZu4J+4iC+AOPfggJNTUItLpYoQFtKrS+LBV4Q6yOGPEWy8d4eYu7M8N4brD8lS+xT9EkG3u
	CXqWP1uZ85NPnwZcISOV1DSpsb6JTi7tV1q4mlONyAkDuLsQ1Q0/4KCY8brpX4TMKpME2n+c+dG
	nDx7BkYSvEQvtjOxY9Gqzt/Tgsv+QMcMb2gR3nkcL6bZ67PcuD4ZYw3jslQRmpRf+02h9hWx6I8
	j0Nr8/a5XI8QhSWuCqpWtBlj62OhS6daJLkT0kcZc5tfD4ipceS5CXI2HYvgNVnHFtbFEsmuhZ6
	hJk1O61c3Cvc56ak=
X-Google-Smtp-Source: AGHT+IFq1KmzNhGvtVs66984a9NOv5sMOibe6BOHQkO/gTQ3VhIt+ij4VgBQzxQcMG6vJun+OW1OGQ==
X-Received: by 2002:a17:90b:4397:b0:31f:346:c670 with SMTP id 98e67ed59e1d1-321162cd915mr10139822a91.30.1754315087651;
        Mon, 04 Aug 2025 06:44:47 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6ac8sm11655474a91.1.2025.08.04.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:44:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, Donet Tom <donettom@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Vishal Chourasia <vishalc@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: Fix SLB multihit issue during SLB preload
In-Reply-To: <DBTN94725QGF.9OV4JD5UDTHL@gmail.com>
Date: Mon, 04 Aug 2025 18:50:08 +0530
Message-ID: <87cy9b441j.fsf@gmail.com>
References: <20250801103747.21864-1-donettom@linux.ibm.com> <DBTN94725QGF.9OV4JD5UDTHL@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Nicholas Piggin" <npiggin@gmail.com> writes:

> Hmm, interesting bug. Impressive work to track it down.
>

Thanks Nick for taking a look at it.

> On Fri Aug 1, 2025 at 8:37 PM AEST, Donet Tom wrote:
>> On systems using the hash MMU, there is a software SLB preload cache that
>> mirrors the entries loaded into the hardware SLB buffer. This preload
>> cache is subject to periodic eviction — typically after every 256 context
>> switches — to remove old entry.
>>
>> To optimize performance, the kernel skips switch_mmu_context() in
>> switch_mm_irqs_off() when the prev and next mm_struct are the same.
>> However, on hash MMU systems, this can lead to inconsistencies between
>> the hardware SLB and the software preload cache.
>>
>> If an SLB entry for a process is evicted from the software cache on one
>> CPU, and the same process later runs on another CPU without executing
>> switch_mmu_context(), the hardware SLB may retain stale entries. If the
>> kernel then attempts to reload that entry, it can trigger an SLB
>> multi-hit error.
>>
>> The following timeline shows how stale SLB entries are created and can
>> cause a multi-hit error when a process moves between CPUs without a
>> MMU context switch.
>>
>> CPU 0                                   CPU 1
>> -----                                    -----
>> Process P
>> exec                                    swapper/1
>>  load_elf_binary
>>   begin_new_exc
>>     activate_mm
>>      switch_mm_irqs_off
>>       switch_mmu_context
>>        switch_slb
>>        /*
>>         * This invalidates all
>>         * the entries in the HW
>>         * and setup the new HW
>>         * SLB entries as per the
>>         * preload cache.
>>         */
>> context_switch
>> sched_migrate_task migrates process P to cpu-1
>>
>> Process swapper/0                       context switch (to process P)
>> (uses mm_struct of Process P)           switch_mm_irqs_off()
>>                                          switch_slb
>>                                            load_slb++
>>                                             /*
>>                                             * load_slb becomes 0 here
>>                                             * and we evict an entry from
>>                                             * the preload cache with
>>                                             * preload_age(). We still
>>                                             * keep HW SLB and preload
>>                                             * cache in sync, that is
>>                                             * because all HW SLB entries
>>                                             * anyways gets evicted in
>>                                             * switch_slb during SLBIA.
>>                                             * We then only add those
>>                                             * entries back in HW SLB,
>>                                             * which are currently
>>                                             * present in preload_cache
>>                                             * (after eviction).
>>                                             */
>>                                         load_elf_binary continues...
>>                                          setup_new_exec()
>>                                           slb_setup_new_exec()
>>
>>                                         sched_switch event
>>                                         sched_migrate_task migrates
>>                                         process P to cpu-0
>>
>> context_switch from swapper/0 to Process P
>>  switch_mm_irqs_off()
>>   /*
>>    * Since both prev and next mm struct are same we don't call
>>    * switch_mmu_context(). This will cause the HW SLB and SW preload
>>    * cache to go out of sync in preload_new_slb_context. Because there
>>    * was an SLB entry which was evicted from both HW and preload cache
>>    * on cpu-1. Now later in preload_new_slb_context(), when we will try
>>    * to add the same preload entry again, we will add this to the SW
>>    * preload cache and then will add it to the HW SLB. Since on cpu-0
>>    * this entry was never invalidated, hence adding this entry to the HW
>>    * SLB will cause a SLB multi-hit error.
>>    */
>> load_elf_binary continues...
>>  START_THREAD
>>   start_thread
>>    preload_new_slb_context
>>    /*
>>     * This tries to add a new EA to preload cache which was earlier
>>     * evicted from both cpu-1 HW SLB and preload cache. This caused the
>>     * HW SLB of cpu-0 to go out of sync with the SW preload cache. The
>>     * reason for this was, that when we context switched back on CPU-0,
>>     * we should have ideally called switch_mmu_context() which will
>>     * bring the HW SLB entries on CPU-0 in sync with SW preload cache
>>     * entries by setting up the mmu context properly. But we didn't do
>>     * that since the prev mm_struct running on cpu-0 was same as the
>>     * next mm_struct (which is true for swapper / kernel threads). So
>>     * now when we try to add this new entry into the HW SLB of cpu-0,
>>     * we hit a SLB multi-hit error.
>>     */
>
> Okay, so what happens is CPU0 has SLB entries remaining from when
> P last ran on there, and the preload aging happens on CPU1 at a
> time when that CPU does clear its SLB. That slb aging step doesn't
> account for the fact CPU0 SLB entries still exist.

Yes, that is right.

>>
>> WARNING: CPU: 0 PID: 1810970 at arch/powerpc/mm/book3s64/slb.c:62
>> assert_slb_presence+0x2c/0x50(48 results) 02:47:29 [20157/42149]
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 1810970 Comm: dd Not tainted 6.16.0-rc3-dirty #12
>> VOLUNTARY
>> Hardware name: IBM pSeries (emulated by qemu) POWER8 (architected)
>> 0x4d0200 0xf000004 of:SLOF,HEAD hv:linux,kvm pSeries
>> NIP:  c00000000015426c LR: c0000000001543b4 CTR: 0000000000000000
>> REGS: c0000000497c77e0 TRAP: 0700   Not tainted  (6.16.0-rc3-dirty)
>> MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER: 00000000
>> CFAR: c0000000001543b0 IRQMASK: 3
>> <...>
>> NIP [c00000000015426c] assert_slb_presence+0x2c/0x50
>> LR [c0000000001543b4] slb_insert_entry+0x124/0x390
>> Call Trace:
>>   0x7fffceb5ffff (unreliable)
>>   preload_new_slb_context+0x100/0x1a0
>>   start_thread+0x26c/0x420
>>   load_elf_binary+0x1b04/0x1c40
>>   bprm_execve+0x358/0x680
>>   do_execveat_common+0x1f8/0x240
>>   sys_execve+0x58/0x70
>>   system_call_exception+0x114/0x300
>>   system_call_common+0x160/0x2c4
>>
>> To fix this issue, we add a code change to always switch the MMU context on
>> hash MMU if the SLB preload cache has aged. With this change, the
>> SLB multi-hit error no longer occurs.
>>
>> cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> cc: Michael Ellerman <mpe@ellerman.id.au>
>> cc: Nicholas Piggin <npiggin@gmail.com>
>> Fixes: 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")
>> cc: stable@vger.kernel.org
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>
>> v1 -> v2 : Changed commit message and added a comment in
>> switch_mm_irqs_off()
>>
>> v1 - https://lore.kernel.org/all/20250731161027.966196-1-donettom@linux.ibm.com/
>> ---
>>  arch/powerpc/mm/book3s64/slb.c | 2 +-
>>  arch/powerpc/mm/mmu_context.c  | 7 +++++--
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
>> index 6b783552403c..08daac3f978c 100644
>> --- a/arch/powerpc/mm/book3s64/slb.c
>> +++ b/arch/powerpc/mm/book3s64/slb.c
>> @@ -509,7 +509,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>>  	 * SLB preload cache.
>>  	 */
>>  	tsk->thread.load_slb++;
>> -	if (!tsk->thread.load_slb) {
>> +	if (tsk->thread.load_slb == U8_MAX) {
>>  		unsigned long pc = KSTK_EIP(tsk);
>>  
>>  		preload_age(ti);
>> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
>> index 3e3af29b4523..95455d787288 100644
>> --- a/arch/powerpc/mm/mmu_context.c
>> +++ b/arch/powerpc/mm/mmu_context.c
>> @@ -83,8 +83,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>>  	/* Some subarchs need to track the PGD elsewhere */
>>  	switch_mm_pgdir(tsk, next);
>>  
>> -	/* Nothing else to do if we aren't actually switching */
>> -	if (prev == next)
>> +	/*
>> +	 * Nothing else to do if we aren't actually switching and
>> +	 * the preload slb cache has not aged
>> +	 */
>> +	if ((prev == next) && (tsk->thread.load_slb != U8_MAX))
>>  		return;
>>  
>>  	/*
>
> I see couple of issues with this fix. First of all, it's a bit wrong to
> call switch subsequent switch_mm functions if prev == next, they are not
> all powerpc specific. We could work around that somehow with some hash
> specific knowledge. But worse I think is that load_slb could be
> incremented again if we context switched P again before migrating back
> here, then we would miss it.

Aah right. Got too involved in the issue, missed to see that coming.
You are right, if the process is context switched twice before coming
back on the original cpu (while still in load_elf_binary() path), we can
still hit the same issue. Though it's probablity of hitting must be very
low, but it is still possible.

>
> How about removing preload_new_slb_context() and slb_setup_new_exec()
> entirely? Then slb preload is a much simpler thing that is only loaded
> after the SLB has been cleared. Those functions were always a bit
> janky and for performance, context switch is the most improtant I think,
> new thread/proc creation less so.

Thanks for the suggestion. Right the above changes should not affect
context switch which is more performance critical. 

I agree, removing these two functions should solve the reported problem,
since these two are the only callers where we don't invalidate the HW
SLB before preloading. switch_slb() on the other hand takes care of
that (which gets called during context switch).

I see in the original commit - you had measured context_switch benchmark
which showed 27% performance improvement. Was this context_switch in
will-it-scale?
Is there any workload which you think we could run to confirm that no
regression should be observed with these changes (including for
proc/thread creation?)

>
> Thanks,
> Nick

Thanks again for taking a look. Appreciate your help!

-ritesh

