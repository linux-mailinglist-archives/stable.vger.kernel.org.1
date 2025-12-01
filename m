Return-Path: <stable+bounces-198016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6297C99A2A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 00:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F4073452AB
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 23:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BFC27CCF0;
	Mon,  1 Dec 2025 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwxKq9xN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276C1CD2C
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764633478; cv=none; b=HDwqPJZdZz0LOwqgTmEp8ptxhSpDtVhn9CyI/S+7tFFJIUUgpLh5TxgidkyuDND6u6yxNYKz+WVwjdUgjNI6dj6A5asFCitmBN7cvvqd1lywEZvLnHmTkWg4NruyBhwNlB0HO+efS9pN+P1siRvHUkgenuNAYdhgIXRa/L6JqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764633478; c=relaxed/simple;
	bh=3vDmUwcS/u70A09LnxZ0rAkyZOobFeZv3xxWb3IHy7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp2mlCCnTkrZWzIdb6yJKrDwxnGY1cFbnolxklsBD7BSb5Ec5ANz8gGUe6MQfCF6tPjedQb0xWGqqz+b90w8cj/lPIkCQH898OKOUUk+ZEncnbHC8Z5amYZrZEXqZd6eZhcFJDewqWC7imDT7VN8ZWiwBkRMiTjt5DwvtWD9a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwxKq9xN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c701097a75so2263369a34.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764633474; x=1765238274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23nJKbEHvBqfOwfZ1RhHlN2bMHavbfGoV65MzPmmeVU=;
        b=TwxKq9xNbITnt5Jm3YHGmTRokqVtxldHzqj7opr3DY1zMem1tDrc1n/uC4cFFee+tm
         SBKi/sIlcFdGjMOkSv/qdP+tD0BMZHhy7dZnGaUvo7bHkAO/dWWAm2YsBkXGnATI/KPZ
         IlpvSlBYKaVjuxkzHMXdJvbtJF4hEmaLuvAig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764633474; x=1765238274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23nJKbEHvBqfOwfZ1RhHlN2bMHavbfGoV65MzPmmeVU=;
        b=EK03lKxXstjjh15GsxR4H0qx9tFOvjDQmzgnaxhgd1fnwIb5ba7fKB9Pw/Yj5fKR0g
         zU45UaQTBTFgcngSidlTrd0SQ2pntU0zlVLYFb7xcyXmTDsaCyY+eGIN+kbo+FswljsF
         pPk6jlLN6Yfoz22RyCCIvHu477PzhqIkufNeWkc6RiSSnUbaZGDebS4Jj+A3VLSS57/y
         e8QVmVjHDuhfSkpQQ8MWPjHo0KdNhRm/aQsA5xOK1kUZfOVfxmB0POsrB5n2T+A8Gbby
         hhidFe7X3PViI2+9mlCZdR2ANBykAO5MH+7cOCZgGUa6gqWyGY+X/bsjX+bTPO2LZxVi
         LyDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KBqUpWsKl5lgM2yHvt/Bd1sA+cyD9IQmlhTgkTm4IhrdwKGIvG4cOf3TovtUGoGPzuZAMn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUqx1a3z/KAyVkrQr6tN76VOi16lJVdVpYQSZhncNKFuu/q0J
	KX+PLhXRV9BPj1Qo66/q/oRw1jWG7OKVpdh769PSW7Maa1qUyTcUEW2mb2PZpgUKcmY=
X-Gm-Gg: ASbGnctZAStjpVlGi6dJ/i+9R//v5/5nDqieTqP9oEd1Z+L9c6Lvq7xRAJ+nSV6271G
	0nKkzxPRRkk0JtFnwXthW7EZgWtq5gCTXgjkrJAWQoF2qoFblTzYvw2v8XS6WZCIrsEMY3ZHau8
	dRu1AXNt34X3VBdgmYHR199EPI7eAYsKkjv8wcRI7gLRUcaOjeuEVqqc7tQ+3tmwFqEmW/wEX6S
	/lFkZPxLdnD5L9zjMcvwYnoE4v5UhAyTHVwLnMpd+yXhm6+HhwgoN061GJxYlZY9hSFqvr/5riI
	ahmj/K0iCgB2/jl74THAstVuPh4ZByhIsngjrUyvqVIDAop/diZzZ3hvJfO2e66hbpq4rX7e+0M
	8YkVEA3C5K+95dsGtzl3wLkTiO95dai3fo9X4YWdw1zRae6qiK6GHI/M3TjVIUrtkFGX6m5auHi
	0/fMimQvnSnR6mckUV+rP7dF0=
X-Google-Smtp-Source: AGHT+IEtS3jcwo4WzU54Sa3K8J8ybpqBEguU1sThRdV9NKjDD7zBUT+pKVXB1PdslMVOEqC+2jguSw==
X-Received: by 2002:a05:6830:26e0:b0:7c7:18e:914b with SMTP id 46e09a7af769-7c798ccdd68mr16820921a34.17.1764633474482;
        Mon, 01 Dec 2025 15:57:54 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5d7d82sm5532004a34.6.2025.12.01.15.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 15:57:54 -0800 (PST)
Message-ID: <d574146a-3434-4eda-accf-d17bff2cc0ba@linuxfoundation.org>
Date: Mon, 1 Dec 2025 16:57:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/187] 5.4.302-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 04:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.302 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Dec 2025 11:22:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.302-rc1.gz
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

