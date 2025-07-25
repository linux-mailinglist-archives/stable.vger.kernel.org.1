Return-Path: <stable+bounces-164714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24FDB116E4
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD04E580BE1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 03:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B71D54D8;
	Fri, 25 Jul 2025 03:15:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD31632C8
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413346; cv=none; b=f+F1af2yUNgeqIIJVlIWHaopaCHkaguLmGlBIry/JmWexTn/CdZd3byXYdp4YnADhaCrNKqXfoxTndUyLZtjdAKIk2hNWF8Xnb38Epa3v9UDhus8wVoM1owy3Bly51lxTALCM7NP2IT2rWw9T319HvcqO1N7Jzh/dWyCejZZvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413346; c=relaxed/simple;
	bh=FI+cQ1AC7ZOf0uTYuc+KDcY/7N8xKp8zs1g8lNZLQQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDuimOvUOkzD4wbTNwWwNiKMemYt57TCLRSPPraa9P4ooPDge0ZZS1onCniUWyPNcXz0JuduczT0t8ICdf3z669rJZtPS/kPqbpABWTrRmRe7yhHNDhvsfWyMt4SYtURjeHbRKCTsi5+Pzd7VlXAruiI2BzBcvhOrSxvpsOde+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3y1u79oJo6DXkBg--.35476S2;
	Fri, 25 Jul 2025 11:15:09 +0800 (CST)
Date: Fri, 25 Jul 2025 11:15:07 +0800
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, ajones@ventanamicro.com,
	Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
	Charlie Jenkins <charlie@rivosinc.com>, jesse@rivosinc.com,
	Olof Johansson <olof@lixom.net>, dlan@gentoo.org,
	si.yanteng@linux.dev, research_trasio@irq.a4lg.com,
	stable@vger.kernel.org, alexghiti@rivosinc.com
Subject: Re: [PATCH v5] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
Message-ID: <20250725031507.GA29618@iscas.ac.cn>
References: <20250705150952.29461-1-wangjingwei@iscas.ac.cn>
 <mhng-2F811C61-A512-4742-A00D-7D01203DAB14@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-2F811C61-A512-4742-A00D-7D01203DAB14@palmerdabbelt-mac>
User-Agent: Mutt/2.2.14
X-CM-TRANSID:zQCowAA3y1u79oJo6DXkBg--.35476S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF1xuFWfZw15ur1UXF4ktFb_yoW8JrW8to
	WftF40gFWSgr13CFsxAw4DtFy7G3s2gr4DZw17tw45XF1YyF4UZr1Y93y0qFy3Jw45Kanr
	Ga4IqrWrZanYy3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYa7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5QZ2DUUUUU==
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

Hi Palmer,

