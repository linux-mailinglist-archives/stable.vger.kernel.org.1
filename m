Return-Path: <stable+bounces-194547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C95C500D7
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39D5189961B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA162F5302;
	Tue, 11 Nov 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrCLwLiX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB292F3C07
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903711; cv=none; b=pbe0GnF9s1C1zQceBrGYN0PDZrJD3YCpXe0XtANGKyJZffwqi0hQZ0G1t1TguTeq11biQqek15aG7hHcHfYfVcH7GIpw4mXXBZKxQA41SkGDO7SLXMgZzBKKylKLZxeZ9LGR86dRDKDeceKRbwkTHNEHPhkK/SyZF86QjhmK2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903711; c=relaxed/simple;
	bh=SBZkH1SK4zEtlic0reoqSi8cs9YBp2mCAARzFUtLSMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxU8drrHsKGZAnjHAq79SgL9q/TaPTtCXP/wJ35DGmbMnSiwFJRbGTy3McUdqNXzxXJxIBArJx5TlreRHU3qIHW5eDxmdKbC6bMrmOfJuqlBDbQbc+sSyFwNBiyo22mZRk+LenGzyBrhG+FRZVZHm1FiRHmPLRxof4iWM0MsCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrCLwLiX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c68bfe1719so89081a34.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762903707; x=1763508507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdmJPBDhXZMh/Cf/AbsXERBVSsuyRqEl9m3+Psa35qo=;
        b=BrCLwLiXyoV6npX0HPODujsDWJ5ctVXL3DcCVWnvULU2JzEQfAjEIzufB6ToAZDaNr
         G2MEP1bAlYNUSFitgAhr/Dp4AkimXu68RuPQPxzpX3YVgYgK9QyPilY9SeNA3UyrN/d+
         F6vBN6jVW4Ae5OIIumz8wMwZMsY7/EcM9Wuug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903707; x=1763508507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdmJPBDhXZMh/Cf/AbsXERBVSsuyRqEl9m3+Psa35qo=;
        b=VHTXcWp+nQvYrS2V6gNkhCmoAg8E0WHwmcguXvT1/hA4A83bNHmVlDKrQI0AJQi/fM
         7+cVtEaJsRsvwlaKS0fFA4RrOpZSn2iKDFamCyZHtBSyjhxZFflDVkyvFqGYXfcMKWUJ
         E/X8YfmCv7v542CqI6yNvEtGAiWmh6+z9kIM7z5RH7nJ7tRY2/HbxkP1f/3RMPuzARuQ
         oBy8sB/sVIGRKfUDUea5fnxg5VIcXLJkHsiY7OKs0NlbAYV8AkDbnYtfWMOHTR+6BX7c
         SvCPuMM8YXhXyWolMnaONcHONuCBDGtf29lJikLuyDvHKe6tteB9PATNbkTv1EV/JIVr
         NOsA==
X-Forwarded-Encrypted: i=1; AJvYcCW9M9hxVxw9xo9oyd8ehE1PVN91m1SHO6qCgDeYJFvhvNc/oQ/yJI+EJAd4xpAtK1zUQ/VjOTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PCYxXxM+h++NOJjUhrNDOVdGCGXBDX05mpyGaXAe/lomAyxt
	rFPjMr/swA+/DYu5iQouYoovJY5THloJrfVKa85I7XpcP8bfodnau3tIRyiOstk51t8=
X-Gm-Gg: ASbGnctz8Kmn8i4hL0a49yVborep3q+2yKArASyiqDGiTGLx0p802vShL2sCvaubwv4
	qPgkNCaIldxtC75O///UeJL1xrwRzVDBBRCh1rl+P8pQzv8ui1VKAvlJAY05P+qgQz4ToFbWZWG
	uM7peOAa2viNEaT04nflm80E83hKjG9vd+NpAZJzXvuPzQZoKlMfNOEkUWn741LoqK1SBC2AicW
	im5hOHTsY5Hd/w+aHqRGj42uYujfnuKoRqc6itL9Bm9L3IBnwLIC/Wz4KoHXvqUCDwgAmE2N4br
	F1+ka2uh6wsh5lEwS8BGrxWYQCLgBUluqHcrS+2v/OAJFbr0a3vsGwcxDR0+V8SuKyL2+gBQcnm
	E7KE3WnatxZbq5576JvBE4dCM29M9VLTkATcFQB6rnE4LS02y/hugUaut5YG6JymuEpwOBmxi86
	XuSLFoGxpcjhdh
X-Google-Smtp-Source: AGHT+IG8L5zMLS2ATSKI/dMgNAQn9ETt4P219H5Z9iYMUxj68WRlOpHr2wSz4E3cI0EJtHnsOTWVvg==
X-Received: by 2002:a05:6830:6e98:b0:7c7:1e8a:c9e0 with SMTP id 46e09a7af769-7c72e3ce55fmr509116a34.23.1762903707177;
        Tue, 11 Nov 2025 15:28:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0fb491asm7617540a34.15.2025.11.11.15.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 15:28:26 -0800 (PST)
Message-ID: <81f3e0d7-2625-4183-8d42-46fc4deb70c8@linuxfoundation.org>
Date: Tue, 11 Nov 2025 16:28:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 18:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

