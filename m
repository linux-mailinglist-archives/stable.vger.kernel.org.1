Return-Path: <stable+bounces-128329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEACA7BFEA
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDA71718E7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F577111;
	Fri,  4 Apr 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RR6ce+oZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E31F2361
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778131; cv=none; b=MEHP9Kt160UaETH9ddvYM1VtYrSvaNTiYozS/Oz99RS7PHCthQBoNCjZ1aQ5relXLHwq8TzJprcyAfNUujWkybCnkYKzNZeKmhx6eytHBn85/53GMK0Eiu3WOlrv3YxJgN96fv/0FbbzJZtCtPDHLGYhWmkS1MKJSbNCko+L+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778131; c=relaxed/simple;
	bh=N8xr3gZnvBzoAFFMIbubqfbIqdfrBwHBym9C7LusSuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECtD+TPce2RudVJp7IVsephlSWsswIvwo5+iHzkA6HOc8TN7305qgpVqdhyZMLOkC5In2YdSyeYynjfdMMiVbkWwUN041hDguhxDOZZ5j+yzgInoDXqk82Qd1eagcfsg475tV2gAoR2HXM3jmEYsTEDdPzcvHI9QfNhvWi75v9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RR6ce+oZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso19152715ab.3
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743778129; x=1744382929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtHOMalSobmJxdbzjcuw4y+jApPaBkGJD3B8y9lwgGU=;
        b=RR6ce+oZblxRJat4JWEYQPHpN79/xlFdt3AUFYxGiN5tbEOLycPTs5F+nu2YmIZmaw
         0wGLZaoZ5W1tna2y0eZu8YwIRJL5Mfje+5FLwKX2Seg7/iQcUKc/gerkNyX0fr35fqVp
         6uIUoHc1w/H2HDrnaRpaRn0gfQFdxupBRMDCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778129; x=1744382929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtHOMalSobmJxdbzjcuw4y+jApPaBkGJD3B8y9lwgGU=;
        b=TVs2Z0vGZI3Zl1NnkC+XWHI4euL2Ke9qvLinqAvlbDB1tqVT7aDu3v0jHoCUTxr4nD
         jl+iCyAXkGJfWGVtwNTJICaXALowowqJk77VvxnHG0lLPVvGOl1R1G6fxIOQl2qUHYxP
         HzOPfzei8npwa4sw1LzDZq74CGF2XHcY8/zeW6QoMgKaZy37kXZi+QHQ8ORj3y2RPcNQ
         bBczORYPPIxhxNhQpWG6j+l/OPhm9sEsfqP2kl1g5+4cjzkUE5smhx2WECnVhy8KqSuO
         OMAbYhTMrPQ/S3Z4W9nP1tU2oijLJaXRQWwEr1+g33Zc/NtTSxZxV3LBa8AAI1JkokEs
         QOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWA3LFE+mVSV+D3mml/JHY1+0iHmMpAsME1lVqrm82V+Zcu8vKr5FK1IufnttFcWlx36rL0PdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jZmKFlvO6gmVutUXohBCEBZjlz8hVl/Y1OzJxqW39znfR70B
	Q6E2Hsg8iGoSeypf9DUx9c67YlHMXQnErK5OyFmBRsYpR0NY5tUD3+/NWsC7waU=
X-Gm-Gg: ASbGncvPu5oTpjL+TYjaXTgCk/NWK+wq3peHHYq7G3+0Zz2C1ZxfBv+38e2QdmJbnh2
	YmDrlSRWUr21UT2pOZrA2MtkD7fQCIZhxN6iH/EI8mOlNBnJR+lkUVXy8laMnwWT323sFWlUkmS
	CjoCq49hOdmBe2fOIIdk67DzHPLXFmGPkxh37NhoClT0MW/K+9FY1AfcEEmKztxGYRT2fPlvaYQ
	qefzXuWoC1I1/0K2w/UKKMkSXjd/DBHh2gCLv0xmy/NJq4TC0/ZzvI49yUyahm8XRqsxvrk4gGY
	ubHUoi/AQ4cbNy7f1Pdm1ZNncMC0wt9Lcp25hH8wBxdyNURsLG9QSXM=
X-Google-Smtp-Source: AGHT+IGJgS5dZigzPp1PfoohVD7rTW7eiqP49p94pLE+ryqtZy9qsHkuogejD5wKg72S1cjf28aMZA==
X-Received: by 2002:a05:6e02:1b0d:b0:3d5:eb10:1c3b with SMTP id e9e14a558f8ab-3d6e3eea7dcmr38875265ab.5.1743778129170;
        Fri, 04 Apr 2025 07:48:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de972c54sm8479945ab.65.2025.04.04.07.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:48:48 -0700 (PDT)
Message-ID: <148cdbaa-09f6-4c66-8a2a-1f55b596a00e@linuxfoundation.org>
Date: Fri, 4 Apr 2025 08:48:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/22] 6.1.133-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250403151620.960551909@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250403151620.960551909@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.133 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

