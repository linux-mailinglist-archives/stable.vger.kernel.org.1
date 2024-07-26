Return-Path: <stable+bounces-61915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1FD93D7C7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB901C21FF9
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EF2C684;
	Fri, 26 Jul 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/B9xbdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E481C6BE;
	Fri, 26 Jul 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016020; cv=none; b=i3kv3WErX534MJ+TXOwjsgGvK1/jPxYpW5zSY+wRqmfNrXntuQDG7BUjCEYLE95Y30QuHg73K3957ZYYGAKLEUy6s3w1mKXmTbcvbk+niuYbSZHdZFCGIaoO5q+9QgNrnCUjrSvHeTiJAzAQoYF5SOmft+iM/FaGgvppPg3x8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016020; c=relaxed/simple;
	bh=uv20BOradmm9ejZK6VE7PW2xqWKlQ17duNVIP7Qs/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPpIHi65NpC8vPhXoNnoPvBju8BBNczv1fYquNatmwtvF8OYNAyyCibpEUaP5mpg88vMhDBthrkJvA5WWrcMtI3ev/mGZ5HoYnaqY5enhWpiOWJO95PPu7hf2Gj+f4RrgbJTrenjLrFUq8/jWB1EJhFoU5+9AAJxA9Z6t8FHuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/B9xbdU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093ba310b0so312853a34.2;
        Fri, 26 Jul 2024 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016018; x=1722620818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ld8tsTjI0GFd4Be9iWKsgD4FSHAh6Eekpaf1onWlKo=;
        b=G/B9xbdULOc4FQZsR1dgyFmOSPM6VRLncWAriPHAbm0q+R4PPPFeo9kb+qi7uBVv30
         vw5zS/DHvOOUmoPC6DC+6jju7UzyY8UDp4XI/uzUVL18LOYfuIrYw31Z9pko5TsypxAl
         a5xyyCi43hQ5ULrPlm45byFKiyugH2PvwvTwK40/toDHNmYXuALhlxLg6rA1fB5znCH2
         hp0flsu7ZAObzYVDEICYKBpCEO5JGvcvXj2bq/zkoQjNHheeB0XA1z4+AizIvDOlT6ta
         tCZztrwsvfAJu00D1XQy8pcGkJct5epnyqq65E88dt5JqgfE9TUe99iBk2xHfXJgfdSa
         RJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016018; x=1722620818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ld8tsTjI0GFd4Be9iWKsgD4FSHAh6Eekpaf1onWlKo=;
        b=JU5T6SPii5Z6eDvTbADNno7DK6pfLT/S3lmxS2rtK+bDaQw/2NBkQvCe1+C9chFc6p
         iXpseyNITaRrNMU0JW8itfBaEwnHS/g+Sb7ZQ3gUbluLh0dbkEkAaisetTwYdhmbGtlu
         PoCqdgMQwhfmm2EDCmnMtjL9EKGdS0s9G5ZNduvBvcYiw5wV3c99iue4gte/7pCoMVSu
         zLJ0cgBeRjc/cxdNzwuDfbJA+ihwhB1QZ5QbHFMPhqpMvWnX1PzvfY4i+maOVaL4LJbN
         EVrnNodXthFNml4erXnE1Qi9GoqR03dq5ZutVJ/u+S+2Q3L/7fVDbGoa1CmY6gF61MzY
         oofQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu0MJcN5CiZifGn7Z5ZJ2Aig9pGePXD2RTtHohiPnVfjP1yXjkzfDFzKzCdXLOTf4yekjW1SgZM+a5QwCfY/dioMhOUxN9+aUvNIcEal67B1wBTc4WYvjyLiktlZ8AB55I9Bxe
X-Gm-Message-State: AOJu0Yw9EENsJnJBbg7ydfD/OVmzGNxxeETRXje5PLr6ave/eknyJ0bw
	6LifA/op1I3bBcURR8yKxAW0cRNMQ3U8enwgmihnE8xYTS1u2sYl
X-Google-Smtp-Source: AGHT+IEmmiJIksgvLCkm6RA8hE1G+1EkOzTaFAw1SJD0NdKtg03MhOARzZGEjAaxqCaQ8dsnGfxy2w==
X-Received: by 2002:a05:6830:650b:b0:708:c1e7:912a with SMTP id 46e09a7af769-70940c1564dmr352398a34.8.1722016018399;
        Fri, 26 Jul 2024 10:46:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a1d7f221f7sm188578585a.19.2024.07.26.10.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:46:57 -0700 (PDT)
Message-ID: <08963e07-f676-4694-8339-f14b340cf247@gmail.com>
Date: Fri, 26 Jul 2024 10:46:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/90] 5.15.164-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240726070557.506802053@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240726070557.506802053@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 00:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 28 Jul 2024 07:05:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc2.gz
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


