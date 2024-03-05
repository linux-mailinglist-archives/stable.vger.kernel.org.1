Return-Path: <stable+bounces-26833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E6872713
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9AF1F28580
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854A1B957;
	Tue,  5 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWM0mkqX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF91B7FC
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665021; cv=none; b=RZO+DbBEo435FavFcm8QlrMddbS8ADxgvefgFLxQQ8eA/X9zlnwpFZX4NtvfPgSKfKZ4SzNNtZVtHiH1rThXuCwT4Q9GuGOi9PLzLdxedHTyVHj5dJcJybn4wuZZpL6xeYuzbLDprSnkO1Zf+L7azL6dpom9ZPjoiJsyZSDNZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665021; c=relaxed/simple;
	bh=K99fQegOZJjtC/2VmKxfu745XKqO10+Riz596Tnvz+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVbEVmBLgmmPcWwd98+ZFXRoqmmdR3ZZ8FWbolJRmBpNxNg8uV1agAYDum/ZA7xwVIM3k+77F1x29wajKAymZT2TX7mRUYk126QhboMJXjQF/Oge6k+5SQ4MgPaDGvV8iBugI1l2hWnk8MjpdSaVyC4glRXH3Xyx+mmU47WsSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWM0mkqX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so69107639f.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665018; x=1710269818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRGkWo4Pf2rp0wd6ei0m6Ry/mBXk2gBBeI7bR03vhAs=;
        b=cWM0mkqXiMEyIb+7X/77ieyjworNDVDFjBfLudGM6e/8cRarxHrZKyAIQM9SF7haqn
         nD9+P0sQ7zWUhy7PQf1wDJPe4/AIvEWQCUgnGzwzo4mO2wOTwfZrJlyfUlD9sweC66ER
         K1q+9bZoq6uumoqXXeyCvnER82p7H1bcltGoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665018; x=1710269818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRGkWo4Pf2rp0wd6ei0m6Ry/mBXk2gBBeI7bR03vhAs=;
        b=bzCUJ3TxaPalne0pSmEq7/IGq4NB/gQgGowUhfEbD0542OyzU4L9chVlrKIvhrc8ak
         v3nFt7W548WKop8cRnaRmFQPgj6h24U46rd7jieFQLGmXyw/lA88s/oMAVgXev6O5PU5
         382vC8CKhXMq8uMbswJReIC+HGSxEr+oFPATmK6whAj7mESLK6Nf5nAnnniW+nwc4XvN
         BrdQkNOq4WIQfFSJpXP2ZY5zwxM+/UT0kZ8qubgHG7q54twyYuVrHBcE3rAap3uFTlFB
         Xqty+hzf/o/rgnNRdFRTJVZJGBlkOm2BirZ/MKACDgknELdz+FU1wiX1evbECRnjL1pB
         xHUg==
X-Forwarded-Encrypted: i=1; AJvYcCUuBvT0LxLKqN27aAlcmVXEmZTzckr4O5GloTHOYjyHFdvgXxPgxpaaxUgXD91wVdaswUm3AJ1zCodDWowqHd+YurRWCczE
X-Gm-Message-State: AOJu0Ywltz5M/f/kfpksr7KWeBKqeAESjSPSz3IQlraXWx0Chb0W8M9c
	CdwnMgPjuoq80zrjzFGq8aGhY2Klh7hiDLYKk1CCgMZzwQ38HINnlGSkFPC47mU=
X-Google-Smtp-Source: AGHT+IGUc1QdxwJe+0fGU/iqLTA7slDiGlfZzyzYgjSq9z2JtuDXc3CsYNy9JFnsKnKspz9kY/3fLQ==
X-Received: by 2002:a05:6e02:1d87:b0:365:3fb7:f77 with SMTP id h7-20020a056e021d8700b003653fb70f77mr1252503ila.3.1709665018609;
        Tue, 05 Mar 2024 10:56:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w8-20020a92d2c8000000b00365ab9e9799sm3256963ilg.79.2024.03.05.10.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 10:56:58 -0800 (PST)
Message-ID: <16fdb81f-7b19-49f4-9f73-447de3315562@linuxfoundation.org>
Date: Tue, 5 Mar 2024 11:56:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

