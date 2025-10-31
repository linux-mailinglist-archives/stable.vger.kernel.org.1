Return-Path: <stable+bounces-191967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF3C27217
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 336784E9586
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820B2F0C68;
	Fri, 31 Oct 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZslB/+/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F351F181F
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950133; cv=none; b=PKox+buVse46HFoRe4JcKM6/89G5cxhovJEg4Zx6nr4wKemQfHrXDBg4CEcLe23H+Y8faV9b93jqXDVCKEK9yVXyAdaUhvWE0TBHW80daXTCrv85/dhyAybZFOMwiHPdHAhP5SaMJdxtAkSaijRScg89Ve4XGstyId1/uNlsPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950133; c=relaxed/simple;
	bh=iYck55bahX1dqxP2BL3n7cuT8Xbz8u0rKuNJzAfwsLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjKFu1Lfw9f1gfFJHXAE7KzC4ZyAtZwJyQGCol+ut94gb/YFWbfSPEZaFzQZTkMmfjGFh9kpVfQmGFWL1A2snFjzyzBGMEk2gcNboiJQg9qfSMwUzFacalz793QCk+/PkDXUl4+RXPoJMsGu6e+gb7O76ViPKXVWzKJFB+CezJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZslB/+/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-43321629a25so1053905ab.3
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950129; x=1762554929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnbrNksRBh1bg9JZSC/QDuCw6CE4G/JQOW3nf+SPy4I=;
        b=MZslB/+/w0nMXv/n4YHPUFxz+TEKq8ZHzFtX74JfuBwU6ywI9xrQjcw1m3QrIthrRz
         9x2fnSz4PSZ7LijfJFkGWfZKDQC19gwYkZDOlQpifXvrOLfoKSrVCwZVWVhuQo8WXL2i
         rjT65/524aZ62hPRx/u5uykndK6EDjwn9PZ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950129; x=1762554929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnbrNksRBh1bg9JZSC/QDuCw6CE4G/JQOW3nf+SPy4I=;
        b=brp9Qq10ta9WoFZcGK2zOr18vG41sOSuYXoMlgLFvYTHYHbLXsdqgd5ILWQgSM6cIU
         spzaTEcgRyTVtWZdRCbMh3BR21GIpgRKIX1rTp94DUyVdtTofTQThex1a+qv0zNxsarj
         HCFeHGtQLOm79PKZtvCx1FSjWvrDwGs5UGGYTK/tj69e00z3uTRtGjdaAVXpZzWlWhsK
         GEwTHw2wd0dMrFlpMlyzwEWknvP+y7NeMTBrdWAKP+haHpII8DqmfmY6p1efpLRnTyPC
         ZkSCYbLm/vMiFaB+ejw4Di3gvVGnXiREXRI1y6oG2X9wSpj5xa4glBzY6nCnnB3cGhxc
         N8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWMufqDaAeJQ5qfVru4C6hdl5dRberv4Jn15m/G15b5zObfPc3CWDaluorHpKztzb2dwlMnyio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxujnxu8l9TQQsKY5jWlrfI4nbsRXeceMsH84QCYKLTSC05QGZu
	tZVFHTNRGKafqsTJsbOr1M0NtFHm/0Co6T+6NSqM+L90AFj7LyRobRdz7u/Ga+JfqXU=
X-Gm-Gg: ASbGncteQJwH7PR69QvY7aK0G0FnODbBO+gms6S+kbQUggotqWv3/PHBNDo48yI+Mzn
	1gZyJ/FZjSERespvhkK4rkejPZgDTpYCp28s9OV5je+pEEpWf+IeskZRrwqxjVCo8zcMBueXax7
	RdOQcSfD5XlHp/3EcC6ifBjvNNSxmETB4yzqJvfv4kXEcKUDKiSSrqxBv8X6Kocktlbl5IFyFkz
	phOPwaD6oAizRoR2i9SomEOQf/UCKfFoToIhyaBXmfVA/lUmPEV+Xw6mslYWUnkPMkdfQcSWITH
	kuZCbiOL2RRWE6NEB/eqgcr1q3IvDEm7OLIGq1ovW1d/HohIt77BUHPiUo3ZTEbK8T+jWiH+KIt
	DREaFKkXcinRcC9UA8/knr7OIIrEupfLsgjYPvIZXs4krXAAWp5NLHHik4q2Egbi8GCa4ExaCkY
	/oLpDE8TMuO9gbnLL/xVV1M+0FkaPKLataUQ==
X-Google-Smtp-Source: AGHT+IGjVrSQAMNqNAnv/gM9bi4zfu2mobXw57w95CoY0VCC2MJGIb3snv4VN/yENZWB73vMHzXC2Q==
X-Received: by 2002:a05:6e02:741:b0:430:9f96:23bb with SMTP id e9e14a558f8ab-4330d1315a8mr76043315ab.8.1761950129290;
        Fri, 31 Oct 2025 15:35:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a55b1b27sm1151546173.41.2025.10.31.15.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:35:28 -0700 (PDT)
Message-ID: <23807f00-6b2a-42a6-9ab6-620ae5dcc661@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:35:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140043.564670400@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

