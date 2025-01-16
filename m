Return-Path: <stable+bounces-109284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918DA13D42
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A7B163D9E
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215622B8DA;
	Thu, 16 Jan 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H0ubxWuE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A922B8A8
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040141; cv=none; b=QoXpymQAjvrIgKJdYtNqijAUPs1EX1bs5zzUw1Ldrq3pTIJXUv6LY4A1Mh3D1oIFHL/jhe4M5gEFTKkIdAYjXrZ3sA2wX7tW4SIrGDp5PMg2brdOIlrX0hQ10YFI8STlL+T9HErSFaJY5y6x8I0o9poDAuuDWzmCuG4wTQiGhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040141; c=relaxed/simple;
	bh=l1dPyhAH0XGedLneC12sZTIuBPdTn0qvEjkH/ggqgoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFzYS6ccNNWHeFJ/gA2Oxjelo5ET2sw25bgLCZ9jW6Bq0Y6WTYwXDxXB8bNV9bs+EQK+v3ZmLcRsievglGx4a1Z62THN3BdQVWnnwG7uPn6sn6ocQL3lAqhyGoqNaAVDPzzTDk9AZsqAr5cjz9gcUTxdHV9kqq0p7zX/k104bpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H0ubxWuE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso163447466b.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737040138; x=1737644938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yreeh01zzKDusWkdic+oOFQVMCmFSlK2ta/Ldjvs9f8=;
        b=H0ubxWuEVi5Qbsve/Ax3CqR37Eyx4j/YFCHBB+UgRkFkI3qw5SWdNZ6HGKBxMNlIRi
         RwvBk+GiJu0LjpurzUxiv7nFBOkBJaq1u5n2kci7z3vCGnQDhoFMeJk0OOgu3ISMKT6z
         vcMX9sPNzF1hTmYeHD1zJnvg+NjMM9GWi3Ish7LIkZcQGbDVcagjQAtYFw8WJvRrzwwW
         dySZ5eBWVEEgg+qvCjl9B2D2QjJ3L28k8ryLNE8tSLh9T1XyvjUrJCIfA0iIXkwAnp4l
         6+LTsiwU2WOWX0EBvUP71e1N0RnYfRoyYyI1usg21pozhW0jqwEm0lFQGNQgA+3zR7Wp
         WaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040138; x=1737644938;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yreeh01zzKDusWkdic+oOFQVMCmFSlK2ta/Ldjvs9f8=;
        b=gQmjmthV5mAu5HKJIX9ZdlhiSOREU4S0Y+5emGTrH8aGgs1kWcZpekj5y8J4w7yHio
         fGe0n9h3XACyIZWk6RFTS3F7Bb9enWHfTP5H7B05Rd6lASaa4SYOvTcVnyXt2PK2yy4h
         kh40/5/kRkkuTBhWj0fZdDP8YdlJovvDKZ45qagsYHTHBb1Ny3WsgygX1tPnllSUQeb0
         nia/+zXcNmyh7jKUThzRuDNQyambM3oZHANrlynLYnbJOIv/vVjev0D5xswarDPde/EO
         1Uju/R8VJyOuba7LPjkAmapbr227oIRCA+109ewWJRt9t6IGdQBhinMsB9ffITPjeLey
         9oZw==
X-Forwarded-Encrypted: i=1; AJvYcCVlpM2GE330KU3niLeTmr+STzepxFzUbszOIrI9L8oEVNNPK2vDPhcYTECRw+ARWoU57ZJUc7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKz3VJsdSeBCd2O3gm4tnNHfYLRRHrAJJRx8Us/F/9xgH/Xt7
	1M1No3tuewK94lYqI3bmZWNUQpODudbHT8LjEmcjF0sFksZLpWm87FmiKlBuFSM=
X-Gm-Gg: ASbGncugEoFqndFwteShVEiZbpNW92exaVnLOqPeyxV6IaU4Vxyr9GpgMLIHaEhBteK
	53Vz8ltC98URLdFKB2pfRkSk46qrNzmWIdE5YDIeAqAbPaH6UyYPHJkJcL0sLjOGZBkR8v/Fd3h
	yKwLw0faUUx5yAMjgBR8tb06Gn+mGV0LVMojivsnjVjzS0V2v/uk1BviHKdMShUuPZ6yAxOUzSt
	ImoGapQBUrjX3jYcrI1B/6v2Yr607SEIKzhetsXtviT6SvSTd6B3c9WxOCZ1w==
X-Google-Smtp-Source: AGHT+IHO11C/grQNmeI/BnNfeeb16Ic8waY3/YPL+ofGtbtLY/uULgkCfkcoFJu1N6Ophfgjg8YSnA==
X-Received: by 2002:a17:906:f582:b0:aab:7507:7a94 with SMTP id a640c23a62f3a-ab2ab55970fmr3035731766b.16.1737040137682;
        Thu, 16 Jan 2025 07:08:57 -0800 (PST)
Received: from [192.168.0.20] ([212.21.159.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2cfc2sm8218166b.82.2025.01.16.07.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:08:57 -0800 (PST)
Message-ID: <8cf5b264-68be-42b8-b435-79b8d682fd7b@suse.com>
Date: Thu, 16 Jan 2025 17:08:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, xin@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com,
 bp@alien8.de, etzhao@outlook.com
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.01.25 г. 8:51 ч., Ethan Zhao wrote:
> External interrupts (EVENT_TYPE_EXTINT) and system calls (EVENT_TYPE_OTHER)
> occur more frequently than other events in a typical system. Prioritizing
> these events saves CPU cycles and optimizes the efficiency of performance-
> critical paths.
> 
<snip>

Can you also include some performance numbers?

> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
> base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
> ---
>   arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index f004a4dc74c2..591f47771ecf 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -228,9 +228,18 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>   	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
>   	regs->orig_ax = -1;
>   
> -	switch (regs->fred_ss.type) {
> -	case EVENT_TYPE_EXTINT:
> +	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>   		return fred_extint(regs);
> +	else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
> +		return fred_other(regs);
> +
> +	/*
> +	 * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type events
> +	 * first due to their high probability and let the compiler create binary search
> +	 * dispatching for the remaining events
> +	 */

nit: At least to me it makes sense to have the comment above the 'if' so 
that the flow is linear.

> +
> +	switch (regs->fred_ss.type) {
>   	case EVENT_TYPE_NMI:
>   		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>   			return fred_exc_nmi(regs);
> @@ -245,8 +254,6 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>   		break;
>   	case EVENT_TYPE_SWEXC:
>   		return fred_swexc(regs, error_code);
> -	case EVENT_TYPE_OTHER:
> -		return fred_other(regs);
>   	default: break;
>   	}
>   
> @@ -260,9 +267,15 @@ __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
>   	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
>   	regs->orig_ax = -1;
>   
> -	switch (regs->fred_ss.type) {
> -	case EVENT_TYPE_EXTINT:
> +	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>   		return fred_extint(regs);
> +
> +	/*
> +	 * Dispatch EVENT_TYPE_EXTINT type event first due to its high probability
> +	 * and let the compiler do binary search dispatching for the other events
> +	 */
> +
> +	switch (regs->fred_ss.type) {
>   	case EVENT_TYPE_NMI:
>   		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>   			return fred_exc_nmi(regs);


