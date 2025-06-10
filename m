Return-Path: <stable+bounces-152357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF07AD45F1
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 00:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9357AC06C
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79D28AB07;
	Tue, 10 Jun 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="WdJKT9R9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990A27FD73
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594358; cv=none; b=oakr+L0cirP3P0B+9LC4oNq9dcsEltnhoyS87OxqrB+RgqS107+AMM2ropmTsj/lVDrnZYTTrvZhsXlQExG9dBw+VGIi2304HDNXjB9m+gS1aqo9/zXOXeiYwnNb178H1NRqnRmU7iCiv3PiH/t0DWRIxANEvpOLle29AcGqujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594358; c=relaxed/simple;
	bh=b29np2dwwhfBDON2fluNkVVEDXoKGD/uA6jTSN380Ds=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=OKnml1zx62kShUfvDS25e3tgaM5FMGtsZFuIJ7KjyNIoeRneWUUfCtgP+6jQDl11g7bp3rmW4+sE1rqd9n9abLJ0m7grt7Lb8m2uMlupH1TAZevKq+WOhgPSgRQ5cIADPM8f1cYMCL4mTdAcRxiXrEmvdH8d2c5SslE+g3l5fD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=WdJKT9R9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso1976402a91.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1749594355; x=1750199155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dpwcZY5ynN16etaZr5TaZQpWfYppiovOVodgkPulHI=;
        b=WdJKT9R9F6uLztpfP1833h903dfM1CYrexS81Mm0jml5CSX+GlKd2H3tzaKH+cGTAr
         +Yu4kpLpXKDn5Fyq0nk0DHNB9ssGXppAfVk+3YElUVaJS09OlVa3eFTBVkKg160MuMf7
         nwBC/6vcML+MxZTkiAUjmwOEsZ0qV7vCjGDzmGt9vYUtYmFriWN1kE5nrz9ubz1ZejlN
         eKCLZ5TqbFhmJ85TxKPuYzlPYzF4yKPqPfPYu7JDZWjSIc9A0tlGEmGmireBp9TyitAl
         lpetaQXCdDNwzpL5kyvLPLQqCFpJzNJYsxj/wrNZhFwmAmra0yMTiuOEh3N4fZYNureV
         dYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594355; x=1750199155;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dpwcZY5ynN16etaZr5TaZQpWfYppiovOVodgkPulHI=;
        b=w5D2+lHD2iK6DjMrjJdldm0PB8JlTszeymYobYo93YQVLeKi44zOUzx6keoWGW+VVL
         RwxHdklWtS0iRKHh5GfbFlNKCL5kpP35wPC8BhcqFAJvgLXWZ9NVSY5tXyHPb9/072FO
         k+EsVqmciRjGoIxDZl0GmKVDQEWzPlubhH5Q72uxqceEnxZwrtgy85+KtFOe0XWA3T4e
         xUjl4z04SqcR8ohTjUVT6WXGHrpfvE7C1U5iF4fvSKzHQVrOUwSbNM5CPHN0dZbEOwW9
         /7uxQ4Y+It/I/Rh/Te7xdx23uT2m1l6ei6BB60q3Dt/XSLYSBOKeELOc+cevBZA233J3
         SvDA==
X-Forwarded-Encrypted: i=1; AJvYcCVuFMq4cC79G6WEPUdz3NmASbfMRdoJTSqy6rh9ENv5Dvi1lO3SplOAprZpncCC50q7EEiC+SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhCFhF/UbYAJA7cfJHo8iuh+TfzMNClIGsR4BjH8KA629N/Ob
	OFH9BQd23PjVeolG6K/L/q/lUkzmmPzywC7LWu3xtfc3axswI+BCyEQO+GP8SA68gV4=
X-Gm-Gg: ASbGnct45Az22gBNmbCn69Oj0WhWGZCpJJ0XI20jlFoBGwMbc3AGrgKhfmJ1zTgWBW3
	kM3DTz0HgjawsFxAyRg9OdKZ7Wikoq9eh0KPib1gPvz7egO3UZGCAUgirshR1md6grv7JKYGmaG
	4PM355YN2G7tLxMP/i1+7d39sGHzKWTp0uYcH3wXrEcfGyHgsSMf1A6WsHxitz3u9RspCAPB735
	4u0HgUCg/B2s0CGUeHMquey+95xaF7eri7INTRS1CFUfBftUrWSXMSdM/NQkgZ+xNCNIJYxBipc
	V9ESSYNEVPOSoK2dHxa0HPZx0kqbVY4r9jpjTa1Rw19uZ+deR5HOOsSKfsva
