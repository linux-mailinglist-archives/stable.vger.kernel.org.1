Return-Path: <stable+bounces-19081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3384CE78
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE90C28A459
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85059811EB;
	Wed,  7 Feb 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="DZd1Ehl7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98F811F6
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321499; cv=none; b=Uusg/U/NVX9qo50pfMQVS6Mfj36M7wt159rTQk5D5xKGUqI93paY4mn9ISbUwF1ofPcSgVPlPJPcp74HyN633rj+MOCMRPsoleoAjraL7vxRRseQyRLxANPsTuHsS1ysRdV0bmkqo4klXw4jM58onxaqOfWy/rCFnDLoRFa9NZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321499; c=relaxed/simple;
	bh=Qye+zuX3oCWPut5vgJD+q4hUJcHXW8C5VACBs8eHm0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTJMnVp73HWOlS0Ie2h7bMwdicqPpd6QxeZmuSNtMRUR0ebHUkO7Lr7JeOkxcs2QoU8jxjD3Z2lhxN6HFL2pKAZwEttxoKGsUq6rfQcA5V5iqT8lhc7d1Ga2LP2P70ev0RWY/N4Z8HilvGLCC5nwh4GXXSDkJNSBDlnzxIaFFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=DZd1Ehl7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363d953a6c5so1849695ab.1
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707321495; x=1707926295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThW4UOydoSx884aXPLxWcHCPZYcLHmO6NwU0Jp/gx9M=;
        b=DZd1Ehl757sQTrcLgpMaNaPMsbbjFcz1JwySOu5c6Qwip36+h0dG0b8BD76rUrRt9p
         gQ1KI7lxrBtwDyIUT+D1Nvdq6Otf275Rr49KTnW+6aOZ0zDTl1ZMcveLu2Pm/LRI8bH5
         VHNxGve10y8gFK51hTx1hLfuGU8u9TgTZwVyl758ApKLun38jOrTnbT804bXWhpjPOtB
         QZO5QcTFoQkgP9V6Eojv1Qel18qXjoFaCL9wkm9EKTnEmdy50hPBAORnTcgXRnslJ3Dl
         RB7A7VvVM4YNKNCg5xphFmAaxzUUechkgx8ugV/pOcY9WwMFHE3bSm/GpvcuidKKZ4zs
         5n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321495; x=1707926295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThW4UOydoSx884aXPLxWcHCPZYcLHmO6NwU0Jp/gx9M=;
        b=jtcALe7YP/MaM+wUrtYDWZwYATJohmvqkDQHoQSdSPPjnyOddTmw7ZlIeDZNf64kqr
         PCg7HzpmScwm6EDqj8SHROHbKsPefoKAthJWwNYfkTujV6juRFF3UGnZkz+mdDy7yLNi
         uWbzbjkf6tImDuKjtbep8oDyDPC8enSvDSuq2EqhUp6jAEYpgRKJEE83BUeDcqk6r7WT
         KQD3MzKoNjDISP7xe0pOs/YwazWfo2dnHPYjliSSNO7AlEzTS90cwbyB9caTfNRF9w56
         7j7x/gALRZwP4o8mx6Q9gj4kLLdJ2a0fRVL6Id7iCRzwBn4HA1fV1+8xfwsUZcHhrPXC
         CkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq7HHkk5MIUm7xaAeI4s1+XK/fOi/PrA2gJvDGZWmWWolAu0UX4KQAzMFrLxGH7h8iFTDw3NIQaUnV1zWbkrdna5kbC1gO
X-Gm-Message-State: AOJu0Yzr1aGIG6KT7OQoI2g0I4RH3hsBVQm6RyJrROZJ0DYD3cRwJs0o
	DeK/t4bk9QPucQN7n2OtegUfLj6PAORBDh6ZMmHxliYMcSH2rFyfZqxGwJro35b0wFDlaNs/lb2
	/nwe9RKpxWbIdkUgwD/qE6EmQXfbGHLsLac3r5A==
X-Google-Smtp-Source: AGHT+IFCMccHnOQccdE1uuYts0EwIbRXGd1LC1MRLGFWoBZRBmKBJLB8KbPbNhmf/iNYEURqw+cqufs3Yf929+3A1QM=
X-Received: by 2002:a92:de4d:0:b0:363:c63a:7975 with SMTP id
 e13-20020a92de4d000000b00363c63a7975mr5867115ilr.24.1707321495246; Wed, 07
 Feb 2024 07:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 7 Feb 2024 21:28:02 +0530
Message-ID: <CAAhSdy2Hp9GeXFBYVNSCGDNaHjYQjCgj+kPQtOaGz6RQecoDbw@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ley Foon Tan <lftan.linux@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:12=E2=80=AFPM Ley Foon Tan
<leyfoon.tan@starfivetech.com> wrote:
>
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
>
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index e66dcbd66566..672669eb7281 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -116,6 +116,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>                 ce->rating =3D 450;
>         clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffff=
ff);
>
> +       /* Clear timer interrupt */
> +       riscv_clock_event_stop();
> +
>         enable_percpu_irq(riscv_clock_event_irq,
>                           irq_get_trigger_type(riscv_clock_event_irq));
>         return 0;
> --
> 2.43.0
>
>

