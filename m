Return-Path: <stable+bounces-65466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7839486EB
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 03:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68702844AF
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0F253AC;
	Tue,  6 Aug 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjqV0fRx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80328E3;
	Tue,  6 Aug 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906995; cv=none; b=efoJiNa/0cdyUKLBYQjXI08B+E1MIqCd9ubsZtPtRvO4RJBCIS4LNTa5yL8+3F/FrhNr9R47x0Aw1dKa6VADE5yOpN/y9ymO09+A+gkt75bmcUpgLjN0xjNYzugHl70sxM4PdM68vXK/0SjSH0mnjjTOuFFbzj7FmkQOrUn5TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906995; c=relaxed/simple;
	bh=vrsg9NbTGSPSgeoMXbEWA8Z6Fm9nqfM5O+ckSo9mUv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iei24VtZDdkhKmFxbGGk6ie9/LPe/k3hSS2G2o+kpZtX4uvo839Tu4ZBJ7ZTVsgkCNt4mF8pJPgpEcgnuAQsaEQFOk+zgOx5yK7JssjiPaUvJkMECvdjyCc7LiBy5T68+R5r6T8Ng631koCpV/Cm/nsQjSCw47uA5EvVfTfHXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjqV0fRx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fcbb131so377355ad.3;
        Mon, 05 Aug 2024 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906992; x=1723511792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pKouwvi/Vi6ylh+J1faFTlAY5UJRoKdSM2mhEBnPJEM=;
        b=QjqV0fRxRDhIQJkqTLoRAxO69/DlXEDT0/9YE7+bIxuO9RhJMocMN5N/qPA80WHJ3Q
         FjlUor6elPoaNmL+Og1l6MEks38whoGVwW4j96f9INW7B2aKdrq0O3scI2CWnMFezySR
         mR2LOFUyB2eNk0rEM5mV8q0FEO+Z72WCBEo5b+WGrZCvsepqvY8ovvWJLkvpd5f4s0xm
         37Q1kLChfkStJpW1hHtC3RVn/1ZfghyW5eRwlTliKefO9mcxOoI/AQIAhYgECYHwLTjX
         2kJgHPkmXMoMVr5b4KjsqSJqZQ1hiig0y1i+qUPRQxik7+qJovTcoqZfj4G6TgUcwFgJ
         AFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906992; x=1723511792;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKouwvi/Vi6ylh+J1faFTlAY5UJRoKdSM2mhEBnPJEM=;
        b=Zlb1mTCE5FLALXjvr8qf1AfYAnQJOnYHQT7GLGa2Wgjdf91svOd6Iy9zvY+iRxroH2
         VCpFvgaYHA4rXTpiGGFKrn7Hwl/aZ28oxDOs9hMKatTX25HVRlcjCrOtWvVSwGWWXOIz
         PSsJvMXlcAmPGQ43auLvhs7NZwkSqc3u4Gj8fbdF2TjitDmwikD5dWf2iIsdqBEEsceF
         UpCgONyl+P0X2uSxPjuYLqoYdFNqn0YWn+ktIdY4jM1QkVBYq6Hd0T9dxX5wYpLtDRpO
         H4ksCg8JDpBS8nbfJIIQnJ4pXV2XTttnxPv52ZwUMuDXPLZ84qYtavaHQznr5BsVfsm9
         fcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmljof+LPg2lKa7uyWNiEEQTedt4nuXql03A/TAS1hqA+UE602AIKW5B8aAV0DImW7CGp64IC8tZ3eKSffs1yS+lrrOcWj1GfSr5wI2DPO4zm946XRaQRtKZjkhQqHA2ymj+RZtdbQRm3ZbRxc6q7KigPh5zaPtX2gSAOxK9BMD4wx
X-Gm-Message-State: AOJu0YxUnDRj6tV5xM9zxsPZb6MdjajfAUBnbuUhBrsaDxjpL0aaEKt3
	7hzSL8VJfNCCx9ufNUiK4fGqWF1k5BnanwkOZ8ifhrqXslG3r5uV4ONzcA==
X-Google-Smtp-Source: AGHT+IGDnj4GAF/mC5TmFoV0IRaURjjgZFInXtHW5VKT3FL/kzOIE5PPdYKD0MK8w1+ZqFd3jXrQBA==
X-Received: by 2002:a17:902:cf01:b0:1ff:3c4f:e93d with SMTP id d9443c01a7336-1ff57462779mr156614545ad.55.1722906991580;
        Mon, 05 Aug 2024 18:16:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5ebc4sm75922865ad.107.2024.08.05.18.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 18:16:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dba1c62b-add6-45fc-9fc1-cc8755fb7a14@roeck-us.net>
Date: Mon, 5 Aug 2024 18:16:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Helge Deller <deller@gmx.de>, Parisc List <linux-parisc@vger.kernel.org>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <a8a81b3d-b005-4b6f-991b-c31cdb5513e5@roeck-us.net> <87ikwf5owu.ffs@tglx>
 <87frrj5e0o.ffs@tglx> <8326f852-87fa-435a-9ca7-712bce534472@roeck-us.net>
 <87y15a4p4h.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87y15a4p4h.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 14:49, Thomas Gleixner wrote:
