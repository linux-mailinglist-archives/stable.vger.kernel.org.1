Return-Path: <stable+bounces-20156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E1854537
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA521C22476
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A0134C5;
	Wed, 14 Feb 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lUJ+pxNd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C241642A
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902957; cv=none; b=ZieiWKrcT4qPzE7I+yPCI9MOKGiGdTqd49FfSzXJ/VR5Pnu3XjBBI1+1mvEhQsg8jJJBn6YPe2dqrI7h/Inn5F+z/0tI6c88p1b/Y0TlCyJfbty7l5BVNbQ6JhQVv6eZulOFK/J9CFjwgB8g6GBMLNJYmfCAdaC51Vp3BZdq/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902957; c=relaxed/simple;
	bh=Upu2SWUrhW/35hgoaD1ciLNHHP2AgZTNscBKJpsggnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhuXpLxC4eqpvhy2LJdJWC6Qo8b8ybrd8BM4hgxJNuyeD+ipUUu2aPS/tA+t5H6xET1qnOFDcvDWgE2ht6e+NYoEZBehX92oiHuIuoj6TnIrJf83VuLPlGjdaemrMsa+rSuIUbUypMNQNslgn1Lkr2wptE58eQ8EM+EY/tI409g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lUJ+pxNd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411de7c6b3dso5109195e9.3
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 01:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707902953; x=1708507753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IDjaBFrcqK08V4TvukbGfzSrUeUUgCPpW8iYr8qsNw=;
        b=lUJ+pxNdglpep3gGYwdLtttirwi0LU5NO8sKEJHz2rWcaHRRfTKX8LPlW81TLqaCiU
         5pSuXOU/O/2eJDgp2gTOj2WDiPfkXt6oSenF51ELuoOb0E0OuhNMr7q2aUPjeg4eQ8Vg
         Ka0yrTIU7QUiLvi1ij1mTonhj1Kzl2Ddd7Hc/SLg6Az1jqvLxYIiKkDFfys6LAFK1F2w
         4u6NwTTd6+DiyFHj/kz3BLbBaL438v2umOhAU6HiMjxQXwyC4tj8GF3EDijD1+YBRV/j
         C1SBHu8MJUxiLmsA+r1VqE269Ui9XH33tA/pFAfXBYeIL/5M5jDZulzT9uBV1xMI3mVI
         aXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902953; x=1708507753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IDjaBFrcqK08V4TvukbGfzSrUeUUgCPpW8iYr8qsNw=;
        b=ww/djk3jB8eir+Hx2C7jHt0kMaxl8HzRXX836guE5CqOPgJ5Jo8OQUNmocu1iiKQy8
         myRtzWIpK02zrNf4NqW1CDyOQC4QDqvm7HKLYD3LK00vPn8OFLIQH9hmlGJxxIs7nMtr
         ZR4b+M5LFjmDGN6w9irQQifl8ChDrR4nzLJCjIgkU8xsmKRoubWTWpaKzVi/vlTUtaHt
         oSjx2fs+7b2FG4o8mmdP2OWAfzd9gNYt9tbb1PW2ULQOs+ygvRVYpp9IjIax8kndVcJs
         zANJbTJNBOQUMkysoZOv8b+zIXgDud+rTVV9uquLBLQDr8JSKQRyLMSzzwgPKyBP3yzJ
         hb0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRdNWgK4gz6QAkjrNu64zr9YVM9k/3kwldJlu/WxHrTAha11MaD2Zb6e0PqV191jhUrXTjJNVYY1PAac6V9n/4iBE45GeU
X-Gm-Message-State: AOJu0YyTmzSedrs2fIiP/jPkbf8KBYVdAwScLWLArlbCzuNMKgM0847B
	xQj6lRGP0ablU+3UjLBzrpFUhzDmFC0CAY/1HLmtQniJSmG0BFVW6HYiCcrdlLE=
X-Google-Smtp-Source: AGHT+IF35kx8fDcqPegx+LX9rbLQtQ9LFkKnwSLkrtYsJzFgxf26jqeRQbcx5k1Pg7huYacEIrcXHQ==
X-Received: by 2002:a05:600c:a48:b0:410:cc53:a358 with SMTP id c8-20020a05600c0a4800b00410cc53a358mr1975751wmq.16.1707902953626;
        Wed, 14 Feb 2024 01:29:13 -0800 (PST)
Received: from localhost (cst-prg-65-8.cust.vodafone.cz. [46.135.65.8])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c00c300b00411ec07674esm1012499wmm.31.2024.02.14.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:29:13 -0800 (PST)
Date: Wed, 14 Feb 2024 10:29:11 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v3 2/2] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240214-cd40380c3969dc9450f05848@orel>
References: <20240214090206.195754-1-samuel.holland@sifive.com>
 <20240214090206.195754-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214090206.195754-3-samuel.holland@sifive.com>

On Wed, Feb 14, 2024 at 01:01:57AM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
> 
> The [ms]envcfg CSR was added in version 1.12 of the privileged ISA, and
> is used by extensions other than Zicboz. However, the kernel currenly
> has no way to determine the privileged ISA version. Since Zicboz is the
> only in-kernel user of this CSR so far, use it as a proxy for
> determining if the CSR is implemented.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v3:
>  - Check for Zicboz instead of the privileged ISA version
> 
> Changes in v2:
>  - Check for privileged ISA v1.12 instead of the specific CSR
>  - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s
> 
>  arch/riscv/include/asm/suspend.h | 1 +
>  arch/riscv/kernel/suspend.c      | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 02f87867389a..491296a335d0 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -14,6 +14,7 @@ struct suspend_context {
>  	struct pt_regs regs;
>  	/* Saved and restored by high-level functions */
>  	unsigned long scratch;
> +	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
>  #ifdef CONFIG_MMU
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 239509367e42..28166006688e 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,8 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> +		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> +		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> -- 
> 2.43.0
>


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

