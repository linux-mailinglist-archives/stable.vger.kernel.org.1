Return-Path: <stable+bounces-69709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7813958547
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DFD1F284EE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C118DF7C;
	Tue, 20 Aug 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="0dvXp3s6"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63A18C004
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151424; cv=none; b=fkUvmR4/USVCk+yc4gkRhfQLUMtUKJ7dSsk4LCWsRixULYueA8xhgmUA2qv16SXrDvOqRsLJPrrXokdrPsAraZanEBfF3/HccG+91+HZpgtvCtbsmkT8URsB/FLZwRD6Dzqw59hmwUMxSL2dMIcOA2UR2ujmwCEQb+CY4f8DgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151424; c=relaxed/simple;
	bh=wJ/EB1HWMzhF4m0C7qiWLBhs6DSBzQo5Xmg8Fm+BOng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEkm6GgEbw7/CN5wLuGRaYm3/wgIf4W5fyR89zAFU33CpyjGQFaNpWTxeELN+Etsrkt81CBfGaQbPt8SDe2lVzK71JjzahabB+q8qL9/vaZhBobHzzCerXO3GZQo8v2mECjJ+jApcrKPEM0FeLJ51En2W+rQZ8DrWlX9UvxvgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=0dvXp3s6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so272907539f.3
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724151421; x=1724756221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9KVEQdhyyAo4Un7hmmWmcdbUoZrm1lWEAKevA08iqI=;
        b=0dvXp3s6oXijujqOcHnrNGxDOsx8amo8H9HPaqcVCa7AcMPqLcMSyNkg4Mw2F+i7h2
         BMOI1oiivYvbzqsfCrDhM5udaW5iB8JLY5E/mApkJx0FnuJYQhGnyARkbfS6YReDbDk+
         /x4RptYPriJmYKj3XMgNYxineYvyi4oc6QoISxw04oP9wrCSN3DpR6AYXJev+bc/0JZR
         LhrUxXQnV2kHunPU8UYsdTgYH9BhXV7R5ng8hLURZ/ITWa23qHgEaJH2Bc19I2fG84Hm
         0PUZbIQ2wgLPuC+N7Jyskpp6A42Jgb8O85kiU2kOyRZ6r+L7KQK/e9K4nhKwah3Dz53I
         DQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151421; x=1724756221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9KVEQdhyyAo4Un7hmmWmcdbUoZrm1lWEAKevA08iqI=;
        b=bMpc32hvQ9ZMTRHzFWYG+mwGl55eDKyH5WisgFyVHWF5lsUEV9h7d5emCWQVGlBx7c
         GIWcVCCzu+iwrxUvr//AQI3ZA9OHOflGJjI6utmw+h+k4Bwv505JdxlmDyl/fTjGFa/W
         mhoS78qTwLq/OQBPkeBH30zxQFnK13vFDgBlYaI22SHe4GlqHy10zLNto1k/lHNHRl9x
         r/TMn20OcDzDThNEeq2P4E1g3IdEkgN4tsGOi9jzMzKy5LO5/cg7tQT2+LViUveHspk3
         ygk66bKycS+Lx2fyWQ+58dnMUB8bYpH113BOltV5GOxxOSQ3MfywWhqT8oW1JIor5DHr
         yrSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2TwryINfB5Ieob+4ZNaUOrkvt34A76LZeHK65inZgN3ud1aVkmvbmxrin7U7m52gecpiyBkwDSMCpE0WfDqcDe1FpHdT
X-Gm-Message-State: AOJu0YzOu8bkmrC9/6zJFKNvsO6fha+AbWzXLLIRv3IW8g7FixVo0G/G
	LHiNeXWwSgaPDSjo3vOTzj5tEsjD3UshM4LVabhGdiwusBsw8YjuddoENSqQ7YsxTXoJVVA/n2f
	XwNu39cQo2hd4yrhzD6PmSw4AvBdEQV9AwmGz1Q==
X-Google-Smtp-Source: AGHT+IF2qDXSD4GVokjV6QN9az33dHDjsKXPFgDYvoXoazydu4xSf7m7DCbKo2VqzmL8osOIuRjyhQlDzHCItoRiOOw=
X-Received: by 2002:a05:6e02:1986:b0:39d:637f:97cd with SMTP id
 e9e14a558f8ab-39d637f9a2cmr5860365ab.0.1724151421518; Tue, 20 Aug 2024
 03:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Aug 2024 16:26:49 +0530
Message-ID: <CAAhSdy3S_QTBzCNtj8kKDpzxtoeyKWvGLtjgSTViieWimpP-JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: riscv-sbi: Use scoped device node
 handling to fix missing of_node_put
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@rivosinc.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Two return statements in sbi_cpuidle_dt_init_states() did not drop the
> OF node reference count.  Solve the issue and simplify entire error
> handling with scoped/cleanup.h.
>
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
> ---
>
> Changes in v2:
> 1. Re-write commit msg, because this is actually a fix.
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a6e123dfe394..5bb3401220d2 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
>
> +#include <linux/cleanup.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
> @@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device=
 *dev,
>  {
>         struct sbi_cpuidle_data *data =3D per_cpu_ptr(&sbi_cpuidle_data, =
cpu);
>         struct device_node *state_node;
> -       struct device_node *cpu_node;
>         u32 *states;
>         int i, ret;
>
> -       cpu_node =3D of_cpu_device_node_get(cpu);
> +       struct device_node *cpu_node __free(device_node) =3D of_cpu_devic=
e_node_get(cpu);
>         if (!cpu_node)
>                 return -ENODEV;
>
>         states =3D devm_kcalloc(dev, state_count, sizeof(*states), GFP_KE=
RNEL);
> -       if (!states) {
> -               ret =3D -ENOMEM;
> -               goto fail;
> -       }
> +       if (!states)
> +               return -ENOMEM;
>
>         /* Parse SBI specific details from state DT nodes */
>         for (i =3D 1; i < state_count; i++) {
> @@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device =
*dev,
>
>                 pr_debug("sbi-state %#x index %d\n", states[i], i);
>         }
> -       if (i !=3D state_count) {
> -               ret =3D -ENODEV;
> -               goto fail;
> -       }
> +       if (i !=3D state_count)
> +               return -ENODEV;
>
>         /* Initialize optional data, used for the hierarchical topology. =
*/
>         ret =3D sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
> @@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device =
*dev,
>         /* Store states in the per-cpu struct. */
>         data->states =3D states;
>
> -fail:
> -       of_node_put(cpu_node);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static void sbi_cpuidle_deinit_cpu(int cpu)
> --
> 2.43.0
>

