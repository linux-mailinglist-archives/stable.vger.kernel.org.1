Return-Path: <stable+bounces-35878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6A897BD7
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EA41F237A6
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F242156965;
	Wed,  3 Apr 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsgkU0oz"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879E15531D
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185210; cv=none; b=eAiP3uo8bZ/oqTkvXwpjWu3mcqmeeiQanETQ9Ma/gjUBet4OWxz5uO2lIQHValdH23LEZFwiy5Uuaz5HhayBQyINwkNlo7JkR8mjZ5SseKfsV9+JU7H30cq+9jbhMSXYTiD1o+xfxbl0nymrrcsVQyQ8pwHcfqSZbsJ+jzO4A88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185210; c=relaxed/simple;
	bh=jmIV0GOw5opWjSRaLZcl7S1Iprv49UC3ViIj5KVGbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbe/0GPaVwRMfrM+FooW9daNoBl/AzMiBbVQ2hceJZkKWU/EzkFDxXpvPoLrylmx9UWzrOONC8LGQ6zjI7dlMPHqpq73iX5t6xez9alNP4r5Pt0e+gvFymCWCHpFTlQ43Y65XBh/7BM29ciJwNqyE8AtDRdWvNbcm49pgJWLmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsgkU0oz; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so7748339f.1
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712185208; x=1712790008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDl1NAxggtWfWoUqJc0/YE9Vva3ljQrZuJwUEtA4epk=;
        b=HsgkU0ozu3b+E06xP13pJU2Zpvz8vNLifMq/uy1O2Zq47R6+jmCod6NEgbgZuaYgow
         92UPrlwi723lZK8yn6PedJTllGyl34dVAvCdTUYmA0lTvhvCyhOlP9wfeF5MfkwWIzNR
         i4cxJFlHfesZz+JzanEh4+vu3eJMYOGp5teFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712185208; x=1712790008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDl1NAxggtWfWoUqJc0/YE9Vva3ljQrZuJwUEtA4epk=;
        b=FLJkQqobYLd92D241u51FyLFeQEwCREYI9wHK58pxoEng7M/zn12V7xyH4dKoJtDVB
         wa/fvU78FjKF5NMQ7yG189dpzK5RMlW0/rDUkXRLQwgeO0fSR1D60cDmcsSTTYbTe9JH
         9VPGrKVjBMZmtjF4MUI6m7PmHKzopJrmQ54n4Dp7eq82xl+LjItsCVyrtP1u6IRTTRI/
         2kLK4jj8D9c1TBTj+M8R6ggTdQpFhOzYaZfOr7J2s/WSKuH4SYNcZlgTmtTHPGEGcVvu
         xHHzfZPJNT55bnobndjq2TyYCq6QxjkyBzcwk5kNowCSaxz6uFXhMHMG3rm+x7e/liPE
         buKw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQQ5ZHeYCv1vLqZdFw3SSS2DQiCosnTicfcRhmk5qge/n/mtlpNlWF3eOnJGslNiuwlQmcoDpKqN/RgetyptysbQ1zECr
X-Gm-Message-State: AOJu0YwHRLZ3guydACueJV5fmMeZLy/o6btKYtNvw3/4pVRQOXXBltKh
	5l9NlqkSFyj/nzQAZyRLTSUl9uEVECEYr+KU/KGrn0RriLxBNqYGygjmWtP7ksdCt4VVrN5HP9i
	p
X-Google-Smtp-Source: AGHT+IFl5XEZ2ibJnPA43ZuAvjF2L0kiBzzsvfNYmw9cYR0Av/jzR05d3ho2D1+yTpz0sqmI2dVeRg==
X-Received: by 2002:a05:6602:3418:b0:7d0:bd2b:43ba with SMTP id n24-20020a056602341800b007d0bd2b43bamr1609782ioz.0.1712185207862;
        Wed, 03 Apr 2024 16:00:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t31-20020a056638349f00b0047be37bfbbdsm4057220jal.153.2024.04.03.16.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 16:00:07 -0700 (PDT)
Message-ID: <a515127e-7609-4947-aec1-4a7cbdf72c40@linuxfoundation.org>
Date: Wed, 3 Apr 2024 17:00:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240403175125.754099419@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 11:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

