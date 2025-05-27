Return-Path: <stable+bounces-146440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624CAC50A2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BCD179E33
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57906241679;
	Tue, 27 May 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="arOiftgd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8712DCC0C
	for <stable@vger.kernel.org>; Tue, 27 May 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355384; cv=none; b=L7OmxJebNwf3eZq9ym5QmuO4mLBQ9XDsSxPqhOdCKrDAJ2sZoIU7zrjzJ2iM8AjePIjZtTmgo2jfeirbhB18pEstKuSZO+2F5LcjHfAmDftzyl5DyVZNev5UwZghttFOqP5Un8VPAgJhCOzL7DUHRo9aZElON40pb9pA08CCR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355384; c=relaxed/simple;
	bh=4mPcWjgTlUexoSg+Tcw9gRiBd6H81JYoywFe6VsZBIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfvRiCwIM72C/3PPJdCyyAte/xTUdnIzRlx/32IdTMoMT615GdfePMekNe/o4L/Qxg0PQz0Qa0RDJcxVczKQm7+lpO5Cm/2FDBX4qSCNFDyTO/j02TuNjwPZBcNkNnpiaEF3VmwMcZd1KgD2njdflSB/Bkc37Fr97/sHaK42W4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=arOiftgd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e75f30452so6459687b3.2
        for <stable@vger.kernel.org>; Tue, 27 May 2025 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748355379; x=1748960179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmbA+KWJRYN4kKTsiIcnj3lBKzT+suvb8j4FzpdCenQ=;
        b=arOiftgd6FhTaQMVmPaC7g8jgxm6X2hwBCQtLuM8XpwOta+XGQxV4P+NEyIe/zwb9Q
         3jAaVo5Gc78ZyynFHU7yVo0cA+OGj90Tv/St4pjtityS47iUzefA0xEA6jobnrQNoiet
         5Gd1GyneTg3EwqzX99/hDpDGpNYgsa0Hw4kZxJ7PW0EPg6XIb1NzhiK2UJowtiiMkuCP
         zNBFIQJ3qKOZ9DarpMplQJXUDRAyRVqoaZEJtmaJIcZdKomGJXJ/ougEP09OJSedDuNS
         9XvKfrqBdrYyhjUBQ1+/FC/PxaezdD1A+5B7Ds61AdpyggRJsk3RfFnxws7BUhqbUnCk
         zk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355379; x=1748960179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmbA+KWJRYN4kKTsiIcnj3lBKzT+suvb8j4FzpdCenQ=;
        b=azUFKH7yMSOJJ9RMvHx/i8YNqy53Y/l8goITfv8iqo/e/9QKjFTBuoOABY7no4g6/W
         TbUonUe9/g2yuA1XJ283yDOJtqTCkrmr390MoXllubniXiecTAtK4wjBUOcSB9Ay03ky
         aQwebs5LrI2pgbtvRCLQqatFnL4RyBuz9Q7iB5bkZRK1JNz4bOzciUjTwSkvAPCuR+OB
         zv7eZXv4vvSZCQymW2CRjf9RDiAbKy6geMyYEFcIPtiWKpM7TzQyEzU9NKO1xlZ5IHFt
         xak7H27/mCiHkWxvj+2J1d/A2BUKQj8FRnlChJeohp+BopIHUzolDOd0TsDlqz7OSkHZ
         /G3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKWdAUlpFZ3VoE9jSooJoccNhV8D/P3rSaqN+h2NwnvZHqh3px4es+Clbl0bmup3bTfYHA84M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbimCJRMIiGUKLZfSSSz2mNJwOrdb3TzOOvQGp5VkKi6iC0KNu
	txiNdjTsdAXzYwjkye8dxYleA1ckm33qA1vPDI2x8CnkPYF08vVoNv1nVh5In/9QPXcN9PylNSg
	cyhHnExRiAoikwRtDq8gLJbPmxMHofolEsXMMKRZ2jw==
X-Gm-Gg: ASbGncu4cMcrcwke5D4H6o6GQ3/d02HuP494Nl+sc9+HN3gRoX+NILsc/jXRBEpd03f
	PD+zI0lponSDARBPxGzP98JDTjFWcvDxTcb6RIkTlh/xXw0UrJxQJek7s54TkxMfUX4GO/1uVGm
	2Jy+JCBOQW/yW4idwKeZhakBgpTwKLTrAW
