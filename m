Return-Path: <stable+bounces-111887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5BA249A3
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BB93A46C6
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9317BA5;
	Sat,  1 Feb 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoeJWMGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B131BBBE5;
	Sat,  1 Feb 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422219; cv=none; b=ERob2naGVisLKtB0hAzfd+0Sw0mrdLehugR3/Fg2hOk2jt/LPwqyMLJgBrRTKgiBGonODEtap0QTvSdLVi09jcoGhsx9EGhWnwrl/B2c8Mkk74CoXbcM+xWvxiQMRheKM5uzG4B1dh4tW5LjF++Opa2hjUjLOCbeg6B85bu8qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422219; c=relaxed/simple;
	bh=DD8VfW9o2r8rJEd+IEUqi9Z/ZvLmjHNSjQsGK6H25yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoS7o0+wvJsF6VR9OyzeBMGl/kWMBD0gNUccutrEEZp6t16BWAVSGvQzOGxwnW5dmvbWRHnLkamnNQS32Zta1/vdPF/Z1MAdw2uTDixsU+K366mUD8FvEuKZjZtqrcajN8r4kFChRwGYErvGz9bFcbdtJD6U1ykqWO3CUj6Jhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoeJWMGx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21631789fcdso53486825ad.1;
        Sat, 01 Feb 2025 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738422217; x=1739027017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcDmH7gsgEJWi12SQ0kBDnjX26Y8Vw0rc0aE3RRxPdg=;
        b=UoeJWMGxTgpWFRdy6LHcM2tC09pjP2lujmimL9dmXYj3Fw2F6/PfPKKq+LelmaCBNY
         OjMe6Douxp8n/jySdCOwDjphkOem1Pwkw5ImKYjFoBbktRT3aK53wR656NT+5IgDrKX/
         2wTPuhHKMmzLm/8NI3Ui8kDpW/k+RKpbOxyPIsA+B2VDx6jy8Eix8+ZSdQ5CmAzotXsK
         QWVmLZxibwTXMc+X40+aHuxQ3Kx5mgs3b0Kp08nMZyL3P+4D7smIdkyqt7KKFs+VzOvL
         v3FS2MJiD33ShmIa2OmrF9Ypcau3zATSHa/t59NwVwwKw5u4U2+YNHjpXeBVblEhLzOI
         bo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422217; x=1739027017;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcDmH7gsgEJWi12SQ0kBDnjX26Y8Vw0rc0aE3RRxPdg=;
        b=vY9ryWcps+4MOt2UPsS0t9mqzSfThwtZ+SdNC1pD2RFRj8lwsy5FQu6dDV+BvTPYhw
         x2YB1XIV9KX5VpX5QkrZtHhTLakW4FJ8R/m7oU7ljJhJd4nreQhNj7S1MbjOR+tezm1k
         8uOWeeXthDLFFuSaetBfQxjHxIW7u87VHQiXuJ3FdA96A29XgTJLxTinbSH+Bxj3Zoc/
         MxkPP5p5EwkAZ9wVn2GyanYkTj64w10xy30l+Uqa3rbnWOnJWIhEkB5JN3HtqF3Emtgf
         oZ87E/SqDi1sLmMdXu6foloxa3YE1EI5+T/zvnwR+jMm0naD+0UF3Qbr5AEp9XpteMZo
         iX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTJ4DiErITYwQdRTUcsHBsCkF68fV4UkFKOuLnwqpy3qL1I/fUA2G27IDL+QACMLBC6GwEgZDolNd+FBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6VWyAI2q1rX1AXlAkCGqfYG3/+8jMuZUAvfFICnooQ7QZ7rl
	a3r98zPgREYBxoSmF9c2cxTr2apXFC5KgH+RG6yNpZh9xZUqJjqo
X-Gm-Gg: ASbGncvsv2VtzupNrRgY72u2bsV+9fF9E0sijtnWXrEsHHclw0JtY2IX3houOb11NjF
	Slc3/yVOZ9FEPlYTVTphGrPlFC1IXa7RAV77HrbEXtd1EfAJ3aJz8O1smc5UFgN+pXbzobc49n5
	k9VjynvfaCIwFIXjzr2t+6226pLj3fHJOyFYfiaprRRhxsp+KDy4xHREDWTrWiemquEuizVCY7i
	ikl7hFpyLegnEOcR161Z48O8v1iDfp6BGIE+vHIuCh5RtJSK4ldViJCksa6mgQIJ961LrUHKZGZ
	r/caWIGT1tPkkHccsi4kG/ihkcZHJEXssloaUZSgFbUNhagsAxVfaEQEspMzbH00
X-Google-Smtp-Source: AGHT+IEpjID2jYrW+M0djm9cTXaixd9ZVxKsfEkWLxxcQOS0l8KbAiAORx/K/1W/vMG5l01POGI0Yw==
X-Received: by 2002:a05:6a21:1586:b0:1ed:a5f2:dba6 with SMTP id adf61e73a8af0-1eda5f2fe6dmr5899280637.14.1738422216727;
        Sat, 01 Feb 2025 07:03:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebea4005csm4160206a12.44.2025.02.01.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:03:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb1e9306-9c05-4a7e-914b-d5127a411ebe@roeck-us.net>
Date: Sat, 1 Feb 2025 07:03:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/94] 5.4.290-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Machek <pavel@denx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250131112114.030356568@linuxfoundation.org>
 <Z5zIZHIZxuHoymof@duo.ucw.cz> <2025020157-unsecured-map-aa0c@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2025020157-unsecured-map-aa0c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 00:01, Greg Kroah-Hartman wrote:
...
> Anyway, are you all really caring about riscv on a 5.4.y kernel?  Last I
> checked, the riscv maintainers said not to even use that kernel for that
> architecture.  Do you all have real boards that care about this kernel
> tree that you are insisting on keeping alive?  Why not move them to a
> newer LTS kernel?
> 

Looking into the 5.4 release candidate, I see:

$ git log --oneline v5.4.289.. arch/riscv/
98d26e0254ff RISC-V: Don't enable all interrupts in trap_init()
574c5efceb70 riscv: prefix IRQ_ macro names with an RV_ namespace
c57ffe372502 riscv: Fix sleeping in invalid context in die()
98c62ee8bc75 riscv: Avoid enabling interrupts in die()
88cb873873ff RISC-V: Avoid dereferening NULL regs in die()
2a83ad25311e riscv: remove unused handle_exception symbol
8652d51931cc riscv: abstract out CSR names for supervisor vs machine mode

Why do you backport riscv patches to 5.4.y if you think they should not be
tested ? Shouldn't your question imply that there won't be any further
backports into 5.4.y for architecture(s) which are no longer supported
in that branch ?

Confused.

Guenter


