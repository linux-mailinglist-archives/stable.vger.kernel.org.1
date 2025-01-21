Return-Path: <stable+bounces-110083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65610A1886B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A793B16AC6A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AB1EF0BC;
	Tue, 21 Jan 2025 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gxtJ2S5M"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970421BEF75
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502593; cv=none; b=n0CZ4jJJ3jN8w7vRD0aMH1+S2fhE9Jng7Cw5RZHk1w3GKhKyvzmwY9DU2BOjSsGsXOX6GtfLu/808fS0W/zpPJJblkbbJ8jGHr7dvwb17CKTQ+N1IruTMcTYc3Ld/HXj5777Gz52UfDA+XQtf54SaHMSyERslbky0fHuZqA9QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502593; c=relaxed/simple;
	bh=HhvXSyQnnl4WiEDxRFY6BAIiSCUL5vDMujoCA6Trt4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz0Kxdz+ILY0r4Czi5krAC8GCDhE1Touml2pykyv0J+wrLz1qFtysQQ5YRH3vs8ljYPJiYJtveHnkEN6rzBk/XeP5XZUfbvPdgnRBG97c4Ucb5E07IB6eWBbUZ3euubb9RhWf5cQkJq1hXg4nIgnFSR/JrAG4ddtOkc78QSa+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gxtJ2S5M; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so209242539f.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737502591; x=1738107391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKYuTz02mZcX3ZiwZL/mjlr1FVSouf1GajqEHj4wUMc=;
        b=gxtJ2S5MplDopqkfsLmU1FMkbg+1+wTebY1wZd3eWNfx8HpM3P3fbwqoejSDg39Dmx
         yFWSA4DGIQKbhPG1yJpwkQiKU/91+cDQo13tFEoB8ednHQKKhHiWBZp/QpQ3FAuMhMWh
         eIGg2N8d7Oc1NBJRzdzItz3QOftc3n+BegG/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502591; x=1738107391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKYuTz02mZcX3ZiwZL/mjlr1FVSouf1GajqEHj4wUMc=;
        b=PHguYJ+MQDTiqzkLDpbujA4BmDLdv5VzcLOVBboqxRMGSyOZIMrB2cvrQZP5LuIjCg
         BaJ2sdyY6hbwZS8/QquoZSsqr6qIuGZk1cjoYTL41mA3KyXU6kzNhDjF3XEYHgRIPPFD
         IMePRhiis7Y6ic0z4PRIaQjV4BjRnzO1N3dXbLXphNv8gpfDtoROpEjAclZixnoYVDBa
         ymP3Omii7QeptjlJtL74sD08zZYJ6SukQyFttssx4RMBld4XX1EI/zpwMb0jfQrPfIJW
         P8HUP3vzZuY7VfbmtPAy3YH1PBiCL4KPfiVspKC6/tcM7Zo4K0eAOdPwrmCErvLyDGyY
         AcPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6/MEng5MV7Wwi3fKdsKpa8E6MGYadB8bBoRE1pRyxSpQmPIONTrSYT9SXxqKGhRh8EBGCuFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlWyvaba5lcM5g/kUXionlAQg7uUHbanqFzCMJRT4w9t2TD5m
	XXTX9h5MjF2H/WLJA07nndw+7sOvt5QOET9k0HNSq6ZqCPsCRRIJZg1UyQeuU6c=
X-Gm-Gg: ASbGnctOZ4H8SK5i3QG4OBAaBFaVD/35eNHJ/LzMw3IY0Bf168m/YeFRNH8Y8aeETb/
	X+qj/YyC2+lVNcrzkA0XPdILjKiaV1aBWMN8tqHN+Kkgu0UWRTYghB8/iUboiAt9jCvGYmWbpKV
	oa9avQxyJNNmhGpBG+drwK8BYx9YieIjeScP6jVyq6DvXuzWL66UF1l2/JVMsjunHsSoMBoDjXS
	eMZcEgXvVZgNpNtPg2Mb3eGF2Xgcip2VPgY8GsFFw9kxJbGqObhIUzy7C9KExRLsKzyJrhKJPYc
	IXWv
X-Google-Smtp-Source: AGHT+IFzvPyYt0vh1Cti1GCPTw6R6EXdCv+yO8aK7NAEMc1wHtbPbgG1byohmjfaCYMwuU4VZG3V3w==
X-Received: by 2002:a05:6602:6c11:b0:837:7f1a:40af with SMTP id ca18e2360f4ac-851b6522d65mr1374484739f.14.1737502590789;
        Tue, 21 Jan 2025 15:36:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-851b01f2e4asm341343539f.17.2025.01.21.15.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:36:30 -0800 (PST)
Message-ID: <2278a353-9f2e-4123-8e3b-4d3ce20395b3@linuxfoundation.org>
Date: Tue, 21 Jan 2025 16:36:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 10:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc1.gz
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

