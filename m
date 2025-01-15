Return-Path: <stable+bounces-109173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD06CA12E1F
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4421162D80
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763F1DB922;
	Wed, 15 Jan 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFAMF/3e"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFF14B959;
	Wed, 15 Jan 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979260; cv=none; b=Ig0Omq9vQ50/M8R5n24c/fXnORfRpJElTPg2eALWjA9t1d+D6EqgJsaAjyLK3KjT8UFqDBRBZ4kLltFd+2DvmHUf+WP7stWkNtTGTbZf/Y+fGg8jpNzEXfDvJnVhSEadLVLMPXMN+t1vbBx3tbbVxAKZ6BXpePfNKNdUgZgpk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979260; c=relaxed/simple;
	bh=OYJIAOSbItTp53QRHUFYCA93HDtJ+rK3bdspxDKulfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+Ceqb92f+6awj95MBEyQNqOKFNoxQkxCJH/4GnGp6Gp8BNbn126t/AgX06mTJq2Ye6GlbSu4Etc4+tICG0NguRJHtK3rKmpoi2zIYzmI+bljf2jQ3F6r4ki8Ki3C6Sk/eu2U3iMPecR+e0xx2TICHAjlI2rATFqxr+Ken23hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFAMF/3e; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb7ecc3c54so223594b6e.0;
        Wed, 15 Jan 2025 14:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736979257; x=1737584057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8HKNpdFHanwKimxAIl6hBfo6D8KRL28BVynAHn3Wm+0=;
        b=mFAMF/3ehSVQGsElqiazigs/+vZFMTxN3SP2YLiciYUMlN00LZe4s7gAo7Wor9DGJT
         bR97M/H6jOrOWbjt1AV54GC5mLgLlYdFQD/zWMDvN7pV+RNQ1xmtu9q/yeOBGw2LrmdM
         o2zk99ZWLi+F4iq2auY0HBX953yjPvo0ff/YjLTQU5AQbK4kX3AYVID4W3mqG5V906TW
         mlClqdoqmfrhtaz2Q1NlLUrIgIWPGcqkLTYNh4VWSN+DTWo9kEi4xkfg0u5Rb3X74c5n
         AtT6EcDh9owLzx28z4OVssqz3uL0fVQbP7GVMnU7F6zpC7iWcDwtjXRzPQhqdpwCv/f/
         2xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736979257; x=1737584057;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HKNpdFHanwKimxAIl6hBfo6D8KRL28BVynAHn3Wm+0=;
        b=cUFL1M+rrJrIc8cgMQcnW+54ST/WGCJqD+L16jSDtL4J7J8/TGWf2Jpv/EUm1DnHLQ
         LkPJ+X1F/rJ78AlwDzwdXGQ2jHeEUnqJpzIBa0Ce3NPnZ6pADJZTlu7ZGi89mKIhfUbX
         Q1GnkFg0YceE0ADhZqVPMAdNKUvRHNnob/Jr1G91q3G+D/cLn0Isut1VDPSLPJYYW28P
         cZNQIbzK24cuDOv2CIOwlxSatfB4Yh5GDiDvBbmd1qrLOeg8uiPSFifuszwDj2C78p8w
         q6YnSBSX9jwGCHSe45OFheXhgGUWOus50lHiz/h1T9ucEXadZDP7Awf/elEchJqeaTHX
         8/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZn1NdvWBo0+nVBxn6kkHqRawFw5olTSs4SZ8XGtE/nd/2hbYDI3fCZFtq2WojfKtVb0VY5dNymEtyu4=@vger.kernel.org, AJvYcCVuIMXTxBLAKMU/fv5kjcAGClQTs2aZJGuNe7EZm24g5hdmDV88zQfDkihfF+5qiNm5W3ufUrt5@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0+z9MMdqv3hCTPVC+QX3NHITvuNUvA1bKYYKIBMF3RAxQz8C
	4HFn9YaACi5vuGwgPp+3UMwmyVFhet1J3qo1eBiuguJQaVQViJpl
X-Gm-Gg: ASbGncvjvotvRbHRlqTs2P0Le8URZfn+yB/rM8wCLGUjVcM13zBFBuP4+E7Cx2txMgZ
	BnjKMvlVfaBrUrbUM2S5vAClyKhiZDQ4Y6AAR8JPcFKBxVQWi+hed27gMXE+Db2vROqZgoDh0hb
	s8q4tp1XrlKtxhbyYZEVnYM5aLhWbh69VCbge7pbzd7LI+ksr+XIXLqJ2dR2ZdVStWe1lOE9gRW
	zdO8jE4po8axdTap54eBw76VR/1i0rc4Zwi14NKFukXUTXcsLgJ1f2fVuc+knHXc6CyRx7aJ8eu
	4Vd1T9o8
X-Google-Smtp-Source: AGHT+IGhn9ll3NB911ccBhd1unOJGldWrCQq0iGgnN4m0m8+Te4LLQNyBxBXnD940TpjnaUQ0xxj8w==
X-Received: by 2002:a05:6808:3c4c:b0:3eb:6db7:f787 with SMTP id 5614622812f47-3ef2ec90357mr22780482b6e.11.1736979257247;
        Wed, 15 Jan 2025 14:14:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855ee1esm6057593a34.32.2025.01.15.14.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:14:15 -0800 (PST)
Message-ID: <4cd7adca-fd08-477c-a00a-f43a653456f8@gmail.com>
Date: Wed, 15 Jan 2025 14:14:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103547.522503305@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 02:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.125 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.125-rc1.gz
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
-- 
Florian

