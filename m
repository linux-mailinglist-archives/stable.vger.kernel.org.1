Return-Path: <stable+bounces-47763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB28D5A68
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E891C2437F
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF27D07F;
	Fri, 31 May 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t20GufHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F904D135;
	Fri, 31 May 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136230; cv=none; b=axbjhWv317uA6/vtEuIQ5tWT6CyFPPGvioIh3N9ss0OBD0fka25RjLn3kTADEiGGI8ioGuv9w/qN+Djx2dyLDE3mCLS2/6OmnaV/t5UbEkYGItnNgRYsnW4YFUwP2idZufRQonItCGOgtzmzktatSrO0EKsiLWJNRRP58cUWd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136230; c=relaxed/simple;
	bh=1txz6EBbLslweRx5zv5HD1/NnMj3qaQXrpFWb1lCz98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1k6ptbjenpCk8Grl7z2d8f82bN/C9pzha/OVW0xcxwM88VXbOFauX5nV3+ig66ovd3wtlpcHUOd6z8dbpwjcIohDyHpUf/EJKycmHmMAFlNqKuHh3on1MgrYWcaLKbD+MDtfzm5do/YmL26y143yKm9yh9uzye/gw++XXP0YDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t20GufHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B0AC4AF08;
	Fri, 31 May 2024 06:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717136229;
	bh=1txz6EBbLslweRx5zv5HD1/NnMj3qaQXrpFWb1lCz98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t20GufHPLHQBp2kMWA365gKoggNXfpSWBayZzrJ7FjumWnZQk9XBJbG9W6cpb5OrG
	 /t5sdQHBtmjP3KbxZ83wpCkCeF1nVl9R7dNyecKY2G46T4uxx8crXBs0rRHzimPB/8
	 muMqumLKT9fgZSBCOwNSGhzHplv7+oewP4wmsGQG1vXqLC/vBGehPw2pc6O3Knl+Cs
	 JV5Zr8yxbu/5CRfhD06PWnBABCce/PsijD/OFPIResrEncuiRH3SqnL91a5RaLH3ET
	 rHml8jIt6yadSzVZMwsYgBQTvoDflVpNcvZ0tx/liVr3Q9FyYPFyd7HFqRA2pLMyR7
	 2IgFOooJi5J7g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so16643231fa.2;
        Thu, 30 May 2024 23:17:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzez604HteAy+kk9K8ODs78sR+no4iQVQbOm8kN4TRSgy0Z6xIX
	XnwG7MIs+7k6+FRCGx+5SPftzy7yQoB5clpcjsoUxo7xL2xJ9FKfb7DFFgq2CPXZuf3p+bA/hM0
	OIIO6WcI/Ml3YeYW8HYrJMJ67u4w=
X-Google-Smtp-Source: AGHT+IFGyssxjO3HSPULUCEik2NAxN2UoEY92mPsbqDDTlJJydSYKwU4Js/rur7G9l9W+yFeCdVL+5olBzKUd9YVvPI=
X-Received: by 2002:a2e:8415:0:b0:2ea:814b:f578 with SMTP id
 38308e7fff4ca-2ea950fdc71mr6338621fa.6.1717136228111; Thu, 30 May 2024
 23:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530191110.24847-1-sashal@kernel.org>
In-Reply-To: <20240530191110.24847-1-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 May 2024 08:16:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>
Message-ID: <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>
Subject: Re: Patch "arm64: fpsimd: Drop unneeded 'busy' flag" has been added
 to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 21:11, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     arm64: fpsimd: Drop unneeded 'busy' flag
>
> to the 6.6-stable tree

Why?


