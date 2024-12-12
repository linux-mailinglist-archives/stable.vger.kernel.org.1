Return-Path: <stable+bounces-103941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CBE9EFE7B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221816B871
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118241D7E5F;
	Thu, 12 Dec 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrL7mEQO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757019995A;
	Thu, 12 Dec 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039520; cv=none; b=d43JvYEH/P+8jisX0+oBmEWgAJ9f1WEGbRd45DRzlhmaori9LOE2qmWTHCpskCJtkqHKO7UJA38fPLgOkh4Wf3CmUG09P5eMGd1SzRYJ9d82pQ+D82Q1WNOKLKK6imJdD8IhSa7KesWO7fmoDJOTpRrANDMedxmyJ60nHsrJIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039520; c=relaxed/simple;
	bh=FVsAhf/L/A/1hExk6EI4BILQJE/BdwS8en2INWU/29g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ln2R2XkTlV0uS1c4yVPMpTHuTks6fRvnZpJbL+j8gQPeCYJcauM7FK+FGgOu5hX6bYJyhUyY5Da1t4hO44cf0paIhqCmvqOq0d/AZuF1CIGBAgwuoKNI40uWak2zw9iMBdAFnbcK3fBOH2VlEYXqwrXj7h9gDdC3rEmjWAG3zcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrL7mEQO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ed193c9eso935836b3a.1;
        Thu, 12 Dec 2024 13:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734039519; x=1734644319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ5zZgnlUdJh8z0DW3NiXjiumc4XlLzMn30s1WWYCFM=;
        b=RrL7mEQOEUPvIAK9OJDNxev2YC5vBMaX1AQdSwMX9kPD0eBocqbbDwAAUROh2qIEmx
         0LUXoKSd23MYdjC2yJKGmVYzl0AdlGl+fSGWOaWSS9Yu1m2bXkebOkeTjQoAjBf8DyR2
         MiXzbg/8apLQ5hR46ZX09lR4/qisIMk5zDFkLMvN7JFxliURUiR6dbl0S5wcLTPYCPfV
         iIzUYs7rifFD1tbzelVBSwfoIENSv0BxbrKrvOa6/4sVGV/ZZdJ9E6nQgCl8XfVrtZpf
         VMrhv7j6PP2mgkawc5X8lN56qZX4egNwhSAT6Mt6wXD7TarPtjhCw2OMwut/5hEqGw3S
         xZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039519; x=1734644319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ5zZgnlUdJh8z0DW3NiXjiumc4XlLzMn30s1WWYCFM=;
        b=t7o1nplEqyYwA+QQ8upwBi1henuYg3RxKdmtZN62AwIOiwM/pa8LIIIdlzzI5JKuIv
         ZrZKl0b09XzDGlWeCoiDTIjKH/nIoc9g+5E0vPCe95s/vfOtilItfTJPUIE2d9scOCtH
         P2zYg5lzllgG5ZFRiMbxVFRrWjH5Luc9nW70qq8FGvyPjJmodxUgewL7tCU8TcCFPSQT
         +Uaiov8Oushc+8iQIyNZe8LWjG1nui+YOPV5ccFzA35wXVOUsg0b0yRIZuUofV7vgNns
         dZrzO09l62JnNvIy7FEdfNk5qJhienGny3lF6cJZcRQBOeCbMM3qIng4tJ9QHMLIt/RA
         +gtw==
X-Forwarded-Encrypted: i=1; AJvYcCX50ItYS3M6OUZrQj7Sfn4mWJv5OeKigQgajMUFx42bAkQ8sJmQ/ID3M/nqu20hjUfXGldqwzrjKkNlrKI=@vger.kernel.org, AJvYcCXVmZCF4gqMrAZwTIKG46WBPWwbguExcHVkKsnnFUT0CCMM+gEzxpLQ+wxeFKvlr1e9h7jhk/vg@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZemGS+PqDO/B1HRZiE8bzurUL6lgc6eq31iSnJ2L2fsbK9x7
	HIteF6BmVOXoGlCMyluPh49fvGzxtiTIt3tBqanB3wtIphWf+BsV
X-Gm-Gg: ASbGncsVf+A3etPlOwFaAJlbOImTNN5uNegA/LR5//7vZkxtvEY5ng65R0LM9GoWN0U
	Pl74E0i/vjTEh43HRm3X8QDfpfVN49UPfUxVLYH54yYgugU232u8/55sqT0xtIplxT2iE1bMSUY
	B1Uc9kMiSA3pW3vjWouUe/YZhVhMjUW8VqWUJjpGBDySoH8lWQWsjlVERh9qFtfot9vt1TNsFR1
	1DbtCDik6V1QNCbSQjbKIw1qMI5NAJ33dkMQkCZ8r0IUwkMoZTJ6oAH6ulOrRtnFHWfhT8m0C5Q
	HXxu+Crt
X-Google-Smtp-Source: AGHT+IGY7RCaXhDWkOiohikluaInFk753KShzMe0a+LB/ak/xr5+1bNnx0spv/17RPvzmUvXHDONfg==
X-Received: by 2002:a05:6a00:f08:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-7290c25a4c7mr211922b3a.20.1734039518574;
        Thu, 12 Dec 2024 13:38:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e8df0sm13750293b3a.68.2024.12.12.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 13:38:38 -0800 (PST)
Message-ID: <c356563b-4137-403f-9f0f-29e9b38512ce@gmail.com>
Date: Thu, 12 Dec 2024 13:38:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144349.797589255@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/24 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

There is a new warning though:

scripts/mod/modpost.c:969:44: warning: excess elements in array initializer
   969 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
       |                                            ^~~~
scripts/mod/modpost.c:969:44: note: (near initialization for 
‘sectioncheck[10].good_tosec’)
   HOSTLD  scripts/mod/modpost



-- 
Florian

