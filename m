Return-Path: <stable+bounces-19087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFDC84D0F6
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29155282EDE
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E354645;
	Wed,  7 Feb 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z+yFOxzq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AF823C6
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329513; cv=none; b=rc2jaT0+aGjJSCURJXFO9tZtjc3xYF2PreANb9cSqNJOCDMs5T/2PJ+WRLh/sfoyXHoHn5EQFlEPgaaTvB36eVUjuRgIouWLqO8fW5Yf6PMRiLTeWlU3pIa6b6N+vWZ5ACPQ/3f77WrPvtJk4PgjyCsHLWbEL3hy7JowWd/ifBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329513; c=relaxed/simple;
	bh=qR8GKpuuZaW4F6S0+Bd8OP3wU4IAuXpMl7pvAL9xLUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bip3BxYY8kb89q4gI0eMRNpPvoCHMoO2qjDluRyfUwP+A62Yee7SquAhBfJyebpaS9TA70bfb39HLr2xdqKcGpgL9553HweTxJdSoYRNdMU+6PVD1M2d7pSdA3hz9PdwPDy4wD+QJc5TBCiLZd3TjDYBtGAe8L43P2+6z/u0piQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Z+yFOxzq; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc730e5d8bdso1000118276.0
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707329511; x=1707934311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsW74Q1+T1mksmXsIbj29+DJwVSribZJe7h8Y37ezZ8=;
        b=Z+yFOxzqvXorHX722BXwXXLCwnw/qrHzV68HOTRTlo81VM2v8Ffr6bB4dsy7i0gnd8
         Xb+J18XdDHvcRcjbyrCEphK1WW7sbsq+bV6r8hOFFPzu9wSphgG4yqOf0xJ0y3M1djwl
         qVEJnlOMI+tE3FYIfv64GE2XI8O8bLzZ/ddw9HQBwRL/M/AdbXxICSy5qLjRbXQGrL98
         vYzsbUWkBf+hw8VLP+y1QLeRkQHx7z3LaoMnHgc02/CmagTxhnS60NO/bl/GAHuyyT9f
         LWrnN+ZH5zphyPU9wviRUQZ+uZHiyPuwJ7d7wxzkJYbBmeGGm6T+YElIIvHWcgdZdsWG
         7Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329511; x=1707934311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsW74Q1+T1mksmXsIbj29+DJwVSribZJe7h8Y37ezZ8=;
        b=USwDMHRy0ymR2g+5X3aGqlDXw3QXheWLxyurUkvYAymEje5wBtybtzrMQqCCOUJZvh
         CLefnTNXBPpkoq03rTK8a7WFxX7Y58y0pAT807A1LKLmVW/FGBmpHtqK+0Sd4nr4XX10
         Qxzyt8ZqiNcZ1S52OecFoc475Pu4Rg68wGCITb7uz/xi3r2NispAs4u4xoG+icv9savU
         iOmRqw9i7Y1bHJjrq6lprI5HtENqFQi4J0eYvQuga6x5Coy1+r70N6D3UeJYQpFynNwe
         AXgVHZ3b7qs5SpLNzU6SF0Gc9+nn0yAJCJuBXm/PsuT+vd8iboI68pZkXotijBy6/xc5
         4RCQ==
X-Gm-Message-State: AOJu0YwbHZQnHiJ1L0+G4SYg106BSP7+FOhmaFtcEtBDlO0sG7gt8NYx
	axTWKAUgsgi/NKmgCUsI28THF0+6nhUIAUIlgElgdj6+Yf51Lv0N+sOJ+OtUCs4=
X-Google-Smtp-Source: AGHT+IGqZ0PdGpZMTBV9zF8UO5NAGQRLPRdqGQhiGhIPGCtJUZIMcIORIqQV5b1hc7bjtFSOILoTUA==
X-Received: by 2002:a25:9304:0:b0:dc6:ae82:ed36 with SMTP id f4-20020a259304000000b00dc6ae82ed36mr5929066ybo.40.1707329510906;
        Wed, 07 Feb 2024 10:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcQ5OWT4CCOH/PP3Db4QUMkXA+yDlW1mbkX17EfCnXO5gK8WOP/Xozf7ihPYcix4koure7BaQW5jT+ar6hA8rU17AbGDtV9covzDt1yNLSG1P4laJoHR0ntUhk99ZUWbfKqm1YcNQqULJ7eQVL29wLgObNrVDkiLAvQdf+eFAwVvHPODwymRFSbyhAkiecQm7NU/yWYul68ExHWOfZVCb2tfBlPnAHZtfglgzEMwc35w1Oc+/TSnmVvH1MHnuSKrc8LZwgCDwwCYsb6KDShzTJWPNbkQVMLbcYNjFafFVuFJ0WiN631bsWhNTiTBkQKnUF/lsOjBbj8vrqDVTrB7EJhC2Rb2k+J2fxVJDrRj7AfQ==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id f6-20020a5b0c06000000b00dc6da5dbe1csm292874ybq.39.2024.02.07.10.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:11:50 -0800 (PST)
Message-ID: <22d7dcc9-a14a-4e96-bfee-dd358af0afd5@sifive.com>
Date: Wed, 7 Feb 2024 12:11:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
Content-Language: en-US
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>,
 stable@vger.kernel.org
References: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-29 1:26 AM, Ley Foon Tan wrote:
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
> 
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> ---
> v2:
> Resolved comments from Anup.
> - Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
> - Added Fixes tag
> ---
>  drivers/clocksource/timer-riscv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index e66dcbd66566..672669eb7281 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -116,6 +116,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  		ce->rating = 450;
>  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>  
> +	/* Clear timer interrupt */
> +	riscv_clock_event_stop();

This change breaks boot on Unmatched. The bug is that the above call to
clockevents_config_and_register() sets the timer (see below), but the timer
interrupt never fires due to the added call to riscv_clock_event_stop(). You
need to move this line earlier in the function.

Here's the stack trace from the initial call to riscv_clock_next_event():
riscv_clock_next_event+0x12/0x3c
clockevents_program_event+0x9c/0x1c6
tick_setup_periodic+0x82/0x9e
tick_setup_device+0xa0/0xbe
tick_check_new_device+0x96/0xc6
clockevents_register_device+0xbe/0x128
clockevents_config_and_register+0x20/0x30
riscv_timer_starting_cpu+0xa2/0xec
cpuhp_invoke_callback+0x160/0x61e
cpuhp_issue_call+0x140/0x16e
__cpuhp_setup_state_cpuslocked+0x186/0x2b0
__cpuhp_setup_state+0x3a/0x60
riscv_timer_init_common+0xea/0x184
riscv_timer_init_dt+0xbe/0xc2
timer_probe+0x70/0xdc
time_init+0x74/0xa0
start_kernel+0x194/0x35e

Regards,
Samuel

> +
>  	enable_percpu_irq(riscv_clock_event_irq,
>  			  irq_get_trigger_type(riscv_clock_event_irq));
>  	return 0;


