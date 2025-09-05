Return-Path: <stable+bounces-177783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1EAB44DF1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EE97A13D4
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1654296BA7;
	Fri,  5 Sep 2025 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Bac3SwvD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CD2877D4
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053766; cv=none; b=rYYhlk1n2iUMuBooQN/e0hINuZH4H92UyYUna2YHM50kd+8PTuIzBfdJ31ti1Z8x76PZxXLhaqsnfobMSZ7UJQyHrwx3H3b6blgDWKtsnIysslDcAc3lFFx5CpP11PwkIUR+0E1jyXvuRGu+XqcEEeDm2ktnBiRoIq8eGOYBuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053766; c=relaxed/simple;
	bh=IewoYa4/sNEIWeRRtA4YvIv2AUnb+uETo37xTP3tPhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuuK+7roSyrKLd5o3lA0NVTZ6fjatbcSyBvnQUzOtI9gyaFjbyXMzt/a9SjZWCrsud3iJ6hCBl3dzKqsKogPOjXwcqqAXX28d9ADTEtLKaNMGGPWSOs4lEWnb0mZ4U0Pe1uG0SYROZzafesMafMy9Sf9Ue9ZjMX+r2YerbGQMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Bac3SwvD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso1357371a91.0
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757053764; x=1757658564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW7lMn0AUODjA3RFU0eDriejARFtJxq8hraVOainqwI=;
        b=Bac3SwvDoIDzc66sPfWaklRouxgTmQGTPBkQ6cqn1b4wVXQNcsU4qHRVPn3UP7CC3W
         k59f/Ock967WQrwuuHWQusPqjeHVP795Q8QNmOSOI2BP5gh/MS6VWPGRMGQTVfANMbMq
         /Z4dJNx4QyjbWa4MOkyB6OwOO+lqxilu4o2Qc5oGM/1BZGWAQh21IasiU8ZUYuTT4oXy
         h8KrgLkH1+bK7lDjvxAOiCKOlwtjYjQFuA+nbVX6mF1+Og9fajAYAb7GlJZuTWSnkK5k
         AaKnrDvXdLqPASaiEtFyHecq1Vp6eVtMVb48qOJFlEr/QR2fWA3+gEnZns+LGG53PgGE
         qguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053764; x=1757658564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW7lMn0AUODjA3RFU0eDriejARFtJxq8hraVOainqwI=;
        b=S1yR1ClDYjA35/SCMha2IeKMB7f3ekKbVvEogyJMb+thbZd9Qv0jwL3DESNyKbquvV
         06IQMrW/Nj4gOjh5cNWdPHWnWHX+DeJoDeods8eta8p/rrLCvHcyF54yxVRbcHIQVPd2
         6Dj3x3q1Gw9gN8AIOnYn3PDgE6DKg5Bj3j6znL2X5MmNrxmYbzIFCZZGrLObOF5Rqpk2
         /2doYC0BXgd+YXdps73pPfq44PaLlxgy3nfJb3rX1zVptCdoMtFsnMxjEQS76zkBnt4f
         Zi6bHMWaMmWCzcRN9SZFlRK8ml291VKOCZ7Vrcgs8gVSrezyLm3aZvESFNLaXx9wuzbN
         eEQw==
X-Forwarded-Encrypted: i=1; AJvYcCXmESmBQrWQA/XCC3yDZXN0CraQ6csLf1pg4NHSC4WgO7U6+sr9Vt2BzuCJZpk/m1f9JDNIJJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6daXDI29dOoMKEslI0oeD56aHOW1QsdhJfYtq+qBRXP+X5A1
	AcZUTWwtbr+DXWHJfpFFsyLXV3cL00EyJwqdn2oNzyZO6IJ8kCpe0OG3t6cPp1WlYG4=
X-Gm-Gg: ASbGnctt9rk05t2cmk3+ulzM1qTPN2MqOf9XfD2Es0C6fwDcJq+qVkpoP1arhstZr40
	2Q4YxTIWrujNpCWZMKZlCGrSTnzQbr0EN//dtMQpB89p6mQD8P3/QjCj/Q7VdT3MZCWv2K0HCLe
	j/60y0NCccL6zDHoJfdQjQ86Zsh/GdOFt0FXxPIo65oCRzoXmDkneFCYhjSmHyKj5+/gDL7YK05
	NwoHbC7vgfQ+0z43r+hb3qvWwnZtcT/5JoSv7KKslMyc51fTOvRaiSaTo9ir7a+h9J/LR2E9yCA
	thgBl5CF3O8GSQRtbfyI/gxNoH23Gi692feJprrEn4FGrhnUq1TcOCEY4F+Pw1eMLVd5bw3mTQ6
	tCXzF6l8plwN12KGJcEi+UWsEF+7aOMq1KEeTkWaghScxR518DQHtNvFVOD1vP2DLeyA=
X-Google-Smtp-Source: AGHT+IGc3VU32PsX6C7ClVKA+lvc5cDeezn9b8o7ZgcI2xpiH2XwVhQRzLUpHdISHH74OneKcDaSiQ==
X-Received: by 2002:a17:90b:3d87:b0:32b:65e6:ec39 with SMTP id 98e67ed59e1d1-32b65e6f260mr9655069a91.21.1757053764191;
        Thu, 04 Sep 2025 23:29:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b694fa438sm6229629a91.29.2025.09.04.23.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:29:23 -0700 (PDT)
Message-ID: <97fb026b-54d7-42ec-a57c-51c8c8c44a76@rivosinc.com>
Date: Fri, 5 Sep 2025 08:29:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/09/2025 20:53, Alexandre Ghiti wrote:
> We did not propagate the __user attribute of the pointers in
> __get_kernel_nofault() and __put_kernel_nofault(), which results in
> sparse complaining:
> 
>>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>    mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
> 
> So fix this by correctly casting those pointers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 551e7490737effb2c238e6a4db50293ece7c9df9..f5f4f7f85543f2a635b18e4bd1c6202b20e3b239 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  }
>  
>  #define __get_kernel_nofault(dst, src, type, err_label)			\
> -	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
> +	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
>  
>  #define __put_kernel_nofault(dst, src, type, err_label)			\
> -	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
> +	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
>  
>  static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
>  {
> 

Hi Alex,

LGTM,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément


