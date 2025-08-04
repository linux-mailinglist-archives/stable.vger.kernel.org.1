Return-Path: <stable+bounces-166478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125BAB1A171
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46563188C4C4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1325A354;
	Mon,  4 Aug 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4evbz4+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496825A340;
	Mon,  4 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310744; cv=none; b=lU3bUNM4/iZmLECS7yHxBnQX9LR2kdYwUvcURq0H1hr4t78Frgb06xaXJxrGbTQdJL/BMS2aJekAcQhHgKEDkBCLedWDSkEo192onKFgpdINf9/1mGTwQLchKd7TugG4HVg1fDRjOzfsRBDZwzNZBaAZenfBl8QCZudOU8C8Uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310744; c=relaxed/simple;
	bh=yvVCpYCSSpG3QD5gfhJuG34tQDBVyUgQjXi6RzTx/9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DtGc/12kB29jC7BN0p1gnxkDd8hYI7/Ddh2UCGXsLzDWIFd2J2kSJ6AqfGcRjSatLpzuRCT+eOBeyR5Gg6bKCde3m2DkE25MDiigKi3UaULENnyhFSHzFo3CbpNXwZ5mhnkRIVE83eBntGcYMn8tu0YXIERggrT42sfUetWX1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4evbz4+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3f80661991so3759328a12.0;
        Mon, 04 Aug 2025 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754310741; x=1754915541; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz81oS+khM9qasQTVZz4MiZgKna2JCQJHFNcckb6X6E=;
        b=Z4evbz4+ANuekToPaD5t1Pk10CXblyrO1RQbGIsv0hZABmx8s6fZRS+S44hbOA8iml
         WbjQeLOz6Wdt9bAPfZobFSsigO9vkE9KkjEM6uWZcQ7r9oP/en2POe6RnytWF6IaK1LG
         XIWiqjvwyYyvVwzs7m7pDMCA0BDfIl37qBwUWVQRVgIrhIvDPcTSb6uos6E6DMvpDpfR
         EXutn6Hj+GkkH3v7JVQMX8LGBqe6JirHlVmoIarE/SebER7qUnaf9dihxPOJ3GtG9DHx
         TQwfX9WAzM4+YtjyLmWAoanjvIyQnO/AYAUYopr4v/3EQeYsjx+NaaP3ag7gETqFoYI2
         jLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310741; x=1754915541;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sz81oS+khM9qasQTVZz4MiZgKna2JCQJHFNcckb6X6E=;
        b=qChrGc7Jzu14lwYelRAtiR98sx3J6JUF9utheopRni9tTSVdUYqS6MhLk7gq5MM5KB
         aQXi+QeQlavaVLzRoPAQNJ9eDnhBpBj0JWU4npkR/9HQN7TQEqWGIB02sZvjYesvhfVg
         jOHKe0Glj6kSKvWelF5D3jd5wtEzd2WlsnAjINTyyvJx02iezwl+a8liOw/rpWae5p7d
         mvuc8ZRhJHpvu1urWlBueQ8ZN6j+y9Fw7GpEyIlaTTTRm9sQ5AHc9RWusCyqHFmVZkWG
         yM0L9cZ9OYCkNQp+9IpH/mdOB9fW48llYnlu+8m7CALKKgT+mIbeu9JQRkk11p/9Mkbv
         1PVw==
X-Forwarded-Encrypted: i=1; AJvYcCULtEX8IWsAA6YJfWnRYwcEEOtBS6SkbMthOdaKOIoK1siFHsXbDyQmEXsbrnFTrLUodpvsWhE/@vger.kernel.org, AJvYcCWmZtY63IC9Xcff/VJ8/oX7RnLBcHJRZlVlfdUH5+N3Kasq3WcK3hdwLipfN7BO5DW/rURIq5g7ip5Gz9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30a08OBuXNfrXLrFa/xuxNzIPw9k2/M/dGCrQSg4goaBFd4Bp
	DG4dVm0GZ22/ZXqBzndtwRQnuYrvIWor+Qqx881hdjBh7mBoTisDIEsf
X-Gm-Gg: ASbGncuwivr5RjrtdE+ouV56x0h74fRBPXtfDgCSu/YmQ3g0pt1kZYxCrx9RnFrmeFG
	oTKPfaxEkBEEJs9d/Hz1Xa/moUy4I+GYVtQz1rqJ3Kc7FFOyYQtmRRHCFDdZg+17S1c2be7somB
	rtAIX12BguSYwnGNlrLkFYcAGXhqZIh8W1g7tGLbLt94VUVDTDbamgCBuxALZ0kGap3iQaXmn2B
	fHD9NCfexFPyIwq9wo+yvh9bQOyB2O9nHzhsrlFEzgHeiyw9q34VPUld6kDMmil3/EUt86q3wUy
	C0SN+DBavdKvyZ3/dUriPZ7lPeiTEfJtSjZymCUkSBjMugHfH0Yg90vAoE3ebA0FuK63BTyYNjJ
	Utd9RqGt/yWtbkR+DGzFZXQKRBtG6I6mEPKy/icxq7Bp5mAUh8m4crA==
