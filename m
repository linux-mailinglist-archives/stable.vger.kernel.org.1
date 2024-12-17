Return-Path: <stable+bounces-105045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85089F568A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5EE1892F56
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A561F8AD5;
	Tue, 17 Dec 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICatD3uP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F71F8AD9;
	Tue, 17 Dec 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461536; cv=none; b=Kv3InNHCKRhPYSTAt4/fi6U3NzQ80mArbaO6SwWcQZA7dAVj4jF2IQuf13TWeGRNcCBKRP2wxU/Un0pA+ZEXD9F913Qo0PTSAotyH3VkCgal5zUo8iypcttLEfbDzxSJR+WZDzUe3nYDyjGD0azFdulXklOjOnYhkctDKWsRnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461536; c=relaxed/simple;
	bh=/etiGLYb6+MfQgjoNA9IYT1CsKUnL16ygRaz1c8zntc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7dnM9dupSmBhL9i2A0reYHzXkKIJwrRNXCDMi81gqtq6hCXIkEgRYOUkQzPl18VvS604/elCYnVXupopOVMt51gxfdwvjoJbPi0w79U0Cd9YnqGWxs5jrNbv19DpU6kCL3eqochvuVorp02FlmWjgh92KF5Dx1rPtnxc9ITHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICatD3uP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725dbdf380aso4565327b3a.3;
        Tue, 17 Dec 2024 10:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461534; x=1735066334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bgIpkDqzo5LovdV7zOJn2TkrWt3t5KenuSiX8WMCjDA=;
        b=ICatD3uPo6iCmTxkHtvOaCYmrbuqZWKSvjanC5r9kdK7Er5Bgfa0FSWB8ycFoBYHzD
         sdk/MXbCHSFlfPuub6+6npxJPetmG4JO1zZrIsLcqxQVBBoUDouzS2aM1lPRHGK13/Z2
         XhtVjegGg7OiEPYZjnszE1lEfkE8BkkJ0V0chyCnlYyuELW1FUd0bs7xDaHJ698psMb1
         bjChc++I1HrV15id5z1N7u1U8PiipjJpoJljk3NA7MgtBT2G1aqNJ3tNTqNQT+M7tv5H
         HEyi2gJ8oArOIwBIUToTOta60QPqDdOQdUXCvwR2+K/WvIDZWKuFJCUEldB1ly0wNb7K
         4f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461534; x=1735066334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgIpkDqzo5LovdV7zOJn2TkrWt3t5KenuSiX8WMCjDA=;
        b=SiVdGvJAuG2zpRnQvD3V8ugWThb0PHZ5TbIVqY8Zj+CeX01nI+p8qMJuevJLQGDxZw
         rLgJMBZ6H+hDzKdZDYjWOCg/1Pho36xnLhdqPFXpKV95mt7b616AT4uucE4jDybOf7Q8
         uIw+9BlZKGOGAUh+cWpifJHzDuUYWcwcHSzddAdy4ve5JNGiGeg/yZjP1Y6ODZvDUiuT
         XXZSB+PzjiyEvAyudzmTxIf/tCwSwNfPjKixJv5DncKRZncPL99NflIvZn/hS9Sp2YxD
         JycFJZYbQFWpl1+19D5VR/Dgf2pUEu2DH4/kQr0B+7FWbNjk3kKkz3nNauv7lip60uGX
         FEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5U/fK/niFBBnFFXAcl9S3bSDcdCaNSZG0p5WSv6eoaaZCYB9s/KooF8vDYRhLPeUS7AE3YgBCvYeBzzs=@vger.kernel.org, AJvYcCWf/fm9X5Ap9okT3o5GmUFtf//2ADz6v4G/06Btkw2q0yGHUvrRRtQpXsQ5owQUo3JP3vfZxzSY@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvxa2xEtHkX/O6ljogM/rIOBqBvWFIwaGbtud488fbbetInmJ
	39smGxwsrF/drPeiFP22f3zW6PpwC3gU1HD3tWhQJa1BfAQC3J/A
X-Gm-Gg: ASbGncsr3a5p6QaR83Onynxc23iOi6ghM2akJ77XHiB7xaxWbjbrMvScY+S50580kEm
	knoeVLP+SP3mJkseQFRa5MMImF+OeFHMZMhx2bEeABRY+ppdAX79X8mIsnH98YMlLS6g3oxd+LU
	wDs+CXCt/2i5GuwXsrhNHBJA4lpIUKiuAjbOXK+MsmTJ7Oye3PGNd8XeVyfSkUrSZpLQRaK8vPA
	TkDzGalwjadCuh5cnLbU3Oy3O/fU/VTBtV0qsazj/dBJIk24GCEMTChEHw9ZE0kSGkQ5TV82nug
	ks5cgJee
X-Google-Smtp-Source: AGHT+IE9hqmgSAulIjqksU6FSJulmX78oa+gvTLKDjBvUJrjZ2I//IhcH3i80HSHr5i4VGLPdVvQuA==
X-Received: by 2002:a05:6a20:9f96:b0:1e1:abd6:ca66 with SMTP id adf61e73a8af0-1e5b4822a81mr190595637.24.1734461534472;
        Tue, 17 Dec 2024 10:52:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5258sm7284782b3a.20.2024.12.17.10.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:52:13 -0800 (PST)
Message-ID: <f50b26a3-21bd-4e6d-962c-4b971a15dddd@gmail.com>
Date: Tue, 17 Dec 2024 10:52:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/24] 5.4.288-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170519.006786596@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241217170519.006786596@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 09:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.288 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.288-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

