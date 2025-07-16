Return-Path: <stable+bounces-163192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C615CB07D1D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD879505C9C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4C1C84DF;
	Wed, 16 Jul 2025 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="cS1QGBJQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626484A3E
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691687; cv=none; b=ARgJHpTpjRAOcuwPCcbvoi2U+lL2xBmzyN+fAqUspJMjhouA2dGdbpF1br1I4b3i57cq5WL6EvG8Ob0MVO+C7wVP7PqROuppumAdmr+pkq5qQlh3Rxs0zMlkXYQS2R2PdH7b7NQ7OSSbUG1a8Yp0XJ83faTfBH7DAEMkLBov+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691687; c=relaxed/simple;
	bh=X+e2GQ6R2feBXuAgsvGaTkp6ndpkJMgb3ZMQxmg/gqw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ufiHsKytAq0Ogckgnu5YmZrJmszPgKpoTW8SxShw8h6n3Q4Hwmz5dTffxsRx6hC9u/hdM6TtxtstnqBPlGSwMCLuxBjXLGINYhmiSQdc1E/SSJS9gHM0GCdyLoGTfOOdOlnEwgilmrhCzf4MD+9LMZuYcYud3yKGOcX3WY3V+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=cS1QGBJQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b52bf417cso216710b3a.0
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752691684; x=1753296484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CL8wCnWle041tDe+nymHcVsSlw4BMV+tT91rzsEz124=;
        b=cS1QGBJQoxUlMp8P92c2hsOQe5VG6IKkJeVK1uMg1Mm6Oc8KcnUcwXv59iob3R0qvJ
         B5neN5WtUSnQ+Td9ucoEYaqOiE9E64vElcEjhpp6m0eNRr/ieVP69mrPAehRGwnQniEm
         +EMepE7RF6XCoEBZuJba8kQpzoRH51dqHjuVmwhFdBXTc7ktTFsn2bfL6nomZ6Qy+aGw
         1zIOfCprDrVaJ5p/60Siv1aNq8YeVr2fLaLZYaidm2jT0iWfWIKa+AiA1SWSuvpxWBHe
         PNEdCr8NQkjtKBMJuoZM9rj+kTbgfCEd25KXh70NEP41nYHf7/W2Zjlh6bUUYzK3sfFT
         49BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752691684; x=1753296484;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL8wCnWle041tDe+nymHcVsSlw4BMV+tT91rzsEz124=;
        b=Be2/uSuOrsUpbn7YCbMO35NtGhI9LJDAFusWlDQgkv9g7WgH1lq8WLyD/5vvJNvym5
         s5tPf/Y468im9wWYNrnRDZnuIJvHXde4M9651Irmv17qiIiSp7+OCUzIas0qKkwqJs8H
         YoG5osOVkgSoFn4ozz2QdlWeSdF1TdhansOkX4MKuR9BR6Epg3Oj5kOYhCOm9C6rERVq
         V6RkbH4wAMIZTk7+CtH8E29Dw9nSsDW2ahHmtaX3v1YHoTdDlFyo0vkqcpGezaaFVq8f
         koVuAiYSMYlA2djPjoFFkK4A6sUsBXq4Swr3SDxJArpU/pmRn0aBlq/oOjoW91jggGD+
         iPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiHOqiiWT4b5djMJElD9tY8sp0JtT2+4V//Sph7ZSS0+yyKvXsiVdr6shm3LE/7U3i8tOm24E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2vRl7G/BXPwOjJ6lqNOEqIkeg7CEeXqk1TtFJ41oO223SXco
	+Bmj7avvewtnuniPP4upEHlzA+h4g20rZHLaTsjcG0GI5PsxAFYai+ObHhMdTrhQJ10=
X-Gm-Gg: ASbGncuzKsPFhqnka30TG758WPrRqg37Nx1pZHqP2TTrVAGhmTArCZk4ugMvO+iS3Gp
	la2t9JI1rkFiESsTj1tkS58uSCBxc3iktd7/cXPh2J5SBTfbaTmVAfjXMvl8dRNlAGyHImzFmwD
	4tcR5O03FF9xXFBshe98cwfCjbXn4/3Gt+jSt9Kex8zZ9SjLWBFxkLNW78VRVkgG1mxczMz5rKi
	ImpyQB7kRlmHbnBwcfCp3DoJqTXnCvIiE9y9Po3+a8OOg8I4R//wOpwQaPBxjNtyvMhYtGv9J51
	dw7wF0yVhcCfIUobV7X0nYAdurqAy8IZStrhS7EZy7vbaHLmW9DTQNj2GStQ6U4lg9bTivMsu93
	uyBdsQsG7SV5pIJwDT++X
