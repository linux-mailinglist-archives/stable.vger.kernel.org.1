Return-Path: <stable+bounces-158874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535FDAED5C9
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63BA7A43FB
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE583221DB5;
	Mon, 30 Jun 2025 07:34:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290B22DFBA
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268885; cv=none; b=Oq+WrZH4HkjcIXbGWajHlQzM0IlLIXKy20CSbE7sXYpghChuJz1alPgPdRjPEjEXMy+SA/6vbI0cH1fYSJzceLUQNT/BoOiCYnCr76Lw6Fdukp0VObKvxzR8MWYbhbFjrw02Uy88pziWLhdpDPp7DYBNJau0Hre6dilodz+vI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268885; c=relaxed/simple;
	bh=Il4G5bz+3WE9oLupMEBB20mV1Hmyh27La4L9UIYCZFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qph4vYbQKr5QdvrjIOxHZHRrdk4gTKH90acTB43n8aaDwIqS3IsGXurpYLbWdXB6zOsqXweI54qWRl5IR8j39zWB4EdPHyi9na3O4Y8bhyEXtbJ1Qi0pdYrjYlHvg6onjkWVVsEqXQauMKiBIxC9CbhJNchQD+5ncRTLOLQNYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8634D442CE;
	Mon, 30 Jun 2025 07:34:28 +0000 (UTC)
Message-ID: <a57e83be-c506-4ab4-962d-4cdbce4aaed9@ghiti.fr>
Date: Mon, 30 Jun 2025 09:34:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Jingwei Wang <wangjingwei@iscas.ac.cn>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Jones <ajones@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>,
 Yixun Lan <dlan@gentoo.org>, Yanteng Si <si.yanteng@linux.dev>,
 Tsukasa OI <research_trasio@irq.a4lg.com>, stable@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20250627172814.66367-1-wangjingwei@iscas.ac.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250627172814.66367-1-wangjingwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegtheekieemkeehhegvmeguugdutdemfeejudhfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegtheekieemkeehhegvmeguugdutdemfeejudhfpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegtheekieemkeehhegvmeguugdutdemfeejudhfngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopeifrghnghhjihhnghifvghisehishgtrghsrdgrtgdrtghnpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdro
 hhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopegtohhnohhrrdguohholhgvhiesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Jingwei,

On 6/27/25 19:27, Jingwei Wang wrote:
> The value for some hwprobe keys, like MISALIGNED_VECTOR_PERF, is
> determined by an asynchronous kthread. This kthread can finish after
> the hwprobe vDSO data is populated, creating a race condition where
> userspace can read stale values.
>
> A completion-based framework is introduced to synchronize the async
> probes with the vDSO population. The init_hwprobe_vdso_data()
> function is deferred to `late_initcall` and now blocks until all
> probes signal completion.


Can you add an explanation of why the move to late_initcall() here?


>
> Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> ---
> Changes in v4:
> 	- Reworked the synchronization mechanism based on feedback from Palmer
>      	and Alexandre.
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
>   arch/riscv/include/asm/hwprobe.h           |  8 +++++++-
>   arch/riscv/kernel/sys_hwprobe.c            | 20 +++++++++++++++++++-
>   arch/riscv/kernel/unaligned_access_speed.c |  9 +++++++--
>   3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 7fe0a379474ae2c6..87af186d92e75ddb 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
>   
>   	return pair->value == other_pair->value;
>   }
> -
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_register_async_probe(void);
> +void riscv_hwprobe_complete_async_probe(void);
> +#else
> +inline void riscv_hwprobe_register_async_probe(void) {}
> +inline void riscv_hwprobe_complete_async_probe(void) {}
> +#endif
>   #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 0b170e18a2beba57..8c50dcec2b754c30 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -5,6 +5,8 @@
>    * more details.
>    */
>   #include <linux/syscalls.h>
> +#include <linux/completion.h>
> +#include <linux/atomic.h>
>   #include <asm/cacheflush.h>
>   #include <asm/cpufeature.h>
>   #include <asm/hwprobe.h>
> @@ -467,6 +469,20 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
>   
>   #ifdef CONFIG_MMU
>   
> +static DECLARE_COMPLETION(boot_probes_done);
> +static atomic_t pending_boot_probes = ATOMIC_INIT(0);
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
>   static int __init init_hwprobe_vdso_data(void)
>   {
>   	struct vdso_arch_data *avd = vdso_k_arch_data;
> @@ -474,6 +490,8 @@ static int __init init_hwprobe_vdso_data(void)
>   	struct riscv_hwprobe pair;
>   	int key;
>   
> +	if (unlikely(atomic_read(&pending_boot_probes) > 0))
> +		wait_for_completion(&boot_probes_done);


To me it's not working: if a first async probe registers and completes 
before another async probe registers, pending_boot_probes will be > 0 
but wait_for_completion() will proceed before the second async probe 
completes (since the first async probe marked the completion as done).

Let me know if I missed something,

Thanks,

Alex


>   	/*
>   	 * Initialize vDSO data with the answers for the "all CPUs" case, to
>   	 * save a syscall in the common case.
> @@ -504,7 +522,7 @@ static int __init init_hwprobe_vdso_data(void)
>   	return 0;
>   }
>   
> -arch_initcall_sync(init_hwprobe_vdso_data);
> +late_initcall(init_hwprobe_vdso_data);
>   
>   #endif /* CONFIG_MMU */
>   
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index ae2068425fbcd207..4b8ad2673b0f7470 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -379,6 +379,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>   static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>   {
>   	schedule_on_each_cpu(check_vector_unaligned_access);
> +	riscv_hwprobe_complete_async_probe();
>   
>   	return 0;
>   }
> @@ -473,8 +474,12 @@ static int __init check_unaligned_access_all_cpus(void)
>   			per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
>   	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
>   		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> -		kthread_run(vec_check_unaligned_access_speed_all_cpus,
> -			    NULL, "vec_check_unaligned_access_speed_all_cpus");
> +		riscv_hwprobe_register_async_probe();
> +		if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
> +				NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
> +			pr_warn("Failed to create vec_unalign_check kthread\n");
> +			riscv_hwprobe_complete_async_probe();
> +		}
>   	}
>   
>   	/*

