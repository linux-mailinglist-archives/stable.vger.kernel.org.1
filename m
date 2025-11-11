Return-Path: <stable+bounces-194524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A66C4FA40
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D6D1897291
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351232C312;
	Tue, 11 Nov 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="ZVAnmryA"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697B3538A3
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890433; cv=none; b=klgp46n+mQUzobcoC/fwD3EO7Syz/SPhRhgaONlLHvveyvPT15BX0rQO3dOKpxeNLSkJojeMP0Aetbjg0kOFSlDxQVrpJbaKC9Hbh54qfYO97Iy4fCLtbZFycvuqSw99A6LvsElc1eZg+LcuXVeACTCOhL1Tk4CfXNnYDIM64Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890433; c=relaxed/simple;
	bh=ZrW+cL6/6u+Ohf+JzfSVkT6ZAGlURKmwD1lBTmPGJbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJP/EfspYqIQnNXrCFAkfShauYoNydt/MofuMocxPQg8aLAo7JkQOVj4HR8QrI01EbiFogR4DJ2iNMKIVb7HRC0yzEZMpDVBvFWH/fj5Ro6rr+e29MfPFgiDu+WrqMD9wJUU4NDHkngIdeUCnKzbaJU5D4JctmtFRqRga8wXLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=ZVAnmryA; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso137905ab.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762890431; x=1763495231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvmJ8eLa//4NsRGRjplCnKOxzOcbE/faHx1blTowx+I=;
        b=ZVAnmryA8lNKlA8piHWG8uDrFckx9DeiFss3vLKMZ/OSY7zND0NdeCa+tounEqB2Nl
         E7G39J1nY8HnKmUEZGJfi4XvIuhbVDQJ4HVjz1ac8T/VwQeJ2aQg6h1+eR8a1MJeyjLd
         PLH16pIVZUodd3NX7pXzHs0tueAzKCoCocKsE1Tlpj3JrBnAzrkvZYJV2Col48cTDq5H
         YZ+P2bndrkdf2EMlLa253ETE6Zv9l/gDCV5pfwGaMhgM90yTPYLtNfagbLWCoPhVahD+
         2A/ZxVApqxZXjnYu+tuQCJmm9+p5U4uDhbee/wFLvqZn0hkkl40mLIgjX+xi/o8DH/mb
         +aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890431; x=1763495231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvmJ8eLa//4NsRGRjplCnKOxzOcbE/faHx1blTowx+I=;
        b=hdaQOrMjPP5v1hr9dfAie6/JUbBMWIDBbFjVQRarUb4WLW9nLzS7voC4KG1CpqdE71
         j+E/TlAo1FsLLHjEmbBNkL2pEyAWnnyjM1I6cLf2p/CdrEGJbPVH/OALrTFdEz+fOzEB
         Dvi64Ggyoh0B6j62JKxf1Bel0iD642i+yHhrCWZjvOOX7XN/xx9esIPenLQ1w6nOFofv
         xC+Ui4UlrhWtncF1WqgKhRqn3OnvNsdv1UztSPaHJ3JbI1XnH0GtEf5h8LYSM737+GZ2
         phfGu+5mEYyIEGagL1EGV4diMDpw64+HFE5TeoPwh0P6eeaPplcOI9WyfMk+iNRynv3H
         I1nw==
X-Forwarded-Encrypted: i=1; AJvYcCWqF1g8tZox9rJobzO+yv11dE6JIsboDstBrJZ7i5MYGhYMdY9II2DbDaTpl6DvYa/BVZeccY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTByvPK9uy7UNyuo1a7Y+QnrNgdtdRBYmLCWTxtfm4MvFzs7q
	zglzN210yswXrbNOZIUZXeq0dEO3krl0oiLtl+Lexld4oogQPCvekzpG0f4YB+7N//Q=
X-Gm-Gg: ASbGnctIvOloeduXvj15nRcJjeC2pP978nWf9SIh/s9GGH/AWLL/pdnRVVqXAvRfJqU
	nqvcfcnnW8ATdpm11Fs472F9EZRtJyQCCiuuyNpdVMhxwQW61sgw1752W93k4M+8ocHzwVoCAS3
	do3htMzlmav3wpQFq24Via+czjrwOGzF6DBFj3zjd2ZNDz8a4tnepnWTQcJ+iPrGOfa88Ae20ia
	X0na2eIkUyH97H+k0hiBcc2Cx5WzbiV0TDwua1j2gQhOS306IHrldHOFz+EzdAjXx8j8LXdup7B
	5XpRvniAe7yZYhMle5qVbxEGuNs3+TSLTcotv7/iel3YXQGOn1hEVjCGSGegxUHhU9RgwDJ1nBa
	+TnvbH7oefVA3MvZQw7ssUU8EROyJ7nEoGVWn3Zl0Xtdb12aBkIzjnzQSSae3TbJEQ3BBdyMzDD
	7Rv2TU633vDVw5WDg=
X-Google-Smtp-Source: AGHT+IEFzUXrbqx24P+kXe5zMwKwFMHqOAgKW6mk9ecTAQgOVV1SJVteL9W3Xh6SnyVk+zsjwHpNnQ==
X-Received: by 2002:a05:6e02:304a:b0:433:551d:5f2c with SMTP id e9e14a558f8ab-43473db30f7mr5000705ab.29.1762890431000;
        Tue, 11 Nov 2025 11:47:11 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d54esm2244295ab.22.2025.11.11.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 11:47:09 -0800 (PST)
Message-ID: <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Date: Tue, 11 Nov 2025 14:47:06 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Shuah Khan <skhan@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251111004526.816196597@linuxfoundation.org>
 <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 1:00 PM, Shuah Khan wrote:
> I am seeing a build failure on my system - the following
> commit could be the reason.
> 
>>
>> Heiner Kallweit <hkallweit1@gmail.com>
>>      net: phy: fix phy_disable_eee
>>

Hey Shuah,

Just to save you some time, this patch was already dropped from 
6.12.58-rc2! :)

rc2: 
https://lore.kernel.org/stable/20251111012348.571643096@linuxfoundation.org/

> drivers/net/phy/phy_device.c: In function ‘phy_disable_eee’:
> drivers/net/phy/phy_device.c:3061:29: error: passing argument 1 of 
> ‘linkmode_fill’ makes pointer from integer without a cast [-Wint- 
> conversion]
>   3061 |         linkmode_fill(phydev->eee_broken_modes);
>        |                       ~~~~~~^~~~~~~~~~~~~~~~~~
>        |                             |
>        |                             u32 {aka unsigned int}
> 
> I will go build it without this and update you.
> 
> thanks,
> -- Shuah
> 

Best,
Slade

