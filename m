Return-Path: <stable+bounces-191969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB2C27223
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9340B4E60B3
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8D2F3635;
	Fri, 31 Oct 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OS9LKwX/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143662EB84F
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950250; cv=none; b=NJJTIvGhAFl+RliXhbAGlFYsiGv7RGZ/ibWBJiEsr2JoH0Zrg30gsr/GoMULPdxojQ7fTnOlIMxh3ccSWRAN48+rGUgnLFqoNKxjcBjZXo06SOjkajmlUJ12QjhE4VnbiHdEsJYmW5zrBAk40Sz+/8igimMqJ7bArs8cvnPj+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950250; c=relaxed/simple;
	bh=lyoMRXm6f9/VrNX6C+nyCiEeZEgKdKGMwqial2YdLtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOjvl9nU4l5U2diiFuCQvgpx40/qey+NcZCekfHnpCiQS1OkB55w5Hrys745nHLpICBvPubMYIXWtHu3LiaFY3F9pNSWUV+IiYnxuvMJkTNVvrffnCfdNo5er5FnfXky1pZz6qeEy3tWmFx+apDTSAq3GQzRP4ekbm4KuGHSs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OS9LKwX/; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-433071389e1so21701175ab.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950248; x=1762555048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYZpsZRI4LYROmtgQIPxauwwjRjZshuAEYwDGnWdS9Q=;
        b=OS9LKwX/rHbjoNUuDCf+D7Jb8NP0ZoI+DEN+yZUn6AWL2h+tW1sX+58WxisFBrlrvf
         roAfSG/EQYL8BsaMbHtyfEGoJ0VUi/cbHv8YVZ3vOnKA25I3+DevO9aWBEPE7neKO/42
         3UZg7tT+pk6HpiwGJdiuy6iZ7p5Gf2cV5WJPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950248; x=1762555048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYZpsZRI4LYROmtgQIPxauwwjRjZshuAEYwDGnWdS9Q=;
        b=C4Ydq9eJMxt6Oa96mlsQ9VFc4SuhSPZsHn+/rN3Lw87VhkXYgr6Z/p56O2Z0u0mIc7
         GyXTJt2kb9rfjIro4m2ePDE2B5fujZBcfG9NeKjdXTpsZTsxVR+XiN1b9A5ToENeJDSP
         HjvJskOmlviHWWv3GdDW/CEw28wG56KphAgMuL2ZftF5N0mYVD71d5lKtQxt5LEWiuRX
         YNKP/Nz0F8nQa2KTmjwp+BwMYdY0cFa7MbTlQhFOaZu2E5rbbfHUS+uGOFFsgyCyzptF
         qhKI4VenOieLDoLVSffT8vDJMPMnB+PIdum4YkmUbvFeAiVoxem9/UZJuBv0Nv//TIDN
         qVQA==
X-Forwarded-Encrypted: i=1; AJvYcCW5mytQqV9HLRiheEX0fcHx+AzGB9ojNP02E3asdBnvVTvhEOx49VtZoapo3178ClQBVWcqCME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HpHgu+9tjAKk+0t1zKQEeE3c/omRJ/kgcceiq0K8kmRy7zlW
	uFFVRKjsNPHNDtHt16mlmaSWivWwU/fY/mSRUuhiD9u7li0JY1zjCCitVwxtCsfnw3o=
X-Gm-Gg: ASbGncswKHNNc4quSexCWu6IsBX2qrKG9V8Tkc6dyt6KBan24DwYzy/OAScsCBWSJFe
	08eW4K2rn3T+CJ5gKUtB/6NGk+e0J78z859y14NkLDQp7Ikvac5bViyHUh/BrTfoiPgrVo+8Ul7
	rkCyAHYyTmQIW1HCc4B7Cpzx2kddAtKXyzS736KVzSHUH5dEi3zzmKwqdwW6Yc+KScqiDRQjiGz
	ke29/mHYFub4YRAElQPnN/3KgtNBbd+4VotSemwu0DfkMl4O96oBDNepG5Htp9vYNnAYa8A6kqC
	XfgZ2zPUoW8TyJTZouVuUkipDnVLHLmgEtxfgd+xXBhS28pcI4Z3NvnC9jFCouwWgnGwIioRSkN
	Sr1wIesPuqX7JotT5GRSPzlsYRh5obl/fs/PoYTPXuExWdAAhXYfW3EOBzwhda2DC8iqkfocrdG
	R65SlMeWVMR2NT
X-Google-Smtp-Source: AGHT+IHQbq8xoN+qH3Deos3yPtiJSPDT57c1SPO4PDOvJb5EBUgTWDF+VAiwrMirbjgmdTNntAVEoQ==
X-Received: by 2002:a05:6e02:3397:b0:430:9f96:23c8 with SMTP id e9e14a558f8ab-4330d14876fmr85117115ab.14.1761950248190;
        Fri, 31 Oct 2025 15:37:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a34b8c3asm1161665173.17.2025.10.31.15.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:37:27 -0700 (PDT)
Message-ID: <993bf106-a8e7-4f71-b340-7db170ad10e2@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:37:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