On Wed, Jul 16, 2025 at 11:48:03AM -0700, Palmer Dabbelt wrote:
> On Sat, 05 Jul 2025 08:08:28 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
> > The hwprobe vDSO data for some keys, like MISALIGNED_VECTOR_PERF,
> > is determined by an asynchronous kthread. This can create a race
> > condition where the kthread finishes after the vDSO data has
> > already been populated, causing userspace to read stale values.
> >
> > To fix this, a completion-based framework is introduced to robustly
> > synchronize the async probes with the vDSO data population. The
> > waiting function, init_hwprobe_vdso_data(), now blocks on
> > wait_for_completion() until all probes signal they are done.
> >
> > Furthermore, to prevent this potential blocking from impacting boot
> > performance, the initialization is deferred to late_initcall. This
> > is safe as the data is only required by userspace (which starts
> > much later) and moves the synchronization delay off the critical
> > boot path.
> >
> > Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> > Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> > Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> > ---
> > Changes in v5:
> > 	- Reworked the synchronization logic to a robust "sentinel-count"
> > 	  pattern based on feedback from Alexandre.
> > 	- Fixed a "multiple definition" linker error for nommu builds by changing
> > 	  the header-file stub functions to `static inline`, as pointed out by Olof.
> > 	- Updated the commit message to better explain the rationale for moving
> > 	  the vDSO initialization to `late_initcall`.
> >
> > Changes in v4:
> > 	- Reworked the synchronization mechanism based on feedback from Palmer
> >     	and Alexandre.
> > 	- Instead of a post-hoc refresh, this version introduces a robust
> > 	completion-based framework using an atomic counter to ensure async
> > 	probes are finished before populating the vDSO.
> > 	- Moved the vdso data initialization to a late_initcall to avoid
> > 	impacting boot time.
> >
> > Changes in v3:
> > 	- Retained existing blank line.
> >
> > Changes in v2:
> > 	- Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
> > 	- Updated commit message to provide a high-level summary.
> > 	- Added Fixes tag for commit e7c9d66e313b.
> >
> > v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingwei@iscas.ac.cn/T/#u
> >
> >  arch/riscv/include/asm/hwprobe.h           |  8 +++++++-
> >  arch/riscv/kernel/sys_hwprobe.c            | 20 +++++++++++++++++++-
> >  arch/riscv/kernel/unaligned_access_speed.c |  9 +++++++--
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > index 7fe0a379474ae2c6..3b2888126e659ea1 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
> >
> >  	return pair->value == other_pair->value;
> >  }
> > -
> > +#ifdef CONFIG_MMU
> > +void riscv_hwprobe_register_async_probe(void);
> > +void riscv_hwprobe_complete_async_probe(void);
> > +#else
> > +static inline void riscv_hwprobe_register_async_probe(void) {}
> > +static inline void riscv_hwprobe_complete_async_probe(void) {}
> > +#endif
> >  #endif
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index 0b170e18a2beba57..ee02aeb03e7bd3d8 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -5,6 +5,8 @@
> >   * more details.
> >   */
> >  #include <linux/syscalls.h>
> > +#include <linux/completion.h>
> > +#include <linux/atomic.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hwprobe.h>
> > @@ -467,6 +469,20 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
> >
> >  #ifdef CONFIG_MMU
> >
> > +static DECLARE_COMPLETION(boot_probes_done);
> > +static atomic_t pending_boot_probes = ATOMIC_INIT(1);
> > +
> > +void riscv_hwprobe_register_async_probe(void)
> > +{
> > +	atomic_inc(&pending_boot_probes);
> > +}
> > +
> > +void riscv_hwprobe_complete_async_probe(void)
> > +{
> > +	if (atomic_dec_and_test(&pending_boot_probes))
> > +		complete(&boot_probes_done);
> > +}
> > +
> >  static int __init init_hwprobe_vdso_data(void)
> >  {
> >  	struct vdso_arch_data *avd = vdso_k_arch_data;
> > @@ -474,6 +490,8 @@ static int __init init_hwprobe_vdso_data(void)
> >  	struct riscv_hwprobe pair;
> >  	int key;
> >
> > +	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
> > +		wait_for_completion(&boot_probes_done);
>
> I'm not actually sure this is safe,
>
> That said, it will end up bringing us back to the situation where we're
> waiting for CPUs to probe before we boot.  So even if it's safe, it's not
> great as we're going to introduce the boot time regression again.
>
> We'd be better off if we could defer waiting on the completion until we
> actually need the values.  I think we could do that with something like
>
Thanks for pointing out the boot-time delay. I had my own doubts about
that approach in v5, and I really like your on-demand solution.
>    diff --git a/arch/riscv/include/asm/vdso/arch_data.h b/arch/riscv/include/asm/vdso/arch_data.h
>    index da57a3786f7a..88b37af55175 100644
>    --- a/arch/riscv/include/asm/vdso/arch_data.h
>    +++ b/arch/riscv/include/asm/vdso/arch_data.h
>    @@ -12,6 +12,12 @@ struct vdso_arch_data {
>     	/* Boolean indicating all CPUs have the same static hwprobe values. */
>     	__u8 homogeneous_cpus;
>    +
>    +	/*
>    +	 * A gate to check and see if the hwprobe data is actually ready, as
>    +	 * probing is deferred to avoid boot slowdowns.
>    +	 */
>    +	__u8 ready;
>     };
>     #endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
>    diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>    index ee02aeb03e7b..9c809c24a1d9 100644
>    --- a/arch/riscv/kernel/sys_hwprobe.c
>    +++ b/arch/riscv/kernel/sys_hwprobe.c
>    @@ -454,19 +454,6 @@ static int hwprobe_get_cpus(struct riscv_hwprobe __user *pairs,
>     	return 0;
>     }
>    -static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
>    -			    size_t pair_count, size_t cpusetsize,
>    -			    unsigned long __user *cpus_user,
>    -			    unsigned int flags)
>    -{
>    -	if (flags & RISCV_HWPROBE_WHICH_CPUS)
>    -		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
>    -					cpus_user, flags);
>    -
>    -	return hwprobe_get_values(pairs, pair_count, cpusetsize,
>    -				  cpus_user, flags);
>    -}
>    -
>     #ifdef CONFIG_MMU
>     static DECLARE_COMPLETION(boot_probes_done);
>    @@ -483,15 +470,20 @@ void riscv_hwprobe_complete_async_probe(void)
>     		complete(&boot_probes_done);
>     }
>    -static int __init init_hwprobe_vdso_data(void)
>    +static int complete_hwprobe_vdso_data(void)
>     {
>     	struct vdso_arch_data *avd = vdso_k_arch_data;
>     	u64 id_bitsmash = 0;
>     	struct riscv_hwprobe pair;
>     	int key;
>    +	/* We've probably already produced these values. */
>    +	if (likely(avd->ready))
>    +		return 0;
>    +
>     	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
>     		wait_for_completion(&boot_probes_done);
>    +
>     	/*
>     	 * Initialize vDSO data with the answers for the "all CPUs" case, to
>     	 * save a syscall in the common case.
>    @@ -519,13 +511,50 @@ static int __init init_hwprobe_vdso_data(void)
>     	 * vDSO should defer to the kernel for exotic cpu masks.
>     	 */
>     	avd->homogeneous_cpus = id_bitsmash != 0 && id_bitsmash != -1;
>    +
>    +	/*
>    +	 * Make sure all the VDSO values are visible before we look at them.
>    +	 * This pairs with the implicit "no speculativly visible accesses"
>    +	 * barrier in the VDSO hwprobe code.
>    +	 */
>    +	smp_wmb();
>    +	avd->ready = true;
>     	return 0;
>     }
>    +static int __init init_hwprobe_vdso_data(void)
>    +{
>    +	struct vdso_arch_data *avd = vdso_k_arch_data;
>    +
>    +	/*
>    +	 * Prevent the vDSO cached values from being used, as they're not ready
>    +	 * yet.
>    +	 */
>    +	avd->ready = false;
>    +}
>    +
>     late_initcall(init_hwprobe_vdso_data);
>    +#else
>    +static int complete_hwprobe_vdso_data(void) { return 0; }
>     #endif /* CONFIG_MMU */
>    +static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
>    +			    size_t pair_count, size_t cpusetsize,
>    +			    unsigned long __user *cpus_user,
>    +			    unsigned int flags)
>    +{
>    +	complete_hwprobe_vdso_data();
>    +
>    +	if (flags & RISCV_HWPROBE_WHICH_CPUS)
>    +		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
>    +					cpus_user, flags);
>    +
>    +	return hwprobe_get_values(pairs, pair_count, cpusetsize,
>    +				  cpus_user, flags);
>    +}
>    +
>    +
>     SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
>     		size_t, pair_count, size_t, cpusetsize, unsigned long __user *,
>     		cpus, unsigned int, flags)
>    diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
>    index 2ddeba6c68dd..bf77b4c1d2d8 100644
>    --- a/arch/riscv/kernel/vdso/hwprobe.c
>    +++ b/arch/riscv/kernel/vdso/hwprobe.c
>    @@ -27,7 +27,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
>     	 * homogeneous, then this function can handle requests for arbitrary
>     	 * masks.
>     	 */
>    -	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus))
>    +	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus) || unlikely(!avd->ready))
>     		return riscv_hwprobe(pairs, pair_count, cpusetsize, cpus, flags);
>     	/* This is something we can handle, fill out the pairs. */
>
> (which I haven't even built yet, as I don't have a complier set up in this
> Mac yet...).
>
I've tested your proposed implementation, and it works well.
> There's probably a better way to do this that would require a bit more work,
> as there's sort of a double-completion here (each probe's workqueue and then
> the top-level completion)).  In the long run we should probably fold that
> all together so we can just block on probing the values we need, but this
> was quick...
>
I agree with your point on the double-completion. And I think it would
be better solved when adding hotplug support later on.
> >  	/*
> >  	 * Initialize vDSO data with the answers for the "all CPUs" case, to
> >  	 * save a syscall in the common case.
> > @@ -504,7 +522,7 @@ static int __init init_hwprobe_vdso_data(void)
> >  	return 0;
> >  }
> >
> > -arch_initcall_sync(init_hwprobe_vdso_data);
> > +late_initcall(init_hwprobe_vdso_data);
> >
> >  #endif /* CONFIG_MMU */
> >
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> > index ae2068425fbcd207..4b8ad2673b0f7470 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -379,6 +379,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
> >  static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> >  {
> >  	schedule_on_each_cpu(check_vector_unaligned_access);
>
> Do we need something like
>
>    diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>    index 4b8ad2673b0f..0f4eb95072ea 100644
>    --- a/arch/riscv/kernel/unaligned_access_speed.c
>    +++ b/arch/riscv/kernel/unaligned_access_speed.c
>    @@ -370,6 +370,12 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>     		(speed ==  RISCV_HWPROBE_MISALIGNED_VECTOR_FAST) ? "fast" : "slow");
>     	per_cpu(vector_misaligned_access, cpu) = speed;
>    +	/*
>    +	 * Ensure the store that sets up the misaligned access value is
>    +	 * visible before it is used by the other CPUs.  This orders with the
>    +	 * atomic_dec_and_test() in riscv_hwprobe_complete_async_probe().
>    +	 */
>    +	smp_wmb();
>     free:
>     	__free_pages(page, MISALIGNED_BUFFER_ORDER);
>
> to make sure we're ordered here?  I think we're probably safe in practice
> because the scheduler code has orderings.  Either way it's an existing bug,
> so I'll just send it along as another patch.
>
Thanks a lot. As you suggested, I'll keep this series focused on the
main synchronization issue.

I will send a new version soon.

Best,
Jingwei


