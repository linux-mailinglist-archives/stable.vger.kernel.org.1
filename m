Return-Path: <stable+bounces-199948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A8CA202C
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 01:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F033012767
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D04262A6;
	Thu,  4 Dec 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWmYB3Rt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F4A59
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806522; cv=none; b=SkjFeH3oFRvLqJz5ySnaBqAxNoEocilXVrA+viDaLkW21ztDGL4nsh9X6Nw/ctwDs5UeZIebg6nSuxDCgQXTABY/G7Fz++14CxBupRcwcT15bK6uyrdbCrNzwgz6g7PTAuvs7YzS74FP+siaBG6+w8e10VDyia8k9pAq55JcGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806522; c=relaxed/simple;
	bh=4HzK1tEhZsn0c0/oMdz/HjjRrkW0O+hCcJ/HG8vLpLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP0guxAmoZLPIt+wpYJ01xFzE9P+JWN7JIjAEGu8SaxFcccQ4HLp+UbMGChVtJuiZAi5Nj+qxjAse5yif1zlMnHSkQFr7Jh508bhJ1x1OEqv7xZQlHc08c7bblErY5/nZYAZfx6aWT/K5lWUYcHF+JAoRxR17k5vyTopgcVI25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWmYB3Rt; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c7533dbd87so317141a34.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764806518; x=1765411318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4wjFyRQZt8QFoZmh2FwKlf9iqvXN/3aCEOnfVe5wtU=;
        b=CWmYB3RtPZ22GM+bxX8ftL/u4xWfdEXenpvmX/LP+yHbb8ZxIjYAsW+NCqkD8IVnva
         iht8gaK9ZEwfz9ii7K8BBZa2XZFExrcc5+/wEMX6iZJv5c3L6I422Kz0eISMqjmYV1e2
         8f55W6e1tgiyOurDECrIUmKygCBeJnkwFInqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764806518; x=1765411318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4wjFyRQZt8QFoZmh2FwKlf9iqvXN/3aCEOnfVe5wtU=;
        b=If4plgZxTaHdBt7boejOhysM+O9Ox5+QrdItrzmX8hGXqmb2qB5l53W9Ikmnq75hCW
         dO259P3Z9m1YA+euzhwOF789OPql3yJUXfScuOUvWEeSsEv89EZuYfS0botIlFmePnbn
         SsHy2ec3puOKe7SyxTTD/pOK86nOFasUL+8Gfv1LNWM7UGroSvBbMSSS1epaCIW9SVqN
         1rUgmblVJPJ2dAdWprbxc+RsDCx8bThmT8KvFZ90+em+qAFV+rTS0kNfYW7W5Pvq6ujP
         hUg3mey0eM8NbSbHFiex3jW52nJEdv6iWWg0A2FD/1TPROv7Wkkq2AknAeq07gOzlen/
         UWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7u0G+wfI+7U9Rwnt6x7ob+mQp9WqWQaT3tYb/lHb2dTtaVZBW180OUO+GJfniWsPb45W+iNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3mL14yFbUerwsC2aqfz271/VAEzME7si4t9hgxloSbFGGdlX
	/1twIqQ0/92r7ReceQC9+jEIEmpcl5x+udC9t8gNM8SERGsSRrDrnwdy0ztkhOxKl3rCQoEehS+
	Da8CR
X-Gm-Gg: ASbGncvmrhRxjHfGMpk5G9QxZJSJhmhAqzT+gW3jE+9y+arMeD2IcNog1Y8Y+0La6OP
	oCgeP9d//AA1wGmeHK4bJy3SKyGRP67OV6l4IU1ydy6tLcR+wzeeY91ZrVF3JGCSc4UC7bO/R3E
	cNphSPgB9NEe7IHJOCIzuiYLWb+Vj/3kpXYZE3zPjDIHMbO9PKyMyVP1h8KWEsxkMNXkUHMMV8J
	EAvqilHuuZXD4m2zxnmiFUndFLFjB20NRWBUaggX5hJUy4ucPrtjqBleqcPHmeZBNs9OMmL9yy3
	A0XVY8SNENH0IOu6X/x0a13kTBPjkNwYNOddgp9JjOLtfOa1e+MBZmWi0Zg+cvXDLaLJf2JShp4
	Rxb67rvYrRxoCGhp+E5q7YSI1jsT+FxGJhFdfHmZVws0EHM7TaTqLa6tQHFlMQeAqS3hyYidOwo
	HXN94N8F8UvAueTrkne543sHQ=
X-Google-Smtp-Source: AGHT+IH6vr9clJI8w5eLykliAGikx/axa/VzdZW+lrxRAlKePDaQJH4HcjPYYKu9xeRqNvaoDTI0Zw==
X-Received: by 2002:a05:6830:925:b0:7c6:e92f:41cd with SMTP id 46e09a7af769-7c958c046ecmr518241a34.32.1764806518352;
        Wed, 03 Dec 2025 16:01:58 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac833d3sm175655a34.17.2025.12.03.16.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 16:01:57 -0800 (PST)
Message-ID: <3093ee45-505d-4c13-a013-8a83b3b38564@linuxfoundation.org>
Date: Wed, 3 Dec 2025 17:01:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/392] 5.15.197-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.197 release.
> There are 392 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.197-rc1.gz
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

