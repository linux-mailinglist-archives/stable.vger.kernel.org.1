Return-Path: <stable+bounces-104142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A928C9F132E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6902F2842E8
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C91E47D4;
	Fri, 13 Dec 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fs7XgN7M"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833491E3DE7
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109596; cv=none; b=Q+6+y9reKEOwOS2bBtA56iek1NghVF7Hj0PXwuiUP+z0sD/sarOuKgms43k+P3+0p3f4ZRK/omxtEdrx2a/N0a37BnpAfX4rYlb4JrjC+OB4IeoHit93uLXnUYDd4kA14nvieeqAbtwORisqHqt8txlJfUbKn2HkuEhZM6infWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109596; c=relaxed/simple;
	bh=AoRSgPzS88JecR+l1uq6Q0y3fbBaioBqex9uux9/veE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1s5cRkDn+hGlSO4C3lBad+wg4FBl1ytDxAfnMexLnISwwLbRG/0GMTfTLzW58LKAncKZn04whnvEywNP4N+7icniAEGm6NphQvFH6Fg6T12iUk7Owjm4kVm0C/AdttRaaS8IBOWEx5VrQDDBtMj1gtnRpQMHtaByJ6HaHVZz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fs7XgN7M; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a8ed4c8647so13021725ab.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734109593; x=1734714393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5b0l10Xxg5NNZ17JwEtHgXQTuzkIvYO2hORgPq2G1Ww=;
        b=fs7XgN7MisCP6MV1KmlPZoFCAD84I9esYIFp3iiWXyK6PjwQkjeEU1So6690KVH2bd
         6RKrbIxDWprr9rvlU4zrflr46LCYCAOV7VNnI0j+PkpIdhEQJoi0+kY48wLan4kVibdg
         ap0fOxrTHRoTXp9AZ/XP1jA2Lu00TdQQ6Cefs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109593; x=1734714393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0l10Xxg5NNZ17JwEtHgXQTuzkIvYO2hORgPq2G1Ww=;
        b=kcIgm0N0QqypuTz/aQjGPTY3lvBI1f0QkIZP4tLIot7njCjZABV0gVfzBSmJKLAI6L
         GRAdwN6NP7QH9q5iqz7c18JLBkyDmKzpgQo+0NpXAe9KsenpTGm0zoar2c8B1zTUI7+P
         jagHGGFgm+pDt7/kzgGVFyKLBCWWj4CI0U/c2wkZQ1Q09hGQ8UjhpBHWjyOq+DTUPEwn
         ksdbBTnV/Gsw5Ke7SaZRqSOi8jWkUbwkeTPSLuHOmkLfMpvYNsZ+ND1T378cNoQn7mpo
         V3XTduXGV3ecuhpD2wl3NQH2F2u+3L3NZ+I5yVIL0vYBJxcwI6ZzKmEHK7vCKfAENxEo
         lKYw==
X-Forwarded-Encrypted: i=1; AJvYcCXSMATzBKI/siMirYIyki6i7oc2DysNCklgi+O2KseSfE7ddPda0X638LjJDP7nKp+ldTfGLXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWQdXdTCKPMin0tLoBLXhH8FJgoatfoUJC6MSaVwBILTWoUj4
	9LgCtDM+qK1/4A3QnumdzRGMBll7NU1SjBbLzIOZ0WWGbsVniszK7tY1AwJp0ak=
X-Gm-Gg: ASbGncskf0xUf4RlN/aygNyB50vX+eosT56biHdLNY9tYW1ZNYUU959XoYNDWWr36w+
	uSeIh3v+yazYSFDpTE6sdKZxIJNsg4k7xOh57072FZnSkXwjPW3FJxER7VDYYu2kly601OxZjUP
	QIsezFD1WUC6L7Ul26B5O4JzomsSvtTVAoZLKtgkj3xN8oeVwZdg9gaLKoCzjuVWaIK2JBWdbDA
	zIPFo1GkRx6nX5ZOI5UgtH7Ase0pDYqDSy2KKEt4anYhOBQN2Oqtq/Q4gNmC6ptwO5x
X-Google-Smtp-Source: AGHT+IHTYnff3TXKfRrpX7mWJMSvmgfa6oVTcS7rebuH2nCEbPNkW26SkILtniouEw0a8sW8t+/LWg==
X-Received: by 2002:a05:6e02:2169:b0:3a7:7d26:4ce4 with SMTP id e9e14a558f8ab-3afee2d0367mr38502285ab.9.1734109593520;
        Fri, 13 Dec 2024 09:06:33 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2e08d5cb1sm1227854173.6.2024.12.13.09.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:06:33 -0800 (PST)
Message-ID: <f52512b4-f50d-496c-a831-cce2d2644615@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:06:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
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

