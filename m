Return-Path: <stable+bounces-256636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB4OGrOaGWrVxggAu9opvQ
	(envelope-from <stable+bounces-256636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:54:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9E260324C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C65C8301739D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195F1A9FBD;
	Fri, 29 May 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xav+U28E"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E22C236B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062645; cv=pass; b=aZKjbBzrmXKGYObs5J0FhNkbcDkTuHcmsqCnjwPliIEZfgpjGMBLctV5GreCTjkJxF25YbKyLc+xDHN7qM51Ftdh5eCZK+ONJMY3x9XGDZqSin0kiDzbNIAUWCwnmQe2NGzEwc/Ir0CtkBirvTfGcLzM3Nv3CAqRRne4Z1ckgbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062645; c=relaxed/simple;
	bh=jWUj0aatBU0fsZjP17Dllv62v9an2vCmWyI3uxipquY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWVFZfKvxFqT0h5fUfW1HD/UDUq3RwquM/1lREImnSDRt1zhWC7HFgU8oervhpKRJaLMJJTqF5LLhawHPzaNdWJwXADklDT86INuO5BUQXOk2pCOeZ7OHSfOu3PfEkOOuObxyqqUWkmK908dgrD5bkfvGqFuCIH3vcM3ZOqv9Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xav+U28E; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so18995951a12.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 06:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062643; cv=none;
        d=google.com; s=arc-20240605;
        b=QAPG7qsd8UIBAIwfDwULs2Ei8XNMkD9qlPyTitXZJHX5aSVVxuo9B3gj5DNj2wnMSq
         r9P5vqDjrTWSDEQk4Z7XiHMoKa/xfiHcBJ3V11J5NtKmLjioBprXet0AzzLZHINi4b/S
         Gq2FM41LGql5vXJhe4GkiIB2XTwjTJOPQOk/roXMtpMb9esoKxanRV3DR7EaJJDe9HJf
         uijV5rrcPIqwOUXhrRtPDEMI97rEKNIRzcnLZJXuID62r5O9b9E6GtriXijK7ybN5TXE
         MZK9X+Q9iYj2qofvKsTeJmQsww85ceFiOzXY1NE6rZxBFA0LD02/A3NR3N4BOc+uHkIL
         V9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9ExrbOOz9TGL3qaD+kl0RBR9EgjXHDEBMi3jSYDcPY=;
        fh=mYC4l8/Q15/rVMgneMIcJlvXSRNaYDbr1x2o+NKjyM4=;
        b=buyIcs22DbsoPHABoh1x/x0gJDwb66I8yUHeKIAnuCR0nNKZpZvX5VlAVHprMKH/vM
         01nAXxXU5hxoTvu4BUaBm2FLlL2Wl0zNVn2v/JiDUrm8ats3mM6yw9q+iz3/WOmDNXA1
         jDHtnlMb/6JezQTss+3SxYxgBf/I7MjhkPl6PGSLQPxpLfeLhc3U34u2uuguYbrWOF2l
         1eSXj9IVJlQh8hUG4/TcH5NNqgZpc9qjMMb+KcQjnwihuGIZoYx3IJCb96sWltW/GoaI
         d2+kLBkKcUEztVcIZ4WOyovIIiNqpXr6RFPvup8zHikknGEKxQhIqiCsEnBVz7meBDkZ
         x1Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780062643; x=1780667443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9ExrbOOz9TGL3qaD+kl0RBR9EgjXHDEBMi3jSYDcPY=;
        b=Xav+U28EI8c0McUQbsiMxKg7MXyqQLXDJnbtPiGfO+OJHX5h5GmxplOOIv4ENRTwQN
         zPJZxVDnzWVQ4xEcvxkpUe8Zv7j2ufstmvO9mIgNzWQxutRxXG6iIUTH/0h4tIdvr3qJ
         Dt55D4ekE43AZespAwwmHma4G/R5DMzIZI24WiORT4R6uAe5YuYhTiPa3/ynNKnHBPYg
         vNOn/168XXBkIMU67vjI+WLYk8qtzdxems3Kz6nYTDuFsCYc9ToZeFSPkLJRm1bdzNI0
         sK2/NOzM+J1mdHVevmAN+t2DSPIrpgOoTutHd1eTA/36EPUlqvw9FgUeReBfzFJCK0e/
         dTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062643; x=1780667443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9ExrbOOz9TGL3qaD+kl0RBR9EgjXHDEBMi3jSYDcPY=;
        b=EQodYBeJ+ILkj3JcWwsRPyWD5JTqFEEgmf4hNk8QU07X3IzWdzIiwJFS6g+ZJjJxYG
         k7kdUFeHeU2Ub9xVqpasdEWovYAwo8f7H5dAcRkmp4VEAmpL30b+EKrYWErl7xg8RtBO
         xQiUpZdsaTDaObLgvkDe4O6j6eDI24EeD8w4syRAVgYEiB9aiD6aVuQIJMPAylwkLODR
         JbXa6xeytzXJPin341Z62u8+b8k3hZ8oesgBNnzY09YUSL4ZyjDBS88rEfjtaS29uViJ
         SbyXNpintgFgFF6l7zN3N3u/VuyYtIn2pOV8+C8A3nJuVRuW6JmMzcrIwYLNcHOKS8ZL
         H+xQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qgYHNc2ma8+nwR4jpZm/3L6+S8noTHo1gOwhfT6+FNS4IpE+DmkCXvLFrWV78Oj59kZsUlGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTPbvv6wHIi8hownJZCwckMddqb2+Bvv6Z3P+Cih3rlD4nk8k
	GTlqMZsDKA3IYz928Ucfk7MWH+5gGNPbePJxEAieV09SydHWPTAFmhHJKqHFvjFZi2AfuxFkHvC
	aUY7rDOiLBd3odTwW0jd9jXcX7O4Hr14=
X-Gm-Gg: Acq92OFX7UWf1lkd6hiGrrwLCBjLwXplhxx7uZbBv8nkbJa5JN+PxHz7ZYCJo2BeFOL
	aVYXYL3+A9CD0AShrdXhL4NOyvqLerY7ZpBgifB/ABjyWhtOwe7Ug5Jo9X8LNH82qW4H65/hOGf
	+ET/HR6Wxx79n1EibqrfxHHirQZLvlQ6r32BW2q6zPyNQRo4S1SPAFr2iqog69257hIM8LkDDqY
	lAD+RAMJco9UMpUUNOjlKeAB73pVX4OgKavOpaErLas+N1aAkAB8A580VpJL+CDoFiiK0c1SFd4
	3RkpYcorpOeHFrWQE0OkV4jDQXh3vCIVJF1cSW1Nyjq/5EMA4zpUv37exKXNtg==
X-Received: by 2002:a05:6402:5187:b0:684:70a:4506 with SMTP id
 4fb4d7f45d1cf-68c10e73094mr1615465a12.15.1780062642718; Fri, 29 May 2026
 06:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528231043.1842326-1-mattst88@gmail.com>
In-Reply-To: <20260528231043.1842326-1-mattst88@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 29 May 2026 15:50:30 +0200
X-Gm-Features: AVHnY4K4Vj2v7dvrwLYOm4pk_cTOpBSBbPY3xX0a53Q4dCeIi62Pru4gfqDLqr8
Message-ID: <CA+=Fv5R1ZRrp-Xvgopw+u4oaC=cTPx1XRuRJiu=nxBkQgTnOiw@mail.gmail.com>
Subject: Re: [PATCH] alpha: Fix SMP shutdown hang due to missing memory barriers
To: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256636-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmag7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DA9E260324C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 1:10=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> Alpha has a very weak memory model. halt() makes no guarantee that
> pending stores have drained from the store buffer. If set_cpu_present()
> stores are still buffered when a secondary CPU halts, they are lost,
> and the boot CPU spins forever in the cpu_present_mask wait loop.
>
> Add mb() before halt() on secondary CPUs to flush the store buffer,
> and use smp_mb() in the boot CPU's poll loop instead of the
> compiler-only barrier() to ensure it observes secondary CPUs' stores.
>
> This avoids a deadlock on shutdown on EV7/Marvel platforms.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git ./arch/alpha/kernel/process.c ./arch/alpha/kernel/process.c
> index 06522451f018..d50f9cfd8333 100644
> --- ./arch/alpha/kernel/process.c
> +++ ./arch/alpha/kernel/process.c
> @@ -99,6 +99,7 @@ common_shutdown_1(void *generic_ptr)
>                 *pflags =3D flags;
>                 set_cpu_present(cpuid, false);
>                 set_cpu_possible(cpuid, false);
> +               mb();
>                 halt();
>         }
>  #endif
> @@ -127,7 +128,7 @@ common_shutdown_1(void *generic_ptr)
>         set_cpu_present(boot_cpuid, false);
>         set_cpu_possible(boot_cpuid, false);
>         while (!cpumask_empty(cpu_present_mask))
> -               barrier();
> +               smp_mb();
>  #endif
>
>         /* If booted from SRM, reset some of the original environment. */
> --
> 2.53.0
>

This looks correct to me. halt() is not a memory-ordering primitive, so on
Alpha the secondary CPU needs a real mb() before stopping. Replacing the
boot CPU's compiler-only barrier() with smp_mb() also looks appropriate for
the polling loop. Looks like you have nailed down a long-standing memory
ordering bug, nice work!

I've applied this patch and, for what it's worth, tested it on my
AlphaServer ES40 to make sure there are no obvious regressions on a
non-EV7 platform. The system shuts down/reboots as expected with this
change applied.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

