Return-Path: <stable+bounces-20132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751358540C6
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 01:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AAF28321E
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 00:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF440370;
	Wed, 14 Feb 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AygqfzxP"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF04436
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869849; cv=none; b=kSR5EfnXVHrV61yRRdpPJwODrch0TvTtQF+5SWImRWhaQl5AC37HQ9UvBsEpTfj0LU6fTzvtinhMex72L0LP+2clPfzwXv9aMO2vR7Z51cV4zveMWgIw84ZvCupN/qX/ks5scSKNn77jDTAbDLsAYQTELkydJROM1Qdhh40WANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869849; c=relaxed/simple;
	bh=GtNPwOVeYqEoQND8csoZlzv6nrrvTMepd1LrHxfG9Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNSwPeoROJgdB76FBPmgD9Lyv4IBRX4hf0YPYRuJ/fff13FstUzta+7HRYp85mGyJ5sEKeoaiPaHQ/K0esHKbrb2G94y09NaQIUm4SFkOp0R5OkoazmhNZz0Zsi9GTKoG0+oXZcZTZ0Hw4xRTSNs90dOAEikry11jZtO3Fz+o9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AygqfzxP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso48707139f.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869846; x=1708474646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8R1ZRFNPBDSJKTf9xhbBZxVe1DfFeuBRTvA+gPMKArY=;
        b=AygqfzxPcSpBt9KesQnE6Wuz8+5q0GZR5EcNGqBqN5oL4sLwczwO+s8i4cw4u/S+Bg
         BBGV26psU4x1Yj1nVOVSMlfYWbJSP9k7vok+ek0JkCE32/iMA75mwA9Dq3459qN5/0ln
         CZqKu3IyxAhsA7aWS2+3GjkxrPRo+VLcPguCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869846; x=1708474646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R1ZRFNPBDSJKTf9xhbBZxVe1DfFeuBRTvA+gPMKArY=;
        b=dFG3vObEMWgccpvZRjd6SbmltMiGtMIKC5S7hyKds0p49i7cO03TLrHMVVjMHoKHmH
         ow14tD61WYnPkhWaEp9wCq6fZBgiFZRBTlzL9FbIKjDxKThtbiNs69ClEd6X1vGgt0IB
         8wn3FRn3H9AmVb337/xYHwAtonmL3GNytwsqolaXRY6lYC03KVoHuVVVjJLufSUy+bQR
         BxBZinhyv/YAWZQkIrA/5GmO4At5D47H9FYZzbrLE4JQA7cWZbnFLNvURi6FhrK0rrDr
         uzmnWi2m+ac3Mdncmh7Whk3/2o55xNqKZT6EB/LDLJP5Y1EejcIJsr+5AKIQQR0PbEYr
         Kg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXYpdeKh97qrRo+BNFkFXWbd+2Z3vZGdZEQ8xEOXvy3skg7eYTrut90atzxco5kIef9HT4qEpxzbxf+6gO8HiAL6sew+Ar6
X-Gm-Message-State: AOJu0YxBjeQtE66iO0EOjVhS0FHkNuwCczLMCLEumoD1o5/3fcins5/H
	W6tNDsJN1TWPHqKDzarq7rvl6sSMTsy9POLvWGmqCDme6oQ3QZq3NXQ5+vNtvSk=
X-Google-Smtp-Source: AGHT+IFGag4hMH+UjZfIrNALOjx0iTOt+qW4FggRBh/NEjikHy6F0nGspfe+Go/nWvUqvVrOBwQjsw==
X-Received: by 2002:a05:6e02:1d87:b0:363:dc84:ef56 with SMTP id h7-20020a056e021d8700b00363dc84ef56mr1461086ila.1.1707869846047;
        Tue, 13 Feb 2024 16:17:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJQruroDPboQu4W7vqSgcJpaFCwZkx/7K+IODSFDmLCHX3CTRFDleS5GZ+DK9cXEIPmDW3GVdi/2QrMsTZFoVHFT0CGXm99RLcvIXrcUBkxYNE0HgGeywyUvYLxTtVagWmjn0T9FhGUws1tvh+0x0x4YmRzcai0KfCTiWNa8x9/OUbwPeMPgCRWUtgoQ4QkJvWMAL84DzUUqdBO15C3fV9dJ/DrA0J48IKjUNn8v4vP6aoHNhkVXz3jAzSfhv7C3inKy6yNcREy1/rKgW6CYNF6R0rynxpLdb3KPlS3NSvAkNdE7jQ1t6ipIfcwIbMNR3yLlCPLAqVncB0kO1cXFF9OUnQWyEFhuo7/IJn5T17NW1PffTbqmJ59DHlBwaheWmAPMmEUochD3e68A4jmOhUZNOQq9ILcBdT2ImxIsewiBMEac1P6JmEWObXxarlYltdOiLnKqOsRrDfaTs4IEqSa+GhdtqjJkpj4Lt89dDKyrZNOeu9gT/4MwPxoSqiE4PnjPdOxarLJ4keORWfZZskCwbncdbK/vTCWzDf3sARJOLeF+pCu+d4BveMbSWknPW7kzVgDzSywA==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id db7-20020a056e023d0700b00363bf95e16fsm2788860ilb.15.2024.02.13.16.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:17:25 -0800 (PST)
Message-ID: <a343de6a-c377-4a81-abbf-6e98652bac29@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:17:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
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

