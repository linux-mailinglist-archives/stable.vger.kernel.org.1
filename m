Return-Path: <stable+bounces-80613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBD98E7B0
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F813B21765
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02AF9479;
	Thu,  3 Oct 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6vxGTMl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3463CB
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914784; cv=none; b=npF4/gcAlWiCieW5UvsOi5YSPm3KeauN9Mpb3MEXlr377DDED/tuhICfxZpg4rBbQ6arduwY4JVxl68yIKBS/mN+ZmN3EvGjZSKtGFTjEQ5V0//oLKO7XY3aC6J/hw+jcB3OLKmq2J7kGtfthUjmcRnlTf2a69o3efmdPDtSb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914784; c=relaxed/simple;
	bh=Wszt+FMi++6hAkyrUPopyYAKo6vWeeUQyn8iYz+ArJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6supKYifESp7zJlXbfwYTIXN6KRLhioTKQGejHs6Y9SdAARhL9P0/ULk64BUUKaHcXhnWSogCSxZqFkA8m4tBnkndMXqJ9AGLqHLzyQlWtoEoCEvuE96lAtTQiSUp40i9ifgzc6s99OfBjVxaD+vh3zCap1TzN8/VddvT+D0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O6vxGTMl; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cf3286261so19360839f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727914781; x=1728519581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZK8FupAz8NR+xEbyhnAVE8FI4jxUNfH0gQ1SYLGKug=;
        b=O6vxGTMldy5tWA5p5dXgc8Xaxfzz2alTiWm3RShVKQVmZBHyBgvvjOYsgsbtn4RGAD
         PgTtr2vZmriLi53Y21GI3r08hBAeLtgjuqIx9ff97RtG3+T5eMecr5/5x9IMYpCqrr5+
         eF0e5rcDtDZ56TeRkgzasahWGdkqXiBrKtwXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727914781; x=1728519581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZK8FupAz8NR+xEbyhnAVE8FI4jxUNfH0gQ1SYLGKug=;
        b=r+jjt65JQTXpx3h+vXMdgBtDU+s5vW938eTViMfB9ifNQxnZzxVyieKCWicJEV8aDY
         bwvQz+jAFz3A2s3/3xROdEXpDTJ9uvRflkSCS7SL5VCWI7PkUMVnH0LL3fxYUPykia4t
         uDxr1pXNw2+jGvl1aiMYAxop73bIdk2kTigmq3xmpjoyy6xQuUmsg3wWkvoHPj4loMAh
         hNoAKK+tHco19BYBBbf2vZ590Ip1xrvBJEBIBCiXy2rhJbkvAcq80H6oJ/VY4JsrZHLQ
         T1omIJhX6iiEM0/swx7hR2H/YtXR5NpKX41qMF2vFXgFEhMgHdIYMuLhth7vUQfMLVcG
         Ts0A==
X-Forwarded-Encrypted: i=1; AJvYcCVsSUlcd0yPTIAn7ZB1OE7a1NfchD5skqhX5l1xxRcZZmwllxt1eZPDS+hLjYJwOWF7TcIFdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMKGbfr0VvU+CBOQiRxsnwHomF22IhOCndMjlfu/dppRVUMDK
	WSTbFUEIuqqRtXlyKBwT44VsOyRM+m0gh5n6mlWyBysqG1LjUjUSs9SKaZIG8zJs1h20SSfI7H2
	B
X-Google-Smtp-Source: AGHT+IFL3nQ2fqVzpy55jIhf/78rEtwqx8BMIhySGt4vVuWgB+Ao0LYLQfLrxbqIDU5Zgeai3OU+Iw==
X-Received: by 2002:a05:6e02:1525:b0:3a0:be93:e8d5 with SMTP id e9e14a558f8ab-3a36592a7abmr52563365ab.11.1727914780742;
        Wed, 02 Oct 2024 17:19:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db5586134asm49602173.33.2024.10.02.17.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 17:19:40 -0700 (PDT)
Message-ID: <199ba85c-afbc-41bb-af30-90e0b197aa84@linuxfoundation.org>
Date: Wed, 2 Oct 2024 18:19:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 06:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

