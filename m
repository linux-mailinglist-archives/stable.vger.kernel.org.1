Return-Path: <stable+bounces-165597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0144B167C5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC25F582F62
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AF221294;
	Wed, 30 Jul 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8ytBZnL"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8792206B2
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908673; cv=none; b=jXYs96RnCzu3S5slkwdQHWb+DDfh64d/nzHyelebyMcdwjV53SclO5HrSzqeNMP7dUNTQiQlvdQMIt/qUC7lNTteJRCJYmp3x3PHj0mtsajjsKo2oUzKmU6nDSULQ38pOnkRLQDaTVv8e98R0F/YqKQLNJdQeFApOGq1Vb7A9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908673; c=relaxed/simple;
	bh=hhMKBAzrnRQl6txKRP0hLxiLCdDTj9HHm440OXhcwWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRpoULSTWIUh8MAfR9QA+gwCusyOMwF5rl5njjC/C/DTr24UWYhaQ3dV8iVtGGGd3xKn0AMdQ3BOJEvHBY3xlPkrskI77bo94VfsK+DCEdIlUkeRYWtFTcE2bF5Au/GVMpEPrzFWIeDKcbWHvYCG/zfWcNEWa2bryVe/jKMiLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8ytBZnL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-87faacc4b8fso11514739f.1
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753908670; x=1754513470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JJbV23d59Z4sZveYEfYuzl8tte3y6HxEdrJPwkO/5c=;
        b=A8ytBZnLIukLczHjgJyIRPXRyTPrGBz3ye0L3qunVVjzMA9ofUACcUa+vO5PFWU5c4
         tZfxOLEpsQWM1yK0rUYR34uQGn8T9agvIKh9RxiutlLsLSzkPOPDnSIl5EItMKEGWy4M
         16nVZGEn6a0rivM+FgHhnHT9kb4RwuMNgMS3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908670; x=1754513470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JJbV23d59Z4sZveYEfYuzl8tte3y6HxEdrJPwkO/5c=;
        b=i3hBU4w4MVbO4R6QEINrXiAMAaUlKrQNnpWPhSoC/q2Y8UP82+/wHx36iRQOi2VHZK
         lEZitJ77PVxOrIinH2+i6n5XoPnnd0BYYqu0kUe10PQ51E7XE6tnyqyoGmwBzzKJBM+K
         QQz0ElOlCt0MC0RSigF+/TKDkex9ntBlVHRfYPh6ANwSnw8GSYvWnPSg1wIf0YtADiqp
         u4nRBaj3Wnb5oPPY1+bUDLMv4NXF1HQVy6dAkP5ih441F3n5UFJHTMWRQMgHVepBKJce
         D9+v+wbJQ/CnXjAinXlKoW6cWt+ZudzMTuU79yQ6hAbcRj9nVui/D/Vn61FP9FOSC6mc
         8U2A==
X-Forwarded-Encrypted: i=1; AJvYcCW5dGkfKKxxgK+s1p/x1XUu70psELHmJaR/ORg9JRUqfHam2al+0l9lvKQimYJQsuSpJr0SjgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwQjEQd4b4t9E2k+zseQm9VyT18EJt6G1rKnkqIMaw1OA65rt
	b13Io3e9e30IuUB+hSc1Hu5lo0lvTOW1jYyskBioKcWTZtuGl1LtLCZ8Wqo4iBGwAOiL1kzJSia
	n2JDg
X-Gm-Gg: ASbGncsBRYU6CDVboaZ1x80c/PwlAhHrrc3HT6ToIUnUxFmeK/DbjU1EqmG3tmSwJZt
	XWYnlvE950u3JuACyiOO1pvUwPrHm5wtqzpPHJq4tv/HKZyFZ8uqg2FhM8tyKeoG3KmpGmkEVJq
	8KokwkVNJ5hOxGjQh4eGLv15eEuiYa2cYH8HO9BTlTaCQBxrvrK/osL1/xUJPRHnM/HXqyT7Kfh
	IYESBjcsSyS8aIYFERIKO0tvXt3bOExU+QmU6DuWKmPGXqxIpoxD9q+Z70QFfFp9jC7xy9KnYoJ
	FvOZ8mX7pYBjWrn4slG4yNIp0l8lRbU51nERFja0LKIAlRcX+Rh1lgMLGpYgreLByQmfCEx3oBm
	GQiTmBM/B9Q+cTi11dNi/0bl0+4X6sM/L/A==
X-Google-Smtp-Source: AGHT+IGbmO2V5F215bA9RT9gWwFSgBF+ew+cMJpwjD2+M8EuTWMQXWowzEwtpAbPaXPzXHu0c0lOcg==
X-Received: by 2002:a05:6602:48c:b0:880:f288:e8e5 with SMTP id ca18e2360f4ac-8813770b6c8mr801463139f.5.1753908670514;
        Wed, 30 Jul 2025 13:51:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55def302sm45454173.101.2025.07.30.13.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:51:09 -0700 (PDT)
Message-ID: <271e8a46-6763-488d-9c60-e4c103b605aa@linuxfoundation.org>
Date: Wed, 30 Jul 2025 14:51:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093230.629234025@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

