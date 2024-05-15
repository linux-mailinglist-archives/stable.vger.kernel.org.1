Return-Path: <stable+bounces-45184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4438C694B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154051F2131C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130715574C;
	Wed, 15 May 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6UterXN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20F5DF3B
	for <stable@vger.kernel.org>; Wed, 15 May 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785739; cv=none; b=u0+OCDWu7DqvA4TSjrPTtz8+96FVYp17LU7e2Z8JArOxYpp1gdDZ5MYQ8Ol4PnWWbprMmPZ0FhUlk2XOMSWnjVlaIUUDmtAooLWCbzkFGFyPFKzSOtrA63FiklixwCLPpLH0B/pVPSxzoXMrGntPg0AbqzSGA3PIzkrGjcxssC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785739; c=relaxed/simple;
	bh=qNAQ/s9LlzreCAmAb2oxC6fUH9eKBTNvC1uNwC5sLXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj4iaHQzngKRD1RwVAs0fA9jsY+3Mlpdjj3ufm5Rj+PiBXAfjcZD+YPVQN5747+5UKN5UgNtFxGs8qrKG9aqVjgC591VuHyS+KhdP5STNWRcbLuddO07T1V/6t8XlivSluLuxaGnxFG1490LSFnnAZKO6I3nU5Ol4v70KO1XppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6UterXN; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36d967b7167so70605ab.1
        for <stable@vger.kernel.org>; Wed, 15 May 2024 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785736; x=1716390536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSqN4wQpwk4yqsoWhaj7lKmacqnY0+0Y5JLQgrtZQTw=;
        b=b6UterXNIs9rCeC6GoL8pIpxSqfWsm9tr/ureKrdLqNyUlLaZ1FP1ixB+e6aLyaZ/Q
         tjsL+jIn+QMxsUe6hHW3M8ZutQCYdxDZ3JH5zlrBx+0QXgK2EWYiMJAm28l8Tj/cSjpe
         fBC9C/iq9hz484/1FUnUcz+86eAdfi5XY4dvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785736; x=1716390536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqN4wQpwk4yqsoWhaj7lKmacqnY0+0Y5JLQgrtZQTw=;
        b=m4qaHIvialSWptJULpk4PXCzHTflAWU8bEHNMpqkvAOQUh++BlDVg4nccab1CSC86W
         z/d5bDrSxPoYfVMNfSwJejnOAOyf2OMf/h1057S9PSj241pXtIZbdsIpMrTg7ORdaXRw
         cRdnl5dZ0oc+scHfBqgGk0b8CfFENC8igH9GCdRr9whbdvczgGsGEYMeTPbUr8cWGObm
         ENI7SG4Peo3zB90HAGzNJd0lbb1IS7qaPquJnK/FQTiYOL2vdie6DLRUs5lhED7oGHPR
         w1qxRtebmGuQE+WkSWPL+XsHZTA0Oem1PdRvLlY+BQbSZrYBUPOTJb/9BbXn367VeKsL
         fNfg==
X-Forwarded-Encrypted: i=1; AJvYcCX1HrdDxFP+hM5K683L4oja9fED46iPPCRpS3939GrMF8OhMIMD0K17o0YrE6BnPzBE+F9bZi66kld/d65ARopCJbtyRStK
X-Gm-Message-State: AOJu0Yxk90yxi7BsOLf31QViNVOa7zwY8JaxwQgiQ+yV04gLg71sepQN
	T5164xDcDp6J6LY4df5hAeU9irUZZ1SW7TzFU6r2dKbTXvDvfHxMJrzGfmhUDqg=
X-Google-Smtp-Source: AGHT+IE/TJsiKBWLJTlooCuqIiZxdPbkyGL4Rv6ykctpuLdFe8Bh1zg+5HLkDYmp6zvnD13qcOfSQw==
X-Received: by 2002:a5d:8c8e:0:b0:7de:f48e:36c3 with SMTP id ca18e2360f4ac-7e1b500fbb0mr1695553439f.0.1715785736133;
        Wed, 15 May 2024 08:08:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fc67csm3631174173.175.2024.05.15.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:08:55 -0700 (PDT)
Message-ID: <77d93d15-c9cb-46fa-8299-3e990be2e4e2@linuxfoundation.org>
Date: Wed, 15 May 2024 09:08:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.276-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.276 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.276-rc1.gz
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


