Return-Path: <stable+bounces-144553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFEAB9048
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 21:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBA45045E2
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4FC269B07;
	Thu, 15 May 2025 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="By8bjPon"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAF1F3FE3;
	Thu, 15 May 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339057; cv=none; b=cI57ZwFlTpk+kV2INL8F+AtBMwsp+/YuBomRP6m7a/Y9cX+tnv/VpuSA+Iuc8x49qmh5QcyPxqJ2h2yr6at2/F/IP8snjPjBWXPp6M4/gX75igfoy6yMb5mwVhQI0RlMktHra9szed4GtsLGgdC+BRaHQJDbEc+2KpNOArwSFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339057; c=relaxed/simple;
	bh=Xxp3Hf8tEb7NVyAn0wC6H1zxrTjRWn4dy59yYUgAG7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j99074zmVcmn/ih1mdymUnNsiGyUgbPMzlSUMEqfC+m9fGOt6B9fymbbParMiVUSGBlL+ZO+1HR9jTbIvs4b0yCIaWyZ88kZUyJBIta5c1z3mOZjdmG6XuU/+rMTsfSzThpF9D8tZtB250S4wARqcPhe7B2ghs65duyDmFnAIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=By8bjPon; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441ab63a415so14206025e9.3;
        Thu, 15 May 2025 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747339054; x=1747943854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+uhLvzK7rNj9LDHaREMcCcONyDPb7wemhKZZ/4dZJU=;
        b=By8bjPon2WTN6Q0bealVH7D7nMewVb25AGLYgW8/ZGSDQKVpu9vB9eaWzCQtFAhYZV
         uiUV0WOHH4fnfmtHXQDzoqtkhurZaR/mYXB4bT2GTcLgv5/EG3FFfS4DvUDr1JgadZOF
         Ha5hcy2Umca1BY+x1TS7Etf5HTx6mu/2JjRE7l+TRfN2blcB6kQVUKrygsPiLbBuo8mo
         GCIfvmudP3Beat4KycZql9rJpJWLrugMxfRuLxRi+NlkeCXVg/Jtb0ah6MoeLIfPhf7M
         P1f3RUt+BoHWB8IrwrfNRT0bCFx8DzX9JkrETnQbm/FRZaAffyMFnHC+9Dv2HwFHBbke
         HXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339054; x=1747943854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+uhLvzK7rNj9LDHaREMcCcONyDPb7wemhKZZ/4dZJU=;
        b=EwxyZvxALRU3O2wgP6BUE9P7wtYTMRt2RLTS8qewAod7CLhfou2sWz181ms9l4SCb3
         y9eJYyt/Rok4gToyJCm4aixje5lOfUlNmD0xNASgdGPF1Mn7EI8Es8WxQDM5+nhBbXxx
         HKSuCRgLK+XPs/c/kC/1aXyES+xDuooFshC7fdyulv2zBUPKuBycFjqneI2ecBK3/Mry
         tuvFW/oVPYTP5BaN8qEzY8/CyrxUIjgMwEEtysydBRqN/RhGz4a41sSgJZqBy7xN2kzX
         GyPV6moNXEURkK/lOvPg3P1eqDwE5MvHA2CwSSsMj+d5ePK5GcWHWePSgJV3MOipSYYB
         ACnw==
X-Forwarded-Encrypted: i=1; AJvYcCUHoPTtGumKrRA0atcMhO481ceLuqS12s78BiMa02z9INVJiJie7cOKnrfQ16gxJ83i3LAJdsNH@vger.kernel.org, AJvYcCUYXuy1YXFFGOntT94biEnP9pJyPR4td4Ds+ha0r72WmtfV3J9z2hp4HZeTPJig7j6TqGWM8q+m8wFBQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuvpFvblCbhArYTq1WNneyDO/tObMNBpIT0O5V2g800bOONW5
	/06OEzyGQeU+SlrQBYWYYBNeXPvVFqWsZJkg5SCQL9p7ESZSYmkm8bo=
X-Gm-Gg: ASbGnctZf5Aj+TgmlJSdhOmK6q6yhP/CaXiB3uasTypn+3nGyO7wOGBFE0c1dWsn4qa
	9A6rHx1hTTv20Ins3kLwCNntebPrvdGkEqkpQR2wloP/CSkpNm68VUyb+GO9nYkNGygDNzsCQvB
	eJTnT3PVibtbJG+hCd7nui19xOE8e1B/r2YPOdr3Wg+BEIwW4DYCuCm8qcbCwl23AVUdrXSbPJb
	0S3Vt0a234ExtWGzU+Ahu37Hs7ztmLaunFFZnbVWytC3UwFK6tOXb3+iy/uaovugo+aY7lvQuCk
	0t1vsewiR7agY2HJaZKvsG+g8pvqw9m/lm73Xz3C4l/5or+i3OWo/FHLJguoeAQC5tC2Z5uedCQ
	8vs/+qViV8dVo6/CO0DXGQA5klA==
X-Google-Smtp-Source: AGHT+IGAhkiHGFhNZo3b4MoNjBTYMdTrTDmz079jIw/UdBFcGOXieOxisqroo9I/bLfyHmmKI7zhxA==
X-Received: by 2002:a05:600c:384b:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-442fd6100famr8233125e9.9.1747339053808;
        Thu, 15 May 2025 12:57:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b057603.dip0.t-ipconnect.de. [91.5.118.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm82758785e9.28.2025.05.15.12.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 12:57:33 -0700 (PDT)
Message-ID: <0d48b34e-ad69-44b1-8b61-141afca3cc33@googlemail.com>
Date: Thu, 15 May 2025 21:57:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/96] 6.1.139-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250514125614.705014741@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250514125614.705014741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.05.2025 um 15:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

