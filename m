Return-Path: <stable+bounces-45207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AD8C6B79
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09001F24509
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176723EA7B;
	Wed, 15 May 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAxw62gq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914783032A;
	Wed, 15 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794276; cv=none; b=k+qYuPfb3ZFZAtPSh5tPXJLS1elVw3r65SOinyiTvETUvgmUkbkITC6CiIU4qYeHF4jtGaiD6y+GNM4qvFPfAwmxV479O2ve9/WagJ72WR++7zTiU+3u2eUgKiPnWi1oqF1655wYZjWqfl6Tadiq8pYHcgXKxuCyGamcOfXXBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794276; c=relaxed/simple;
	bh=WspG4dbmpI7y3HN4/j9MrTs8m63DfPJvR1gFu99A4Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJkuYd5vtjm+iTJLxrRWxQRiBj5QCKtI2ZR31Y26BoYQS3I7yz6CGURQVk8T4kMSEXhYQujWGyngK/fgfuMUHxuxdHKOjGOz/nVrhrfED1Mi/swJrwzfLbSK0f1Rlfk48mIyy67Q/Adx/izgVisxXitCbtYTeTIODxr35HD38mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAxw62gq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so4567398a12.0;
        Wed, 15 May 2024 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715794275; x=1716399075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSbs3QJZgIV1wguU0m7Hf9knvWUOvS2qBtHCZHDe/GI=;
        b=FAxw62gqd8AolORbKt7hsbyxod1QLH4FJBKXuXZEhIm8+3Dle037bjLZe0Dk8wv8o9
         P+NybjXkISNWifuGIzS6I7bvJpqacpOAZVqdMH87MC+mET2av6Uzvavo9bY1ub12LLe+
         0X5Ral8z45flTkO7KoGI8EBp4+i8tcRNuQjcYiVDDJEXqqa2cnOjqrXvSKwhv4siBniX
         mQyvWo44bMeyvWfzIj/H4L+KC9uC/twcRki2I6JsKWUvuBmS6mb2pNAkHEhJUIZK5a+q
         t2DienZc8UxJ/+Tqm+44ZE3EUlqfS65Q+U6DLL3LqOjfSBKwunlheQ+ooPuZB/5ONTrL
         wibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794275; x=1716399075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSbs3QJZgIV1wguU0m7Hf9knvWUOvS2qBtHCZHDe/GI=;
        b=iDhNxz0JF3+vGu2HfazrV7avDeV3gGYFoAIm7A3ebDJlM2BIvSQCVmzGdpO1FTyyyM
         PPOSxQNS3/whXRB3ACojtN3fqxmU1ZwejZXMSskBWJbec4z8EGA98reGsrlJVnsXMmvf
         +D39PImJVu7zT1a4yCDJCf88O82i3+XqJGFg+MgriIjlHst6pC5oJFu0cZZ6S9T8libN
         Og9fL24W9ZAJywXdqTcJQYlj/hilvTKNO2uOE8Vg/lVPLCz6Pvykb1pfZImIQyjV/hWJ
         iYwmdoEdjAs1AHaX0spy9942TAgGc9S+UxczprEeq/v/aeSidq0AIzh/va+syQel6rVu
         a8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJRSp8aXPSXWldUi/NkIkC2gJsE8LA6hcEZ7zVNqwS7/XzKstwlM5ZByjDNW4rIF8nRKwXDttM/Bgn9dgpb6TBHwCSNT0h9bvE+gx9Pr5hGIj9HpRWZ3VSp3N8H3MGnHvHKP1Z
X-Gm-Message-State: AOJu0Yzph0uJTI/+fF0eN06eoENokl8TBwA+uQjeejQvG+LHCY03j/Kr
	G+cFKjW07mEF/5zP3LKOox4Ej0Z9FsqKJkFNVEQrgPQVfZ1aBkcA
X-Google-Smtp-Source: AGHT+IH+1P0V+5QqsR6vcs/Nm9esEuTsfpdd8aqAIj8buKx+p+1+eEn6RQ/BpkqOCtB/jKSmBYKcQw==
X-Received: by 2002:a17:902:744a:b0:1e5:3c5:55a5 with SMTP id d9443c01a7336-1ef43c0ceb1mr151404605ad.8.1715794274755;
        Wed, 15 May 2024 10:31:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0bad819csm121148485ad.84.2024.05.15.10.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 10:31:14 -0700 (PDT)
Message-ID: <6c2a2127-6db5-461a-b54c-05b73cdd146d@gmail.com>
Date: Wed, 15 May 2024 10:31:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082510.431870507@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 01:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


