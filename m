Return-Path: <stable+bounces-155360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FBBAE3FBC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C3F188B186
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B324169B;
	Mon, 23 Jun 2025 12:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D42244663
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680974; cv=none; b=mniPdd75+EynPqxdGo4mEr+KLnotyZiewPK0R81Nn3j3qeshUZ+YM9eIzuvC9XB9+YAUOq2CaBXNkZuqeWvoQZ2mWojOIDXHOxOxtiHMlmr7p99yhS/JJPOkmqJmHAxEsAq2XHQxdJZl9hAccAe1ko1upFfOiX1LSXMNrrmhYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680974; c=relaxed/simple;
	bh=oAAqtm/ErFq6EejPe3Vd6v5BzfW8bgkCALLc8GycKqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+dIcA5KA1ks60swC/22EeGB04H2mnEXAFTOOCfr74MymnO38t5vaKai11BODdELs6VeAqc378GsYadF1RNfaDVbjE8QWI7iJ3nyBdt5bqDWV7SzznU8GxOiM4c/5VlqZAqMgs89c2Xec/Kyy2sYRaaZav9cv/IvG4b7+ioWjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FCB5439EB;
	Mon, 23 Jun 2025 12:15:57 +0000 (UTC)
Message-ID: <f0a2971b-ff67-448f-b8d7-8082b0c77f4f@ghiti.fr>
Date: Mon, 23 Jun 2025 14:15:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Jingwei Wang <wangjingwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
 Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
 Charlie Jenkins <charlie@rivosinc.com>, jesse@rivosinc.com, dlan@gentoo.org,
 si.yanteng@linux.dev, research_trasio@irq.a4lg.com, stable@vger.kernel.org
References: <mhng-FC7E1D2C-D4E1-490E-9363-508518B62FE5@palmerdabbelt-mac>
 <da8bcae6-a6e2-4da2-8547-08ed2e35c55f@iscas.ac.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <da8bcae6-a6e2-4da2-8547-08ed2e35c55f@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefffedvleetleetjefhjeehudejteetvedtvddvtdfhieetffelvdffgefgieeinecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemvdeiieejmegvjegvtdemheduledtmehfvgdtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemvdeiieejmegvjegvtdemheduledtmehfvgdthedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemvdeiieejmegvjegvtdemheduledtmehfvgdthegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepfigrnhhgjhhinhhgfigvihesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhop
 ehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlvghgvghrsehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Jingwei, Palmer,

On 6/20/25 10:43, Jingwei Wang wrote:
>
> Hi Palmer,
> On 2025/6/11 06:25, Palmer Dabbelt wrote:
>> On Wed, 28 May 2025 07:28:19 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
>>> The riscv_hwprobe vDSO data is populated by init_hwprobe_vdso_data(),
>>> an arch_initcall_sync. However, underlying data for some keys, like
>>> RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF, is determined asynchronously.
>>>
>>> Specifically, the per_cpu(vector_misaligned_access, cpu) values are set
>>> by the vec_check_unaligned_access_speed_all_cpus kthread. This kthread
>>> is spawned by an earlier arch_initcall 
>>> (check_unaligned_access_all_cpus)
>>> and may complete its benchmark *after* init_hwprobe_vdso_data() has
>>> already populated the vDSO with default/stale values.
>>
>> IIUC there's another race here: we don't ensure these complete before
>> allowing userspace to see the values, so if these took so long to probe
>> userspace started to make hwprobe() calls before they got scheduled we'd
>> be providing the wrong answer.
>>
>> Unless I'm just missing something, though -- I thought we'd looked at 
>> that
>> case?
>>
> Thanks for the review. You're right, my current patch doesn't fix the 
> race
> condition with userspace.


I don't think there could be a race since all initcalls are executed 
sequentially, meaning userspace won't be up before the arch_initcall 
level is finished.

But that means that this patch in its current form will probably slow 
down the whole boot process. To avoid that (and in addition to this 
patch), can we move init_hwprobe_vdso_data() to late_initcall()?


