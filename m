Return-Path: <stable+bounces-163184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4CB07B80
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F31E7AB298
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E92F5084;
	Wed, 16 Jul 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU7U9UTb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F1290D95;
	Wed, 16 Jul 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684545; cv=none; b=fQBmTtnozVo8L+WGtfhi8ZjeanFbkAVsvvMNKlQNUvr7JNyePC3S6klXf3wWGsHvO9P49SXF+RpP/j5pjo9XyUJQhHZHbiT0o9l1t9sGQtqEJNKWLsXR8ltgmVepz737XlQq/AvISVGZDq7ASEXjT9hagkZKJtmNzPSeZ2vbad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684545; c=relaxed/simple;
	bh=NJGuRaDpXfHvw6loKwAWFVJW4NxckF0v1yEFcdzHrx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz1d7LUlFZOnc9uP8PT2noJhoXFXXnu14tr9kO6yYhL0fBuLG6gLaygd+Hvkovq/Xl6aa9t6BGTjESZDOmGgNkkEkAEK0Cq1OxtZKyXQbiHigDcWbpJGIlAJqYFXgUmB+EcwFg7rKwZyLM0zNXsHi9Hyle2+MeYq5cJFFwYhI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU7U9UTb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so1541336d6.1;
        Wed, 16 Jul 2025 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752684543; x=1753289343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EXO8ZWGxoFIW8b4GtjNGg34fGEYa90sLVvc+WxHjZ8E=;
        b=RU7U9UTbD0ufaRlaF20ZpC2Pm/qaUs+mU+HwoOsg7BhmmlmvC5M23Vb5k9NcJS9HFk
         8hbj8nw3SsXZCShcZeUzve9Z2pOpzsXpJKM3iAiasy328Bmq1UjxamAyxeWv5AUkF1Ln
         t1SCpyBG9Qvj0H5oABldLHxFNHsVrtV5ynbu/bJiRytkpoGwuxxCe9T2LuBwMBbgGcAH
         TyGF5xSk/mfRew/xc+H9DrqONHSMKEYaJHnWUzOobOSwfJTOvjyf75xKtDEr+3CoNxI9
         yoPSuWMgf3J/BAh/FH92j1zEeXL2j3ZTeTWE8E9CvhCJqGlX+HPA89oB22xUdbi1Sp6l
         4PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684543; x=1753289343;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXO8ZWGxoFIW8b4GtjNGg34fGEYa90sLVvc+WxHjZ8E=;
        b=akyjK5gNRRahTdlZ1O8CXK8dDnsnd60De67fw2rV/B3bnjApHXZCaq+XSTt6T8+2vy
         5NlROo7OsIprEjtDrj7yPWXLcmoDlgIiPEsXZIANxmi9yVUvnzkKkDC1KualhNSEPofP
         lSm9EjfPHsnWlrEULACvvhuwc2t6iFNG6E8gpIBmZ6ktkmLuhC6T7/Aq2XFRNISi9s/7
         fnCXwrSM8BgUc2lmGB/NiLUFax4f5w7kDSVRaynoxL0oyHUsCywFVyqsrqbdxVFq1vRB
         UDmVLwKSAdvCdsUoHU9aMLfuYTsikCfuJSg+ZvdxVqZUyb/vEuD7o3UhP8JLTnPE5FGQ
         95Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU0mPvsFLyZr9fkKLb22oNKAJoE4P2LDjtLWw5QuAGEuisBdY0fsv5QHNeL3tXGo5jwMiy5ginglGTpxXo=@vger.kernel.org, AJvYcCWsCj+iU++qoSRaFHJSDu2coXF0o5Hs+KKwo+P1/v+j7Zx4efVEKziNAW8BlPn44bjkxTaW8v8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnLOG4XMhh5Q9AIdxFy/4U1fFBylxql/3jC82dTkejTFn5kVN
	3PT2CVkGuF0VTBn20VGI45drcy0JkPuYCnvOgKJ+mhST+aO9xw+dfj+B
X-Gm-Gg: ASbGncsQNIvXlv8erqiFEa0CvcfBdnlOZ3IF81zwtmNV1OYkS92rrl3LUs7fRjCesa4
	wcZnpvPFOG43B1ISOx1/6P5LsBHDKfFgay6/EIwueL6rsZy1jmWRtnmAdJdj8MLMNgk8lrAC5+2
	nm/hS/8SfEZKcA59PhjD3z3tmuTp7qocP3nRG/I5nLGCPBMXTspuo12xTixIUMhXXoKiU/UX4xl
	5B7xzSP8r1HExKNWyGX6OfwceHmkrelo/FcH4csWuPuOwGk/eF7D9wJ241pmucFqmU/0J98JEm9
	SMqBsbcPnUCdUdBepN76tozYzpa0Jd0z7KtfwYvTwshCV0owyDcB3wT5/F5JXc8JuXxp8gMYOWg
	EbZ1uKO3Oz8+Glx7IMkDoqzfeA49yi8a700ljmj/BICtknh6F/Q==
X-Google-Smtp-Source: AGHT+IFXJAf2tvaHTND6faelQr+HHFLObS0O5YooWkthj37bPVzEe6tAavvR7q+Ct1PA+5+e2O+OiA==
X-Received: by 2002:a05:6214:4a83:b0:704:85bd:d239 with SMTP id 6a1803df08f44-704f6afbca4mr57030286d6.16.1752684542799;
        Wed, 16 Jul 2025 09:49:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e31ddsm72676526d6.43.2025.07.16.09.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:49:02 -0700 (PDT)
Message-ID: <261a5fde-5da9-4f99-a330-e5155a7bdeb3@gmail.com>
Date: Wed, 16 Jul 2025 09:48:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/78] 5.15.189-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163547.992191430@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715163547.992191430@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.189-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