X-Google-Smtp-Source: AGHT+IEemuLDfwAHPUghQhJ+Lyj5EmS9ODQzRvzhpE0+zPMFNsLF/cKxpm+aymkvDZUkWWJj7doSqA==
X-Received: by 2002:a05:6a21:689:b0:230:3710:9aa9 with SMTP id adf61e73a8af0-23810666f3amr6252387637.4.1752691684234;
        Wed, 16 Jul 2025 11:48:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe71a40csm14258071a12.64.2025.07.16.11.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:48:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:48:03 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 11:47:58 PDT (-0700)
Subject:     Re: [PATCH v5] riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot
In-Reply-To: <20250705150952.29461-1-wangjingwei@iscas.ac.cn>
CC: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>, ajones@ventanamicro.com,
  Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com, Charlie Jenkins <charlie@rivosinc.com>,
  jesse@rivosinc.com, Olof Johansson <olof@lixom.net>, dlan@gentoo.org, si.yanteng@linux.dev,
  research_trasio@irq.a4lg.com, stable@vger.kernel.org, wangjingwei@iscas.ac.cn, alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: wangjingwei@iscas.ac.cn
Message-ID: <mhng-2F811C61-A512-4742-A00D-7D01203DAB14@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sat, 05 Jul 2025 08:08:28 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
> The hwprobe vDSO data for some keys, like MISALIGNED_VECTOR_PERF,
> is determined by an asynchronous kthread. This can create a race
> condition where the kthread finishes after the vDSO data has
> already been populated, causing userspace to read stale values.
>
> To fix this, a completion-based framework is introduced to robustly
> synchronize the async probes with the vDSO data population. The
> waiting function, init_hwprobe_vdso_data(), now blocks on
> wait_for_completion() until all probes signal they are done.
>
> Furthermore, to prevent this potential blocking from impacting boot
> performance, the initialization is deferred to late_initcall. This
> is safe as the data is only required by userspace (which starts
> much later) and moves the synchronization delay off the critical
> boot path.
>
> Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> ---
> Changes in v5:
> 	- Reworked the synchronization logic to a robust "sentinel-count"
> 	  pattern based on feedback from Alexandre.
> 	- Fixed a "multiple definition" linker error for nommu builds by changing
> 	  the header-file stub functions to `static inline`, as pointed out by Olof.
> 	- Updated the commit message to better explain the rationale for moving
> 	  the vDSO initialization to `late_initcall`.
>
> Changes in v4:
> 	- Reworked the synchronization mechanism based on feedback from Palmer
>     	and Alexandre.
> 	- Instead of a post-hoc refresh, this version introduces a robust
> 	completion-based framework using an atomic counter to ensure async
> 	probes are finished before populating the vDSO.
> 	- Moved the vdso data initialization to a late_initcall to avoid
> 	impacting boot time.
>
> Changes in v3:
> 	- Retained existing blank line.
>
> Changes in v2:
> 	- Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
> 	- Updated commit message to provide a high-level summary.
> 	- Added Fixes tag for commit e7c9d66e313b.
>
> v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingwei@iscas.ac.cn/T/#u
>
>  arch/riscv/include/asm/hwprobe.h           |  8 +++++++-
>  arch/riscv/kernel/sys_hwprobe.c            | 20 +++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c |  9 +++++++--
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 7fe0a379474ae2c6..3b2888126e659ea1 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
>
>  	return pair->value == other_pair->value;
>  }
> -
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_register_async_probe(void);
> +void riscv_hwprobe_complete_async_probe(void);
> +#else
> +static inline void riscv_hwprobe_register_async_probe(void) {}
> +static inline void riscv_hwprobe_complete_async_probe(void) {}
> +#endif
>  #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 0b170e18a2beba57..ee02aeb03e7bd3d8 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -5,6 +5,8 @@
>   * more details.
>   */
>  #include <linux/syscalls.h>
> +#include <linux/completion.h>
> +#include <linux/atomic.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> @@ -467,6 +469,20 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
>
>  #ifdef CONFIG_MMU
>
> +static DECLARE_COMPLETION(boot_probes_done);
> +static atomic_t pending_boot_probes = ATOMIC_INIT(1);
> +
> +void riscv_hwprobe_register_async_probe(void)
> +{
> +	atomic_inc(&pending_boot_probes);
> +}
> +
> +void riscv_hwprobe_complete_async_probe(void)
> +{
> +	if (atomic_dec_and_test(&pending_boot_probes))
> +		complete(&boot_probes_done);
> +}
> +
>  static int __init init_hwprobe_vdso_data(void)
>  {
>  	struct vdso_arch_data *avd = vdso_k_arch_data;
> @@ -474,6 +490,8 @@ static int __init init_hwprobe_vdso_data(void)
>  	struct riscv_hwprobe pair;
>  	int key;
>
> +	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
> +		wait_for_completion(&boot_probes_done);

I'm not actually sure this is safe, 

That said, it will end up bringing us back to the situation where we're 
waiting for CPUs to probe before we boot.  So even if it's safe, it's 
not great as we're going to introduce the boot time regression again.

We'd be better off if we could defer waiting on the completion until we 
actually need the values.  I think we could do that with something like

    diff --git a/arch/riscv/include/asm/vdso/arch_data.h b/arch/riscv/include/asm/vdso/arch_data.h
    index da57a3786f7a..88b37af55175 100644
    --- a/arch/riscv/include/asm/vdso/arch_data.h
    +++ b/arch/riscv/include/asm/vdso/arch_data.h
    @@ -12,6 +12,12 @@ struct vdso_arch_data {
    
     	/* Boolean indicating all CPUs have the same static hwprobe values. */
     	__u8 homogeneous_cpus;
    +
    +	/*
    +	 * A gate to check and see if the hwprobe data is actually ready, as
    +	 * probing is deferred to avoid boot slowdowns.
    +	 */
    +	__u8 ready;
     };
    
     #endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
    diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
    index ee02aeb03e7b..9c809c24a1d9 100644
    --- a/arch/riscv/kernel/sys_hwprobe.c
    +++ b/arch/riscv/kernel/sys_hwprobe.c
    @@ -454,19 +454,6 @@ static int hwprobe_get_cpus(struct riscv_hwprobe __user *pairs,
     	return 0;
     }
    
    -static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
    -			    size_t pair_count, size_t cpusetsize,
    -			    unsigned long __user *cpus_user,
    -			    unsigned int flags)
    -{
    -	if (flags & RISCV_HWPROBE_WHICH_CPUS)
    -		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
    -					cpus_user, flags);
    -
    -	return hwprobe_get_values(pairs, pair_count, cpusetsize,
    -				  cpus_user, flags);
    -}
    -
     #ifdef CONFIG_MMU
    
     static DECLARE_COMPLETION(boot_probes_done);
    @@ -483,15 +470,20 @@ void riscv_hwprobe_complete_async_probe(void)
     		complete(&boot_probes_done);
     }
    
    -static int __init init_hwprobe_vdso_data(void)
    +static int complete_hwprobe_vdso_data(void)
     {
     	struct vdso_arch_data *avd = vdso_k_arch_data;
     	u64 id_bitsmash = 0;
     	struct riscv_hwprobe pair;
     	int key;
    
    +	/* We've probably already produced these values. */
    +	if (likely(avd->ready))
    +		return 0;
    +
     	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
     		wait_for_completion(&boot_probes_done);
    +
     	/*
     	 * Initialize vDSO data with the answers for the "all CPUs" case, to
     	 * save a syscall in the common case.
    @@ -519,13 +511,50 @@ static int __init init_hwprobe_vdso_data(void)
     	 * vDSO should defer to the kernel for exotic cpu masks.
     	 */
     	avd->homogeneous_cpus = id_bitsmash != 0 && id_bitsmash != -1;
    +
    +	/*
    +	 * Make sure all the VDSO values are visible before we look at them.
    +	 * This pairs with the implicit "no speculativly visible accesses"
    +	 * barrier in the VDSO hwprobe code.
    +	 */
    +	smp_wmb();
    +	avd->ready = true;
     	return 0;
     }
    
    +static int __init init_hwprobe_vdso_data(void)
    +{
    +	struct vdso_arch_data *avd = vdso_k_arch_data;
    +
    +	/*
    +	 * Prevent the vDSO cached values from being used, as they're not ready
    +	 * yet.
    +	 */
    +	avd->ready = false;
    +}
    +
     late_initcall(init_hwprobe_vdso_data);
    +#else
    +static int complete_hwprobe_vdso_data(void) { return 0; }
    
     #endif /* CONFIG_MMU */
    
    +static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
    +			    size_t pair_count, size_t cpusetsize,
    +			    unsigned long __user *cpus_user,
    +			    unsigned int flags)
    +{
    +	complete_hwprobe_vdso_data();
    +
    +	if (flags & RISCV_HWPROBE_WHICH_CPUS)
    +		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
    +					cpus_user, flags);
    +
    +	return hwprobe_get_values(pairs, pair_count, cpusetsize,
    +				  cpus_user, flags);
    +}
    +
    +
     SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
     		size_t, pair_count, size_t, cpusetsize, unsigned long __user *,
     		cpus, unsigned int, flags)
    diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
    index 2ddeba6c68dd..bf77b4c1d2d8 100644
    --- a/arch/riscv/kernel/vdso/hwprobe.c
    +++ b/arch/riscv/kernel/vdso/hwprobe.c
    @@ -27,7 +27,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
     	 * homogeneous, then this function can handle requests for arbitrary
     	 * masks.
     	 */
    -	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus))
    +	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus) || unlikely(!avd->ready))
     		return riscv_hwprobe(pairs, pair_count, cpusetsize, cpus, flags);
    
     	/* This is something we can handle, fill out the pairs. */

