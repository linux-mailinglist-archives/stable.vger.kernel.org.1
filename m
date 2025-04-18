Return-Path: <stable+bounces-134595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764CA938B3
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC47E920BED
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66116282FA;
	Fri, 18 Apr 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IeWa26oS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE184AEE2
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986651; cv=none; b=JZDDcWrP0rzHza50vRIPCQj1afRmz1/plpraUJhtbmAFCR4JPIvQBHY5oRfvlyQlMLNriK4QzkOt90hMpYZKoDsKQt2G3vc1Uss8Ko1eW+qwsMN0m9QWlO+USE4xeSQ6KfSod/RCuxvJws2KRzJhQ9TsWlJx/eJ8JSfKUo/4TEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986651; c=relaxed/simple;
	bh=oVL2kU5gjstzBGfXvp9kTBe+PNQYdWCgXca3RUgd+N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZBxSnm00u/zawgbhP+IGRQ/+X89r3wcc6cvXm7gegqNfRX19rrJF+0GkL/hGW0pnvDVQCtm81DAwnATdJhtHshHBa/kniL9OIzjWGTDhRBF9W/F0wBjG0JGR+zK+SlFVTRQ7Z5ZOr261Ou1n94KEwTj6Os1lYQLHg7CbMIUpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IeWa26oS; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86135ac9542so61413939f.1
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744986648; x=1745591448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5zbYlhCEZEOrkhXJJRlzWrW7M63mHM4S+7WR1Jrdgk=;
        b=IeWa26oSrWib5Z7OZoCykBgsO6okKwOrqpYx7aO3u/5tyYhWP24CMJAO6VxBMVpcPl
         kj0FvYcM0vo76UTGamV+HghUVndMrfqom0keSblRNzvFXrbvwJyRS6YN1ybJUUgQ1+qT
         /zLUh0uNs7N9J4r/4J4nNMOYYzgDty1DK8jOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744986648; x=1745591448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5zbYlhCEZEOrkhXJJRlzWrW7M63mHM4S+7WR1Jrdgk=;
        b=XO6pkJFSrzfSZn+74HXLD7X/kKFlvF0yKGeyIXSGlH0ND8a5XUV5w2dnJ2sjKVq1AW
         zmBJN7EtMjpAtQZSqnXBZcYJW0ipsFxWcFExysLa1K3ZzYIcYm1HzyIKRj3NyRxaLyTi
         Zu/jtuDG9INPcLVr4XqdauQpIzXxqyARSkhZ+EMKfQ3xTFeYA9Zs4i+dAZuwYNHC7RYk
         1FqwLJ88C1prDhLBfuIqwrqCm3b76QmVqRmLhI8W4V8kWoXoxM8tjB53TtidpV+82sM2
         iJ769FUsolMsSE1RIKbEu1CaS4RW2qbF+Y7XvufkH/izgIs6de00ptB+1edUXdR+lfuR
         corg==
X-Forwarded-Encrypted: i=1; AJvYcCUnyx0//zfodw35p585KiI8KRc328UBlUbbL6cDMHcyB9Sy9VulifFjODoY7y3WESiVqbnBIlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujebHXF4MnFUnOSiN1v+msPUKeqo2x1Y++Dvpc2OEiGDEz8ie
	0ETIJorNBaK+kfwlZUzzCqd72LofcRHUuLmNvkFz5lnTmzu1R4xQKchk2AurlRw=
X-Gm-Gg: ASbGncsJ+Spo5PHA8mzV1VTWsECWal1iZvHyQjh/uejwVeQ/xLpVhm9KUQvl+8imI0l
	RnXE7USkKkUMZ2668uqv2w3NOmyABKsJKiQ0XyCkj5pVt/bo9XCgAR5gUgthvPsOYmcW807M6w0
	QJi4bBbyKMKDFkB0uurlxFR8RyVkSogoYVro7eM5JWg/bhi8ePNdhdtppf4IWYeFUVFoEQB5DJr
	789kd3M94Z5YYuWXwnowNEBQtvMVtrsxKzyab6TrMJfOydMJeBzIbvUKdtx+6lO8fVPBliH3SN+
	A77poRIji8+iEbCi4fxQWVZI0CR8pLPWqN9odK2Dl4UfK7eaaK9DS44+UBtOXw==
X-Google-Smtp-Source: AGHT+IHg6AQYt64hVTa2MyJj6PvmJcGkPqJ51JrQFjKLFrY6PtlcvN7ICxYBR+rpFCkNIDuYhjWG3A==
X-Received: by 2002:a5e:d718:0:b0:85e:22b3:812b with SMTP id ca18e2360f4ac-861d8a19580mr353447539f.8.1744986648413;
        Fri, 18 Apr 2025 07:30:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37cbb44sm468122173.26.2025.04.18.07.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:30:48 -0700 (PDT)
Message-ID: <5c0ae486-f29e-4a7d-bca1-434c82d06b23@linuxfoundation.org>
Date: Fri, 18 Apr 2025 08:30:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/393] 6.12.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 11:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.24 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.24-rc1.gz
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

