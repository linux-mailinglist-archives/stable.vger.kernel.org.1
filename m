Return-Path: <stable+bounces-110081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A32A18866
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7733F3A46D6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189621F1515;
	Tue, 21 Jan 2025 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fFlty3Pa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F963199223
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502515; cv=none; b=HWJImyYxiBrhqt/AAO9trTitmZ/FD4SSGslIqztHZNaLKUbnBUk87tWd1YI6dmSjO5SgCO7vRKCtPnpE30broL3vLvJvm984971agiwzvFKap0qHcwWJtYuyZWXB2SKsQm4lkyh47S5pAf1NP5nQuyqgeZVWVnaMvKqTuLa23eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502515; c=relaxed/simple;
	bh=osMtyxK+pHAgjvID7ctuHvlkEQeRdUCptYQ5IZsw8pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrX3+lxuPoC8wNDU1r3+xl4eymZ8lvUg97Vuzb561EdsVsZrxro8oB5aRTGFzPhyBNwKcF7fQ+hNCwkEplryawMryPhSlhfC1PgWdvQbtJmX9w+w6GXFzb4S7cojVs3n1mwXd1DkkjSsODuAKJLH0BK/FTXhJgpWwOOqeaXYuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fFlty3Pa; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-84cdb6fba9bso516080339f.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737502513; x=1738107313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3wuJFte7c2tUcICxO5JAQgnHYLJwxx9ozuRq150yvE=;
        b=fFlty3PaPIlk7D+7J+JTdlJ25itH16CYsH9VofttZyu1WUrrphJnybveliFCoyaQAZ
         claAkqN1pkbPyDwLfPnMEP7huBVgbSDsRVYm/FmaSQk/8i/Ue4/Ggn/X8WSumj+TYIg6
         HuwQtMUCKY7DbZn3gDZXHQIi1OaW2aehNiYTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502513; x=1738107313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3wuJFte7c2tUcICxO5JAQgnHYLJwxx9ozuRq150yvE=;
        b=vgafcY/+OPdvqv2AQbDxWGyotrKosbvIMVW+BjPI2i0f7AIO1Y4/J7VZtz7DzrUqPs
         rKbMdY7Nk9pQAgNTedANmllAb3xccbvNdn3YCAOoZwDTopRKswPN3dqEqlGAhcxp6hIT
         vGKBxooT3hvylAY31r0Viatx/KzmrjwA7v7h7UzaGM27K9fJ/ctVSV+JD0dxJDo6vJY+
         czRTygiKi6IFhuR8C1Y29Op5GBI3+WUccAptylvD7Jcz8kpxybmUPAObBdLs/aJ+TLm5
         4YLKcNGtR2xLSIpUewjuzbUdJEi9PlJkyJeOq1oE3vqHLIaKwoPQKQfQi5+Tuh/dtJlw
         qnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxR613tT9dlBawTO71kQPIOgDlQbB/Blj2bT4VvxGgYIYMRaBOaCIlzGo6j0V5s/v+Ztcaw7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnRZCFkaJc/T6XxLegcrl4dasv3daBKyNx6j71iWItyUulOMN
	r3WtbmeLgaQZxPBccmy6E6rfHGsPRAejbAW2lmi68MdjJCURtD65LtirxQrfl/s=
X-Gm-Gg: ASbGncvW0ni6QJ+EgGmB52/001o25Kvngwfp+fSdVAZ0JhddRzO9CSeuG1PSEqEH+r1
	Ihlfn5oJCwRx7yoVkfCZAgglVLg7KSp7fKw8mi67pemiqYNuvJL3jyKxi/WEYWytoCTYarM8m3A
	cGWiZfGs33//teMlzZB6eL08Jw1u0hV990N71ZCELFxgk6MG/isijwAJeiJK1ybedHOAgkuZBBW
	TwtkdEcx46rbpzT8ojQ37I7hNFknN1nNC5kcn1XK+wQapXr7Z6SirWB4C+N0+lAsOg29LDVSfE+
	xQrc
X-Google-Smtp-Source: AGHT+IGe2UVE/0NZQzMBI5Zp4gYxSfpmsBRAXWWGudzI5TLbxjl/l0uX+pqaRBMD/NIFK0z55TSc6g==
X-Received: by 2002:a05:6e02:18cc:b0:3ce:403a:8be6 with SMTP id e9e14a558f8ab-3cf744be806mr170891115ab.20.1737502513243;
        Tue, 21 Jan 2025 15:35:13 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea756493d7sm3596819173.85.2025.01.21.15.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:35:12 -0800 (PST)
Message-ID: <812623dc-491d-4a19-85b9-0f70605c31f9@linuxfoundation.org>
Date: Tue, 21 Jan 2025 16:35:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250121174523.429119852@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 10:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.74-rc1.gz
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

