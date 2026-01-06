Return-Path: <stable+bounces-206045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FECFB4D0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 23:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D9F301B2F6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAF2D46A2;
	Tue,  6 Jan 2026 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jv8OEh6B"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534B29C351
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740185; cv=none; b=ZaXK5ioXHpJJ6/XUqONVmeFVjIWfs71tBlGA6rydHH/KcfmTPhdeiNYLczsQpKYL/aWntDKjQfH8LUS2rKkZj6tYcR2NYkXCaUVz9y+R6zptJw5Cg/Scb+v8N6LDKAKRUBp+D7qagm/mFtLGXIy+dLb9bZ+ovBUBpieTO8iM/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740185; c=relaxed/simple;
	bh=A+XSURg7K9EwgUvytmexG4/kwwx+ACrDpqBOoY2K9QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXxJ/T2AqXpwlx4zcKPuqSrHXzPOrRSyO85QW2+YjQF/+5M7BghIV4WCP+TsvKeMyllFf+Ec02oack07/cHkmV9+PjOR2axcrMiHWL7G8CIbatQFU841OII3GZskSP8hRcpIb5G20FO8g74gXL64qnbsewWDmlrzcIdNfjiwY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jv8OEh6B; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3f584ab62c6so630953fac.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767740182; x=1768344982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlEgTGvQwC//J0kCOTtW9TufRYi3qibIbd/C3rGyaPU=;
        b=Jv8OEh6BH/j50hoej2fmiFmEOt1AR9yCRGEwOXEtXdqH40bnMX6suLSHhaclKHpzTY
         4sTawX/148EBkzmMKTkc3ol8sZdIP7lVbs81a8Vb44en62m9AgB5wJbmIzlszFwLln/w
         5TinHxuAI5gv7dfL7LGw+FMNQykfwnSKhgi+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767740182; x=1768344982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlEgTGvQwC//J0kCOTtW9TufRYi3qibIbd/C3rGyaPU=;
        b=DRvxSqUl9Y9klL/whgmpFwuzdgY38pAVhCs9TCt952BFwbxtYQSQiWS16RNxn7qLW9
         hJijFXvO9vSThdyOc24BLbWjttX1Ik7ZvtRlOFVYXsNTCTbUCaxEilAiHb+YXYrbl/R6
         YOUVCL9VApXfemIMGWzYGuOttST3/XYXKwXup0fOBCn2CDST/F0IoUmGz0nL1YHzUgG7
         8RUA0olAggwEZ9INczLr28akr0Jo1Y7cYoQ70lyMGXmzDYRJhhMZvJQ3ueRnY9RcQne+
         3z4AohnFWRGU2CcWN2XOIEQj9tRAaCeq4LktdcbT0rmiUUTjo6ZU7Dj3huf9WHVDP6OD
         0Mtw==
X-Forwarded-Encrypted: i=1; AJvYcCVTqeM4MxQ3+RhGS1dRY0edIVEiaNHyBM1ntus46ZIOpjEJPif1Hm3u6rVz38WvHTn+TdVCKEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7nSXTvySzG7Lxj+LYZnIY07TQVa/QT9iUJYv+rWMOpeHeto4
	R/gfTHNYxyFOMbTjw/vCz3SFfa5uZjHy4tkl6GFKmJ2CdOAMt1+7RYXD7erVFX/hXpuM0lKkusx
	ZoL0G
X-Gm-Gg: AY/fxX6oKDkcNelWjfw/eVOrZujikOn3wbP3HYajFHjV/bE0gQhIJjJRp1Xa8c8DQZo
	Np5d3++ePR3LB1XLuL6wCymTbd6gve74q8jKYmCOTClTz/axwxTIexNeBfNtu3UbG+OGe8VpGmM
	XRInNA/sEdh4IKEY7JwUrtqGA9Fm/7OcP8U2+CrG4MA+7WxPGONfXLLa1NvrtUXLEnnFaVN16f9
	JJ2wTGTKlIU4nO+gjGU5x975jRHf44muyHlIm8OL2CgNTfgTaaP18GEcQ/YiO+09FtZLOh/Ut6j
	imBO2M2sFnE1ISXSyIhl7Fg644ApIhO+gwBiEgE5d2Zg8wckonvGDPQbWxbzX/iiO69S/CHXQO4
	1Kk9CnRrfBKHaM8Xvud1D1iKZJenoFL5AKlHTrFtCXlSX2fCbc6lDAnjczzAIytuqHHoGjx3thW
	GpOfaO/jbQyKiIpAegk3sMkFw=
X-Google-Smtp-Source: AGHT+IFAuV1BxuoZwVQSFSBXE5zpDFi9jBI42cEVmFxkFCru49vqQ7tHYN9dkhTgJRw8CjbAd0tKDQ==
X-Received: by 2002:a05:6871:739c:b0:3f1:664f:e8db with SMTP id 586e51a60fabf-3ffc09fa492mr292992fac.23.1767740182243;
        Tue, 06 Jan 2026 14:56:22 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50ecb58sm2056089fac.18.2026.01.06.14.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 14:56:21 -0800 (PST)
Message-ID: <51c18a00-2ac6-46b0-be9b-b7b1587a382b@linuxfoundation.org>
Date: Tue, 6 Jan 2026 15:56:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 09:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.64 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Jan 2026 17:03:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

