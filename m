Return-Path: <stable+bounces-160126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C1AF8326
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517ED1894B1E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9912BEC3A;
	Thu,  3 Jul 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baYYdORJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC2DE6EE
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580838; cv=none; b=ISJeSyuNO4IejOrRrM9kvAIfCfmME8fhk43d4MnAswj4KJ85Q4VGqpdMGBdM1RnqQ0FKxxKfHHXBPjSJPh3rPbmliTNLMeRgCDrEQe9zXSIHvGqkUwFOe4t0f5Ku4YIYj/8ctlE3n+nL+GngEPbJRdLl3dDu+ObLd5UxF0TGcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580838; c=relaxed/simple;
	bh=XBUgrUQQS2IqwX0+wTG19jVJ5Ci3HRHkOkCqjlNfFLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOwDDSVOD1nJY1MEy5A6ZRHgYV80epL+KA/CzfDYWf8Nw1FXb8Vjpg5aBE7KOQYd8Saep8Q6u/S/Prx7g5zJAeBrsO9BVHtbX5KSSM9AwW31kIGW3qKiD0R0KYmV5tIuVvMdE1jrmtDR+acQqQhCuYm7Gaxu/B9DXLePBwa9lO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=baYYdORJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-875f28fde67so31869639f.1
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751580835; x=1752185635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unR9qVJeTgB9WSoA50q1O1NQAOhKvwtm6keiADO3aKE=;
        b=baYYdORJngNNUyYwVPZXf+oOOaWc5Xz5mkkVdzQvoIME03jNjtv/5TC3BFnAnlfmhu
         DhrocKQxbYuNP6M9ZTP3jpHMSu9B5f6p4XNCxxRxYF+T3NosrkPLxAcXOCZP3RrkWBmn
         JXEo53IxybllvZ8W7nyKphCgz4u5xo+WStur0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580835; x=1752185635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unR9qVJeTgB9WSoA50q1O1NQAOhKvwtm6keiADO3aKE=;
        b=pbOxmD3lnyvhivoRw+UB6VLQvjBCLcQAhB2dKD8Zli2DcDC/zCIoVeF2gLhBUxU1FN
         ZJKGHOmosj/t41FYm8D0n17QTvpgK8FL8KnXm7g/22RVsT0cUV6mciGc/UyeMHjBqIU0
         RkM0CHouQM5sP+14sS5pA1xQVWEXw0ItBOhvdb6JYSrtTZlilikiscg68/It8zHcguFh
         2XIX+bxQnDhdsaoae+DPD0g/extgeDSHzT0cX/mkIuHf17HesjmwPHSpG4v3EL3pGdRH
         W1/2uH3dMiJ67xYr50WBexDQZ8JfJJtxO1aZCJt2DGohoybBoOcvfhaxrxn2HVz98ExW
         DhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUibyQwBMGYrwc14z1wAt/0KrT2MuNbSfvMf0g1jHrED2vtBCEY2VolBPgmINIs+q7RIXQDEAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFq2x5qaMKIp8t8LORnTHwvYRzH04ye5pwSjbr5TAs+TJTbB8O
	Dm97eeCTuHdAYVpObhhdztIehqKLMn2OG6kJ2Nbs9I69vjfRDCEo6u00pWV/TGk4ue4=
X-Gm-Gg: ASbGncsgWGg7ESSnZaMlJHG3dKbSHVNlGtlix+yPB4mDOXaujYeeYAJIJxR4M139N4Z
	dN+A4zeWQzdgx/N5r65WB77xeSoigo/lvyq96LArd4CMlqVxXzEMbsoU9GBj7Q8Q63kkegVeB1f
	77q8eEQvVieFxkVoh8RDEJ4Cgy6lcMP4L4XZ+kUmfcFZhB0Nx7SAXeNkPPB01U4c0sr2OZFEGNs
	pFvzuOkemoozvqPcySSsjbpWcDaAa1mqIisYHrN/Z+qy48eG2RisQ6OR2wRoAiE0B+q5e2KnAlr
	740gL5u+RV7gtXToVADC4PyUZu8hfWhN6qySkuEzLPdGyX3NyNreucuj4UdQjzhdeOMbDqalZgH
	f5Zb0/Iqg
X-Google-Smtp-Source: AGHT+IFTLPGUsvktoYg6kHPD6nYNhc4LkDTbKKI3SWfHrM/XXrmfE9LouQSm0Mhp4hyUgtiuBB0RcQ==
X-Received: by 2002:a05:6e02:12c3:b0:3e0:4f66:3106 with SMTP id e9e14a558f8ab-3e13547ddf5mr2083225ab.2.1751580834710;
        Thu, 03 Jul 2025 15:13:54 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c7860sm152582173.39.2025.07.03.15.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 15:13:54 -0700 (PDT)
Message-ID: <55497fa2-f6f3-4c6a-9869-625e5edfd777@linuxfoundation.org>
Date: Thu, 3 Jul 2025 16:13:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 08:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

