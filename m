Return-Path: <stable+bounces-169294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE8B23AB4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0682681273
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567712D7383;
	Tue, 12 Aug 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k35LF33q"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84A2F067A;
	Tue, 12 Aug 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034161; cv=none; b=Ivd4AkQ0KeKXRDpjycTN32t1b2D7JYOkELml/reowM86tipPRbbZxute10a3t66jeRX+91/0BSB+JmCoTvIbIYdUrLKShyUp4dWGeNmjXkSbw1d9tISlZNLip/QwJcd+kcH4IxOUx0BoBmwtwBrKhnZJa6f3ZQEzjLrqF18bux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034161; c=relaxed/simple;
	bh=eGqZCroda2wJopOF3l+REjl4tR5Yq9+2gAley7tEEew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipv3OdC166EhujEBta0etoSs8vaEADPLc9J0oaMA2YE4NOYNUycAjuDQCP2cxA0biyyaaPBOwhYeybXsbeP7zzaBxvijLNLA3fjaWkHXQE9aykGLYkGL8IWG4bEodtIr+CbDtbriTit3CcNZbj60mPsxZBir69aZLIb2XBWDsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k35LF33q; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-433f1cc2719so3933829b6e.1;
        Tue, 12 Aug 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755034159; x=1755638959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLeohoAGJ+hVylKDxkihOkXHb1E9F0dH5sp5SD+x3pc=;
        b=k35LF33qQU1t2VktkrQb+UOc4wU5mqvglxKcnUxM6eU8pBOiY0dQlfvgzoySy/0zrO
         xTVouWq2++I/6E8wk3CjHrn82IUYanuhLEO61azPNi+vvDc74DBkn6Of59UljDeaKXrY
         CjtwRcDxlLykahh8SIZ7JmrvaFhR7wTdXB7txighdnkfT5qc00Lx0H8r7eUQUaLmpqeu
         Guw0maEvE/IcJU2pT9DHsO4kKnQoq04IiIggwJo2eY/3XLH5lnfKvaXZl0p7G1RwDRu9
         hKfTiHNzm7jfJ/eqg00LQFu+yU/d6xxF9zVIhc8rMjLv/xOlqxoqwJXTV1HUWjowmIUH
         pAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755034159; x=1755638959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLeohoAGJ+hVylKDxkihOkXHb1E9F0dH5sp5SD+x3pc=;
        b=MI+A3cp/DElJSyzQDV9a+ehW1IuxVQTEyHjGClmfeeSPUz6nSEjYTnFRV5wNsSZmms
         C3H8bthHJbxlUBA5GweO67HI5MsdyKySM5TKcDjlKjCDWO8Q/FGCcmSgI6OmFZC9iQEi
         WY++TelO2SXSoFk4a2dAAIYCOXeCOZiDP+/Vx9HvT19JPHMd4PVZtzy23iXL0cfqRHM3
         WtDMjFI2vz8GkVqp6FE+SHglGe7obEvYyFIQ1PkzDY05HQjXSkATohn9ikPKYEW5HMkr
         13gyknIYlbwrtyFl5qKIBzFNBHmxRTDix/H1/aGVSRnw/AFZQYjtk9H0VWGLL/WzZIHN
         KfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa2af4elsqaPOiXclaw7lE2e+rbaB1LNStgAYjD/X0KSrjyF/tkPIA5UtCwanlLkLpsQj6WQypAGBXquU=@vger.kernel.org, AJvYcCUpRx9KkNeVK1dQbVGXX2NK0AUhTRU4By6Oj3hI7+P9Tfrz9VDp9RASjfObgSnhZzUEtakq1Rmf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Vlk7BG6ToHBlx9qrEz/SmyyGbiilDzeXNqrjOg4GwtlCw2VC
	siiim/ZJr4Aby1v4GoupE1RhnhCFBcTG7ChbrFXRL3fW3kMgCjQHVR/dSSW7aNhY
X-Gm-Gg: ASbGncsRRcI1FhPBanPX1k9k4vTreUveVPJ5Alfyn4PdZC5NnTXMr2//CbUIIQhFp9b
	Z2VnCg5qq9WLWb9HHJP2jLj3kuTxGbdljUnKmGM9Bel/nV6mWVR1e1WWU+0SQ624DrgF1KNxU2F
	t7JaoaM6tDDJ8bv3cmGFa/h1w62TBN0F8MuYoVKMgrbqQNYMJKAZ9GrPhfHZizBe6VgrG8O3opb
	CshLUfzQ7qUkEk7dpYOkEJZ4I+1uZBSJ4yXX3mk46gPEp65vfM0bGJM/IyahBB2nbNCOhuFbJw8
	F1a0NT0GmxDtx4+ALSV2E02CVGhOccaf2DScEuViM8CvltmNCwjQ+Uc3QPWJU5gSZS/iicmIVnp
	BMlJE3I0W632UJA///iam92nhSVfQEGr/dmWW8DMGp1kEJO79VyH5qVM=
X-Google-Smtp-Source: AGHT+IGWVbUN21tmOA5DQIBW20HuNxcOZHa+8f5mkd53ppc4gWWw8N7yD+V3DBAFt9EaMmDWFFrpww==
X-Received: by 2002:a05:6808:1781:b0:420:81f1:32fb with SMTP id 5614622812f47-435d4275049mr530209b6e.38.1755034158685;
        Tue, 12 Aug 2025 14:29:18 -0700 (PDT)
Received: from [10.236.102.133] ([108.147.189.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce85683dsm365938b6e.20.2025.08.12.14.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 14:29:17 -0700 (PDT)
Message-ID: <f86afb24-a328-4b20-ad4c-e8f5b56eeb24@gmail.com>
Date: Tue, 12 Aug 2025 14:29:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250812172952.959106058@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 10:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.102-rc1.gz
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