> On Mon, Aug 05 2024 at 08:02, Guenter Roeck wrote:
>> On 8/5/24 05:51, Thomas Gleixner wrote:
>>> IRQF_COND_ONESHOT has only an effect when
>>>
>>>       1) Interrupt is shared
>>>       2) First interrupt request has IRQF_ONESHOT set
>>>
>>> Neither #1 nor #2 are true, but maybe your current config enables some moar
>>> devices than the one on your website.
>>>
>>
>> No, it is pretty much the same, except for a more recent C compiler, and it
>> requires qemu v9.0. See http://server.roeck-us.net/qemu/parisc64-6.10.3/.
>>
>> Debugging shows pretty much the same for me, and any log message added
>> to request_irq() makes the problem go away (or be different), and if the problem
>> is seen it doesn't even get to the third interrupt request. I copied a more complete
>> log to bad.log.gz in above page.
> 
> At the point where the problem happens is way before the first interrupt
> is requested, so that definitely excludes any side effect of
> COND_ONESHOT.
> 
> It happens right after
> 
> [    0.000000] Memory: 991812K/1048576K available (16752K kernel code, 5220K rwdata, 3044K rodata, 760K init, 1424K bss, 56764K reserved, 0K cma-reserved)
>                 SNIP
> [    0.000000] ** This system shows unhashed kernel memory addresses   **
>                 SNIP
> 
> I.e. the big fat warning about unhashed kernel addresses)
> 
> In the good case the first interrupt is requested here:
> 
> [    0.000000] Memory: 992804K/1048576K available (16532K kernel code, 5096K rwdata, 2984K rodata, 744K init, 1412K bss, 55772K reserved, 0K cma-reserved)
>                 SNIP
> [    0.000000] ** This system shows unhashed kernel memory addresses   **
>                 SNIP
> [    0.000000] SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] ODEBUG: selftest passed
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU callback double-/use-after-free debug is enabled.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> 
> [    0.000000] NR_IRQS: 128              <- This is where the interrupt
>                                              subsystem is initialized
> [    0.000000] genirq: 64: 00215600      <- This is probably the timer interrupt
> 
> Looking at the backtrace the fail happens from within start_kernel(),
> i.e. mm_core_init():
> 
>         slab_err+0x13c/0x190
>         check_slab+0xf4/0x140
>         alloc_debug_processing+0x58/0x248
>         ___slab_alloc+0x22c/0xa38
>         __slab_alloc.isra.0+0x60/0x88
>         kmem_cache_alloc_node_noprof+0x148/0x3c0
>         __kmem_cache_create+0x5d4/0x680
>         create_boot_cache+0xc4/0x128
>         new_kmalloc_cache+0x1ac/0x1d8
>         create_kmalloc_caches+0xac/0x108
>         kmem_cache_init+0x1cc/0x340
>         mm_core_init+0x458/0x560
>         start_kernel+0x9ac/0x11e0
>         start_parisc+0x188/0x1b0
> 
> The interrupt subsystem is initialized way later and request_irq() only
> works after that point.
> 
> I'm 100% sure by now that this commit has absolutely nothing to do with
> the underlying problem. All it does is changing the code size and
> placement of text, data and ....
> 
> So I finally managed to reproduce with gcc-13.3.0 from the k.org cross
> tools (the debian 12.2.2 does not).
> 
> If I add:
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1513,6 +1513,8 @@ static int
>   	unsigned long flags, thread_mask = 0;
>   	int ret, nested, shared = 0;
>   
> +	pr_info("%u: %08x\n", irq, new->flags);
> +
>   	if (!desc)
>   		return -EINVAL;
>   
> it still reproduces. If I change that to:
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1513,6 +1513,8 @@ static int
>   	unsigned long flags, thread_mask = 0;
>   	int ret, nested, shared = 0;
>   
> +	new->flags &= ~IRQF_COND_ONESHOT;
> +
>   	if (!desc)
>   		return -EINVAL;
>   
> that does neither cure it (unsurprisingly).
> 
> Reverting the "offending" commit cures it.
> 
> So I tried your
> 
>       +       pr_info_once("####### First timer interrupt\n");
> 
> which cures it too.
> 
> So now where is the difference between the printk() in __setup_irq(),
> the new->flag mangling, the revert and the printk() in timer interrupt?
> 
> There is ZERO functional change. There is no race either because at that
> point everything is single threaded and interrupts are disabled.
> 
> The only thing which changes is the code and data layout as I can
> observe when looking at System.map of the builds. I stared at the diffs
> for a bit, but nothing stood out.
> 
> Maybe the PARISC people can shed some light on it.
> 
> This reminds me of the x86 32-bit disaster we debugged a few days ago...
> 

Looks like it :-(

Thanks for checking !

Guenter


