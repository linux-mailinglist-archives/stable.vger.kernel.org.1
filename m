Return-Path: <stable+bounces-109175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A90A12E45
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF665188A276
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD5E1DC9A5;
	Wed, 15 Jan 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDGRnPmP"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448E35944
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980078; cv=none; b=Ri9ree+B+1qxOV9s190UuB6cOhWrTfyDY0Xz5LYyETX8pH6WKzJ44YPv8khRjm0IIDRi/s8Sr1W6BIfm6g1+WqgkN+QnyjI0RT0+peza1CLe//mb/p1sEYybDjvxDV902G4zl6EQI7A1ookUbZGsgwPSkAgxrcjSZM2dKcwsyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980078; c=relaxed/simple;
	bh=Wsub3r7kUiSE6AHXUccY30xErg779pqEZx0lhPVUf4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vtg/Rps/eM9o9Ak38hsKeD8mX6KLOFXaLJDc0mWZTy3Vu2/qMXbM/VB6VBoGU3NoqzOwEbARWjzzxohw6+4Z6Az8cPvTcZzBecIwc3eQGn2dShSZPrc3rclv6grNNoavYav5F+QKuH1jM4f4cvjGvtcpRpkNicCg0tlsvGGrkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDGRnPmP; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce7a33ea70so911475ab.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736980075; x=1737584875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFJuM5NVZ1dVBv3WrImHyB7Brd5t7moiC7M6XsDLsbo=;
        b=IDGRnPmPoK1yPs0v+TOlUQgibxh6QtX9ri72C1tXJ/CESrD1ZXHs6wmAw3xb2Qp/Zy
         n9xfYNTXFU22o83dQe4iSXZCx4oaMVRGrP/PfPdQP+mpexs1uDUr2zPZKtUoz95KWuYN
         uxxCKuBXPmxv/YLl0+e1++CV5YHmVq4XFcbZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980075; x=1737584875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFJuM5NVZ1dVBv3WrImHyB7Brd5t7moiC7M6XsDLsbo=;
        b=MbTPetzenDPdxV85GZx5utOkrq2c5wVfP9gUVlGXOPeC1CmvcU3obLqsm1yL0m0Q0q
         d7p7C0oVydtXH5tYmHjBEt1CnE9nK1U0GdpbsDXuVG+hqcUViJdkxaELxGQbFwqH8zH2
         LZ/f28eQGlhqsolBSR0JGy3tHZX5WCvCdJf9oNDcfb+RJRZCoQcXYR52CHV/css1zD3L
         /0ssot3vOtO81x7gvTt9EMNcLjSYHRfBNV95ZF+QGjHxv4p/WgDVCX1T8GI3QeshQ3Fl
         sAOSLcX/aY3mxBArLQEmTFIFDmBoQuVH5msdwJpN36/yC9jhKlguX8Ta2GcV78I0a2ug
         1R8w==
X-Forwarded-Encrypted: i=1; AJvYcCUaDqMYn/GoNeKqEtWxuMue5emwvaEq18K22g9g+i/ArIMZ+hb2F8b6/QqOWjCleCh069wjMMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PgroKEjUkrYSBz0lxqB+c34DXkB52/CBAJzwxwsAZpOcWN+4
	BCWcxlFl85MxsW5PFqKmwXrRTP0+C0PoJTKFYtilbgoDCH3h3RAuCwZhE1EByT0=
X-Gm-Gg: ASbGnculzKpsSIAGojzDqOb4upTc2Mq3zA1AK6o63hCo63GkjV7KBX36/fJ7ELPZn+U
	454pVOogr8hpHAUTodsiri21G5eGIXQ7aHrH2DHzvpnXd2AvCJ0v9eF8f9fi4Hrn7HgWB1f12U2
	rbPugdWDR6pHBEsz7f0Aj+i6+rYsojFsg6jwRTLb3ypnWi2acOY8mB7tXltuKVwiSuOiCRv08Xt
	mafG4Cjg9zlrssyybnUCgIwFqdcKtssmrQLXF9CY1MATaL2wq/QKDTZB+iUT49mx7g=
X-Google-Smtp-Source: AGHT+IF2x6cH7ne5/wc+WpTOvtI5zlQZGORFHrFJKIO8AzOg4shETl4ZD7K30JJP/B9MSY5jutRYrg==
X-Received: by 2002:a05:6e02:168f:b0:3a7:e701:bd1b with SMTP id e9e14a558f8ab-3ce3aa760a7mr251410175ab.20.1736980075242;
        Wed, 15 Jan 2025 14:27:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce8a6ab77csm4916445ab.58.2025.01.15.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:27:54 -0800 (PST)
Message-ID: <412d2b65-e47d-4a16-ac41-74f1e2a16fc0@linuxfoundation.org>
Date: Wed, 15 Jan 2025 15:27:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.10-rc1.gz
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

