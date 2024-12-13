Return-Path: <stable+bounces-104147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D99F1394
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D25916832D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B311E4928;
	Fri, 13 Dec 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjyDZR4w"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46A57C9F
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110846; cv=none; b=LIGKAXq/WLiJsiq8phD4PegCDpbZJyFdqfvf21cUCj4PnG/LXl69odwDPYUYB84T4HIT18qgFBwHyKsVyu1dK6Sz3g0+2q+4URodODq68OfNBBd/yX27LgcpcYQLSwwVMMTUuHWVgfQFEXObNBSm5sUxHwdS7tJ4T6ci+R4j5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110846; c=relaxed/simple;
	bh=MwpY+eaTHW6ZPilONEG0CjNGfxYk7BcIdF5jRQfjrkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxrLw/gs92UYTH2/+VwRk3aEnpgChGFHfGymeBt6CLjH4QTLaNVqaem9yUB6Xeia61BfeF0qiCRu4Bd2lImTT3m+erbImW6wnzQ3FClbi8WP1jzda862TSntcPGDDz5UBknC8QAydYaHGv4RSX+JlWsD3wYfIhIsDkN67SamC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjyDZR4w; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7750318a2so14655525ab.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734110843; x=1734715643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ873rr8z0y8ShQd+LncMxaWKOoC4jcirXRjLJy1nJI=;
        b=TjyDZR4wWIcZ+Nc6kQEcrFqPmfjUfvzNiPp20fP7f1AqHg3jbXXKUuTbwqjglfaGZC
         sxM8zU17B4w7n8mee0UhZNkt3kuWetBnhY5k6MD8eaDoZlS3MdXGM4tQ9pO9ORSgAbv3
         MjVHZ4crOlG4nNrWjNsUNuUWIkcOeS9INoaTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110843; x=1734715643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ873rr8z0y8ShQd+LncMxaWKOoC4jcirXRjLJy1nJI=;
        b=QwwxlwSkXU88QBde++EDSWu/okjU8NM8Sd1MTHvapJceGByyuu0ye8OO/hqcPuGPLg
         Fs9bsnFPAKW7W5CupzNB2XmDgwltCocq0yH5xuZX7/zP6kEBCefvB04HI/MiRvOxJK+W
         u+2pw6cIJsZeg764FGVGIxq9wPx7XxUOm/8OtXdTrPYf+3yiIdi+UUR/+3HMXIlsAo18
         oo0/Gp3HvGomO0CSzeCET4NXidMfo9MfSE9TGsE55mDOShbI3V1cS9QvYcYbvznE2Sua
         4XSEeXUIzy29ljq6vbXq7Ou76/GjlmfILsqSHe5ZKkSbXLNdmtpf3TgtSXEERO4amsx+
         gmHg==
X-Forwarded-Encrypted: i=1; AJvYcCUYCsrHQJkgBdegesyEUyK0PyXkNaCJFaw/0PaR037rv2Bhb1ohuKuP0pLGU56QLh4p26SBv4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWe2RNMtdUdtermq8IqaWHG14rjCWdJmdMjRNi2i1ABfryJsc
	fRSW6igAUN208leBJMmnIVWi3u+/afsexaYWW4umthuQFx7JrIhVpFF6qcHLYt8=
X-Gm-Gg: ASbGnctEHvANl70sAqXaFlK3fAF4/fXVphzLiXJrqlADPJsD2Trk1D4xOkNO5RaenSw
	i+hPKfmymrY8YVwJOfdAqmRpSkaCGmPHu/XyxLZPsKez4+IjbBR2TzAjadeDRxOkUKWMrlFIBZC
	UJ/6tRkST2LqisWfW5lptzBLrolhmnXzLvH833CLL6lVPhh+Z1MtcZTiXMu46y9CxbdaZVZ0WG1
	7vIPevX7WYF6LLxIe9xcAsGgMwdu1QgIetx1T82Hfu/DUd5a5mDwKigS/PR3w1bkQqt
X-Google-Smtp-Source: AGHT+IEMEr3uAWKMVxI9slphjbVdYchSxXggpcr5ca9kl39X9OR4taB2Resxa0Fh4jOpJvOjJQ1o1w==
X-Received: by 2002:a05:6e02:1ca8:b0:3a7:4674:d637 with SMTP id e9e14a558f8ab-3afeda2ebadmr41301295ab.3.1734110842854;
        Fri, 13 Dec 2024 09:27:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24d8dc980sm84075ab.67.2024.12.13.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:27:22 -0800 (PST)
Message-ID: <e31df167-1a15-4015-a6bb-85ce29ada6fd@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:27:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241213145847.112340475@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 08:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.287-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

