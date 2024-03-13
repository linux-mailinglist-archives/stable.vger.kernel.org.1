Return-Path: <stable+bounces-27556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BB87A1C3
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 03:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9460282985
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3DC144;
	Wed, 13 Mar 2024 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qJEHcIVT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC710953
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298428; cv=none; b=mvtKGnJFwHrIUL/TL1nCNpcsEs0e//SqiJAz2jE/n102XHZO3NW4UkgxH0UaVmCxxev8p8fKlz4U+cOXtX1T+QcEFkc4tQwn7q92qYkPdGPUEieviKGPIRPetY0RsadAHbTiD1AnzbVup6Qn888iDVw5/jdxWU4kyzQGq9n9PgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298428; c=relaxed/simple;
	bh=NTReDqVivR5/vZLdG6BnZ/KUXkuOSC6UjdiNqkzytqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg594TRvuU2pFP9cssxiiAo2UtnuWPdL4IfwTgHzRcECE3MPP6UGL6u6uJzq4tqQc6VcFHTMKEDGsgx86Pr5yIeylJqwUBZauPh9SjotPuEFcxCizeY2FWxeEJ0B0I8UIyuIOu8u+0Pl+xomcnifto08BNVeJOweljesEtyRg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qJEHcIVT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49b00bdbso37851625ad.3
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710298424; x=1710903224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm82SO2BpNSLFwSI+4lS3PD4XXk2jhZjxDf4bI5jTqc=;
        b=qJEHcIVTcj6GmJpb6OE16HbVqrcC2kZ5qEah7cpZwtRRaLG65cUBJG+qZwEq7o35Ta
         kGqetRykhN0mwUkkd0B250yGIpgmyQqtmV8+YFDe/U1+HBMTskioGFNA8Paj5M9hLnTc
         wo1f3phW7GR5eCLT1PZW8B70XOPi016+BVU6hAjePU9Io2nW6pRbYvSZA26RBJ5OjLpK
         oBH6Sj4Xx8/qZT1T/l7TNiwBkvhkGEAhGyML9FGaHVjsAyxvpuSmSWiemWsTzLUNHOR1
         9h4JFZmUDHluCfCGlxgYqF7VYdSZGTAbB/XUXEAWmxq5+JN9thmnHOPjikamTlinHL6H
         Hajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710298424; x=1710903224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm82SO2BpNSLFwSI+4lS3PD4XXk2jhZjxDf4bI5jTqc=;
        b=LBTRCseLKy/p9qxuetAAeVHJ75cLTPfBylFzoEMSTxv4a63QiIvKIYXG3h84/Z4d/3
         eCcIZyiuXIWm7auH4UFtKqEcf3Z7B4aP024LuAUqdJIm9znvKH+8NoB+ltMejgGrUKFV
         4vjkJNUMxlIKdWdtFTd/6bViuN3oN7nApgz+elF7fLUlR3TRsymMyeMp6Z6Mf7xC+BzL
         xKBeiPmhPyrIWOZoqzV7I4yAfxlytBTxZKHgRU9L7TRV1EllMeyINJTiiGF99trd/3YW
         4bFQZYdEt799VUPX3q6glTA6MbvlascUKt/sAmAOG4GgpZYRa1W1/LyoFeBmwGtaxQcV
         2vmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyt6q6/TVn9zmhboe60YAHgylfx04KbZ6zCOiHg/DZBN60m6Ut7lx4hN160rG6G9exx5GHuldFHRMoG8xmlTCUf4wouu/D
X-Gm-Message-State: AOJu0Yw+OD3fqEZCIjKWh29yzvhoDLYc/N6JQV838ZTHMgPXyw2kJ+ZE
	TceKHge400YaJn316K5MtSgMnrRByh3M3iYFbWMl50BnjLX3RDxfP/rJ9ZzOSgo=
X-Google-Smtp-Source: AGHT+IGWxCpTXsK47de51P3AiM9hzji/3eB3TD8nuRB8rKNVi8mjNxa71yE5XsNC9R6lpX1df1eX9w==
X-Received: by 2002:a17:902:d2c5:b0:1dd:9984:29d3 with SMTP id n5-20020a170902d2c500b001dd998429d3mr9473835plc.32.1710298424071;
        Tue, 12 Mar 2024 19:53:44 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:733c:479a:4b7b:f77b])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001dd55ac5d78sm7442926plh.184.2024.03.12.19.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:53:43 -0700 (PDT)
Date: Tue, 12 Mar 2024 19:53:41 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
Message-ID: <ZfEVNbt9AMeVJS0k@ghost>
References: <20240312022030.320789-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312022030.320789-1-samuel.holland@sifive.com>

On Mon, Mar 11, 2024 at 07:19:13PM -0700, Samuel Holland wrote:
> These macros did not initialize __kr_err, so they could fail even if
> the access did not fault.
> 
> Cc: stable@vger.kernel.org
> Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> Found while testing the unaligned access speed series[1]. The observed
> behavior was that with RISCV_EFFICIENT_UNALIGNED_ACCESS=y, the
> copy_from_kernel_nofault() in prepend_copy() failed every time when
> filling out /proc/self/mounts, so all of the mount points were "xxx".
> 
> I'm surprised this hasn't been seen before. For reference, I'm compiling
> with clang 18.
> 
> [1]: https://lore.kernel.org/linux-riscv/20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com/
> 
>  arch/riscv/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index ec0cab9fbddd..72ec1d9bd3f3 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  
>  #define __get_kernel_nofault(dst, src, type, err_label)			\
>  do {									\
> -	long __kr_err;							\
> +	long __kr_err = 0;						\
>  									\
>  	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
>  	if (unlikely(__kr_err))						\
> @@ -328,7 +328,7 @@ do {									\
>  
>  #define __put_kernel_nofault(dst, src, type, err_label)			\
>  do {									\
> -	long __kr_err;							\
> +	long __kr_err = 0;						\
>  									\
>  	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
>  	if (unlikely(__kr_err))						\
> -- 
> 2.43.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I am not able to reproduce this using Clang 18 with
RISCV_EFFICIENT_UNALIGNED_ACCESS=y on 6.8. However I can see how this
could be an issue.

Going down the rabbit hold of macros here, I end up at
arch/riscv/include/asm/asm-extable.h where the register that hold 'err'
is written into the __ex_table section:

#define EX_DATA_REG(reg, gpr)						\
	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"

#define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
	__DEFINE_ASM_GPR_NUMS						\
	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
			  __stringify(EX_TYPE_UACCESS_ERR_ZERO),	\
			  "("						\
			    EX_DATA_REG(ERR, err) " | "			\
			    EX_DATA_REG(ZERO, zero)			\
			  ")")

I am wondering if setting this value to zero solves the problem by
hiding another issue. It seems like this shouldn't need to be
initialized to zero, however I am lost as to how this extable setup
works so perhaps this is the proper solution.

- Charlie


