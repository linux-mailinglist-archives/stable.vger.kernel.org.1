Return-Path: <stable+bounces-54871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8399134DF
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3AB1F228BE
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155F16F906;
	Sat, 22 Jun 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEx/m4p7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D215442C;
	Sat, 22 Jun 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719070453; cv=none; b=oKx7Amx5h2EH2VrmkfV0CXOwVnE2m7lO5tGQzTXxbY7p/slpTgg1T83r5R+JZNKEOrWZ8vs9vkrFZ/+oOu/Dj0n8MsteKatHYpXJtzPVs10xAWTK7D3ytSra6RczDfLbqno1UP/g5Zd+nU12Zmn8GZSPH2RbKLoNnPZP5yK3Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719070453; c=relaxed/simple;
	bh=QCoWPbZpA5+ahyyQf1f/cMvhxveeyZCQS/I444joNNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP+IctH9tuV6OTh5MHtP5shFFG1Iyx4YgeRnuEST8pJKc+znKNUWFTMIISz307HXd0I79r8/xa6vsKv2p2eWKg889r7xRuby7I4M0dAe4CsZHrH9pEWZtMZ2jKFLie6sOiVOPmgJjuLhGkUMnpWeQDsEyZM7Wqc0Uj7f2tKndlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEx/m4p7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f700e4cb92so25259075ad.2;
        Sat, 22 Jun 2024 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719070451; x=1719675251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bpeqB4hqfDsoJc4VU7OMJoYV4bguvw8cUE3Pl4T7xd8=;
        b=nEx/m4p7Z1oJocuDaYX6uajaTs5dBZU1drfj/YaySDTP8uorPjBeXWXFPwj9JEjAAH
         H4iXHnrrV+un1w4gJPSxjBvdVvaMwLS0TVHAaAOdw9DdPl4SIBmbfMXL5baFuch4tFCh
         cC+QxeKr0k2S79pDcwqQt8iLSz/BZaUkYiWicx/RUMjdsIcdRYMqXgll1lDqU3XqQ+5v
         jXB2l+20Y4QBoPQFDOncRl6roTO2i8+ESvyxAJT96Qm7xGtthhbtdVIdqjmbtc2Bp65K
         YAONiqlXQb/TWP5yeR4IW/FC7ArSxk4b97Gqmn0edigUuRh35+Y2d6dceW/Y1mLROCdg
         qkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719070451; x=1719675251;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpeqB4hqfDsoJc4VU7OMJoYV4bguvw8cUE3Pl4T7xd8=;
        b=l3fJrDgqjcXU/uyQXd1NVF2x6Wyc+sBLE950nsvkL6T4ao0lA0dGNOAev5vwor5tQu
         0ATAuIyeP+h+2cIS3bXXub1E4xiT5IkgnNZ6QjuGabae+4qO9O8HuyDJH9h0gKnTADiO
         79rp1Pul+nULDSnPqHmUvWix0gS3ZHV9Zkihaf348dFUVdp5fG7uoRL4J2LW1jswDnL6
         5PJe6XRovocwE+m471FtbRGhA/TjFt50gF/pFRN2tzWkLAiOadC9IBZk5FT1MQhluOhC
         0nLXSA3eK4IeG/FzCGK9CTOlHAA8lGOPwOM+DzkmMCJjQOuu2wBTfv+R2beabQ82XbzK
         F2zg==
X-Forwarded-Encrypted: i=1; AJvYcCX09EkqokHrBmz6LETbAlv4UYHhGvjZmR9dDP3FSRlf5dzLbgNkhaO4EdaPNCBirzYbHrt05Iab+jT0Wo6kEHcLn2DucQP50sn/CLwbrkEEe1GNiHmamvW3PO3D43bMaA4e02Yv9NNhQAk3dGkn1krTjyF61y8/JOjz8f2mmLWPP011
X-Gm-Message-State: AOJu0Yx7CCxPImai92vrx3rVbt/3rBL0a+vJOm6a70G8iF13CwHubpOB
	+VA5YAsjc/d6ZuEHk3ieA4mKP7la7IBNO6k5lEnVliSYEdTsLfKQ
