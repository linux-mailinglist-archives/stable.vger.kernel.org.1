Return-Path: <stable+bounces-37914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728589E6CA
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 02:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2493C1C20F3E
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E0385;
	Wed, 10 Apr 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+d2S1WA"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CC372
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708687; cv=none; b=U2zGpvNwIWbu2DIfKfJTrtvEhZuGy0NV94DNOND24gCUSAGJMkMeCmocGnimBn/kNnNaAVxabnZyK1pCTX01SCx6hKnZ6O5azPTEIGZUs2Jbt25Ms0C08C5xfttBFBDA1iO/ym/LnWrvrUp3Rt0wdntapUQvRIS8vo58SLDBxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708687; c=relaxed/simple;
	bh=GIYL7/nThlCUdA4CAU9q44dwx4jH78PDGJqI3ovNgOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7/GIfDV/1vyXm4WErWFQdYFblC8HA7+4rqGERfjHO4LN4R6teXtMKqPEs7cxbFc+zeqZnQqzxbvn0st8IavC7D7mnYzmUufZKSDfD0+KMJE+Dwv7nfpXPqnPkZIxQGXVn4uf6lHt9Z7+bsshZNsoJvdiEF7TszaQDJPdu8wA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+d2S1WA; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso142330639f.0
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712708685; x=1713313485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES6QomRFvLrFDB39gb2GX3zkfNFij1oZGJPnUaL3yX8=;
        b=a+d2S1WAcfuGXYh0F9aoVtK3ADrGR7rap3QlQseJSVR+ldrkof5ZhdRTBfYw5Gt83b
         z2kQSe/l/8UUbAaktAhLFhDkS/nsmfM5AxQWdDVWBKHTXj1CNGCMysEkmSD/ez/7vwWn
         3K2xsfsj+n14SnyGWTe9IxizhiEDclPFdRlNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708685; x=1713313485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES6QomRFvLrFDB39gb2GX3zkfNFij1oZGJPnUaL3yX8=;
        b=Z/R5KKlbQPoQ0ymc285R2DBvRhHkiMINP9LkeCXas+Pddk3iGdU3ICC16gXytm6y8c
         bQLFi3b2IVYUp1VxKhrEDgB2Nv3HLcBUEEFD15Yy7rk26I5xt6EeTfj5y+Mwu4iyNr7j
         lzYheJyxjqipINwtuS6jX+lLGNq1E9Ihd0Oq50pnFPw3y0sDn356lF/W7to29DrIdX+q
         krkK5fASujwrJXmHoUtcHQkYi7rMK6S+uLc0FSgE/Muim0+rqsya8+7ElUudorq6ILs+
         2G8+yHYN5FAY0Z27LIjXX/Vf25h46J/31UTL43Mws6mQBHS+XXiHxqbBqoMoQAkB+98p
         g99A==
X-Forwarded-Encrypted: i=1; AJvYcCWpVygVOe0NbJyFyFkVwdOVxPQrDQ2mkwnI9LksqOAALDhNqVpcexlV5xCMJFCOewpnMRjmBSFiK5s5F81Ppb7Y+BxH/f3w
X-Gm-Message-State: AOJu0YwQhYHqEj9KjCWG62MzSvyYooYGaUuKEnd8jwOS2FLUVVjfFUCg
	OiZf1pHli53uiduMtM7V7jRGyF+IKTbJjDejSW2rNviA+8iEx3vS2erTAUVPjzI=
X-Google-Smtp-Source: AGHT+IHAftx4RfZVpvtH7wznKTottslQUrkWU/Fb6KD2yX1QroQOCt6CIVbNLlH0WAmaBk1thLR4Tw==
X-Received: by 2002:a5d:9ec1:0:b0:7d5:ddc8:504d with SMTP id a1-20020a5d9ec1000000b007d5ddc8504dmr1441180ioe.0.1712708684989;
        Tue, 09 Apr 2024 17:24:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id el6-20020a0566384d8600b0047f100b70e1sm3630203jab.105.2024.04.09.17.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:24:44 -0700 (PDT)
Message-ID: <c1b7885b-8f21-4b8c-87ac-429799551723@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:24:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
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

