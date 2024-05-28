Return-Path: <stable+bounces-47599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBA8D2747
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0150D1F2543D
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A347F6F;
	Tue, 28 May 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmFYkx0o"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E71DA23
	for <stable@vger.kernel.org>; Tue, 28 May 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933166; cv=none; b=ULnL3VVxGvBOtmxj8odPkcqpyD9Bs14ULS1Oy0sQe5YKSz5Z9vcs4Z2v1NlbWmlkmQiUQH78zI3TpVohJshcYL51ffvANOytGU8No58d7CHusGu/w+kU0gn4WrUpdh99Y6wO57ShOm4DMsmFQ1mTnlzDU5XI3JtGUIMhcND7iKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933166; c=relaxed/simple;
	bh=yH1vu1c31OfzYxtkggeNs4D7ggx6/2Zd3PQKw81s4ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvQgTpeFMAGlGf0UXNDYNxaSl6AzIjISXxB8pOkauozrTscCEJ+mPOGkEDPJseyqj1l03EHQprSBg2r+aw4NseDJUU/AdlaUR2t2NF/wpSS5PlyvVsa3Fy5iaAdW8s6vf5ZTW7WJJffP1npDpq+aIT9U8Ht0TPleDQnBNsJ8l+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmFYkx0o; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37453912261so507895ab.1
        for <stable@vger.kernel.org>; Tue, 28 May 2024 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716933163; x=1717537963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbmjUb1DrV072rwCjfR56Adlee/LOZJno21U1pK2dDU=;
        b=AmFYkx0oZXrg4BUXlfCiROS7X92Elwvk/wsKEHHONr871BLM8M83qcrJOGWkX54Sf3
         NhmurYhhIdD54eARmBMa0RUM7vm4213fnb1qTuq0XsD+uPySVzpzhP3Xp6hHdXsGj3dY
         V9GsGTxEHm1ycwYo2bwwSUHtoYJd4s5SxGbgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933163; x=1717537963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbmjUb1DrV072rwCjfR56Adlee/LOZJno21U1pK2dDU=;
        b=WRfLf0a8i+VwrNaYYo02j2wx31CtH2FhC9WYMifPElDH5tCdhrIOmeWuuyWYw9eEK/
         HFYhiNnOESe4mao65V2FbPwhVyakgYB3ofRYXEtDujrpHVhz/jorJV57H5MNApFEffG9
         gZd6oMaTT4alVu9neDboRlJ0WuF7dDMF29FUB+de2aW/UnLANYn4J1g/7mU/dXdtr3FU
         5ElSsX832mvQnfs6OxthVzKFDvfNsOIAp/jRzGw9q0ixFGyxCAeecKtNtPSPzVa0IIVz
         wcfXu0hNI+9gRWzVYU//ylTo5T0dK9Ug7LpPqYVrqnM9MT8O83HWrtH6znCBGQrtHdAO
         rcHw==
X-Forwarded-Encrypted: i=1; AJvYcCVLf5uNPvFqXxRURera7bjb6P8EvtMUJSJkaK4+spuSQYC6MunZhfVDpKJmlIAtEM8V/RzCw0fUpMtBVFZWcg/rTotUybIU
X-Gm-Message-State: AOJu0YzGsjCx6kiU9UnU/EmZzUyRwJzQ0qAXgq9GFFdahdolhodMYdsf
	/C1OfRyT8zmlH20D0/DxtJ1cRdrPpbUbXt9yRs8fIiqXgg/XiiI3mYgpdEjeNsY=
X-Google-Smtp-Source: AGHT+IE0M+9sjQAQpvQr/L2mFhvHpPIobSn4jg6Msft6rjn8ES/qj1GtXhM78jgBLU9M+f83Jynd8Q==
X-Received: by 2002:a5d:8783:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e8c65599d7mr1515103939f.2.1716933163663;
        Tue, 28 May 2024 14:52:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0b2c5a6e2sm1541613173.128.2024.05.28.14.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:52:43 -0700 (PDT)
Message-ID: <88d9db41-e262-4125-b45c-51b25d77bc5b@linuxfoundation.org>
Date: Tue, 28 May 2024 15:52:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 12:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 May 2024 18:53:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

