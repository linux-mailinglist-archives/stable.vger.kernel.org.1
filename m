Return-Path: <stable+bounces-83480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5E99A8D2
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 18:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C80D1F217BF
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050418C008;
	Fri, 11 Oct 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jymfRrkg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572A198840;
	Fri, 11 Oct 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663763; cv=none; b=p1lG07ZdNeIV1JYq9SZO5g4GJx1Tu/B4+ln2D/Xk+ivMmRC39HGcOyow63XSt1BFtEzlyqvMflyTVXd8voIL1P2a9sb3Gsc0qc9czZGSbqnz1+EtMrwlHeVQbfwSaNvkBq2jZbFPw3Z+UNFI+qZy3HZJAhsEqpLYjvPQSdG1Qwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663763; c=relaxed/simple;
	bh=PbB3rIKGvbAvYpxtLLWFYWoYxTd0khpG5z069+dd+vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJt4SV710mDw0UWSWzqG2o/i2zrkAXg3Qu+YHAOiaw+9Osyt5RGPrInnL8ZlZ4grszT5ZV+I1glsmO4lf6tepj4YNYDHho42PyqB39uUCwRbnuVgA7XIAH+ltdyknZdZm0YFFFLX0BmTVVBqc87CMhwUv4tY9cLtvuIn1eFGvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jymfRrkg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20caea61132so4658065ad.2;
        Fri, 11 Oct 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728663761; x=1729268561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OuBSzhIwnMagOUUfpLw22fcA0SccOjrSFVQyKoEYABA=;
        b=jymfRrkg1We/yLZthp2VJaoIOOWO14bNgVJEH5DRH7xmhK7y1RF4Hnmv6ZEST2pAjJ
         Vh4ttIGsHXo5xQ6uugbrR6a3I22Hp2hmE+OnTnU8pBpR/WIaqZP+hYzosixFR+jKqvJw
         vPuxhC8zlboWdDkZncLFTdYn5cAkXMPrPEBdD8JAZxfDO9uol27IlfAdJEUIBgUYhEv+
         DIFJIXUuAxe5agL6JL5FJ68LmioSBr/gaxLHM/sbIrjJsok3GxR0wZCdkgSG6GF7rdsN
         c6T2N0irQ6pW7CuskT/18DmzlyCCanybBs8msVW0CV7QgGRQIOEqQ/WVEPDVv5HM+QkA
         9qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663761; x=1729268561;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuBSzhIwnMagOUUfpLw22fcA0SccOjrSFVQyKoEYABA=;
        b=DueRKLdgLyJR3fPTONHy+dcgITZLOw0pwM7BQsVnUOtPsyx2bl/PpBqYT5NH0j1rKM
         HGeaUSI8M+CMTLSOVgJHB75sfKrcb8HXHLT0QKBcX/d/Vo1wTY3l4s0IZqStvRwANH4t
         zBjP+SjbdocsO97sNNrT7wk0mzzbxmScNBYzSGkM/fKgrpMwgjQleihAO2E2JciiilpO
         2pp8rUDbphc40PKsiOcXS7kKMXFthfGfPITJY7+bwHhaeZZzveWXInNQf7hkNkzoD3p5
         R/GqUWup5hE5Nip6oDNCFQWF34PHBb7AdxblpJ+ioZ5hDE4AYKnvVe82SA3nX1+Pe5VK
         vYQA==
X-Forwarded-Encrypted: i=1; AJvYcCU9qAFm3IIg3PSrR4ItaqEgfFTpn66SDJkmxgTnmbSTtBuC3oiGJ6tal6CAV5qAI/2nKYsyMOoLzDSKYnE=@vger.kernel.org, AJvYcCWJ/XV9zdT+Mx0wv1MdjpFfbzYDmRkL9400DKPiqLWFgPZewLSXXElw9Mcl0nj31SeQw1v2nolI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1kHY9BtUjGT7CZdnoiUAN7s74Nhcp/D5p7grw1LWhVs3ym+n
	QFWHd+8ktwyGsPBppmSNnrwUiMlO/dLhwK7VZCI82g6IdRBPCUMi
X-Google-Smtp-Source: AGHT+IGinWdVVYqxXK0AuT7KM2ymFJcUgJD+Mje9DHlJUyAwq5oBW0lFy0IlcIGvXK//GDuFrOeleg==
X-Received: by 2002:a17:902:db01:b0:20b:6a57:bf25 with SMTP id d9443c01a7336-20cbb1c6cecmr2398445ad.20.1728663760882;
        Fri, 11 Oct 2024 09:22:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad3455sm25169395ad.13.2024.10.11.09.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 09:22:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <611bf42e-281d-4764-9bdd-88983e6f6586@roeck-us.net>
Date: Fri, 11 Oct 2024 09:22:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115648.280954295@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 05:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 

This release, as well as 6.6.54 and 6.11.3, is crash-for-crash compatible with the
upstream kernel.

...
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.14 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
PC is at timecounter_read+0xc/0xbc
LR is at fec_ptp_save_state+0x28/0x6c
pc : [<c00c4e84>]    lr : [<c08691fc>]    psr: 60000193
sp : c8825ca8  ip : 00000000  fp : c1e6c6a0
r10: 00000000  r9 : c183b90c  r8 : c1f6d810
r7 : c7ef4eec  r6 : c1e6c904  r5 : 40000113  r4 : c1e6c940
r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 80004000  DAC: 00000053
Register r0 information: NULL pointer
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: slab kmalloc-4k start c1e6b000 data offset 4096 pointer offset 2368 size 4096 allocated at kvmalloc_node_noprof+0x14/0x108
     __kmalloc_node_noprof+0x3a0/0x504
     kvmalloc_node_noprof+0x14/0x108
     alloc_netdev_mqs+0x5c/0x454
     alloc_etherdev_mqs+0x1c/0x30
...

Caused by:

> Csókás, Bence <csokas.bence@prolan.hu>
>      net: fec: Restart PPS after link state change
> 

Guenter


