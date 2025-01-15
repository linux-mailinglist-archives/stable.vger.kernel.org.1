Return-Path: <stable+bounces-109178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17BA12E4B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBC81889EB8
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881ED1D7E35;
	Wed, 15 Jan 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+XtX7wO"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3919CC2A
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980350; cv=none; b=BEEy4RbEz1F92+uYEn7OCfYAvqdmz5bniqF2M4D3BgnQHgEjw+JOASFnPDb4SAcp6hBd9qnhNCeB+faZePX1mcK8eZGks/bdE6ucHfqTecXekX5lYn+vl0vwaHIg+rI0Or7S2mxNvY7kfoF7IzPWHjEt+B/27HWiUXMnvs2iSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980350; c=relaxed/simple;
	bh=BvESpttXPM+cPnUnYHzUkfijK1/cxJZNs2ANKE3voUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw4TLCdNassYHi3cowr0vDTegXZxG3oGLyOHcJ4os4nhMODT+FklLT1EngBWQjJDGMiwolyHQA0fsD4XaVwJd5ekTHMkSf0jhg3t+53mnY0ZIUybrhSuLKbZf01pkImyF9mgediSGSHBBNmfNIMoeGkYgjQImD0QicZujQfaxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+XtX7wO; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce88909991so3447535ab.0
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736980346; x=1737585146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOb20PSjdeGT0anWqDB+dqo18daPgjdBpR3vyxUVTEI=;
        b=b+XtX7wO0/Arbl0UWAIIBmpNQBhvzr0i8t/LyFmqVnZhT5Dp685+OdVrU6+mdG93dT
         CxRwNuZGqKdixPg8FsMyBShXeVB0ofHmOIade56uzlqS71uI/97rJAr9wGaFI3iVO43f
         G0vY8S4pc4hMCYaNt8DZb6fnhVjrY3C/4VdDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980346; x=1737585146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOb20PSjdeGT0anWqDB+dqo18daPgjdBpR3vyxUVTEI=;
        b=S8o+UqCXhCmjIK8bxv9QyFJzbC/hxH28QbUoAJjAszYi5vDJHpeEc6R4Az6+FuwtSU
         megME0um0k4qYkdmtLm4oMC9iKdnqWplpW0iCXmfZFBxj7+Ldz1hhPfSsKXO+Sq8AKx6
         yKIUmKedAsoXHBO1rzFvWrG2yTzFMQgYHOz2Jsg9iUEh1z6TzpsZWp46A2VTxbRAKs5E
         gL7hq2bqLoPZIYDC83DFzkoBPGS055WhSCq2d5Wg07C4XMaAnutlSk/W5vEYa0OnnxVl
         Ero5TDBUF4kJZLSRvv+X8YPWH6i0U5mTgY21kOABPl9SOfcrmOkJlEFxKT/N0tTk+C55
         cmgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZJepAcl15eY3PpiY6r3Gd5nY6GmriuglJR2Nx3b/6mZShS52VJAHv6+8Fhw26N/1eD7ayZfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7eHScBSPrjfbv4UW2BnSUwOdvOHTe9Zx3YcM2ba1OwqUMfNM
	AnJGpcFBDuzmI48KU0SasqAWUYgi+ewAJZYqw9f6yotkSbva3D4TtxFEWuVZOCA=
X-Gm-Gg: ASbGnctRLwIQ6PkGbyXzzDdup8bn0ff+hB57e8qETixCmjy0dikvRyD4+aM8dHZh8F+
	ltt5HSO6ADVhBNaBrCeKT/HJbCa8jkGm5F9T7v9TVYIbgP9EpYP8dUEbr5S6r/e9tRfhjl5r7yE
	QSIVfQtXnTWRQ9DSGzPBFxrfcWO1/q0gOnsWVaT86f+W4e0O03KML4RFvXSJ3iDDVG7hMQeVR93
	YMSVgXpXyrWe+HNP2wN4GUAmakbidJiX27AphAdbqaVtTkb6RLjiDglQ1C9E497d0A=
X-Google-Smtp-Source: AGHT+IFl92Ibs2oFy7a4C6tHXHj8T2cGTjuNJBVfgfJ74/qMBNF9tXTpjVxba6p9FhV9k7u3EJ8CQA==
X-Received: by 2002:a05:6e02:16cb:b0:3ce:3657:7407 with SMTP id e9e14a558f8ab-3ce84a8d3c7mr39407335ab.11.1736980346689;
        Wed, 15 Jan 2025 14:32:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b718a4dsm4284662173.100.2025.01.15.14.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:32:26 -0800 (PST)
Message-ID: <e66d86b1-ff1d-41d6-bebb-d64c4f435094@linuxfoundation.org>
Date: Wed, 15 Jan 2025 15:32:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250115103547.522503305@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 03:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.125 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.125-rc1.gz
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

