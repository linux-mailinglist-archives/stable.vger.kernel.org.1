Return-Path: <stable+bounces-54873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7493913520
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D54E283B65
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17516FF44;
	Sat, 22 Jun 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy8b6E2D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5F155310;
	Sat, 22 Jun 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074279; cv=none; b=cONP4YSur6Sf1ZV4MEr9CMAdy7dp9Jg5+jDqVO0Je5FBvN/hS52DS1vve2jOgOcli9dKUXrvhXN9YZI3KbRyhN+onZS2m3GSbCpTNzOJoJ41bUZVYMzCSu9CPECVhNC0DtCuklcYXla7ysuHMlIXDyif0BckM4ewbAJ4bOHK5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074279; c=relaxed/simple;
	bh=wicbUPOHbDVXPTgZ3JV1UYv1hXKn5Q/LtgJ6YffpcnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqysC+TKe4g2nzdEKGCHCbMt6tKt2waXpKsd2lIdYP6cQwQc+n0yF5aTPVVHBP4U9gDYT5RQDIwlzYF9ScfraIiIKqF5+pnGrmf0q3vc/uJQUL0AqwOY+26uRueq/PuPZcb3qObZHqY1sGBAdwnGMeCWa3YtzFCDdZEfRkbqhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy8b6E2D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9d9b57b90so19958485ad.0;
        Sat, 22 Jun 2024 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719074278; x=1719679078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LVWh8aXIRdw6KlJx42lPJzU1iUTgDenarPm7inF+GRU=;
        b=Cy8b6E2D09xWqWqfpVm9r5auLFEhk+dsHtU0gQLQPfJs/nPhIeF+1HlQI/8kH+1iLT
         RfbGl9DpMiDs8EI9+agdu5cR77EeIRG9EdGseq9EZw4MqeIaaDF22Hq5ZSCrEdt7Tc1X
         1lQjGPemOgw+dslgd3XZoxFgFc487jcYJks+pqIGQ8VhNnE4/Ex0PKRX9pCLIvkbgPOI
         kERHLKF3jNwyVS+8VYY2Qw74s91NmL4gPeEb4qf4sMLEdpbTVF7OKVEWj+X3CI20ObCk
         PTwhtLYulkEZvHiq3Fi2NSGisAo5N+F0R0F/WUKbg55RqGtee+V6fA599z9zoUVWT3H4
         p+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719074278; x=1719679078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVWh8aXIRdw6KlJx42lPJzU1iUTgDenarPm7inF+GRU=;
        b=ofWucf2bGTLwCpybikAIObq/1QtnY/0if3rMdWMHqQaGsrUoxR/6sha9ZzyKeJvIBm
         seRMIUR9OjHPGQBFLIsf2yVcDD/F/md/T2sYFS9rK8HCKVpWw54kxg7/q7D/vIjshH0h
         UWa78oLW/OtWrhyXri7TR7Tq3X6ANj28taFscKoFo0fUpaWMQqcaGg56KBh8OhNP5t9i
         U5fYl5Hv5XPsHnmLat4FzotREggpg8hALYVhGJVmGb0goZSdQqWywqNE85LWWZC1kC9m
         l/7mglw3MlkPuHPvQUwsIx3x8BpOUZwMuhaNfLYWm0yNnBS9+nh0Mc+hA+nxCR3HbpbS
         Cvug==
X-Forwarded-Encrypted: i=1; AJvYcCVEfvjGS71gTaBr2dG0CARO2Aw35x7TBgwFky5D/YppEkrFKVHQ/2QgD5pEFonWw9Byt5PIuPPB0u2laIxaHPWidptO25AvnVNF2DK4PVaBVRxuqa8n+bHHZ8N4IPX74jV5CbC+IlvHUWp3ZapG5XI8wNlzSOW480W7nj22Y5s/RJco
X-Gm-Message-State: AOJu0YyDqE0p2oQFG9Arc3xNENGqvMoVkC/7Vfckj5H5WUeT86qjbKqv
	/pK+R+rGuGcW5NgD+SMWNMzeyrPdlU5kICWMFruvpHg4mP8gAuqIUBoteA==
