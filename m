Return-Path: <stable+bounces-165759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D55B186BD
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7727C563CDB
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C61D5170;
	Fri,  1 Aug 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mncldl43"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E342065;
	Fri,  1 Aug 2025 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069489; cv=none; b=mw7tOJpX3/tRAB5+geDaUgdLIKQkwtmmaULheE1WjbUg2SjzhZaGzji0vy/6CDPyJSeeSIJOxQOxGwKdtEhWyOB8rTNN/1Bcs3sBHxN9elUJ6LD+o5vPbINsCZT9nVy583to5idnusoVLXdM4nJBpP3NA8xeMUXCH2dLOmSYdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069489; c=relaxed/simple;
	bh=6p5x1d/4VmlIH4ExUe3oL0Y5f3XnqxSn6nPpu6za/B0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=CW7YtwbEdyRQ68KOMn/zFtrye6PL4S1nEKjZ+JdyxxfFfcVvWKYqjep1P6faropB33CadeERFESkma/RYwU3AoZ3vmVDZcvo/kX5yaMEOBwDb+mQRIOHTcNK3pErGxnWPnjzs6B99fWVti+oHUASH3S1+s7rfWPwzFjgHpU6uPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mncldl43; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3220c39cffso1217480a12.0;
        Fri, 01 Aug 2025 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754069487; x=1754674287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYkhBI7Ln9fYlOieDEvuny+XS7GVAdJ2Y1G82qbanHk=;
        b=mncldl43iwPq72EFShj/IEq8apPvEbhI0+Rkcv/srhUFJMNCXzkhwwBKOP1AUBhSC2
         OqzaE2NLpPG+xGq+NrrKkzTiBpdEByIF0bz64S1wC/3nVEgfkqwhncolPrMCK4U1ALlU
         ovbpbg4/qCHLK5osq5A9dKm5vx1nhgZceMnh+HmF8VmIig4jMgPC3/tW1iorMldpSw3u
         lv1nwoPoBDQwrJDyKCpprvrdGRfAQ572MjIh6yxXnFWghvGWMeygynN1QAkQuEMpDWsm
         Rnoyjx0+pxeccYqSO6Dd/5eyOpieSCYRdJEtS+jUpMT+ngFU0QLXMyy0rDRwqtpXR94v
         xrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069487; x=1754674287;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYkhBI7Ln9fYlOieDEvuny+XS7GVAdJ2Y1G82qbanHk=;
        b=iWxzWgFWRF2g/kCCwKF+IGWKgDCS2z9uOhYpDBcGcKA8dO/kEEkqXeDumHQRAQ427e
         1U1q9/P7bgMzJmKcyO5rKWCMI1yVF5fhr99KZ8aC1+rSAc7dsQKHZHnRL4usL61HGE3h
         IZBb1gPznZtTCZ0Jb1SyGYj+nniVOBkZJO/4FGDCuwyIMzZRUxZJD2Nro9Vt9D5AKOke
         CM7sNiBcyu0zNzbR2JQ2jS/7WHVIJtvYf+U/9jECyK0lCK1yLRt2Pun5j2tWTfnZfPvt
         YrjUbZHYS6pGvhgJcJgK4tQFgk8/pKmSCDWRmO+w6/8nmm2WiPIV8YUvcQl23gqKfU3d
         izCg==
X-Forwarded-Encrypted: i=1; AJvYcCWU9zIutOTFI9h/8pGDXyBODECKGXGBi3rNbRrf5He5H89jk5GsUmKB0JPEYJwvJdJDmXxbkVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnaY8FEOwsoUmtnrHEVCJnl81qbWTaHqCiIiXW3mtUftkilQl
	/6IpyVSFbDb1rfcRCI2owtx/rSzk1MaxjfUw13R/uVYuqhFfxvYohWFmO0Fvag==
