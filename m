Return-Path: <stable+bounces-144450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46649AB774C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8E862AE8
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2FC2F2;
	Wed, 14 May 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdnfWe4J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCF746E;
	Wed, 14 May 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255751; cv=none; b=Aw6XdLWTMntJpB2QFe0rclUgNJGXmV8k+zgz0SqrIk0bExDwLuvdsO9E+y1hvTdskJL21Zc7Q6fjQHTJMtEoaSwvV75scxSrL91NFC76lFVlRXezoyp8P9qp1Ut1SH6cs9nYY8gU/c6sIU4kmU+eeYMua9+PWxFYlX0z/yWojHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255751; c=relaxed/simple;
	bh=rE0nme3UR6JGtve/bdvTfkT3GlbF/KK2HGPbSK/ETxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrPVu+FmHGJyjxQ1VUoqiLcRVBwEuwuAAjTFoKUjYwqICqC2RRuFNNaC6SQsjcj2XZd9VaIyd/L0xE36rwZRpyxAoIwKKLkbmgL7zS/oJ4DghvgtDwf2YT+q8zh/Uq928+j4Pkpk3h83ZpNKEFtC3nCdR+rL+BMyod2exVf2Lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdnfWe4J; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so320065a91.2;
        Wed, 14 May 2025 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747255749; x=1747860549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4TWkm4Axk1iyu7DwZESVkMnCOkvF4ymCsQoRNABC9NQ=;
        b=OdnfWe4J6utK0V23dOMPhistl6wNjoKauobnM5os6SwhuFmEC7OAQv2lA+O28dlBxT
         ypx4y8bcuy6NGJXwbIiAXWXKwT9ZEN3ZiiK5iCwwwFNRb9Id/iRzZqQBO0ykwhxSc75p
         QQe7ntWw13xYbJxv3gRi4zYhNQqPY3BYw+M3B/v4xKQYMgMLHNqnKWIbdkP207AtST87
         M3HdIn/tZaRolr0LGm5eGk22c4/PNBNh9k2J9FeSGOfEX+OVaPUBcEP594zrMpcwWb3/
         nWq2YcdFu7yQAm90Yz/Yr/QimIW/lwbu3dPsflPVhAVLBKf+LnZMkl6FkM02yVaaAsED
         Fq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747255749; x=1747860549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TWkm4Axk1iyu7DwZESVkMnCOkvF4ymCsQoRNABC9NQ=;
        b=tx7ZzEOCCMYyzsxQIQNYneOy60N94p/cPWkKfT6nFHvK4bPDySSGJu91NmoJB+qPTd
         gZK6HQcn9PsF2IkUw5oe6k6UC8DPNT6ug6TimxI+JKrgT49STx46F5yBU4ikaTWZaxIB
         iQwliuiSeBOUU1ncc7wLOvFSIHGTdcA8n4UZbKzUh/TMVjSYWeAl4GcTi9HNjlXmXbNC
         j3LpVOOk05fdKLxLKZT+/RkEjCeF+fh4/MvCZdDl2Net0pcX0KHixYaXKPCfmn8HmAmJ
         eltikQtfK7I+6CQ+hmLtmLGkqh0QfxP16b2gMa05vCTP65XuagfMsLnHZ++yuTUjVvjH
         vWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHEn2PsltesCzNdEPX04Jh6ec2HV89AFafgdHLUA5YyMMXuA93RnFR6c6wkNUin8edpPbRk836gffeLcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboZZ6evOuo6crd1SBoc/622vy/X4ib0kIxLEno7bcPll6eIUz
	K1rcGMpenfWYtBWNFReLjdtzO9bgvmCWjatY7glzO6alNF/FMwDy
X-Gm-Gg: ASbGncutJYpfgSlFXJ+ULw7M6w0IBkcO6f7KebQLRJPDPpeCdA5njB903x+j41FtAHt
	0mw1HUcT5C6rq6J2DEnDoXhM77vwkWeL67T2Mnr0h/ocwlwLBqwk0rO6Rg0WZTINL58vAWF7FgN
	SG21xyq9izUglkD4C8Y1d1yqHmP4HnGVAlgrcFpR+17IU1dmn04WathA6HFO6naPSbyn3jsVnMY
	oEOTuo2XSRgVstELsaWkSdv7Tx5Bgz2SI+LbdzK6WKfrnZfj+XJnlgURoU4NQhhX+uWeI6ENfU/
	y+wBvBbMzzYcCrOnyQMwramrStKNUGSG28zHP+FgPEUpBfYQ+TKqQ15sYh4L1u+wgRwWBeN7vV/
	aNlLjmlqpZ25XaOLGOyTuq7XwNaGSmt5tFzE=
X-Google-Smtp-Source: AGHT+IG8Hz3dWZ+uZdxCOMvGwrsDdFLZhyO0aJQKCEOYGQQtHCAhGk7ylVgss5kOv8QeH5p7lhEMFQ==
X-Received: by 2002:a17:90b:288b:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-30e2e62ff9emr8877929a91.33.1747255749050;
        Wed, 14 May 2025 13:49:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e3340194asm2019137a91.5.2025.05.14.13.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 13:49:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e1ea37bd-ea7d-4e8a-bb2f-6be709eb99f4@roeck-us.net>
Date: Wed, 14 May 2025 13:49:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc2 review
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Darren Kenny <darren.kenny@oracle.com>
References: <20250514125617.240903002@linuxfoundation.org>
 <861004b4-e036-4306-b129-252b9cb983c7@oracle.com>
 <2025051440-sturdily-dragging-3843@gregkh>
 <9af6afb1-9d91-48ea-a212-bcd6d1a47203@oracle.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9af6afb1-9d91-48ea-a212-bcd6d1a47203@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/25 13:33, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 15/05/25 01:35, Greg Kroah-Hartman wrote:
>> On Thu, May 15, 2025 at 12:29:40AM +0530, Harshit Mogalapalli wrote:
>>> Hi Greg,
>>> On 14/05/25 18:34, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 6.6.91 release.
>>>> There are 113 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
>>>> Anything received after that time might be too late.
>>>
>>> ld: vmlinux.o: in function `patch_retpoline':
>>> alternative.c:(.text+0x3b6f1): undefined reference to `module_alloc'
>>> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
>>>
>>> We see this build error in 6.6.91-rc2 tag.
>>
>> What is odd about your .config?  Have a link to it?  I can't duplicate
>> it here on my builds.
>>
> 
> So this is a config where CONFIG_MODULES is unset(!=y) -- with that we could reproduce it on defconfig + disabling CONFIG_MODULES as well.
> 

Key is the combination of CONFIG_MODULES=n with CONFIG_MITIGATION_ITS=y.

Guenter


