Return-Path: <stable+bounces-172524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09065B324A3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCDA3A10FF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2F343D91;
	Fri, 22 Aug 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is+XQGpH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF86337685;
	Fri, 22 Aug 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898194; cv=none; b=U/m+BXOyJCSQ9Jdyd7Af1qJ+SFKKHb90diCTFV4kMpL1NRTG05Qb/vFPWf+LiQmxpSroBawznq3m8IYlp1ITRzhJkPFQlt4LpBOgrW8ocA5fyH5G4yq9HKbbvzwtR72du4uuAhFYR7EY+w4N7JMiknTF7Y3H5uFonPqeff0kLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898194; c=relaxed/simple;
	bh=dZ8zvioxb4sJxNiQfPrAxtevAW+fEIgRQ19rSOWqLrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKOVY5Lwyi2ONixnGIgxPogAZVhAcBUFMut34cmBr+5HkMc8U1SKg6D5v33lWaN/ZppGzF/zFcopz5wkGufMYyAiiqXlVQ8fqFNaycaGGdoHnIhVR+FvajVkMI75qM+BHiBEtyuUl+ma1A57pdnROiq5IAnRGcghv/91ba0Ai3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is+XQGpH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e870689dedso193462685a.3;
        Fri, 22 Aug 2025 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898191; x=1756502991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s8Ovyun/TMHM0pGVPmWlNx8ggduSwJfwBzcRUmzf8AQ=;
        b=is+XQGpHzgCs94dYZZAF1BH/dX6v1Wsmhk/PP42BongXXvoB/aWdr60/+VXievALYf
         faZtbDCLEvcBSnWmukmJkEBa7tGPlaPrZcL87s6OColm8vlQAQZbFM79vVl9cTUae4Ab
         jrKRFRpcghaoBv7cYfZp03UsqXxhdHbNPUCiQRZ42iClwmQTquFcotlS6L5VfacDLa5b
         z2XPPPwG4W23vUMazwH214KVN70x4wthhb4AmZayaMT1cHa3QJq+r+XwI9JazFK4PW+4
         xc916wJWjyAnXaqJYZJyjZs0u7RZwRGtuND2RFq6zQvglcN7I+orRbS+BtZhfhmUaQeT
         Je2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898191; x=1756502991;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Ovyun/TMHM0pGVPmWlNx8ggduSwJfwBzcRUmzf8AQ=;
        b=HsnIyQYJp0p/7GD5Qg0ArwkkRUZR+LveSUxlDSuoCFBhac8jDnGySruTrPatmt8SkG
         J+jc0arj5uSeeXcmLWUzv5ONE+nWbTy/MMcTgKFAKsrD+h4MELVnQtWkNmCILavUqFSD
         NtEgboqYn3jPGsB0NnGlUxPiv/Gjod+SqwYrXKqZ6s9PsLP1h16omXJch6ISvLcuCHzE
         Lw7CpkvN9l3S5RRDqrXrPqXlfgmeT66lFv9uN1FTGvPzm3xlCk1xj2FK/t51v9pTQZY9
         TZQt3/cO83Honxl71TRyuEMp8jiNK4lx9vk6GRgia3f5sJCuXw/HgkkpZrtAjNkqPXKj
         aLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSJuptt/qEM3oj6XdQQe5pbOx7sSsY05nFVqLF1bSwDPrJYjJYRzDEFKg+OV5oF7NCOzoNKFzPaMfQBHM=@vger.kernel.org, AJvYcCWbN6u9PNM99h8pT7m7oKb+RynlQejYM1lIMaXquJduJxGCdCgj4Peo0CIacY21DoIxXlz6W4OC@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDU462dMLPUm0onOjkK6UsNWyxKsdmC+2LsicT23lF5Hp4sEa
	ubawYXz3ZcRWC5xYxIycHnT4P73vdP2I2G9mygmmRsNPTTXaZHAxaANI
X-Gm-Gg: ASbGnctPjaPOgS9JD0UXtp/zAJmi6bo2SarEZaYEamo5c3xJppqg1TTWhl4n6Q8RviI
	hlNGXaaw5fE26n/DMwDkGNK3EHl9eziC7qdnTZ6AASmRTN0VCIeMBLSKBybZ9h3siGGhapmQJfy
	qZwRXLeaoF7TMAEhENUOAIGvfE0bsr7UOdsQmXyDdpN2jVrVpTMYGnDkcYq224CfeHv2kZnN6hN
	kJ/djblz2RPQDWj2AQrf14c4qrL0kEOBy+kVJWtNUSWixkbnmBr1LzE0/ZL6Io3m3H1Z8DBpasf
	E5kcO5P3uGq5SGtv5bK2OValPCgaT4wY59deZbqgdGx4TMvcZI9jcFMb447M5q1YpeBfWXlPQZ6
	FIU9VCgw0AW5CBd/y15rQ5LBqNNI717gY8Bu7QhblJmtLnjrieQ==
X-Google-Smtp-Source: AGHT+IExax3cGMrlhEhiqNxmeTvgqTbOi1ULNWqjINBGIC0YZHoo0Ccq8YR+33e1OpILQbT/tjYrpw==
X-Received: by 2002:a05:620a:3715:b0:7e8:598f:bc5b with SMTP id af79cd13be357-7ea10f7470amr498407685a.4.1755898190970;
        Fri, 22 Aug 2025 14:29:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf2b50789sm49375985a.42.2025.08.22.14.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 14:29:50 -0700 (PDT)
Message-ID: <56a2abfb-365e-4160-b42e-618eba3bc35c@gmail.com>
Date: Fri, 22 Aug 2025 14:29:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250822123516.780248736@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 05:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Aug 2025 12:35:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

