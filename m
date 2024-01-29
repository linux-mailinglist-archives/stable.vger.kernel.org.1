Return-Path: <stable+bounces-17357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA18416A8
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901E41F23CAC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 23:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B279524B1;
	Mon, 29 Jan 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FJkAVnTF"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80951C4B
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570189; cv=none; b=VgTWA340ta0uRgjrLftAqdMoHBDKxUDifN/hoYbpVfUuTfacJm0fKU2u8UU7SlO23Sc0oZ6f42ob3/nqMI5/n8w8izs5AnIMqSNxmopnr9YkguXxr5Zz4O+fzUuNUHObQwr8acWqVTVb0p65lNJhI24I2QM9yG615z/Xd3O5M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570189; c=relaxed/simple;
	bh=EHU/gFLmRVzGlHoLA/zjYW4/9gQBhzXmrwpJH2AHQlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oy/biyHG3uP/mo1QepLNn92tgYEHluADDBPqEHQ9Uqm89lWZiTDJXHNW/LbJBi5MkT6MINrOBt9ubBLTATkG15SREEo9xtYNYd09y3q9CQ02pAVM04uEPIRQiyTDxIPPfpQmoK0bGPpW205doJA+pJp9GvzmQaO+jKi+j87ex3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FJkAVnTF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso45613639f.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706570187; x=1707174987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2XpaGGZCWFpMyaB9aPEtxHOP3hYJmSQiAvS87bMfNM=;
        b=FJkAVnTFd9l4g3cElfMgIML1qAUDphkJAGQkEF1R0Iowl5gy2EAlZt8MFc5E9uy441
         sTMJsbs1oMB8T2k6xxuGC8UfzBP4TNHFqTYGr/SGzUNrko3UX4fRsYzupXskyZTg33rU
         xVS8SYVvrL+SDW0QdQ76RfszDD20FZY6fKbME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570187; x=1707174987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2XpaGGZCWFpMyaB9aPEtxHOP3hYJmSQiAvS87bMfNM=;
        b=Hq/lKp7a11EjzOpsRE+WCCSgqggzLXJ4z56Fyf6MwKpCBdAFoozcsaG8BL8vuJM9L7
         X0cSVZmMlQPboMQQ9Hml8SCeaTjvwYs26i/RmqlucH3kxGr3pqlYFlCZ8tPuwClibNWA
         6tWXyg4w5F/qzdLfmZ/OqnbKc1dE34DYtGCSPvZo+cqB2Z9ctAyr1tSubPGwZ3ZhTR+I
         oHsc/YQyqmOWES8a37y2BpbAtuM9eBmT4NMqcvxb4MUgYIoGvBfRJyeEGAmNU4AEUDL5
         CX2mKzKkRrgIuEhD4/fuL/tLCDc/LaOQxx1oh9LHfvl2LbI2KmRrc9ebR6Me2LGIMxYW
         OV0Q==
X-Gm-Message-State: AOJu0Yz+8opRY/Ou7C2vNtsNd5OUjaaw4YAv6AGTVTJmrvtoBy3zaIBn
	rC0Lw8/YB5BR3m40JFoUZumcZJZPe1bfNQp7pBublgxwnrxRIsdeFQW4NNBK2bI=
X-Google-Smtp-Source: AGHT+IE06yL/FKzzFPN8CpJNqqMMYEYB7Ec6sTMjdLr826q5Y5ke1zuJTodWnXyDOQTPnb13WBUS0Q==
X-Received: by 2002:a5e:c748:0:b0:7c0:bd3:ab7d with SMTP id g8-20020a5ec748000000b007c00bd3ab7dmr502826iop.0.1706570186744;
        Mon, 29 Jan 2024 15:16:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g19-20020a02c553000000b0046edf6bffedsm1988701jaj.85.2024.01.29.15.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:16:26 -0800 (PST)
Message-ID: <b065a083-e87b-42ad-8d49-a71f0c53b303@linuxfoundation.org>
Date: Mon, 29 Jan 2024 16:16:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 10:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
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

