Return-Path: <stable+bounces-47600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B88D2749
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC28D1C249B6
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397971738;
	Tue, 28 May 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yx3NRZrn"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED211DA23
	for <stable@vger.kernel.org>; Tue, 28 May 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933241; cv=none; b=C9wMoMB6Z2leureC2HjzunYHB+4rFVJ7yjiTgHzI+KGrOlkUgDRpuiuIAfbxfBseRzKvW9CTNXqERD9x5iTOegmEHC2d7XVTyCSmkuxsX8mNlz7fTvGollUfCdLNgtK5ArQ1A8xZlDfKzJD1EPoK6i9F5adZDpX0Nw6QEVNKgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933241; c=relaxed/simple;
	bh=1qdczpPOuQX42ByroNXbNe+HO1MN3jMHmqL4n2GjsDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsmgp/GrVV/zHQCvm/4V7M+lj0SoKW7FwrXLIdp3ysF0q9Id8qB0unbq0IzLOxoeD02u30aT9cSP8KJf3qV940MhwsnB9+5+jq5M0aSMu663XcyZ9gDwZXkP4xkSEORwpflcPrNlmXX5Qoaud08pOT/JRi0RxDDORGuTmcpPeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yx3NRZrn; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7ea12d448ffso5075739f.1
        for <stable@vger.kernel.org>; Tue, 28 May 2024 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716933239; x=1717538039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfACfrliUC8RvUZvSpo29lWjHhmcZI934D2GcMw4Ck8=;
        b=Yx3NRZrn3afLgMuuBcgk4TLZNPjCq1y9nv40s95NbtyuA4YGtk0Ee0cwtCbL+9u9H8
         ealRkosxrP7E5P+XUB7u1qRvQ5bjCkHdN8F9capjA7+tr2kbAI4Z4yPBL/1J19h5H/KK
         QBklkEcw5FfudxW18uGiPZ3fS1cjvLxfuqzRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933239; x=1717538039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfACfrliUC8RvUZvSpo29lWjHhmcZI934D2GcMw4Ck8=;
        b=NbhfMyeZrk8sgLqaYZhHmQew5YyecpmK4hPOH57stQ87yik4pP8MN8tMZZrk6NGffq
         RYZlVfQc73f9D2oskxQjLTYiV6EaTshplchGHFcZyU+NohnZeDmTbMG5s/uvFFBTYQPF
         YvcAcanQeDNcEN6kg9qpX418TomFdjZrZXvz946p3lKS4M34AbK1LXlRpMIfd6JGNjd3
         ls9OxM7q+pPM+jCd9I4mrftZeq5ocx67gJ+jPt2FXnSn5sUBLj4ZZPE5NTW1JKfdpoUX
         fCGvWJmV0a5+rnVMI4nG52GDrQ7ZVbFQp/qzAGcuqilKOQXYFrcZi77e/K04SNqmOjrP
         m//A==
X-Forwarded-Encrypted: i=1; AJvYcCV4lMUB5Iv5RRBe6wE8Z7m5UkizLMkOytqzakz0ZfbYggAuyEpoj9dlAt3dlN/wJWQUI4mX9tapt3no9rOScMCZFe9x5xeu
X-Gm-Message-State: AOJu0YwFjuZIGtOGbCm+LwJwdQ2tSmDCOEWXYLrOMKQ7AsKbbsY3t77m
	GOpdkJcx23r4I29sbuknvLtbegHnwiI2ltFfJzP0VZ2GdjBmf3PwJd9dbnmBT5Q=
X-Google-Smtp-Source: AGHT+IGlp+f9XTmGdfRN8ZCb2asH0wxF0ge73+1BXthKHmMYyHK/ofz+zklI+icES/RDoyHkhVbhgA==
X-Received: by 2002:a6b:ee11:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7e8c5f86536mr1456721639f.1.1716933238758;
        Tue, 28 May 2024 14:53:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0f70c8acesm611762173.84.2024.05.28.14.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:53:58 -0700 (PDT)
Message-ID: <073f7048-5c3c-4581-a6ef-2e46f7d35ade@linuxfoundation.org>
Date: Tue, 28 May 2024 15:53:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 12:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 May 2024 18:53:22 +0000.
> Anything received after that time might be too late.
> 

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.12-rc1.gz
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

