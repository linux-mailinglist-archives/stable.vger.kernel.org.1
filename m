Return-Path: <stable+bounces-119400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB3A42A5C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3434F1891684
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751162641C2;
	Mon, 24 Feb 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL3hoPSZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53D2561D8;
	Mon, 24 Feb 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419563; cv=none; b=VPTGuQW2e4m+ZoK0A98jYdy4xIwr78QMnr8nrl8dRHAjMUbEiTs7kPPAAGI2enhR8+arNhVw/Xdvb7APuqPBwAthOvrDIoa1msoi1ZREk6DAj1h+Ta8Esn4tSWox9sT/ySmt7ELY9Jm3HO8CLbo0N4WiLIshBpN46jsqMdB7M5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419563; c=relaxed/simple;
	bh=NCWOxcc0FggZlDvNi6x8FO5aKjhVwqAojymTejm/gw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL8qDmL+ORmP56g1JZ+eTilYNcaH5Ff/3R18/X6tOV+Z5jI9Sa85jn98AZT5XQ/Ebd6px/AMhJ4klK6Vgnbwno211o/kezLKLkT4Ow5/2gzCgdbKwqNv0Jf7okt1uyk1BeOx+jXLiDLVDQpn5Qw05fi2zDntjM2DjVKjvK1iLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL3hoPSZ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso852940fac.1;
        Mon, 24 Feb 2025 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419561; x=1741024361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIlvp+k0tIx87AXyfg99ULU0xhzVvlrx+I8UJDBnNyc=;
        b=LL3hoPSZ5+u6UcmaDRpFtHGK03yoAKlzhk4gUmkrm0Th/XyYfK9rMp5tNbuFbASqrn
         ogyAfXUo4OzXYbCj2qSFLsprUyBfvcHZ4xyxUHlcNk3kh1wDLVWhl/fI9Wf8eS1dAsBO
         fyzyQj1EJjeGeoqOMmo9G7ydxvc5NSK384JAn/fnsFl0zoiBVkowBWfFaXZ8/usDS52S
         RsBtJZc5YTxNwWKc5r7G3oIg3dxQT6IbqliEOtqLCt0PFc959gKnCMaCeRVOGr4RCXPJ
         fWpDIH6u9BhhUnXlVItsPgFokRdZeTkhzqvYgStTVii8yQXt+C85aMVw5nZZYSUzdZQ2
         FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419561; x=1741024361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIlvp+k0tIx87AXyfg99ULU0xhzVvlrx+I8UJDBnNyc=;
        b=jximKffhbbMLCy8rthr3x8qp3iX5c2d0+NB103MImWIMl0Mk2CCyBoHQfPrB1VvmTh
         jZdXm6rQd6Iv9kJvITOP4Un+CIhkB/c5YAs47WdR1A8PMRTV8WuF7nY5e6VPLg9XvzMa
         CqaInaWMyreFVSAVW8oul0iXf/h7ZjfUhdakpaCRVPESe1pPFCvzjq0Ha5pzNaRUa/wH
         0fSB+1g8wmJXTn9F9OkZ7IWV3w/BVbTWZjzEpPIX6hg7n5mBwS1dPZcBKHpT9A/o8D5i
         tyKaUx/+ZAacqOtDFgDwGsv8jmgaNVXxmpLTjrOzYLL3ECVXQDDg6Fxg9XLkNcpsfQU4
         +Q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV85+Bxa8GU5M0ubQXVucY0ffdZrOAiTqPN31AlLpslxLkSSSOx8A9Bgiq6GuZ1bJmPFj+EHTn6kWs5Ae4=@vger.kernel.org, AJvYcCX12n47Eywq52Yxe2RYGW2HQFd7Ic8nQHN5uOdx9GyMK1or+2az/czH+T1CFF56vozvBlv59+YR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyro3bhyN8pG7NdnIrd6G1HerwO09KLq1THMQz6/ZEAl1aEvByj
	MnhZC+Ez/Ii657C+yzFI4M9ckvn9JKR6qkdN6x30ZbTM7NegvBYB
X-Gm-Gg: ASbGncsz4OP+oLAg2hevtUbdcw40dgnWDR5y69jsdhSOEzDTBx+8+7TLYt3TPI+nM3y
	JDLQABWAX1umoilACIuamUgnCAZCqQ3SIQi1IIEKe8qq2/p2m4LUCILWKffSkk20AfF0hVpMR0n
	9UcDuMXhtv9zX+FRAM6Z2ddMCt311kLXn3UmjmsJYKggiwOhXnZu6LmIMO8JKb8RqiM+SauoQ3Y
	WW1BOG3w79YrPuE4XEkhYNhtUbvm2h/W+YJt3Fas0NEB9HOWsYpfPrAKMUZ6dgcvfV6DFN3PkCj
	E6oPa29tyL3YR/hNuhtGC1I3iLE9HQIitR+w5fsXdA==
X-Google-Smtp-Source: AGHT+IFAAhDz+5WaiPZ2rXADMwKGQp4dEUYxwemzE0/IOQc9mAVrcQ3bl5lQM2sU02CK0QSvDCfkIg==
X-Received: by 2002:a05:6871:314b:b0:2bb:15b1:55b4 with SMTP id 586e51a60fabf-2bd51810cf4mr11184858fac.31.1740419560902;
        Mon, 24 Feb 2025 09:52:40 -0800 (PST)
Received: from [192.168.99.86] ([216.14.52.203])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727295b7eeesm3654778a34.46.2025.02.24.09.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:52:40 -0800 (PST)
Message-ID: <eef85f1d-604b-4c53-bb3a-9785b23b186b@gmail.com>
Date: Mon, 24 Feb 2025 09:52:38 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/154] 6.12.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142607.058226288@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/2025 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


