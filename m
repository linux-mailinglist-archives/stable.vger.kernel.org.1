Return-Path: <stable+bounces-159110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9433AEED30
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 06:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6815189A44D
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 04:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782C17993;
	Tue,  1 Jul 2025 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20230601.gappssmtp.com header.i=@lixom-net.20230601.gappssmtp.com header.b="o9/oF7Pk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D94C79
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751343378; cv=none; b=dDQyijf1LvJqUy2TLuX+wG0MH/d5MuJTVo0jPN/uYLHFXvvgwTMjIMuLK4JhjvmpzzsUCUU17EENWRaUHE8VRBIieww4jtSGus6Xx3ekZUU+RvJLeSdVUasY7Rw6Sq5xSHLxKU5Qjn+h+NkB+iQ2noDDfO7toQ42JyU5wiPN8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751343378; c=relaxed/simple;
	bh=STg42VIPtK2jkqWr0dFU5WoLrxsP6lgiks3OXWgnmV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ijLsXkV/jCXrySK8JMCYSQFmMZVjrwN6ToJo2I+xsOtY708/aiUmv33/7BvwBEHeD4mDqHHSttqjoNTyCiuMMP8ui0egTQbD4LgFBDUMkeO49Dud9T7KQ2ED9ODN9n7vu6OKLaPuuSIXpLAX3ZBWtJRI4Khw26Ieu1O48Gyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net; spf=none smtp.mailfrom=lixom.net; dkim=pass (2048-bit key) header.d=lixom-net.20230601.gappssmtp.com header.i=@lixom-net.20230601.gappssmtp.com header.b=o9/oF7Pk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lixom.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5786194b3a.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 21:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20230601.gappssmtp.com; s=20230601; t=1751343375; x=1751948175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih9T4CCmskKJGlCypNtvtt9gxqtXmA+YvXo79VcNoMA=;
        b=o9/oF7PkyWexKL9h9rH6VXT/HtFbNvQmNSP5SuYuISRC9XuM63fnELLlHEY4yNxLh2
         fIXzxTRjVm1RqGAJZKuLigBWOeKxgmI+wejvj6emhqqJ52G8rdxZtVeuNjWg52220O6h
         5oHtcadhXpWlYpLj08x1FHhNdtCIxLwnN4ovy++f20s5v9MQMGPnPs5ehcUYl0PSzomq
         DAuWcmwlHmMhJjKleg0pfifRmsEjVN565Z3Ge34D3WXIQqEoHRq7t6UdeOB9mJ18WG+c
         aM3B+rpvEy3248Fe4hwXU7tPjx7nN7GyPv5rOQy0m5dmHj+1+q9wqUNItcMnSnqBxzA6
         c9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751343375; x=1751948175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih9T4CCmskKJGlCypNtvtt9gxqtXmA+YvXo79VcNoMA=;
        b=FLrh+3yfC4y6WkS85qQE7l6GzGAyjReysIvw3THYnVgaCNeFCLvCvxPxo17NIxYCrp
         ZwjVNtwhgdV+KurFKmotcIcuG38E7yl6MyM6c55jwsb6jvTAymCYZCC1rKU+ZSBuUXem
         9f6IS55oP29SKcPWkD50WMmN3+3IoRl5FVIDFx6dIJ7f/5xWvsQJg0fuQsq7+h13oK/q
         J287STEdzz/DklvnW496VSVpzeNwBQJ+KeFLus9psH06ozmBoRCChHIvngylQLY5G6gc
         sKgrHuB/F6JRWdxfstakWWoDIsyjkkRDfM0dnI+cC0sOvx6VaA4zpVhk1JfHs/s2v8t+
         +r0g==
X-Forwarded-Encrypted: i=1; AJvYcCWJKBaIK/3/4w+220wl+B33Hked31MKfl6PtAPzge+HxcwS3q3U9RyJkHOVhgBkXmOlRA3cGyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDBIIw/WReya/wmjSX3ILnb+9YWCw4pEuMFNa8rKLxTXaSIJX
	9NLuIiZ/RFjcaLUvNxhXZXLBquETjWwkoVAeK6tLpdVoPEmLAcqFrrVoe8DD+KvJfgI=
