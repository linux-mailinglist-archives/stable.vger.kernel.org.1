Return-Path: <stable+bounces-163162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB2B078DD
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5697EA43EE7
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D926E6F4;
	Wed, 16 Jul 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMd+JYrV"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F71A01BF
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677981; cv=none; b=ieyVTEWQSxcAmOIm68yO6mtIeff9+rH9XfVIkZtY/JB0vX6tovhUY7udf0xq9ATSkhqXcU75CfgyrYP132LifJS40pD2sWGUnW11qAv9KtstU/M8/7TWuOeUvJRNkllQT2TUuuZQRFNdgqdpu6/+sqg6JGlpIAN4lCnRP9E+J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677981; c=relaxed/simple;
	bh=pElvr6OAn8/o0rsAhu8xEJ0k4OTTaUohXepM9+sPZes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUi1f79JWIBLtOAfGpq5OHk7O+yqn7G4Dk18WEn8vRBnPHhgRaSlfZR5x6ombijgzxSpAgHTU6R2QGCiCSheV79DHLTROvcb3c8Z6Kkt2gWxAfUBcqq0Xx9Oix2SpivnwyOy9KFm2hjRRZoWzH5KsBWhvUPeOk5abir/AQf+GVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMd+JYrV; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso43404145ab.2
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677976; x=1753282776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJempd4OJNDSO0EWYBVMBDa2dGUd1yxIO1Ir4NFgQpo=;
        b=HMd+JYrVfcPoa0DIhleM1z4jd82e41EekZJc3wBCEyT//TBacRomB4LveiiTIUQv8g
         H0Pbo+ZUPgztK86u7Jv+Xr+oGnN39leAP9VAXyq0sSAh+FHjSCSB1p4a7em7Ignsl8E8
         KxxhH1y+Bfc0ufgnBewR/sfFHo7UZo+WTsJCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677976; x=1753282776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJempd4OJNDSO0EWYBVMBDa2dGUd1yxIO1Ir4NFgQpo=;
        b=mJAjMhx7CDJ3YOx03mvfKvoy+u3maM4ll34I2pyA95Nnl1VlBx6sOiFynkbn8PsvZh
         FOkvRBASE+2DdWslDtJhmP+sHmG4aq5xe47pmHVMNU2tDGBQoaxqbFXqPzCKIjc33kzl
         WwnWkQjjZabGeVa4Gi94CRd4en918zI1B0wt6hnoVaFHn0fp9SLaSJyywjpDWB7oGy6U
         J1x6emU6jVx5lpJ1t1qSg48o/L2nZVWQkX4Rbnb1MVLfYbphu/eIJP+VK48GABQvoHgg
         dCsdqO9P01cTJEJlQCUSQyrJXL3aouMpuzO3ljht0Od8e2kx6XnZD2EBFWM6TdCmmAcR
         rd7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdc9DEmFGjZQaWQaRmfyWbq/SwJoBa9AHJ6oIf7qN4rJnuEdARp4PutAy3Ogait/WPILFy1YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8MqVaxJcuO+dJ4NovafliSCEHeSaTSICH+MXL5VH3qmCnLnb
	4fVnscdIWyS5LY2vWJqQC9hIL8y7LsoDTTVDZp9dsnhNvU4E70Z7r7ADARE2g/ncfwc=
X-Gm-Gg: ASbGnctSYGSQNcTcAJfUMoCtOr5eMuIRDjjgiNvCHObhDEyfNZIO4NtoJKxxEeHasig
	KRpfCSPHJj43cOuu/v9i4z02a6iAybaMBVOPYgo/jsj8cLfxVp88R/VDeLW/NmTYn0YjBL//HvU
	OVILZx4f2tcRb4vd8b8NK0a2qeyTRszcMwy9H57D2e0PGUB+CVtRwlT6FAJDrgzLJI82BYUzr5K
	d0+KXK4LLh7aNmoOzev1POHY9ziklMz3J1kyZSS+nyW4lRl9KYS/ojXn3RgGp9f++Wp1L9j83zT
	FX+02vTZ9iQvbzU2fUePzUMTcIkw5zIesmP0MswqEaNd8XCxb16W4NelO51wJlwIAgn2dU1dTwE
	FLA0R409aEg7GjtlbCXTyo7ArvBKvc9l9zg==
X-Google-Smtp-Source: AGHT+IEHyBKfKdnKKqLqyogPmYS+T+iV5IDluzDqDwsG+9OoFrySizp12bUVr5zit6PtTuV85Lqb/A==
X-Received: by 2002:a05:6e02:3497:b0:3dd:b4b5:5c9f with SMTP id e9e14a558f8ab-3e28307b2aemr34336545ab.19.1752677976330;
        Wed, 16 Jul 2025 07:59:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d0e4dsm3015334173.109.2025.07.16.07.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:59:35 -0700 (PDT)
Message-ID: <d0459758-767c-4593-8954-bf5f23be861f@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:59:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/77] 5.15.189-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

