Return-Path: <stable+bounces-119407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90134A42B48
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891E91899440
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21024394F;
	Mon, 24 Feb 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLb1kTKJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01ECA64;
	Mon, 24 Feb 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421346; cv=none; b=nrQ4CBwPAbaTtBwdamMP8MHXckGFPkcG2a7Z2hleOyo0Q3tl8DS12QH5byRzLktR/ajgs0rHEPtPaaWf9fOZ/JIrm0d+9VOyP9aM9R0g9blghJr+xWzXBB5vURsJIPHu+dbVkdQBRxr1FIVvQSJkPj4yArPXS0n277ZOJRHXf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421346; c=relaxed/simple;
	bh=naeVgrzsbRbKEcFwVbhDb2hcvAba94hy6j1nys2AWcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7vqhpRd5uyqcM1xQ3CJ4/y14d+H3xcQqg5G4ZgcVxZbE0IKiPyMoLildWHEUZWfZ3Fba3nPTuR6HKksZBUMHrjCdpo6JoXf07CaVstJM5mAkWaZMs9uhmWmh2xPW9xzE5sfUXR2D/onxXRyS9PXuRAl+dtzP/39fjNQpZQ/oSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLb1kTKJ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7275bc6638bso590239a34.2;
        Mon, 24 Feb 2025 10:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740421343; x=1741026143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UdKEHmyMd5H47y39cmettl3IA1fNENE9xIH3vBcrpPQ=;
        b=JLb1kTKJkI+L8Ilcpt44MPxoNV8ceYGQ3qdNcS+7zwTMOgfDRWsTZABSR/mcKMZPAd
         pTV+CQZldqrilgoc8g6b74muU8iLvzFyyC+ZsmHAEgeYEWTN2Lr9KrNAqQvUXcvDAQhT
         C4wbvweJ6+Rom9UlXMK8XyRzuJGC7yzqN90kesHSqRD7itVfjGyBTBvzWWOai6SYm5aP
         boTStpR1YeVZrzCEMS89SfGol5nED7kQPuD8m8jnP0fG1iazOkQkIhqWNhadwpR4O7YY
         DAEohQr7IEYU8xafb9u3FTp+pf0RBL9vTuTilXhLQRpD7kEEEyEcQF0TaKY7Dmjj6QuN
         PPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421343; x=1741026143;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdKEHmyMd5H47y39cmettl3IA1fNENE9xIH3vBcrpPQ=;
        b=Bm8XNoT9cH6QvFps+D7nWbDS1wwfgohGya+B9dTEJ0LAQbHXAwSrDkSZ+R1aWXSQVs
         JmDEF5/xdAY/u26rkP3ovj5hqmEi/Zu9dNCu1OLJN27BYNrvhI+iAR/fVcas1o5DeKyt
         ZD46oUrsvpv1BtUOXu25mTTJG45D9gwbR6sYlgTxEp7gQKQT4IgLJbm+vxVNS+P+O997
         ot5zNQhU7XIsIsXj1uxUaD5n9bE37rOAx8R9mKK5zsntrHiX0VV2Ihs7yuiWAlrIFOeE
         fviX3JrmRwXbOw1HudaF+5ATThD2hdo1yYKVKzs8kjVKERQCgwnKDrfb/7tjBFy8Bs32
         /URw==
X-Forwarded-Encrypted: i=1; AJvYcCUjQJDv5/GGLCW7B0R14i/A4vN4BisZ8Dc3YAeews7JcAlPWRDiVYRgypwIlmaDkixNp8m464+1@vger.kernel.org, AJvYcCW3onPoJ+ija7HpfZ/d8ERvje8wt6+pS4WEO9yKrQiT0V5wr0O7et/ZM3izMpIu5+9PRgm6jaFq0IJ+0t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySxR6pNXB1k2bMHzT6QhRL5GQ3ir1iRZSWdORPCi5cGUHaHguh
	bvgBI8YBX4OPL9hAbtQByOBb7V/hlfR27HnbGuG+7/idhn3a7gNK
X-Gm-Gg: ASbGncvRLgC/FU8ntMhilCSlHAy1oj6n3vUl3VJAnv6ef3ut2Wov5gMRHrr5tUkcrZx
	tB/6kMguzclWeBOvX7Fhx9zlnjhWINhJW4DckbvszUhuvi201Q+//Dq1IlZ1p90klmz7T9ExHpV
	zntjisANZGKipYy+6jrnI1oSf7xE/3/6XTaBnCqsMlfkR9WHEs6yHLbXjARdN3qhG6ylApDVdm8
	BjtKZhFZtnaBAovZynndZ6LNLa3WwHTbJj5uoiD+en1x0VxeHi+0Vns6LbwP9AciLbR4qxef+9W
	huDTEH/ZRyGU81LbxbvEVn0Hzqt3VBF1oNWDHDyi7Q==
X-Google-Smtp-Source: AGHT+IE8yA1C9t9rSYbPuuyP8P6ehNeV+szdw5a8Yk0mho2cX/JB4I9hh8GU6Uw/l0HXkhoC4wvt/Q==
X-Received: by 2002:a05:6830:2b14:b0:727:38a3:8a63 with SMTP id 46e09a7af769-7289d15ad9dmr257289a34.21.1740421343508;
        Mon, 24 Feb 2025 10:22:23 -0800 (PST)
Received: from [192.168.99.86] ([216.14.52.203])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273b0d30f7sm2332167a34.59.2025.02.24.10.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:22:22 -0800 (PST)
Message-ID: <226b50e8-0e17-4842-b2f0-c8c84d59177f@gmail.com>
Date: Mon, 24 Feb 2025 10:22:21 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142604.442289573@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/2025 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: FLorian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