X-Google-Smtp-Source: AGHT+IEe2A8axB/3Y14iPkh2FI0QHWMcwcqvzGaU/WwLKwhmaCDZ0BvYQraBItJoSJLtr0gTXUl2IQ==
X-Received: by 2002:a17:90b:2b84:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-32116ad3520mr9953044a91.15.1754310740620;
        Mon, 04 Aug 2025 05:32:20 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a5b2cdsm4417443a91.1.2025.08.04.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 22:32:11 +1000
Message-Id: <DBTN94725QGF.9OV4JD5UDTHL@gmail.com>
Cc: "Ritesh Harjani" <ritesh.list@gmail.com>,
 <linux-kernel@vger.kernel.org>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Vishal Chourasia" <vishalc@linux.ibm.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc/mm: Fix SLB multihit issue during SLB
 preload
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Donet Tom" <donettom@linux.ibm.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.20.0
References: <20250801103747.21864-1-donettom@linux.ibm.com>
In-Reply-To: <20250801103747.21864-1-donettom@linux.ibm.com>

Hmm, interesting bug. Impressive work to track it down.

On Fri Aug 1, 2025 at 8:37 PM AEST, Donet Tom wrote:
> On systems using the hash MMU, there is a software SLB preload cache that
> mirrors the entries loaded into the hardware SLB buffer. This preload
> cache is subject to periodic eviction =E2=80=94 typically after every 256=
 context
> switches =E2=80=94 to remove old entry.
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

Okay, so what happens is CPU0 has SLB entries remaining from when
P last ran on there, and the preload aging happens on CPU1 at a
time when that CPU does clear its SLB. That slb aging step doesn't
account for the fact CPU0 SLB entries still exist.
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
> MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER:=
 00000000
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
> To fix this issue, we add a code change to always switch the MMU context =
on
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
> v1 - https://lore.kernel.org/all/20250731161027.966196-1-donettom@linux.i=
bm.com/
> ---
>  arch/powerpc/mm/book3s64/slb.c | 2 +-
>  arch/powerpc/mm/mmu_context.c  | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/sl=
b.c
> index 6b783552403c..08daac3f978c 100644
> --- a/arch/powerpc/mm/book3s64/slb.c
> +++ b/arch/powerpc/mm/book3s64/slb.c
> @@ -509,7 +509,7 @@ void switch_slb(struct task_struct *tsk, struct mm_st=
ruct *mm)
>  	 * SLB preload cache.
>  	 */
>  	tsk->thread.load_slb++;
> -	if (!tsk->thread.load_slb) {
> +	if (tsk->thread.load_slb =3D=3D U8_MAX) {
>  		unsigned long pc =3D KSTK_EIP(tsk);
> =20
>  		preload_age(ti);
> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.=
c
> index 3e3af29b4523..95455d787288 100644
> --- a/arch/powerpc/mm/mmu_context.c
> +++ b/arch/powerpc/mm/mmu_context.c
> @@ -83,8 +83,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct=
 mm_struct *next,
>  	/* Some subarchs need to track the PGD elsewhere */
>  	switch_mm_pgdir(tsk, next);
> =20
> -	/* Nothing else to do if we aren't actually switching */
> -	if (prev =3D=3D next)
> +	/*
> +	 * Nothing else to do if we aren't actually switching and
> +	 * the preload slb cache has not aged
> +	 */
> +	if ((prev =3D=3D next) && (tsk->thread.load_slb !=3D U8_MAX))
>  		return;
> =20
>  	/*

I see couple of issues with this fix. First of all, it's a bit wrong to
call switch subsequent switch_mm functions if prev =3D=3D next, they are no=
t
all powerpc specific. We could work around that somehow with some hash
specific knowledge. But worse I think is that load_slb could be
incremented again if we context switched P again before migrating back
here, then we would miss it.

How about removing preload_new_slb_context() and slb_setup_new_exec()
entirely? Then slb preload is a much simpler thing that is only loaded
after the SLB has been cleared. Those functions were always a bit
janky and for performance, context switch is the most improtant I think,
new thread/proc creation less so.

Thanks,
Nick

