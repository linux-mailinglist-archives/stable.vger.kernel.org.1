Return-Path: <stable+bounces-54952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E817A913BBB
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05CD2821B5
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F818133A;
	Sun, 23 Jun 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0N5t4Ky"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43252C95;
	Sun, 23 Jun 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152889; cv=none; b=iBlixIVN4DFgWQaLUVuPsMUYljKmEUn2WQiRii7ATvkJiGfuRaupIU8EUrRrdnkM23kmxf2gL6nq09TzGaXFJQ1wXOyjavUxIAWhLDzYTN7mKliJtzzZakULTynH/0ttC66OzJ+83Ec1Gx7Q211cM1LL/ed6j5vLPzElY78j9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152889; c=relaxed/simple;
	bh=uTS0y5tk4q5zjkmZUAian/2KuNlmbhkj5TWIK/NgBTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDpt7TksvWfZtUnzNSiMOuHD541jXxHVQyUjgV2SD4TlDOcGnE1T8POSbqtA15FgLAAsOx3JY168C3mlHYc+ju9J0uNMCF8cCwP8NoH8KzGNk5or8azEaOgzMIRESRxReQQDL5Cb4/+wvZEV0MV4IHdzGNtSS4QU7CE7hihWeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0N5t4Ky; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa2ea1c443so2971895ad.0;
        Sun, 23 Jun 2024 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719152887; x=1719757687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jqO6Icdxzq7ad8wELujObe1VLZwcjB87wmoeNB6xN1Y=;
        b=c0N5t4KygW8RwyF45+qBcInRq2Xd9iFY/UXMnRQSb55r+zZLOcOG/2mLhXzXgV7wOY
         vYxEChTOwVivK8km9tM6rvqNNrLVnoxHKw34u4NERd3jd3bBC99aBm7w/QZyyCBKmf6q
         BdV3rk1bV2w7xzam91sUAjcRRj4X0wC/d+Zc9AgV5pu/I3xu7b9XJMFxnRMuWGe4nobj
         Zl+BD/yNSpsG1Wnu82ymswBCFj/xBRglXb94V19D3x33WvUUD7Tne8syi2a6dsbggWeW
         GPJ0bNzjFqBa2rL57rsYD5sQ6vX+28w5Rx5ACDbvhbe1hZYwfoeyINnYFtZhi82LLKnV
         /UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719152887; x=1719757687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqO6Icdxzq7ad8wELujObe1VLZwcjB87wmoeNB6xN1Y=;
        b=M5Tr3IMHC+uzn/XNOSs3vBilAleGi+djSDySUVnZVGx5ujcaboY36enPSYt+ISJZco
         aryKydLDSfI/liY66jRai7i6YMoaZ9Je+9/7MXXMdIx2L9ar2cgqQQLKSbbOAyDYQyFw
         Hi4QLcTmasZYz7tPR47v0c6DnuqZH1N/r6VyB96VxBdRIltL1gLkoPeBJaNaBclbx2NX
         KZp/1QA6zXKJRcW7EXJs5tUccKfM+9GPkhnrKkXnxt7Z+F3llDaDjEDlgBeD5YAkeViP
         v6IPq1kM6tX3JuTKMI0hZei1TqCEFirDxRtJFpp4jPVKsU3kQuX4jXSV3ONgnJo3NYuc
         14Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUEeIZQ0l4VHL3plyajjAIG+WqNgz6ytk/xL8lWNAaKf5PQn9uJiAKv60DGWZI76XdoOq0moBQ0tj+9idFHTTpn8RWTR6fur6R7ZacKGcj+KGdF2QfXjTUXuoZxo+Sq6HZBs+agm7+gCBPnu3wF59JYzUPTeoceK5PGdaHS5H2xwD0Y
X-Gm-Message-State: AOJu0YyVxD9qiKg2GBBEzv7/Sv0V2g/YNlebqPaJCleR4QgzXlLEff0o
	0TlCEqXe36T4UzBTQdkSAnmvtZJQ0CMvwSEnKOoOOAgTzguSs5Kg
X-Google-Smtp-Source: AGHT+IFjDr9GyxsTqtQNjKwUjgnNG16nBwyUcLpr72RPNRsO+MVzjMOQUZQg2+OpvuosWHHKPL+Q8w==
X-Received: by 2002:a17:902:ea08:b0:1f6:5013:7842 with SMTP id d9443c01a7336-1fa23cd95edmr31101595ad.27.1719152887013;
        Sun, 23 Jun 2024 07:28:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa2e3d0389sm10487575ad.107.2024.06.23.07.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 07:28:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a496413-0317-48d2-ad78-2ce32f92f12b@roeck-us.net>
Date: Sun, 23 Jun 2024 07:28:04 -0700
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
> Please note, that 64-bit hppa (C3700) support in qemu was just recently added
> and is still considered experimental.
> So, maybe it's not a bug in the source, but in qemu...?!?
> 

Following up on this for everyone: Helge doesn't see the problem on real hardware.
I can make the problem disappear by any of the following:
- Use gcc 13.3 instead of 12.3
- Disable CONFIG_KUNIT
- Enable CONFIG_PAGE_POISONING (without actually enabling it in the runtime)

Overall, that suggests some kind of heisenbug, most likely in qemu,
unrelated to the commit above.

Thanks, and sorry for the noise.

Guenter


