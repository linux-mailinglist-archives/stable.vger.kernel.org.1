Return-Path: <stable+bounces-105091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2959F5C1C
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC8A1622DD
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFA35940;
	Wed, 18 Dec 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVx6ynQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7791F5E6
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484418; cv=none; b=liPWhkqG5UhJSqZwOawSMqY/Z4UODoSn9T19KWa3EyGEjRKIMmhamdMkVc7dbRuY72VqNqSzw0QJE0BYhH9eUHOHbD5yfV45M8XXknnsa9Uy+0xhSkrpKur2rhN6kPrYQ9tiTBxu1z//w/Y2dtmER/F/bLKvxIzSjr/+wXvnAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484418; c=relaxed/simple;
	bh=Jnq3a9Mp6GeYFmHNoKlGjPOJsiDdZuUS0Ph9aMtKgaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSd18l8+dkQGzYYCHz2c5J9jHqWGdG65obG/22pzcjwWETv1zeQiJJJ6a2+GCLU9XFIPBip/4Y1GpmYpy/7kfnhI/NR/dLc5N2rKbgB5quBBTzvaKf4gyZj+pWEOSuFY5CO+vNpYLYTa2eu/cuAO0Ja0tUNlzJUcqbwNVs2Jcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVx6ynQp; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ab37d98dd4so20348475ab.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734484415; x=1735089215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MIaWhOayCAGEBZ6/Srj8huJLJWFEvDsu1OwxMVgWrs=;
        b=NVx6ynQppzJsfbJf52qNrt4lumaNShvBerPr0LlePB/lwumlSvoPfHlintGK2Lf2aA
         44XJMLu8GqZHvItFXdtnMZBrE3fMTor1bWX/hDuRTX2drSQf53mWAQt/y7ji84yGyg2z
         M0e6x6N3gK1ZdceTBKCSKf8fvwGK0z1I1hTZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734484415; x=1735089215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MIaWhOayCAGEBZ6/Srj8huJLJWFEvDsu1OwxMVgWrs=;
        b=H8/tGuLoGml7JEIqmVHhIqKyvIYkOC/RTsKfFsTAhBWBMdovqYenHkDxcWZgwNcz5l
         VcfRdw671sceOWJvQ7r5QyNfGrKKqFZiBtEt2TY5Mw0WWe54V29A9GxW0tshfK8hiQHQ
         DKU1pMxhZXLQRhV5xcjwx1jckry9BcVPDytR+uNvO3l1Gl+K+QHXZCJgFsxTbo395v4w
         eU/h3/UF5d8FeyjLVge9X8NGxuxihWQ4mcQc0cNukhL57EJW47PfEOiSqrtkPoMm4/Oj
         vVattswHk16xNXFPwdW6/6nhuIevB8cmo7jyz8Z3Hz0NXg5snyw/6sDvMNtSIxAXLEQF
         59ew==
X-Forwarded-Encrypted: i=1; AJvYcCUR5sLeaJSW6IbrlaE5B0Y8WoF23gjE/7kQEkNSRctHdRKEfrABHrKeckPBdrWL78WmT5pp9iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnNJN4U6DDX5plNwtLsUL+JYUZKB6L4UNrxalX6Y8Csz+M9TN
	okSMesSf7LeRnsOXeh3G4jyJ6nwq27SOpQL0g9RTaME1JS0fgvcjrESJ+V2vW68=
X-Gm-Gg: ASbGncvNU+GiZFp5zWx0rF36NvclwUZ5mLG8/og+4pOMtI4gtOtfmnMRtSYywekjXxJ
	tIDAA5A6m57dJIVQfdTmtFY7CSnNcV1wUvHEuhw45WQDshy4Fte8gFZzQksHmv6AJPhOlnEXjQs
	ls3mQ8oMpx/pmjySY0SG3L2GSXdST1FhtElzHLhKAhuxVdjwwKyS6H2lZmARpLo0me5Ee5GaZ4k
	jp6SjP7GSPPaJUbD4FkYNdSZm2gbrmDIHaa72ovb+6LHP9afLnQzDUSewnjhrtQ0TyL
X-Google-Smtp-Source: AGHT+IH59hqk6TvgSTl61Yb2QfXa1njYv/W2AHnV+LeRa7Q4yZChXmIc5ifk/e6AYSjY1UulYcIPFA==
X-Received: by 2002:a05:6e02:1a46:b0:3a7:6c5c:9aa4 with SMTP id e9e14a558f8ab-3bdc174f0f1mr10768175ab.12.1734484415382;
        Tue, 17 Dec 2024 17:13:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475aef77sm24165525ab.2.2024.12.17.17.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:13:34 -0800 (PST)
Message-ID: <90302dde-38f0-4be7-991c-a464160d75c4@linuxfoundation.org>
Date: Tue, 17 Dec 2024 18:13:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/24] 5.4.288-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170519.006786596@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170519.006786596@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.288 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.288-rc1.gz
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