X-Gm-Gg: ASbGncuxYF+f0wT7Nx9Pv7CqhHUzUb9aFj13AtqMIegxjQig9wPHo86QrKrMU1YvPAG
	GDRVIsTvC2pev0B/QLaNub7SwZCJzAKDtEhRPgt9XlQGMDYOPP4uQZC4nIbmwa2qrnnynFjq3Qm
	H+sEinz8Yj710a4AeHtJ6bpj+ZMPtMJxSeGWfk3zXP6l0T6/shjZ4iCAwo3dqLzLn1ec2PLtBuy
	Im3K5filFb2ontYdohrCKYnRAgTyr38qkJlNQpfUdI6bIRX6nTligeE1tPT4LkNLTATF9/uIA7g
	M2RSbXAuPPmE1UpSSApoTQ4waX9IIFKHKR7FRY4CEhBl5srQfG1wBWqaFfmPJZ5PjMsOuaMzGYM
	rT1BYKw3rMDsr79PtArDDKbI8oTH6
X-Google-Smtp-Source: AGHT+IHXJXpgKPECdLF+1KJMcXzz2DyFCD8l8YmHdLjDAtAzJXuF/Z6q4FSlcfieQOxR026JITE3ag==
X-Received: by 2002:a05:6a21:392:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-220a169ca84mr19671016637.25.1751343375502;
        Mon, 30 Jun 2025 21:16:15 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e5c1sm10652356b3a.70.2025.06.30.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 21:16:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 21:16:11 -0700
From: Olof Johansson <olof@lixom.net>
To: Jingwei Wang <wangjingwei@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>, Yixun Lan <dlan@gentoo.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Tsukasa OI <research_trasio@irq.a4lg.com>, stable@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4] riscv: hwprobe: Fix stale vDSO data for
 late-initialized keys at boot
Message-ID: <aGNhC3mtpT8x_Z6V@chonkvm.lixom.net>
References: <20250627172814.66367-1-wangjingwei@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627172814.66367-1-wangjingwei@iscas.ac.cn>

Hi,

On Sat, Jun 28, 2025 at 01:27:42AM +0800, Jingwei Wang wrote:
> The value for some hwprobe keys, like MISALIGNED_VECTOR_PERF, is
> determined by an asynchronous kthread. This kthread can finish after
> the hwprobe vDSO data is populated, creating a race condition where
> userspace can read stale values.
> 
> A completion-based framework is introduced to synchronize the async
> probes with the vDSO population. The init_hwprobe_vdso_data()
> function is deferred to `late_initcall` and now blocks until all
> probes signal completion.
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
> index 7fe0a379474ae2c6..87af186d92e75ddb 100644
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
> +inline void riscv_hwprobe_register_async_probe(void) {}
> +inline void riscv_hwprobe_complete_async_probe(void) {}

These need to be:

static inline void riscv_hwprobe_register_async_probe(void) {}
static inline void riscv_hwprobe_complete_async_probe(void) {}

Or else you get an global instantiation of them in every file that includes
them, and compilation errors about duplicate symbols, as seen by
nommu_virt_defconfig:

riscv64-linux-gnu-ld: arch/riscv/kernel/process.o: in function `riscv_hwprobe_register_async_probe':
process.c:(.text+0x170): multiple definition of `riscv_hwprobe_register_async_probe'; arch/riscv/kernel/cpufeature.o:cpufeature.c:(.text+0x312): first defined here
riscv64-linux-gnu-ld: arch/riscv/kernel/process.o: in function `riscv_hwprobe_complete_async_probe':
process.c:(.text+0x17c): multiple definition of `riscv_hwprobe_complete_async_probe'; arch/riscv/kernel/cpufeature.o:cpufeature.c:(.text+0x31e): first defined here
riscv64-linux-gnu-ld: arch/riscv/kernel/ptrace.o: in function `riscv_hwprobe_register_async_probe':
ptrace.c:(.text+0x714): multiple definition of `riscv_hwprobe_register_async_probe'; arch/riscv/kernel/cpufeature.o:cpufeature.c:(.text+0x312): first defined here



-Olof

