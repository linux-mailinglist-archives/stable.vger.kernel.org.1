Return-Path: <stable+bounces-146145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B05AC19C9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0670A25177
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591518E362;
	Fri, 23 May 2025 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGEwkJOv"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A82DCC12
	for <stable@vger.kernel.org>; Fri, 23 May 2025 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964455; cv=none; b=rvJ+OJ1ZLR2Soja1XuMBfVh5jLIDK929lx+crZo6fd6/15RMBrJQWBOL15T29H9eUPysA/IcaMvaLWhVF5hlyijU4uE7G85XE/guohzbuhN+kYcTb7+CqW09dLyCi8Pfd/Ao0u0ATgz9m0T1by/NN2d48bmkNdnrki2+TVXSpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964455; c=relaxed/simple;
	bh=X1rvREMtb/EqPoj7GYl9pDZBv+bHOTNdlcUGRNOgkW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGfeKwskPWuyWvNpZfv1OU/67A/N8A5I47HeGNDODiWUnBXOwvAck4L+JzECq41kYubhs5NkayugSaqYARl5jmhSwr+f9plTgUpCqYf2w2V0q7KNnHa9e6qea7EuNRKj5beou4PyzcY8pGXKjBO1d/4Xdjxp1ROFuhRgPQ5DTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGEwkJOv; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b17ca6d-73c8-408a-83e5-9951d5d53517@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747964449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlSzJG3XR72UGdbIGS63Mnadz4DZpeLnkGG1eAC+Cnk=;
	b=QGEwkJOvSM9OVTV7F9p9Cfo8jgCyNT7IPNNTnO2Gz3sDEe/l3QovquAXtyP+IArsOfkS5c
	sQp7GcQsxT0kc8V+XePVezuvVQyyAR54mbjBgFWI703fy/U6Nq4gs64DNbu+YGstODfUVN
	Bl0dVew3Dby+ctfGkwqNqtzLWNx61gI=
Date: Fri, 23 May 2025 09:40:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Jingwei Wang <wangjingwei@iscas.ac.cn>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>,
 Yixun Lan <dlan@gentoo.org>, Tsukasa OI <research_trasio@irq.a4lg.com>,
 stable@vger.kernel.org
References: <20250522073327.246668-1-wangjingwei@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250522073327.246668-1-wangjingwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/22/25 3:33 PM, Jingwei Wang 写道:
> The riscv_hwprobe vDSO data is populated by init_hwprobe_vdso_data(),
> an arch_initcall_sync. However, underlying data for some keys, like
> RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF, is determined asynchronously.
> 
> Specifically, the per_cpu(vector_misaligned_access, cpu) values are set
> by the vec_check_unaligned_access_speed_all_cpus kthread. This kthread
> is spawned by an earlier arch_initcall (check_unaligned_access_all_cpus)
> and may complete its benchmark *after* init_hwprobe_vdso_data() has
> already populated the vDSO with default/stale values.
> 
> So, refresh the vDSO data for specified keys (e.g.,
> MISALIGNED_VECTOR_PERF) ensuring it reflects the final boot-time values.
> 
> Test by comparing vDSO and syscall results for affected keys
> (e.g., MISALIGNED_VECTOR_PERF), which now match their final
> boot-time values.
> 
> Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> ---
> Changes in v2:
>    - Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
>    - Updated commit message to provide a high-level summary.
>    - Added Fixes tag for commit e7c9d66e313b.
> 
> v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingwei@iscas.ac.cn/T/#u
> 
>   arch/riscv/include/asm/hwprobe.h           |  6 ++++++
>   arch/riscv/kernel/sys_hwprobe.c            | 16 ++++++++++++++++
>   arch/riscv/kernel/unaligned_access_speed.c |  2 +-
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 1f690fea0e03de6a..58dc847d86c7f2b0 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,4 +40,10 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
>   	return pair->value == other_pair->value;
>   }
>   
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_vdso_sync(__s64 sync_key);
> +#else
> +static inline void riscv_hwprobe_vdso_sync(__s64 sync_key) { };
> +#endif /* CONFIG_MMU */
> +
>   #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 249aec8594a92a80..2e3e612b7ac6fd57 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -17,6 +17,7 @@
>   #include <asm/vector.h>
>   #include <asm/vendor_extensions/thead_hwprobe.h>
>   #include <vdso/vsyscall.h>
> +#include <vdso/datapage.h>
>   
>   
>   static void hwprobe_arch_id(struct riscv_hwprobe *pair,
> @@ -500,6 +501,21 @@ static int __init init_hwprobe_vdso_data(void)
>   
>   arch_initcall_sync(init_hwprobe_vdso_data);
>   
> +void riscv_hwprobe_vdso_sync(__s64 sync_key)
> +{
> +	struct vdso_arch_data *avd = vdso_k_arch_data;
> +	struct riscv_hwprobe pair;
> +
> +	pair.key = sync_key;
> +	hwprobe_one_pair(&pair, cpu_online_mask);
> +	/*
> +	 * Update vDSO data for the given key.
> +	 * Currently for non-ID key updates (e.g. MISALIGNED_VECTOR_PERF),
> +	 * so 'homogeneous_cpus' is not re-evaluated here.
> +	 */
> +	avd->all_cpu_hwprobe_values[sync_key] = pair.value;
> +}
> +
>   #endif /* CONFIG_MMU */
>   
>   SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 585d2dcf2dab1ccb..81bc4997350acc87 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -375,7 +375,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>   static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>   {
>   	schedule_on_each_cpu(check_vector_unaligned_access);
> -

Although no one stipulates that a blank line must be left
before the return value, this patch is not intended to solve
this problem in the first place, so let's not delete this
blank line in the patch？
> +	riscv_hwprobe_vdso_sync(RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF);
>   	return 0;
>   }
>   #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */

LGTM, So

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng

