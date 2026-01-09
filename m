Return-Path: <stable+bounces-207918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA83D0C688
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63330301103B
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79073033C5;
	Fri,  9 Jan 2026 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJppvqTJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABD2FF14D
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996369; cv=none; b=OnTqgMQzwLY8rsAx7X3i5cGFI4s8KOt+FbJppKeI9F31EWp4IWbtvTNMzY0B6fFxiRWDQuPzI0zlcXct63kFMEpWlxynDNRUJcyNPAXuhN+N0DUzuh9fcGaU8oXxlewJHMjcQAjVL2eT0xV8PK6FerVualSUjvAN4ZsfUzDJjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996369; c=relaxed/simple;
	bh=swwFGWg/jJM7yv0Xw7oHtYtyit1HnAscQ4AwHOR42rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TePYe4o0xiYnuBnIcRMP5/3pAJ4Yr6tunesImpAY9RXNSUzau/dl17rC+cl1xUDvw3cDuYcznhbIMyPEgKgtCMgCeKC48/zHD+A0Z1FSwMxwXIdJ/ZGPfqPXixHSwVSnfnr7/U2xt85M9Oqx6rukeFEZFHj1bgMnJb1f1Gpul6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJppvqTJ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f3a10dcbbso4035146c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996367; x=1768601167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agPABsKkhvuouLEAS2GQt5eEaQkhiWfnzTAz4qrEzlo=;
        b=hJppvqTJT4vB69PvONcFr0aTgxdZ56DUub+zCCAE0FwkV/bliuzhHFqkr9PY1OjcSa
         oekg3S6dsP1drEhFVFnNYpGiPL1cey+Qgh/kPm0Fhbsdr0NtYJj9EyQYK1NJXGYaJWDW
         Jmd08gzcY09rxqMlFlutUyijVs9jCBqV7VFCZm36oQZokKV8GAMbQcNlLhwIQAVf3KFh
         X2nC+3cj+mOd5tBXbNEhk0wQePO3w4JtXk4UZSrbeF+j/YAn1Wmi7YnCsvy/xy+fywwz
         LOBrou+/Gn5djVltbKSo2brXaA1c32MVnAw2MKdqIgjR8eWRz3h86sd/+8Dxg9fvcFy6
         ysYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996367; x=1768601167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agPABsKkhvuouLEAS2GQt5eEaQkhiWfnzTAz4qrEzlo=;
        b=Kr1UHQ59yv6Cr1dH6wXL6mouvX7MBXL+DRZIS6u2O41RxvlsuqxtmFkbD+rHMr7b1n
         MzbcF21n06QOqbqj8q0nNVIp6JxUzSmvZf9mnbbS64JRxDadKt6JFHTImE3al8LYgq7B
         //nsJffvOXXZDxDTFSr5npjFxmfSr4CN8PeToQpFN/7NI4/dkTTXch7jFLM14AMYrylH
         vCXXNdAiYSb88J9TZe1hPl5UGtRFSuYoaun7K6RvDwlWQpE2hK0cbL2chCuoggV5hpNv
         lJIg+S1xPe+/Fo+PASQa2TrC0boRGdyT5vP0TSU57mQ17vfvj2oEap8H6U3Lav/D9ZF/
         VoSg==
X-Forwarded-Encrypted: i=1; AJvYcCVMd7SDWSLQOTZnGroM9iQBj2UIGBAhbTwJ10ZlfFjqc9/CMkORAx2m7f2Dqw1tN6070FvRbr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzPs7Wqx4uBiw2t0WZ2AQZU8/n7n073up6C9kU8U9xMJqpfug
	sCxJqwkhwcJJgVMEyNlN39LSRcOoy2ez5D6GPH6uQd7YX9TDD0fl4FBq
X-Gm-Gg: AY/fxX5JUDGM9SMLogtvseR1j+JEMjBiJbSlwOPEbEsKCkAUjT4huE6Znq8xntwQiuK
	RES+75QXpWn8Otx6IKlf6ibFg+DrH/jN3+shPqkk2E2JquiCTdK/q3xB7I4gv7bwDJHgNajvx4F
	U11RAnAbRETDx7SHNmBLSyCwV1/7/NiNHu4FaGFrSi4xvQIXBM0G/vEVr8BcIb2fWqsvN63lobr
	IGxyKUuB9afYXn50XNILW+UA3W7/i1nXMb31ACdbeV9yI90TLX8jCNNYmspPfLLr22CXEQ1wS5G
	KHbdNen0Riddinay8Mp6XhJRCvaSNYpvBy17ukFKYgXFrsjewAYdnOf7vUWxPZKgVt2LkbpVZ8O
	PvL9J1mRCbMKu0DBHjrcvCoF7c1mQTajYw1nuWgZ0QDtMpp3ZjGLufqTRPsyK4UVDxzG63HnjR8
	+bPDJYNixhN6dHCeikVGVpkwlW55eggOFVMp5Img==
X-Google-Smtp-Source: AGHT+IFpDvZmcjnb0/gblc368UV09XDLk6L/2cdvvznpi5MwFjdKdvzlHIWKhVg4BUbXE9DXSL3Zvw==
X-Received: by 2002:a05:7022:6096:b0:122:415:25ed with SMTP id a92af1059eb24-1220415265amr5206420c88.49.1767996367271;
        Fri, 09 Jan 2026 14:06:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c16fsm18561401c88.10.2026.01.09.14.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 14:06:06 -0800 (PST)
Message-ID: <adb5cdc3-0a24-497a-b506-266120355e42@gmail.com>
Date: Fri, 9 Jan 2026 14:06:04 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260109111950.344681501@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 03:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