X-Gm-Gg: ASbGncsG2SCP05/EHEKn8eoqkW+jZwrCAqjRdTo3TbTHf2+JMO6UCT8SwFDQIjEhLWK
	bYmd12dGDn+RD+wstqZfYkCUpAEVx493FVfRgyeeT81zXyiRf6fcsUE1Q37FjkJ2/Yvp9StZIBC
	ew4o9xuaMukF/0I2dj/pzkg+F1zoa+TAqF2k753q8LJNLJwpiekB5T1lGyswbPsjCeawy9zlSfJ
	sujyds56K7KjXN8WxQycpccBdlmknRS2VK+KYAQSEf0nkFk8aV9uffZ6tNUo1ICLnH2Q0dfvvNa
	Y4lwE3zs6yRgKLevSe4CGIoY1ZKsSqnUkDcjEzIsMDugNItCPJjFatoveUnIgUND8bvs+bQG/cy
	vTmYKO4HhbG2fNxg=
X-Google-Smtp-Source: AGHT+IEILVqTRLBBaQ0amWjTizr2ivYHmUAzrruxTd/9XNKSBJp43sLWgmmPtBYWsDPdQ0MV3QAGKg==
X-Received: by 2002:a17:90b:3ecb:b0:31e:c8fc:e62a with SMTP id 98e67ed59e1d1-32116315768mr748254a91.35.1754069486671;
        Fri, 01 Aug 2025 10:31:26 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bacbb74sm4183608a12.42.2025.08.01.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:31:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Vishal Chourasia <vishalc@linux.ibm.com>, Donet Tom <donettom@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: Fix SLB multihit issue during SLB preload
In-Reply-To: <20250801103747.21864-1-donettom@linux.ibm.com>
Date: Fri, 01 Aug 2025 22:56:37 +0530
Message-ID: <87qzxvq7g2.fsf@gmail.com>
References: <20250801103747.21864-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Donet Tom <donettom@linux.ibm.com> writes:

