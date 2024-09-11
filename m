Return-Path: <stable+bounces-75893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA958975969
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD12B258D7
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA941B150D;
	Wed, 11 Sep 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtAY3Yce"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5719CC15
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075789; cv=none; b=nPLwnMOQS3kzIIsXwK0zf6ckojZwgDJHKFNPtNPtJ1WFuH+r7d/hAUBMnP+QAgChMXrjglU+ta/MIJxkH1ztbqTvlXzrWrirPYTvTIF3P3P2P2xs1OBdlnwHuSjChtzr2gEnC8napGxU2X2QAc1TRqD88Hnw6U8YIzvIAyokjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075789; c=relaxed/simple;
	bh=deyId+hbvPtYVLrqOKPCrG62mVsKADAmngzIBDzqIuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzBHas5ntKRxjvweXqEEdPg9ecLVsG97xTD6RWoEfTw+ShhTd7pHO23ik9NBjGAYLkRmFig37mxruVV6Uk+q2KNjiBZQpNZvHeyS2GWiEoLwTxHHdOZkhYIspnxpEHZAC62pu8uxypE/Gp6c//M7b+PGTNrvdCGd5N7tB9sAhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtAY3Yce; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39f56df0ddbso304645ab.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075787; x=1726680587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhTcGv+CB7b5Js70j67xVM7T4ZdDcQ6iwfn6qh12PQA=;
        b=CtAY3Yce2ybZtI+rXtXQzbLaiy9kJvKSquncVZ78Nbx3iicyZnFQkMmFb1xmPLf5gL
         38p14PybIDovU3qdRSF4lZp+UYIo2Xi5jI9YODlGPGKMsXxVGYBv05NLwgM47G30G77Y
         /vMUx0zNAwBpPM0oTM2aAeOdZfpDQDvJN5XOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075787; x=1726680587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhTcGv+CB7b5Js70j67xVM7T4ZdDcQ6iwfn6qh12PQA=;
        b=xLyHu8eF4Ltupapc3/QEQQ7v1s8tY9qQLXvsaQubDPuUhRq9c1xKGY4vKmBH9N3jb7
         F+uLmnVmKLRFRz8QLw7CusLgJCxAQX3wlMvOBG2m5UdCXYqnPHd8l75+YGFxA3lm8iJb
         Fe9fqm4D88/6HGjEJ+IR+jtc5IqApy0eZijn3MO2LVmvzWczYDBdanbj2gtulzhGV4PE
         NY1FKPUWNO8uG8mLfm+wZjQeG+UEvKXJZTzwI1/+CMF9eui6b903BcxdG4jeIkH7ww47
         nz14yOcJ79gGNFVvDe9enJwVlmg9D5JMVSADAFC9z7i4mbPZ/akqikN+T17HXf0gkhM8
         6/+g==
X-Forwarded-Encrypted: i=1; AJvYcCUBm2NSdyAeETGZaGk448V2jU9BXFFbDqvTdhETDkAoGJKjrPnzgxBd/qVQBodWX1XJy0v6G0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSVaO5vH75HuPcz0z9+NV1uWtEHppH1C4+4+YdTISt0C+Y1Fq
	CqEulpnk1/kMiDMQXek+AtwiAJx1S0mytzn2q22JHUxt3O37nJFj36M1QkV0krei8Z3fkC0RQv6
	e
X-Google-Smtp-Source: AGHT+IGXlGFn0JYATmp8cePrZBokGVaAbGUtgxCOQUBxYmspTHiO+sJeq9FPmDxQYzyWepKbjXkDkQ==
X-Received: by 2002:a05:6e02:1708:b0:39f:5efe:ae73 with SMTP id e9e14a558f8ab-3a05685605fmr139166385ab.5.1726075786908;
        Wed, 11 Sep 2024 10:29:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8910fdsm94868173.107.2024.09.11.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:29:46 -0700 (PDT)
Message-ID: <5734f415-87fc-4897-8241-8d262868757a@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:29:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130518.626277627@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130518.626277627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.284-rc2.gz
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

