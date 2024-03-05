Return-Path: <stable+bounces-26834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD03872736
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9E828CA96
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF724215;
	Tue,  5 Mar 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmH6Yd9K"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7101B81D
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665312; cv=none; b=A8iPOPeeKMhPY6VOV/7ehxM9ifxaflp+0QTxl0bVK9cBMzuIV5g8uWrZLZnSdsEVcgSXyxCrmoMAeEUAp2DGAnUxiT8VJ51ZQ9pgA2AO8DdA6asZHqAOKR4e8/CzJEyoNAYrT2OTiQYC9uQr63Vy+XhLoyRFwvqKDdfel3hZAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665312; c=relaxed/simple;
	bh=W+RIx2s7YMjsH6sJS+7De6hX1x7jsNpUAzQ0NlcFJiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBx+36/YgvpGipdH38TgikW+QBYD5WKNNEw0b+EbGMj6O6BZclzZGwQdrfYPM5CsXrdCmYU3ZH6xTbbh5QcfkaVzignp8jP+kJ50DQXV5qaq3khJlkG64XZ9RRDh+HpVOzK+uZzffpKtRPzzX/ETLk8l6OeOM5k4cS+oTs5G7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmH6Yd9K; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c495be1924so55155739f.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665309; x=1710270109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phLlY2jti9ivqH/MD/B8hzSvaQLkns3JMxn+/mmfZ+M=;
        b=BmH6Yd9KQ1f4d9buSjjegRAkkIKEV7O0E2sLqI7hiv6z2RFKIYkODb0YF4EOaW/mQ1
         6pGrz3G8V6n97LW2Owq4pbbAVYFB0h0efDf4yyy7apUurGzjRtrp0Pg343thgPmCWgU1
         Be52jsyChmkCnKXvxHoYgAuMCxzh5r82egGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665309; x=1710270109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phLlY2jti9ivqH/MD/B8hzSvaQLkns3JMxn+/mmfZ+M=;
        b=dNs5uaXu419yQ83ONEnlobxf5rHKt0zmz1MazcAcfdlJ8r4+/FO/8AIDnabhIozQb/
         +v+GG3U1NjvbUG/70Sv5ALv5Bf/XPdacNSqbFIOvnloU92z3b8UGOoY0AUX9rPD+2rX6
         WXYKyCLBxjPWe2dZVW1t93WohUPC9CJqWBcXl2uvCUFS03u7hvj+/8m14kZY6vkrVIzS
         Ibq6M6hg/5UVXJCeGrRJlX6JvzYlFRZOjsCHlCcpp6FAGi79f0UiABQ/L+RXZcgl9Qe+
         HjNc6xEODZrfYpEd77l55veehKVwI/Xp77x+ZrTm2ClUY6dd8a5pm+I+m1grk0QSIUWN
         JPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLauAbZBvOXjmpaebX7Yk5xi5+mk15ToAm8luxOjZuwVu9KMLUMXj6PsJosLOmmE4XBpUNjVIb64LJ/ujZKlApdiRsoknf
X-Gm-Message-State: AOJu0YzEICUve7IdLP+1soX3cnDYxpqgq236uqOj8SDWhuf/pMVyrOAf
	urY7UzOSZhsGepXg9UsIwbJk/3tTNO2YKKlSXGLK+FptmPD5BuzH5DMgKQ53FmA=
X-Google-Smtp-Source: AGHT+IHPMuTBc1rTAxSyEKpsXnbRwfQXwOdorpfvId7aMNK3EeNnLlymF5/PNN18AAz8Vd4mwqm2gA==
X-Received: by 2002:a6b:6b15:0:b0:7c8:4963:5bb4 with SMTP id g21-20020a6b6b15000000b007c849635bb4mr1607918ioc.2.1709665309410;
        Tue, 05 Mar 2024 11:01:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d59-20020a0285c1000000b004748b445684sm3126093jai.21.2024.03.05.11.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:01:49 -0800 (PST)
Message-ID: <d8df9362-d0a0-4994-bd2e-6bccaba95111@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:01:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
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


