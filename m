Return-Path: <stable+bounces-109170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA6A12DC5
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D443A1C91
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B91DB15A;
	Wed, 15 Jan 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Iz7Ce5sr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493801D7E5B
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976828; cv=none; b=QPPi71V+v2DbD36z8/GXXxIlYtG5k9IUXd5opzw1XuxSx3Zm5lmnt8Pyls0ywG5EsTccPmf93NKtGXO+Fa6LrOEKNQhGAy7eCp+HBET2DGgqtOMeIuyEIqTXd7f7gJwD/zmhEjkKCxCMLJzOCiaCICIIr7uCLMKhezTcphJqO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976828; c=relaxed/simple;
	bh=h+NaRM7QL9IiCXNPkpaGcgGYiV9vj98spnFFYr03YdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2TFLja4HPuaL/rMu8GiO7T4+hdUXVZ569qztLPi4fkR3h5rPficlPX49HHsdTlaO3tFXY9O3TEQYUFZd5/610i/k5DIwDlwZpqT76QE/wk3xv3oOLbwwqaussilu3oRNW3bmVu5on39q8sGszUwu+hHAV9cfYxcgNJQhyUxA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Iz7Ce5sr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee74291415so387442a91.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736976825; x=1737581625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qo4ETtsJlbJYJPy25LzBlpSKy4jxFb72+aJIYM6Qmdo=;
        b=Iz7Ce5srZT5gfoDZYLv0SnxKNpjll61OVuimoOtJKvYm5hvlCn+OImr+w2QAwPMXjg
         vjjKGUocKVsnv5b3/1I+XSEP5I0o3DB2nbGtz/cbrTahO/tD++CuwWXB0sBnT4xDbHhI
         UFvreKQKQ8pIE0UYy8okrUmR0bTJTOK0Rs2hdn9K5EJ8oWDVQyn8S2OeKPEkS15f4Y1O
         QpLJPTUXs2H/RXWoZxYlVw3K7BqnuK7G5hT6VGVYwsC1fuwdEYFbqARcPEzuXinfPm8W
         cXsN5O+AKl6ku4ClL4BF3WMLjtMP08HVnRfAPWu9kHf1tOQkkrGFEZFIHibHXITxWVfC
         ybag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736976825; x=1737581625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo4ETtsJlbJYJPy25LzBlpSKy4jxFb72+aJIYM6Qmdo=;
        b=S3IbQa/ROJy6L9tcbrjRUpf0i35cBfzYsTzspQ/CeQpV328WIf4VB5qHAsJ12Z81fB
         GZApQyhor5kD/IrOeb6nCZt6F/Wm3hOOQ+kIKxaz7687bum08jLZJVePON7fuE283qcQ
         yEdiCXHW7MISiy5pspWaVCqybVVayIVsqy19kqxEAUBmei9LWgvI5X0kcuq+luQHdSqK
         6rexWGzxUq5iHGDYRG9dkgsvJPC+zD/8VrOgB/rIqx+uPcatyQjycxD9Uge+vxJsBtif
         Jyxe8CCVL7mjI75ck2Susx7rFbFVeOib3tQ37LK8OWZdbH1MIZ3r1W0DYTO9N2DlRlSG
         T1zw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZKv/vmbCkCwjW6RIB2KkWsbPAtHUkRvAIml9n5KzVXVjj6XY0PiswHHcpwseNzrjrczGaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFB2uEYJ0T+KGh4J1A0JBiOsy17+9sASn9GbXNk1GbFUVmpUyH
	Skacky12NrCrJizxv1SBj3TL2V1607DHyE8EnYB0AUwu4H9wOCjOKdLyMuc7Zf8=
X-Gm-Gg: ASbGncsIZI1fNqhA3dmzFFCumrpLQgs89M/UcykU6FK9+R0sjphHjcUUb6zd+PpaJn6
	u2OC3keUDhFy7kJhXD51rPLt9K5smSbs0i/iw+bLUmBDshn/615uiN0pqzdNS7CXjjQ8iu+oHxi
	8hOc0z8hdy/OWVqIm6GIC/h+3qpuRLaQtIiQpaJHu9SG3E10Q83UZb+WZpSltHoWH7/jqBlNJBV
	qRYz9gmQKizKSBRmYe3WekPevyZxhUi0FZufY8/+xMmNlc=
X-Google-Smtp-Source: AGHT+IHeBFp9ozsD00dMGeBP70l/6pdoK1N3rRLqykt0VBwwJZB2RSCK6+oNoGuy+C0NCfg+cpgwSw==
X-Received: by 2002:a17:90b:518b:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f548eba7d0mr45962466a91.15.1736976824059;
        Wed, 15 Jan 2025 13:33:44 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c17fa66sm2035101a91.13.2025.01.15.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 13:33:43 -0800 (PST)
Date: Wed, 15 Jan 2025 13:33:38 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v6 1/3] riscv/ptrace: add new regset to access original
 a0 register
Message-ID: <Z4gpstfwOanEy_Ck@ghost>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
 <20250115-riscv-new-regset-v6-1-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115-riscv-new-regset-v6-1-59bfddd33525@coelacanthus.name>

On Wed, Jan 15, 2025 at 07:13:27PM +0800, Celeste Liu wrote:
> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
> 
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
> 
> Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Thank you!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  arch/riscv/kernel/ptrace.c | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..ef9ab74c8575a5c440155973b1c625c06a867c97 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -31,6 +31,7 @@ enum riscv_regset {
>  #ifdef CONFIG_RISCV_ISA_SUPM
>  	REGSET_TAGGED_ADDR_CTRL,
>  #endif
> +	REGSET_ORIG_A0,
>  };
>  
>  static int riscv_gpr_get(struct task_struct *target,
> @@ -184,6 +185,29 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
>  }
>  #endif
>  
> +static int riscv_orig_a0_get(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     struct membuf to)
> +{
> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
> +}
> +
> +static int riscv_orig_a0_set(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     unsigned int pos, unsigned int count,
> +			     const void *kbuf, const void __user *ubuf)
> +{
> +	unsigned long orig_a0 = task_pt_regs(target)->orig_a0;
> +	int ret;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	task_pt_regs(target)->orig_a0 = orig_a0;
> +	return 0;
> +}
> +
>  static const struct user_regset riscv_user_regset[] = {
>  	[REGSET_X] = {
>  		.core_note_type = NT_PRSTATUS,
> @@ -224,6 +248,14 @@ static const struct user_regset riscv_user_regset[] = {
>  		.set = tagged_addr_ctrl_set,
>  	},
>  #endif
> +	[REGSET_ORIG_A0] = {
> +		.core_note_type = NT_RISCV_ORIG_A0,
> +		.n = 1,
> +		.size = sizeof(elf_greg_t),
> +		.align = sizeof(elf_greg_t),
> +		.regset_get = riscv_orig_a0_get,
> +		.set = riscv_orig_a0_set,
> +	},
>  };
>  
>  static const struct user_regset_view riscv_user_native_view = {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cecc0f9de90ee66bfffd2137f4275a8..390060229601631da2fb27030d9fa2142e676c14 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -452,6 +452,7 @@ typedef struct elf64_shdr {
>  #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
>  #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
>  #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
> +#define NT_RISCV_ORIG_A0	  0x903	/* RISC-V original a0 register */
>  #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
>  #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
>  #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
> 
> -- 
> 2.48.0
> 