>
> The robust solution here is to use the kernel's `completion`. I've tested
> this approach: the async probing thread calls `complete()` when finished,
> and `init_hwprobe_vdso_data()` blocks on `wait_for_completion()`. This
> guarantees the vDSO data is finalized before userspace can access it.
>
>>> So, refresh the vDSO data for specified keys (e.g.,
>>> MISALIGNED_VECTOR_PERF) ensuring it reflects the final boot-time 
>>> values.
>>>
>>> Test by comparing vDSO and syscall results for affected keys
>>> (e.g., MISALIGNED_VECTOR_PERF), which now match their final
>>> boot-time values.
>>
>> Wouldn't all the other keys we probe via workqueue be racy as well?
>>
> The completion mechanism is easily reusable. If this approach is 
> accepted,
> I will then identify other potential probe keys and integrate them into
> this synchronization logic.


Yes, I'd say that's the right way to do, there aren't lots of 
asynchronous initialization stuff so we can handle that when new ones land.

Thanks,

Alex


>
> And here is my tested code:
>
> diff --git a/arch/riscv/include/asm/hwprobe.h 
> b/arch/riscv/include/asm/hwprobe.h
> index 7fe0a379474ae2c6..87af186d92e75ddb 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,5 +40,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct 
> riscv_hwprobe *pair,
>
>      return pair->value == other_pair->value;
>  }
> -
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_register_async_probe(void);
> +void riscv_hwprobe_complete_async_probe(void);
> +#else
> +inline void riscv_hwprobe_register_async_probe(void) {}
> +inline void riscv_hwprobe_complete_async_probe(void) {}
> +#endif
>  #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c 
> b/arch/riscv/kernel/sys_hwprobe.c
> index 0b170e18a2beba57..96ce1479e835534e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -5,6 +5,8 @@
>   * more details.
>   */
>  #include <linux/syscalls.h>
> +#include <linux/completion.h>
> +#include <linux/atomic.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> @@ -467,6 +469,32 @@ static int do_riscv_hwprobe(struct riscv_hwprobe 
> __user *pairs,
>
>  #ifdef CONFIG_MMU
>
> +/* Framework for synchronizing asynchronous boot-time probes */
> +static DECLARE_COMPLETION(boot_probes_done);
> +static atomic_t pending_boot_probes = ATOMIC_INIT(1);
> +
> +void riscv_hwprobe_register_async_probe(void)
> +{
> +    atomic_inc(&pending_boot_probes);
> +}
> +
> +void riscv_hwprobe_complete_async_probe(void)
> +{
> +    if (atomic_dec_and_test(&pending_boot_probes))
> +        complete(&boot_probes_done);
> +}
> +
> +static void __init wait_for_all_boot_probes(void)
> +{
> +    if (atomic_dec_and_test(&pending_boot_probes))
> +        return;
> +
> +    pr_info("riscv: waiting for hwprobe asynchronous probes to 
> complete...\n");
> + wait_for_completion(&boot_probes_done);
> +    pr_info("riscv: hwprobe asynchronous probes completed.\n");
> +}
> +
> +
>  static int __init init_hwprobe_vdso_data(void)
>  {
>      struct vdso_arch_data *avd = vdso_k_arch_data;
> @@ -474,6 +502,8 @@ static int __init init_hwprobe_vdso_data(void)
>      struct riscv_hwprobe pair;
>      int key;
>
> +    wait_for_all_boot_probes();
> +
>      /*
>       * Initialize vDSO data with the answers for the "all CPUs" case, to
>       * save a syscall in the common case.
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c 
> b/arch/riscv/kernel/unaligned_access_speed.c
> index ae2068425fbcd207..57e4169ab58fb9bc 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -379,6 +380,7 @@ static void check_vector_unaligned_access(struct 
> work_struct *work __always_unus
>  static int __init vec_check_unaligned_access_speed_all_cpus(void 
> *unused __always_unused)
>  {
>  schedule_on_each_cpu(check_vector_unaligned_access);
> +    riscv_hwprobe_complete_async_probe();
>
>      return 0;
>  }
> @@ -473,8 +475,12 @@ static int __init 
> check_unaligned_access_all_cpus(void)
>  per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
>      } else if (!check_vector_unaligned_access_emulated_all_cpus() &&
> IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> - kthread_run(vec_check_unaligned_access_speed_all_cpus,
> -                NULL, "vec_check_unaligned_access_speed_all_cpus");
> + riscv_hwprobe_register_async_probe();
> + if(IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
> +                NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
> +                pr_warn("Failed to create vec_unalign_check kthread\n");
> + riscv_hwprobe_complete_async_probe();
> +            }
>      }
>
>      /*
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