(which I haven't even built yet, as I don't have a complier set up in 
this Mac yet...).

There's probably a better way to do this that would require a bit more 
work, as there's sort of a double-completion here (each probe's 
workqueue and then the top-level completion)).  In the long run we 
should probably fold that all together so we can just block on probing 
the values we need, but this was quick...

>  	/*
>  	 * Initialize vDSO data with the answers for the "all CPUs" case, to
>  	 * save a syscall in the common case.
> @@ -504,7 +522,7 @@ static int __init init_hwprobe_vdso_data(void)
>  	return 0;
>  }
>
> -arch_initcall_sync(init_hwprobe_vdso_data);
> +late_initcall(init_hwprobe_vdso_data);
>
>  #endif /* CONFIG_MMU */
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index ae2068425fbcd207..4b8ad2673b0f7470 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -379,6 +379,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>  static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>  {
>  	schedule_on_each_cpu(check_vector_unaligned_access);

Do we need something like

    diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
    index 4b8ad2673b0f..0f4eb95072ea 100644
    --- a/arch/riscv/kernel/unaligned_access_speed.c
    +++ b/arch/riscv/kernel/unaligned_access_speed.c
    @@ -370,6 +370,12 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
     		(speed ==  RISCV_HWPROBE_MISALIGNED_VECTOR_FAST) ? "fast" : "slow");
    
     	per_cpu(vector_misaligned_access, cpu) = speed;
    +	/*
    +	 * Ensure the store that sets up the misaligned access value is
    +	 * visible before it is used by the other CPUs.  This orders with the
    +	 * atomic_dec_and_test() in riscv_hwprobe_complete_async_probe().
    +	 */
    +	smp_wmb();
    
     free:
     	__free_pages(page, MISALIGNED_BUFFER_ORDER);

to make sure we're ordered here?  I think we're probably safe in 
practice because the scheduler code has orderings.  Either way it's an 
existing bug, so I'll just send it along as another patch.

> +	riscv_hwprobe_complete_async_probe();
>
>  	return 0;
>  }
> @@ -473,8 +474,12 @@ static int __init check_unaligned_access_all_cpus(void)
>  			per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
>  	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
>  		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> -		kthread_run(vec_check_unaligned_access_speed_all_cpus,
> -			    NULL, "vec_check_unaligned_access_speed_all_cpus");
> +		riscv_hwprobe_register_async_probe();
> +		if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
> +				NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
> +			pr_warn("Failed to create vec_unalign_check kthread\n");
> +			riscv_hwprobe_complete_async_probe();
> +		}
>  	}
>
>  	/*