X-Google-Smtp-Source: AGHT+IFByILDDr/4JzM7q1ErQtXRZlrRWCwnIfBaHYsuSnXyDDL9DfJP8bhytsWrU1Zu6nydSLvBhwu21NeAVkUU/QU=
X-Received: by 2002:a05:690c:9c0e:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-70e2d9488b0mr169827177b3.6.1748355378999; Tue, 27 May 2025
 07:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522073327.246668-1-wangjingwei@iscas.ac.cn>
In-Reply-To: <20250522073327.246668-1-wangjingwei@iscas.ac.cn>
From: Jesse Taube <jesse@rivosinc.com>
Date: Tue, 27 May 2025 07:16:08 -0700
X-Gm-Features: AX0GCFujEUw4VTFvWx9GiZk7vuvFRGBto3BjHiiDMXBQ8vtytZ3fpT-U5ypmk-Y
Message-ID: <CALSpo=Z=bfp4UxAJAD=8mjSGYUo7wb-=hhYWh62Ar-pQp7mv5A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
To: Jingwei Wang <wangjingwei@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yixun Lan <dlan@gentoo.org>, 
	Tsukasa OI <research_trasio@irq.a4lg.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 12:34=E2=80=AFAM Jingwei Wang <wangjingwei@iscas.ac=
.cn> wrote:
>
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
> Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d5=
5d44e7f@irq.a4lg.com/
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprob=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> ---
> Changes in v2:
>   - Addressed feedback from Yixun's regarding #ifdef CONFIG_MMU usage.
>   - Updated commit message to provide a high-level summary.
>   - Added Fixes tag for commit e7c9d66e313b.
>
> v1: https://lore.kernel.org/linux-riscv/20250521052754.185231-1-wangjingw=
ei@iscas.ac.cn/T/#u
>
>  arch/riscv/include/asm/hwprobe.h           |  6 ++++++
>  arch/riscv/kernel/sys_hwprobe.c            | 16 ++++++++++++++++
>  arch/riscv/kernel/unaligned_access_speed.c |  2 +-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 1f690fea0e03de6a..58dc847d86c7f2b0 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,4 +40,10 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv=
_hwprobe *pair,
>         return pair->value =3D=3D other_pair->value;
>  }
>
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_vdso_sync(__s64 sync_key);
> +#else
> +static inline void riscv_hwprobe_vdso_sync(__s64 sync_key) { };
> +#endif /* CONFIG_MMU */
> +
>  #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 249aec8594a92a80..2e3e612b7ac6fd57 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -17,6 +17,7 @@
>  #include <asm/vector.h>
>  #include <asm/vendor_extensions/thead_hwprobe.h>
>  #include <vdso/vsyscall.h>
> +#include <vdso/datapage.h>
>
>
>  static void hwprobe_arch_id(struct riscv_hwprobe *pair,
> @@ -500,6 +501,21 @@ static int __init init_hwprobe_vdso_data(void)
>
>  arch_initcall_sync(init_hwprobe_vdso_data);
>
> +void riscv_hwprobe_vdso_sync(__s64 sync_key)
> +{
> +       struct vdso_arch_data *avd =3D vdso_k_arch_data;
> +       struct riscv_hwprobe pair;
> +
> +       pair.key =3D sync_key;
> +       hwprobe_one_pair(&pair, cpu_online_mask);
> +       /*
> +        * Update vDSO data for the given key.
> +        * Currently for non-ID key updates (e.g. MISALIGNED_VECTOR_PERF)=
,
> +        * so 'homogeneous_cpus' is not re-evaluated here.
> +        */
> +       avd->all_cpu_hwprobe_values[sync_key] =3D pair.value;
> +}
> +
>  #endif /* CONFIG_MMU */
>
>  SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index 585d2dcf2dab1ccb..81bc4997350acc87 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -375,7 +375,7 @@ static void check_vector_unaligned_access(struct work=
_struct *work __always_unus
>  static int __init vec_check_unaligned_access_speed_all_cpus(void *unused=
 __always_unused)
>  {
>         schedule_on_each_cpu(check_vector_unaligned_access);
> -
> +       riscv_hwprobe_vdso_sync(RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF)=
;
>         return 0;
>  }
>  #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> --
> 2.49.0
>

Reviewed-by: Jesse Taube <jesse@rivosinc.com>

Thanks,
Jesse Taube

