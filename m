Return-Path: <stable+bounces-19736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE52853389
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CDA1C27B0A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52A5789A;
	Tue, 13 Feb 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RV7VSI1j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC058106
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835758; cv=none; b=upTSVjiqvZiQrg80l86IAs0WNOh7fLcKmftYNMAPBkXIWcrYaDYV+w0/o0a2LdcBtYoXaugpKccCnXa0IW7tfqQQKGwu2b/7m1nfBbS6jarE93UntqkwNKit20opcCLzB/N6e39x39Cgd5dk7h7AGlUlkgs8AMqVfhXommbre4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835758; c=relaxed/simple;
	bh=FHSmpYdfwyE3kP9dlHAFbDIzGEDZA8QZLlp/HuYFx1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSCOBiQA7tn7LE3euEHnPMc2iTQVUASasl71cN6o4kWZHPxwfqrVhntNx0kdwpD95DidVA9KURYa5gT6bmcpBJRLSk4pr0f5PhniCpb06E/wAzaWf6sJjWusfJddqZswylkVM4I9RUkNGHid7ky0LVvRkTF5P9cGrg/OXP2ZztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RV7VSI1j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33cd57b86bfso560346f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 06:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707835755; x=1708440555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXJQUoDdwS+iTPfnGRrbEe+K9eyw1etfn33Hywo3Ilo=;
        b=RV7VSI1jcf4ooimpreD+4B/rv3r/wI6QJf1V8gq+2DZ7seNWPlbQ0a3yFg/JpIXxQ/
         krUUyvqt/SMA0+MZdPDLbUFNH+zM4dLDRseeDtr4m/PV6TFhC4S+1RMM4sdDGqq9p5A4
         J/nySjIofPJp1UyI533/wFPuBqq7lmBXEKGdXiOtXH50qWCgq1q3amKvrIGHfTYipsVz
         6hgYkPuibVElNS0XjpPgWJLSG8cYjtpCCxhB2yPf6La6lhysiFbYae+znUw2bJtg7nDF
         opY96WWGBBOnY7zkuaMeJxGxlzHoW9ygCbmv6BaaO4obcOzwpgwHZMyhAORPhHYcmtPo
         sSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835755; x=1708440555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXJQUoDdwS+iTPfnGRrbEe+K9eyw1etfn33Hywo3Ilo=;
        b=AWtgNn39Z9/29UPo9qE7BbXqMlSBjf/Abx/lPFd4+hXRMlSmHPjz01VMejg79j8sKH
         ZPwZLBxGOQm8BZ6HkrHKRMFLmrbXmI7IFcecaIr34YEt6bpYyWlh5EVIc1vYea7GIP4l
         ec1oXpcoWxAcVxiTBj6iEz9qEPo2Ei6gv3+Mq1TADksUzil3TCuYfsjrQgfT6BUdQk5s
         LLfLztrYK1AwZ7SeiUgI0k0Vb0pY0Plat2iSRtWHwjdM7HgLQZ4PMyqY3suHkSlIH+Bk
         uw2FkYGLsGetvmyzipPgTUR/pOZYtCfreHi7IAI+rBDCyacfm3zeExensvnO0XOJ4k+g
         tkcg==
X-Forwarded-Encrypted: i=1; AJvYcCU+iybjxDRNJCWByvyvehHfxGYZTvh1YxTiwnrQezxw4i4GhHeVEpP+0iXYrZ5PYBPL/KcAK5v7dsbXncf7pQtyxqIUyri+
X-Gm-Message-State: AOJu0YxEjOstNawqQmo5gA4vSPJvyRrpATOOj6Uc6zAvUBq3y0aSAOvD
	zTVNb4hBk4ilq3caD6rslWgC917sYIUs2iyYR3srlXItb2tjdOknWcHoXF9fDr8=
X-Google-Smtp-Source: AGHT+IG9C7SAShtPGr5zsMTscSXEtgpO3XA5ia8oUuLsEgFn9vYz7E19Z3TxoVMOdiJ8hl68kJVMhw==
X-Received: by 2002:a5d:5750:0:b0:33c:e2d7:79d1 with SMTP id q16-20020a5d5750000000b0033ce2d779d1mr380838wrw.69.1707835754661;
        Tue, 13 Feb 2024 06:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH748q7wAhr5L6ObVJfyI8Pj0jD0Qb1kE812vewtgBqH/Np1Ym/ZVQ03YOT45fC1GJU25rvnQodmlyht86tbJ9rYLpL2NVZz6PfZPX/bWXatoHnCeudMvTH3l+gIr05rjZ8Kmh4mvlp/hDHuKr8yrYKrbf6tqjIUN8ODuV82PBcqBgMXFP/fpd/a0UdAw9zpc/Sm5f2m8/IL2P
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b0033929310ae4sm9749747wrv.73.2024.02.13.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:49:14 -0800 (PST)
Date: Tue, 13 Feb 2024 15:49:13 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 4/4] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240213-86af3b49821630b5bdd76c0a@orel>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213033744.4069020-5-samuel.holland@sifive.com>

On Mon, Feb 12, 2024 at 07:37:35PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
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
> index 239509367e42..be03615486ed 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,8 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
> +		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
> +		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> -- 
> 2.43.0
>

We're still exposing Zicboz to userspace in hwprobe when only
RISCV_ISA_EXT_ZICBOZ is present, which will be the case for anything that
either doesn't implement 1.12, but does implement Zicboz, or maybe does
implement 1.12, but hasn't started putting Ss1p12 in its ISA string yet
(e.g. QEMU). We should either stop exposing Zicboz to userspace in those
cases (since it won't work) or rethink how we want to determine whether
or not we have envcfg CSRs.

Thanks,
drew

