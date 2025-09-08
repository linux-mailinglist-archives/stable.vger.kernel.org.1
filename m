Return-Path: <stable+bounces-178942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4E9B49687
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9CB1B28167
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D53101DC;
	Mon,  8 Sep 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU9iTOux"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF18311955;
	Mon,  8 Sep 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351322; cv=none; b=LTJrn9MBFitKDi0oB7Ec59ll9PeP+PlaEopDTVFQZBDnV0l3lcBIwygkqx8DLj0WYT5eEvNqLBAdKkYpmmrW2uI54pq32t6livDr2JRDM8G7kX5cZ+IyrwEhWGe9TPRFTJDsNo/vPrFoRmqzE+mw4JoQa4TP71oJ7wqJZrmjNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351322; c=relaxed/simple;
	bh=5uEwekRG++n/6vCGt6uFdqpmna1MvLd5M34wYF5OZZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN1+A/BQ6tcuT+dO2P6drOKXzbBptukEKVErrTPLQugDC3ZyE8FmwwmhjDGSFwAFYIeQ8rk9cK7Cl8XKaEKnqBUW9Z2GPumQ2MYjj81BuuxoNQB+9sI+vsWBH6Di0F7593YpezFDGWemnO50XEEkM7LyhbRTjK3ghewh9PuET1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU9iTOux; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-722d5d8fa11so40885986d6.3;
        Mon, 08 Sep 2025 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757351320; x=1757956120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3Zy5ZLPWLQUGIyWV4EuJmfZiDxNFY0iZHySMK1mWhU=;
        b=XU9iTOuxm34iw32sWsJSqIwPMSr1fcXWFZBEPC7AkZnS9STaN9aawD5Fl9YaSylWM5
         EV1W71wqYBKKk+npxLG9bB9C5g6b4BriSGXBCNUCWJCB4ucLsf4ZrPpkOTLCjBQe65dH
         4vGvpKheKjMYogdgJ48jGhy88R0weoWKqHexDvd1WZv5/pJo6OiqS0eCcTNyDW4wovZa
         Tss0Ry+dHlAUv8YyOIzRwVZMcJTe9Oox4uWHj4/pIBjrEFGx8AqjD+f7GaVjoI/27w01
         9+6QmzMMtNuY0rQVODv/Z0uEBIEe4VfT85dlMzJJI+G05u/EYS+l/jvcc0p1D0UuImZG
         oYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351320; x=1757956120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Zy5ZLPWLQUGIyWV4EuJmfZiDxNFY0iZHySMK1mWhU=;
        b=e0r/0yzX2/SpdIz5oOGeBoqmwZYIqloH8HfnVmdVCR9IGsRu8Dj/Elz8Ajxn84cUEP
         cduM04qCwsd0q4lRFS7WUt6wztne2P3hU0qIyGgIKaeCMiSKFg5vahmk/RLsMq983JPo
         nKj7mOguNDWVWUPxOKU3JcIJhnJUlmH+A/7SH5sELgD3bvW/Lu/8Y2COkadbT+e/hAi3
         5FExWL83w1RGj7a2x5VNKzkNnV+dUVKZA4M7wgShyatdJAOYzOhFTUbLs2gYX+RNEad4
         i4bysv8gPoxufBxuLWHV+6zljRWf/4oiOspyGT8dqNYAR9vNxeUwZOAQu64QlgJ56Bpj
         jY9g==
X-Forwarded-Encrypted: i=1; AJvYcCUPv3J+0RQcB+NoOvG5ms11+Tw3SUes2C5aqUFBGHsZZZJBwZZwOk6S7bDwsPa9m+4f/HkameOSGzbVbLc=@vger.kernel.org, AJvYcCVDlXTFvDfcrWoW33swjd5jF2U9SrbxTubHrLagzy1D+F8JJ9WOEJh9P7Tip0VBwKDPI1oudSOT@vger.kernel.org
X-Gm-Message-State: AOJu0YziMklEyGjgDy/C04zOMRMJ2lrLuwJjcVgfIuzObhCF5gF1H6Sd
	Iwh84chuL3Uqn3YST4vw0QYsozevK/ERQHwNiIxBfm25S6Vc/XjGjcdr
X-Gm-Gg: ASbGncvraEQ40D9nDiaDWJogOvydmeFmd7o4iR2yDZBnyXadK93ifWg+cLSll4mXnDM
	B3zcOa6ITK36yuirE4J6AWh5VdlU1Qjw/+26i6p3FWEHaUWchqXPiOiJz8Q2RR13DpO41ML6BRK
	v6cioSsIYoRWqiLOkSDQc4K5RD/vfhwM7dEI2eMLPGbcL3SopZH/+9/puIWNV1qporq9dv9+OCg
	xBjWf1kJ51eD7oz6XVPgsqPy7pUaVNjKvAGeGJXYZI9k/m6HW9LBTwGZX1VJcV4OMq1z+oZ4+8F
	+AQuIh7udJzdqN1vuBqpRkoKzoj4pvgXjG/ryhDhRkwYf/YtIqcdg5lR7JaXVUgM4TW/sLuiMk3
	Q2spXzX+sM5ZVUPU2QMZkLKPtDfKxXKgNNhQnLmKhlXtd8Bp9iA==
X-Google-Smtp-Source: AGHT+IEnXVBd0xs6cD+F1po+Y/d93OYhtTZGeGOxk2tKmlczXokge3VIN6LGtun67OfAUYmfyviP7A==
X-Received: by 2002:a05:6214:e88:b0:755:33b:93b1 with SMTP id 6a1803df08f44-755033b9a19mr1206476d6.43.1757351317260;
        Mon, 08 Sep 2025 10:08:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b46660fbsm130679766d6.44.2025.09.08.10.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:08:36 -0700 (PDT)
Message-ID: <3607db02-7fc8-4485-8728-608f74ae63e0@gmail.com>
Date: Mon, 8 Sep 2025 10:08:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.6 000/118] 6.6.105-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250908151836.822240062@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250908151836.822240062@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 09:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Sep 2025 15:18:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.105-rc2.gz
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

