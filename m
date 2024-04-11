Return-Path: <stable+bounces-39240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C38A22A4
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BB91C2115D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1474AEDA;
	Thu, 11 Apr 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax+8tY8H"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99547A5D
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879776; cv=none; b=lYTpWe9a4VW933iUAYr9tVpCIRF6Z4vdn6KiakuTrqw2FJKA1bTW7ZPgt541rwc1O4Y3tw3EHW6uF3gkS0TiTLpOCZJTJo6G74Zc2nJhzW6wJaWl5hPYK2Y0vWBTtMZWbHtsA6WnJFuNzD/4WGNpk+/BNAxKY7gm9Mc9f4zPJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879776; c=relaxed/simple;
	bh=1hJuW4Q6DIb/H/sHiYOYExJ//bqXgHS7kwabOym3u1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aw/CA2n+v6odcgjZwi0rrqkMDxGpdjgu6y8RSvMBSXUVlkKJtGKkhDlJ5RN6kmrlR750jaAG/xDiHSHiLgqPPc8uJS0mwUiPzac7gB6FuVvxBn01losXU2J8DpzB9D5984RtKat1oF8rYiOwUaAGQd5GMEfpX8HTYEbZC+echXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax+8tY8H; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso7991739f.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879774; x=1713484574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe0CvRWLgYscYGo8HB4Lqcq6jCdobjBtnisZZSsYEYM=;
        b=ax+8tY8Hx9T+pGfzUTLwrcFhDUP6gZduZygzmij8iEUD/K9t63R2hSY0r5TO34whZk
         4DSVX4/IC+85oXl+NGdzkgVOu02adxYYPChJ6NUyc+IHH8XsW1wQdmsjBqXV+XFofOEh
         IajvAi6/GaZdNGq1LNX/yzxYSZsReZBpAohz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879774; x=1713484574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe0CvRWLgYscYGo8HB4Lqcq6jCdobjBtnisZZSsYEYM=;
        b=NcV3cb7L8Oj6CRPhaga3/tnlyQfO/dxPgw8G1bJ8M7p5B20/xNorJCz/dCRGSogAUs
         o39lf2WkDbPc0l/iQye36q8LzVg0pCQ4UKB2JhySunVZElLGMDBME/dcTOM1Sz4L0VIp
         F37tO7N9T+bJ23taxoDmZQbJs5RKcDhgHQvH8rFmuS4UlM7Tf++HHukwUOgXyME1daEJ
         6v5mLpeAPCgCfMPGXM0L9LSfOIg/tECLI8jzvFRvisnw28/aUO7QDdbg9ox3d8YS13k3
         yYRQQBepyjcPekT8FzIDQP0Ec8XEc821bEB4k+ultvty6gEtdyD+FAt/0yTONJjfJWDy
         Cjyg==
X-Forwarded-Encrypted: i=1; AJvYcCWEDRZHJ7Hd6TokRY14GtcY0orYbgUBVYeRq4Pd8FtH/ePXPNVym+ZAFgcg7I3seh35ViO84/e3evv9HwIaet1bwJgFxDoW
X-Gm-Message-State: AOJu0YzPDQ5VbO5oYUn+FZOXxghxDTCzPXrcEQGX5iF4IlOasAGofs1r
	EP/ttl4ubeXzGbBlpeKSL3B5zzXwi4kxMay6CUZRZUsmXelK9+VMmBD43fQRNiU=
X-Google-Smtp-Source: AGHT+IGV0IhqS2O6YRkP3iIt3Yudyqf3AzBPtdznd78B8RXYp98RlusRMAJ9uzdymcwqzIpF6kSb0w==
X-Received: by 2002:a05:6e02:194f:b0:369:e37d:541f with SMTP id x15-20020a056e02194f00b00369e37d541fmr1456230ilu.1.1712879774647;
        Thu, 11 Apr 2024 16:56:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r13-20020a92c50d000000b003698fc3a541sm644512ilg.80.2024.04.11.16.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:56:14 -0700 (PDT)
Message-ID: <8de5278c-9bf5-46ab-9fa0-ffba4c95b4fc@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:56:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

