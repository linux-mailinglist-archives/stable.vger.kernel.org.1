Return-Path: <stable+bounces-83102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F299597B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 23:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FC1284AE8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3943215026;
	Tue,  8 Oct 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MnWMHDiF"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AF212D28
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424726; cv=none; b=l88BsagDeodBPyWlGYTlIhq7F5mi4ohKi0y+x/dofu3HZTerlTbdx9O87AYqiTDktRI0mhSijgn0EWHQ0KZCpH17bBsioKh0FRJ9RaSmYL5AaWcpsjrzzUTA4CO/MMgMGFqXRLF+F/eBnGr5tg6/jO68Y4T+3fKilYNzi4ptuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424726; c=relaxed/simple;
	bh=BDDiSW9BBX6xnOUh7/79lZgysI7A7Y8so7jKZf0yTV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9z2nRTasdf00Qicw7sow4CyGYaXfLmRRHrB93Fy2aG1khnE9RFLYP1LHjBf7PFzkTKIqgpEQ5lr1/sLuHOXnCdaQpRVu8jIJAVKHEkncCjFYDhGMCs+eSZ40m4+vtd5WulxyMu/aORYcUwaUpeajPfUQ1M6MOOvOoNt4R2pNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MnWMHDiF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso34347535ab.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424724; x=1729029524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4S2vT+XJ6lAU0O0Dbvl1xT1xfiGrVvJLydXOgnwn2gQ=;
        b=MnWMHDiFx26k/dK/gWfxZP/Yyudu/dlgANhhPzDR+GEnu5iEouJqJqIgBnjMcsJNGw
         /N5YEZ6nuw25xjV4CLae6VdAeZFI1H+tbuqQLvBdUlvt+502Jd76T0bN3axmgvxAiwfb
         lUQHyWFvGVJtdFQWBr/7VBfH3SibgseTFWJMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424724; x=1729029524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S2vT+XJ6lAU0O0Dbvl1xT1xfiGrVvJLydXOgnwn2gQ=;
        b=ABcf3PLWntiBMvBpt5zyQkQKxMrMksaPrkXaTzngxN+d0CNf9Hjet4hbcf9SvcyJe5
         2GRQjE+EZ6lGsJP5wS8GnqOYClOBmmdnWcDFgRfQycAZhFJwiIyQyeYJJrc7Rd3yAmy6
         SeX9pjWkAyd+httBQt8dIhTT2lK8LzzlmAUuao9lOYaFxoW9ITRGmo2Qe+DPlPk5L7Jv
         DyEcEV9rpGw4843m0TPVFK2KbKgdB9wHXw0Rwyw/bNJb24vxgjZd9AV1HU/XVTaefEZL
         bk17LHbUAuFdLq8LFGBgFYzpFQ//YNgTci9AMFzavwoJFURHK1kjOvL6rzSlFsU/2of3
         n1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVgi9uW9C9dW0fd0wvGJpu3g25O30m1KDYQA62VcfW5y+nnI2Rxdgf497KfCbD/L1xvhdyNWgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtQvD+jl/Xlxqmd7ukt7G2ZONZATxjjXUy3CAU7R7wg98nr2x
	59LN65uJF5Z7WoF6g6LNHZAZhUUukxQDA6U4FLt+uGDunWGIAzcz35Ka8dw1KnA=
X-Google-Smtp-Source: AGHT+IH1ggCXTbeo7PXnHHIwj+SZzzLhpIklALX/d/oiBJ5FvrShbiCfcU7w9a5bCxSKcJUiSz0/Ug==
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:909c:812d with SMTP id e9e14a558f8ab-3a397d0a552mr3176975ab.11.1728424724272;
        Tue, 08 Oct 2024 14:58:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0998sm1811480173.87.2024.10.08.14.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:58:43 -0700 (PDT)
Message-ID: <4882ef4f-37f9-4e89-b8ab-85895eca4cf5@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:58:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