> which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      arm64-fpsimd-drop-unneeded-busy-flag.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 37f2773a1ef05374538d5e4ed26cbacebe363241
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Fri Dec 8 12:32:20 2023 +0100
>
>     arm64: fpsimd: Drop unneeded 'busy' flag
>
>     [ Upstream commit 9b19700e623f96222c69ecb2adecb1a3e3664cc0 ]
>
>     Kernel mode NEON will preserve the user mode FPSIMD state by saving it
>     into the task struct before clobbering the registers. In order to avoid
>     the need for preserving kernel mode state too, we disallow nested use of
>     kernel mode NEON, i..e, use in softirq context while the interrupted
>     task context was using kernel mode NEON too.
>
>     Originally, this policy was implemented using a per-CPU flag which was
>     exposed via may_use_simd(), requiring the users of the kernel mode NEON
>     to deal with the possibility that it might return false, and having NEON
>     and non-NEON code paths. This policy was changed by commit
>     13150149aa6ded1 ("arm64: fpsimd: run kernel mode NEON with softirqs
>     disabled"), and now, softirq processing is disabled entirely instead,
>     and so may_use_simd() can never fail when called from task or softirq
>     context.
>
>     This means we can drop the fpsimd_context_busy flag entirely, and
>     instead, ensure that we disable softirq processing in places where we
>     formerly relied on the flag for preventing races in the FPSIMD preserve
>     routines.
>
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>     Reviewed-by: Mark Brown <broonie@kernel.org>
>     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Link: https://lore.kernel.org/r/20231208113218.3001940-7-ardb@google.com
>     [will: Folded in fix from CAMj1kXFhzbJRyWHELCivQW1yJaF=p07LLtbuyXYX3G1WtsdyQg@mail.gmail.com]
>     Signed-off-by: Will Deacon <will@kernel.org>
>     Stable-dep-of: b8995a184170 ("Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index 6a75d7ecdcaa2..8e86c9e70e483 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -12,8 +12,6 @@
>  #include <linux/preempt.h>
>  #include <linux/types.h>
>
> -DECLARE_PER_CPU(bool, fpsimd_context_busy);
> -
>  #ifdef CONFIG_KERNEL_MODE_NEON
>
>  /*
> @@ -28,17 +26,10 @@ static __must_check inline bool may_use_simd(void)
>         /*
>          * We must make sure that the SVE has been initialized properly
>          * before using the SIMD in kernel.
> -        * fpsimd_context_busy is only set while preemption is disabled,
> -        * and is clear whenever preemption is enabled. Since
> -        * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
> -        * cannot change under our feet -- if it's set we cannot be
> -        * migrated, and if it's clear we cannot be migrated to a CPU
> -        * where it is set.
>          */
>         return !WARN_ON(!system_capabilities_finalized()) &&
>                system_supports_fpsimd() &&
> -              !in_hardirq() && !irqs_disabled() && !in_nmi() &&
> -              !this_cpu_read(fpsimd_context_busy);
> +              !in_hardirq() && !irqs_disabled() && !in_nmi();
>  }
>
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 5cdfcc9e3e54b..b805bdab284c4 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -85,13 +85,13 @@
>   * softirq kicks in. Upon vcpu_put(), KVM will save the vcpu FP state and
>   * flag the register state as invalid.
>   *
> - * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may
> - * save the task's FPSIMD context back to task_struct from softirq context.
> - * To prevent this from racing with the manipulation of the task's FPSIMD state
> - * from task context and thereby corrupting the state, it is necessary to
> - * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
> - * flag with {, __}get_cpu_fpsimd_context(). This will still allow softirqs to
> - * run but prevent them to use FPSIMD.
> + * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may be
> + * called from softirq context, which will save the task's FPSIMD context back
> + * to task_struct. To prevent this from racing with the manipulation of the
> + * task's FPSIMD state from task context and thereby corrupting the state, it
> + * is necessary to protect any manipulation of a task's fpsimd_state or
> + * TIF_FOREIGN_FPSTATE flag with get_cpu_fpsimd_context(), which will suspend
> + * softirq servicing entirely until put_cpu_fpsimd_context() is called.
>   *
>   * For a certain task, the sequence may look something like this:
>   * - the task gets scheduled in; if both the task's fpsimd_cpu field
> @@ -209,27 +209,14 @@ static inline void sme_free(struct task_struct *t) { }
>
>  #endif
>
> -DEFINE_PER_CPU(bool, fpsimd_context_busy);
> -EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
> -
>  static void fpsimd_bind_task_to_cpu(void);
>
> -static void __get_cpu_fpsimd_context(void)
> -{
> -       bool busy = __this_cpu_xchg(fpsimd_context_busy, true);
> -
> -       WARN_ON(busy);
> -}
> -
>  /*
>   * Claim ownership of the CPU FPSIMD context for use by the calling context.
>   *
>   * The caller may freely manipulate the FPSIMD context metadata until
>   * put_cpu_fpsimd_context() is called.
>   *
> - * The double-underscore version must only be called if you know the task
> - * can't be preempted.
> - *
>   * On RT kernels local_bh_disable() is not sufficient because it only
>   * serializes soft interrupt related sections via a local lock, but stays
>   * preemptible. Disabling preemption is the right choice here as bottom
> @@ -242,14 +229,6 @@ static void get_cpu_fpsimd_context(void)
>                 local_bh_disable();
>         else
>                 preempt_disable();
> -       __get_cpu_fpsimd_context();
> -}
> -
> -static void __put_cpu_fpsimd_context(void)
> -{
> -       bool busy = __this_cpu_xchg(fpsimd_context_busy, false);
> -
> -       WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
>  }
>
>  /*
> @@ -261,18 +240,12 @@ static void __put_cpu_fpsimd_context(void)
>   */
>  static void put_cpu_fpsimd_context(void)
>  {
> -       __put_cpu_fpsimd_context();
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 local_bh_enable();
>         else
>                 preempt_enable();
>  }
>
> -static bool have_cpu_fpsimd_context(void)
> -{
> -       return !preemptible() && __this_cpu_read(fpsimd_context_busy);
> -}
> -
>  unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
>  {
>         return task->thread.vl[type];
> @@ -383,7 +356,7 @@ static void task_fpsimd_load(void)
>         bool restore_ffr;
>
>         WARN_ON(!system_supports_fpsimd());
> -       WARN_ON(!have_cpu_fpsimd_context());
> +       WARN_ON(preemptible());
>
>         if (system_supports_sve() || system_supports_sme()) {
>                 switch (current->thread.fp_type) {
> @@ -467,7 +440,7 @@ static void fpsimd_save(void)
>         unsigned int vl;
>
>         WARN_ON(!system_supports_fpsimd());
> -       WARN_ON(!have_cpu_fpsimd_context());
> +       WARN_ON(preemptible());
>
>         if (test_thread_flag(TIF_FOREIGN_FPSTATE))
>                 return;
> @@ -1583,7 +1556,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>         if (!system_supports_fpsimd())
>                 return;
>
> -       __get_cpu_fpsimd_context();
> +       WARN_ON_ONCE(!irqs_disabled());
>
>         /* Save unsaved fpsimd state, if any: */
>         fpsimd_save();
> @@ -1599,8 +1572,6 @@ void fpsimd_thread_switch(struct task_struct *next)
>
>         update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
>                                wrong_task || wrong_cpu);
> -
> -       __put_cpu_fpsimd_context();
>  }
>
>  static void fpsimd_flush_thread_vl(enum vec_type type)
> @@ -1892,13 +1863,15 @@ static void fpsimd_flush_cpu_state(void)
>   */
>  void fpsimd_save_and_flush_cpu_state(void)
>  {
> +       unsigned long flags;
> +
>         if (!system_supports_fpsimd())
>                 return;
>         WARN_ON(preemptible());
> -       __get_cpu_fpsimd_context();
> +       local_irq_save(flags);
>         fpsimd_save();
>         fpsimd_flush_cpu_state();
> -       __put_cpu_fpsimd_context();
> +       local_irq_restore(flags);
>  }
>
>  #ifdef CONFIG_KERNEL_MODE_NEON