X-Google-Smtp-Source: AGHT+IGZ6LgOdj3415vxy7OAvE4erbr6gr/PoGveULs+FC1nD8J1qVhdPXFQeicn5sgghElNL25YTA==
X-Received: by 2002:a17:902:e5c1:b0:1f9:df81:3103 with SMTP id d9443c01a7336-1fa23f1dd22mr2918675ad.57.1719070451262;
        Sat, 22 Jun 2024 08:34:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0374sm32374625ad.22.2024.06.22.08.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 08:34:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2760c168-974b-41da-9f1c-171a07bb60fb@roeck-us.net>
Date: Sat, 22 Jun 2024 08:34:07 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <21d5c00f-a373-4173-84e5-33dbd6305b57@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/22/24 08:13, Helge Deller wrote:
> On 6/22/24 16:58, Guenter Roeck wrote:
>> [ Copying parisc maintainers - maybe they can test on real hardware ]
>>
>> On 6/19/24 05:54, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.95 release.
>>> There are 217 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>> Anything received after that time might be too late.
>>>
>> ...
>>> Oleg Nesterov <oleg@redhat.com>
>>>      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING
>>>
>>
>> I can not explain it, but this patch causes all my parisc64 (C3700)
>> boot tests to crash. There are lots of memory corruption BUGs such as
>>
>> [    0.000000] =============================================================================
>> [    0.000000] BUG kmalloc-96 (Not tainted): Padding overwritten. 0x0000000043411dd0-0x0000000043411f5f @offset=3536
>>
>> ultimately followed by
>>
>> [    0.462562] Unaligned handler failed, ret = -14
>> ...
>> [    0.469160]  IAOQ[0]: idr_alloc_cyclic+0x48/0x118
>> [    0.469372]  IAOQ[1]: idr_alloc_cyclic+0x54/0x118
>> [    0.469548]  RP(r2): __kernfs_new_node.constprop.0+0x160/0x420
>> [    0.469782] Backtrace:
>> [    0.469928]  [<00000000404af108>] __kernfs_new_node.constprop.0+0x160/0x420
>> [    0.470285]  [<00000000404b0cac>] kernfs_new_node+0xbc/0x118
>> [    0.470523]  [<00000000404b158c>] kernfs_create_empty_dir+0x54/0xf0
>> [    0.470756]  [<00000000404b665c>] sysfs_create_mount_point+0x4c/0xb0
>> [    0.470996]  [<00000000401181cc>] cgroup_init+0x5b4/0x738
>> [    0.471213]  [<0000000040102220>] start_kernel+0x1238/0x1308
>> [    0.471429]  [<0000000040107c90>] start_parisc+0x188/0x1d0
>> ...
>> [    0.474956] Kernel panic - not syncing: Attempted to kill the idle task!
>> SeaBIOS wants SYSTEM RESET.
>>
>> This is with qemu v9.0.1.
> 
> Just to be sure, did you tested the same kernel on physical hardware as well?
> 

No, I don't have hardware. I only have qemu. That is why I copied you and
the parisc mailing list. I would hope that someone can either confirm that
this is a real problem or that it is qemu related. If it is qemu related,
I'll just stop testing c3700 64-bit support with qemu on v6.1.y and other
branches if/when the problem shows up there as well.

> Please note, that 64-bit hppa (C3700) support in qemu was just recently added
> and is still considered experimental.
> So, maybe it's not a bug in the source, but in qemu...?!?
> 

Sure, that is possible, though it is a bit unusual that it is only seen
in 6.1.95 and not in any other branches or releases.

In summary, please see this report as "This is a problem seen in qemu.
It may or may not be seen on real hardware". Maybe I should add this as a
common disclaimer to all my reports to avoid misunderstandings.

Thanks,
Guenter