> On systems using the hash MMU, there is a software SLB preload cache that
> mirrors the entries loaded into the hardware SLB buffer. This preload
> cache is subject to periodic eviction — typically after every 256 context
> switches — to remove old entry.
>
> To optimize performance, the kernel skips switch_mmu_context() in
> switch_mm_irqs_off() when the prev and next mm_struct are the same.
> However, on hash MMU systems, this can lead to inconsistencies between
> the hardware SLB and the software preload cache.
>
> If an SLB entry for a process is evicted from the software cache on one
> CPU, and the same process later runs on another CPU without executing
> switch_mmu_context(), the hardware SLB may retain stale entries. If the
> kernel then attempts to reload that entry, it can trigger an SLB
> multi-hit error.
>
> The following timeline shows how stale SLB entries are created and can
> cause a multi-hit error when a process moves between CPUs without a
> MMU context switch.
>
> CPU 0                                   CPU 1
> -----                                    -----
> Process P
> exec                                    swapper/1
>  load_elf_binary
>   begin_new_exc
>     activate_mm
>      switch_mm_irqs_off
>       switch_mmu_context
>        switch_slb
>        /*
>         * This invalidates all
>         * the entries in the HW
>         * and setup the new HW
>         * SLB entries as per the
>         * preload cache.
>         */
> context_switch
> sched_migrate_task migrates process P to cpu-1
>
> Process swapper/0                       context switch (to process P)
> (uses mm_struct of Process P)           switch_mm_irqs_off()
>                                          switch_slb
>                                            load_slb++
>                                             /*
>                                             * load_slb becomes 0 here
>                                             * and we evict an entry from
>                                             * the preload cache with
>                                             * preload_age(). We still
>                                             * keep HW SLB and preload
>                                             * cache in sync, that is
>                                             * because all HW SLB entries
>                                             * anyways gets evicted in
>                                             * switch_slb during SLBIA.
>                                             * We then only add those
>                                             * entries back in HW SLB,
>                                             * which are currently
>                                             * present in preload_cache
>                                             * (after eviction).
>                                             */
>                                         load_elf_binary continues...
>                                          setup_new_exec()
>                                           slb_setup_new_exec()
>
>                                         sched_switch event
>                                         sched_migrate_task migrates
>                                         process P to cpu-0
>
> context_switch from swapper/0 to Process P
>  switch_mm_irqs_off()
>   /*
>    * Since both prev and next mm struct are same we don't call
>    * switch_mmu_context(). This will cause the HW SLB and SW preload
>    * cache to go out of sync in preload_new_slb_context. Because there
>    * was an SLB entry which was evicted from both HW and preload cache
>    * on cpu-1. Now later in preload_new_slb_context(), when we will try
>    * to add the same preload entry again, we will add this to the SW
>    * preload cache and then will add it to the HW SLB. Since on cpu-0
>    * this entry was never invalidated, hence adding this entry to the HW
>    * SLB will cause a SLB multi-hit error.
>    */
> load_elf_binary continues...
>  START_THREAD
>   start_thread
>    preload_new_slb_context
>    /*
>     * This tries to add a new EA to preload cache which was earlier
>     * evicted from both cpu-1 HW SLB and preload cache. This caused the
>     * HW SLB of cpu-0 to go out of sync with the SW preload cache. The
>     * reason for this was, that when we context switched back on CPU-0,
>     * we should have ideally called switch_mmu_context() which will
>     * bring the HW SLB entries on CPU-0 in sync with SW preload cache
>     * entries by setting up the mmu context properly. But we didn't do
>     * that since the prev mm_struct running on cpu-0 was same as the
>     * next mm_struct (which is true for swapper / kernel threads). So
>     * now when we try to add this new entry into the HW SLB of cpu-0,
>     * we hit a SLB multi-hit error.
>     */
>
> WARNING: CPU: 0 PID: 1810970 at arch/powerpc/mm/book3s64/slb.c:62
> assert_slb_presence+0x2c/0x50(48 results) 02:47:29 [20157/42149]
> Modules linked in:
> CPU: 0 UID: 0 PID: 1810970 Comm: dd Not tainted 6.16.0-rc3-dirty #12
> VOLUNTARY
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (architected)
> 0x4d0200 0xf000004 of:SLOF,HEAD hv:linux,kvm pSeries
> NIP:  c00000000015426c LR: c0000000001543b4 CTR: 0000000000000000
> REGS: c0000000497c77e0 TRAP: 0700   Not tainted  (6.16.0-rc3-dirty)
> MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER: 00000000
> CFAR: c0000000001543b0 IRQMASK: 3
> <...>
> NIP [c00000000015426c] assert_slb_presence+0x2c/0x50
> LR [c0000000001543b4] slb_insert_entry+0x124/0x390
> Call Trace:
>   0x7fffceb5ffff (unreliable)
>   preload_new_slb_context+0x100/0x1a0
>   start_thread+0x26c/0x420
>   load_elf_binary+0x1b04/0x1c40
>   bprm_execve+0x358/0x680
>   do_execveat_common+0x1f8/0x240
>   sys_execve+0x58/0x70
>   system_call_exception+0x114/0x300
>   system_call_common+0x160/0x2c4
>
> To fix this issue, we add a code change to always switch the MMU context on
> hash MMU if the SLB preload cache has aged. With this change, the
> SLB multi-hit error no longer occurs.
>
> cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> cc: Michael Ellerman <mpe@ellerman.id.au>
> cc: Nicholas Piggin <npiggin@gmail.com>
> Fixes: 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")
> cc: stable@vger.kernel.org
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>
> v1 -> v2 : Changed commit message and added a comment in
> switch_mm_irqs_off()
>
> v1 - https://lore.kernel.org/all/20250731161027.966196-1-donettom@linux.ibm.com/

Thanks for adding the details in the commit msg. The change looks good
to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

