Return-Path: <stable+bounces-45995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFA8CDB7A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0831F1C21D6E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CC84DFA;
	Thu, 23 May 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ16b9mq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F384DF4;
	Thu, 23 May 2024 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496773; cv=none; b=A28JI8VIB3z7RdJF87qhyhf3mphW2Q5KsvS/5oUyJsym4rEIBRhVuZclh9roXqj9E7ctFuRY0R7iitw2rMROm/4dNEQdfqACpBQYPMTEyI0nyegaZEJUNntcg5/hZZi3aDUoM/oItIDgB6ngMnlrLUL+XD9TtwVhO+5WkRNFCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496773; c=relaxed/simple;
	bh=mgn9h28+Vwf/nN4w7oj/4mZLrW6UjJJC0ePuhv5zS0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdNQpq5eoMaRFcUlxzcmvOGQd6p36FRo0na06skdUhofSYXcQHe9jyVS4/KSvB7w4/aEh9LyxUS/X0ve5irh30YfZnjLoo9zmnBucE8hX7LxIjIVb9GXsbcZDFnqnO/4tZq2x6yDlsCqBXxm3qGIreBNgi0/JrAuAAnCVAXtwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ16b9mq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bded353d17so756132a91.0;
        Thu, 23 May 2024 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716496771; x=1717101571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2zukG9AHwYGlaUsr6ubbjF9W1PHQWW61Xya5qRT0JU=;
        b=FJ16b9mquC2QxmWZSSk2o88q9ol+1g3OapuwpYTHWCoUHrQN+oXWTom2Vvbdu1zaFK
         1VTat/vUfSle3gMbD4YzATy9GjM07L4N2Dduup/XTD1zk53re4iPf1Q7ohxOYPYUFG2Z
         mSewp6p6xDWQNioVJndcMEGU9IqevLAbQqqlo2EyqMzxrheELsr8suOeNhQ7qsrjSW0B
         RAEcNTNlfOQbRSW7ZWYgVhjBveeQTBKUtReC0N3si082NBR/SWLb9H4kBS2hqKr/aTDK
         BaxmyMUfQP+8Xs1iqyA0nwXrY8FD+RMBVG0F3Wru7lmFcKD+Db97bJkm4aXmUcXQ7YBL
         bAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496771; x=1717101571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2zukG9AHwYGlaUsr6ubbjF9W1PHQWW61Xya5qRT0JU=;
        b=nH5dLkxUSRJbxO3CepxIHXNZeO3J0+RZ+1ilcivrEy4+o35VoPayRwV02CQvlvCSjx
         zs8igLT7R5tC9WoZGbuBvonIcS9hrisoD/SnQbeUchOTnz6h+SkF9M7L23JySAaqr+su
         Lxm8NLvl5KYnyyXMLvyWYmACyGj1YEMyFauZ/MWlnPhVMj253z8hXs01kgijscnzLts7
         WbshEKDsRfO1VyqF4A+1ys+WeasFy51WTO37zsROPFnS9KfeUZ7S1hW6dYQeRyrXzBFL
         3JoJr1043dp1f1lGaB13VVda1eElc2+krembtlaovpp6VdTiwCZoKBq2hgstY7dEKnHu
         1+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dHneRu8S/bwov8N3IenXQ4mTLqfuM8K7MsaqkX+pQi3gJTwnJCkr5YazLHh1XGJjXyWWVoVdX1lx3r+obGLmZpO5668odd3T+8YfB8INyPrS0Q7UKuZjsL6+vznkh11k99JC
X-Gm-Message-State: AOJu0Yx/hDoccSFAyH7j/LaIUY+0lKU81GY7zwUJ/ZjeVF4vqa8XWJQ2
	r5hJAvfl5A2vcXP7w09QebZs1U5/ckNklVPpAiXxIiYUJdy14L01
X-Google-Smtp-Source: AGHT+IEQGxnRZXZ0Qz9mZFnPzonGw8RgyMWgzKQck1ITAFDNLFtt2hC/kadqF+cH5aMwhgtwtMCbqA==
X-Received: by 2002:a17:90a:d801:b0:2bd:d2f9:c22a with SMTP id 98e67ed59e1d1-2bf5e660254mr289152a91.29.1716496771389;
        Thu, 23 May 2024 13:39:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bd9cf52fc2sm2315494a91.0.2024.05.23.13.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:39:30 -0700 (PDT)
Message-ID: <7009aac4-2187-4c21-8272-ca9074edc4ab@gmail.com>
Date: Thu, 23 May 2024 13:39:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/102] 6.6.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130342.462912131@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.32 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.32-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