X-Google-Smtp-Source: AGHT+IG6a4OA5LnNPQiwBz8nuGa5Qz7uWt4ILXcxnsimT2BzX691J9GZeOlylM4aKL+GQUkjZ1s6tw==
X-Received: by 2002:a17:902:ec8e:b0:1fa:15ca:e61a with SMTP id d9443c01a7336-1fa23bd1afdmr5192875ad.8.1719074277601;
        Sat, 22 Jun 2024 09:37:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6011sm32988965ad.144.2024.06.22.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 09:37:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <11983f65-ec2f-4092-917f-7a09bae7c4b2@roeck-us.net>
Date: Sat, 22 Jun 2024 09:37:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review [parisc64/C3700 boot
 failures]
To: Helge Deller <deller@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org, Oleg Nesterov <oleg@redhat.com>,
 linux-parisc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20240619125556.491243678@linuxfoundation.org>
 <614d86a1-72c4-489b-94f9-fbe553c25f28@roeck-us.net>
 <21d5c00f-a373-4173-84e5-33dbd6305b57@gmx.de>
 <2760c168-974b-41da-9f1c-171a07bb60fb@roeck-us.net>
 <48aa5db8-2605-42e3-a1e3-1bf3428380ee@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <48aa5db8-2605-42e3-a1e3-1bf3428380ee@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/22/24 08:49, Helge Deller wrote:
> On 6/22/24 17:34, Guenter Roeck wrote:
>> On 6/22/24 08:13, Helge Deller wrote:
>>> On 6/22/24 16:58, Guenter Roeck wrote:
>>>> [ Copying parisc maintainers - maybe they can test on real hardware ]
>>>>
>>>> On 6/19/24 05:54, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 6.1.95 release.
>>>>> There are 217 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>> ...
>>>>> Oleg Nesterov <oleg@redhat.com>
>>>>>      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING
>>>>>
>>>>
>>>> I can not explain it, but this patch causes all my parisc64 (C3700)
>>>> boot tests to crash. There are lots of memory corruption BUGs such as
>>>>
>>>> [    0.000000] =============================================================================
>>>> [    0.000000] BUG kmalloc-96 (Not tainted): Padding overwritten. 0x0000000043411dd0-0x0000000043411f5f @offset=3536
>>>>
>>>> ultimately followed by
>>>>
>>>> [    0.462562] Unaligned handler failed, ret = -14
>>>> ...
>>>> [    0.469160]  IAOQ[0]: idr_alloc_cyclic+0x48/0x118
>>>> [    0.469372]  IAOQ[1]: idr_alloc_cyclic+0x54/0x118
>>>> [    0.469548]  RP(r2): __kernfs_new_node.constprop.0+0x160/0x420
>>>> [    0.469782] Backtrace:
>>>> [    0.469928]  [<00000000404af108>] __kernfs_new_node.constprop.0+0x160/0x420
>>>> [    0.470285]  [<00000000404b0cac>] kernfs_new_node+0xbc/0x118
>>>> [    0.470523]  [<00000000404b158c>] kernfs_create_empty_dir+0x54/0xf0
>>>> [    0.470756]  [<00000000404b665c>] sysfs_create_mount_point+0x4c/0xb0
>>>> [    0.470996]  [<00000000401181cc>] cgroup_init+0x5b4/0x738
>>>> [    0.471213]  [<0000000040102220>] start_kernel+0x1238/0x1308
>>>> [    0.471429]  [<0000000040107c90>] start_parisc+0x188/0x1d0
>>>> ...
>>>> [    0.474956] Kernel panic - not syncing: Attempted to kill the idle task!
>>>> SeaBIOS wants SYSTEM RESET.
>>>>
>>>> This is with qemu v9.0.1.
>>>
>>> Just to be sure, did you tested the same kernel on physical hardware as well?
>>>
>>
>> No, I don't have hardware. I only have qemu. That is why I copied you and
>> the parisc mailing list.
> 
> Yes, sorry, I saw your top line in the mail after I already sent my reply....
> 
>> I would hope that someone can either confirm that
>> this is a real problem or that it is qemu related. If it is qemu related,
>> I'll just stop testing c3700 64-bit support with qemu on v6.1.y and other
>> branches if/when the problem shows up there as well.
> 
> I just booted 6.1.95 successfully in qemu and on my physical C3700 machine.
> I assume the problem can be reproduced with your .config ?
> Please send it to me off-list, then I can try again.
> 

Done.

Thanks,
Guenter