X-Google-Smtp-Source: AGHT+IEXez6ef6MRwgOq/i+THZa2e1vR90BUGdf2GTUMezKIA+frl+RMV2NXJyuX+QHfG2OrFO9yug==
X-Received: by 2002:a17:90b:5404:b0:311:a623:676c with SMTP id 98e67ed59e1d1-313af243c3bmr1647811a91.27.1749594355414;
        Tue, 10 Jun 2025 15:25:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:116a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603c6c325sm74793705ad.173.2025.06.10.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:25:54 -0700 (PDT)
Date: Tue, 10 Jun 2025 15:25:54 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Jun 2025 15:25:36 PDT (-0700)
Subject:     Re: [PATCH v3] riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot
In-Reply-To: <20250528142855.1847510-1-wangjingwei@iscas.ac.cn>
CC: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>, ajones@ventanamicro.com,
  Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com, Charlie Jenkins <charlie@rivosinc.com>,
  jesse@rivosinc.com, dlan@gentoo.org, si.yanteng@linux.dev, research_trasio@irq.a4lg.com,
  stable@vger.kernel.org, wangjingwei@iscas.ac.cn
From: Palmer Dabbelt <palmer@dabbelt.com>
To: wangjingwei@iscas.ac.cn
Message-ID: <mhng-FC7E1D2C-D4E1-490E-9363-508518B62FE5@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 28 May 2025 07:28:19 PDT (-0700), wangjingwei@iscas.ac.cn wrote:
> The riscv_hwprobe vDSO data is populated by init_hwprobe_vdso_data(),
> an arch_initcall_sync. However, underlying data for some keys, like
> RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF, is determined asynchronously.
>
> Specifically, the per_cpu(vector_misaligned_access, cpu) values are set
> by the vec_check_unaligned_access_speed_all_cpus kthread. This kthread
> is spawned by an earlier arch_initcall (check_unaligned_access_all_cpus)
> and may complete its benchmark *after* init_hwprobe_vdso_data() has
> already populated the vDSO with default/stale values.

IIUC there's another race here: we don't ensure these complete before 
allowing userspace to see the values, so if these took so long to probe 
userspace started to make hwprobe() calls before they got scheduled we'd 
be providing the wrong answer.

Unless I'm just missing something, though -- I thought we'd looked at 
that case?

> So, refresh the vDSO data for specified keys (e.g.,
> MISALIGNED_VECTOR_PERF) ensuring it reflects the final boot-time values.
>
> Test by comparing vDSO and syscall results for affected keys
> (e.g., MISALIGNED_VECTOR_PERF), which now match their final
> boot-time values.

Wouldn't all the other keys we probe via workqueue be racy as well?

> Reported-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Closes: https://lore.kernel.org/linux-riscv/760d637b-b13b-4518-b6bf-883d55d44e7f@irq.a4lg.com/
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Cc: stable@vger.kernel.org
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> Reviewed-by: Jesse Taube <jesse@rivosinc.com>
> Signed-off-by: Jingwei Wang <wangjingwei@iscas.ac.cn>
> ---
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
>  arch/riscv/include/asm/hwprobe.h           |  6 ++++++
>  arch/riscv/kernel/sys_hwprobe.c            | 16 ++++++++++++++++
>  arch/riscv/kernel/unaligned_access_speed.c |  1 +
>  3 files changed, 23 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 1f690fea0e03de6a..58dc847d86c7f2b0 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -40,4 +40,10 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
>  	return pair->value == other_pair->value;
>  }
>
> +#ifdef CONFIG_MMU
> +void riscv_hwprobe_vdso_sync(__s64 sync_key);
> +#else
> +static inline void riscv_hwprobe_vdso_sync(__s64 sync_key) { };
> +#endif /* CONFIG_MMU */
> +
>  #endif
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
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
>  #endif /* CONFIG_MMU */
>
>  SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 585d2dcf2dab1ccb..a2cdb396ff823720 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -375,6 +375,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>  static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>  {
>  	schedule_on_each_cpu(check_vector_unaligned_access);
> +	riscv_hwprobe_vdso_sync(RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF);
>
>  	return 0;
>  }

