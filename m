Return-Path: <stable+bounces-182856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F8BAE429
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDBE94E13B3
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CF269CF1;
	Tue, 30 Sep 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLw8ucPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8C20FA81
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255235; cv=none; b=cDee0Q67iqhTPVhpyzy/PV6FUzCpPfFRWkbclknzIY1XjkCjjeu8BPgspKpQfDR+rqbIaLRJN48kTttXmgRjRd/6GRPdM/6n7CFFL0/QaGnfUPvPhUgXrO8uY4AwdoE1DviM8eXCg9VC3scl2AkyeBkqYH45dnvjfz+e2NqQDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255235; c=relaxed/simple;
	bh=YbSZbrwLsMWtea2gVsJ93Z7HflVLWz8Y++acXgdJZ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM05KlnrExEjuhe0Wonq36ZVNYMZO/yMr9ZIPAB30mLTeYkyAS8oIB+ex3WXrAN/PkO17ezxZa9/IeLfeLZStENLeoCsxpQAdiA+KJI8V6J3Z/Xt0FJtZwYHp7pQaNXQNK7n5kggSZ6+ds9DncGdhyXK7wOJ3N4t8BgUscL5vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLw8ucPl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4d9f38478e0so1489561cf.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759255232; x=1759860032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwfmIPtyp+rsa2DwTVLeGN/bTgy7je9QsgOF1Vb5InQ=;
        b=cLw8ucPlIBxGSiln7/Eww2Kre9NeyrWLu95eFLrsVHTxTCWy8t+xBf6Ivug2nRcA9u
         TjM5PEqWrRLDBKfYUm0QK+FWJN8QzMpfq46pkxlHg/Q6w4OAOlteE/KLwkpYqcxvoHxZ
         eGc+/ddgXsQAQBhuDyn1ESS3PkHXKwQ9bPpDzEP5onJ2aV5nZkxfNnEgauGU9RpNAmPs
         5Zol1WvGIFhJA933LtRGNr7GfJ5cGW5ZGaRYzieNI1L6HYAtNkbnWcYwehLp5IB37nNO
         pkpfKckyXjABkzJuQfDJEisEzCACk5niGCVqx1rFmjqCQ4L2vy83kUzCxKlhBINzrqx3
         KpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255232; x=1759860032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwfmIPtyp+rsa2DwTVLeGN/bTgy7je9QsgOF1Vb5InQ=;
        b=ghDryTgEeLVw2DnwTPrhqzF2Actdy7178q7GjxUc1x1+3efWDKVLYuLC5ubBS2Lykc
         gFjxxwYQpd05a4vzaVEuPeYBCXBujW1jydev8cu9yJkXTsy8UtCUZDA/bwWP4jUVNMGq
         dHJCMKr/pNvxS42yCqU1FBLKibP87AJU68F/JRSNyPkqGvs8neJUrHtuTf4Mbw2/pnbK
         K2s6Np1KkdB+ha6TO83eWMPQV3wdOm1d7GLxvXizXyk2iuBKtFKt7SV/NKbf+8+7O7O1
         sq5kgzNP+2WBOhxUPIGggYYCWWAscwIjfb+Ww39a2QsGJsFqcYAWBfYgffnyuIKMkLE0
         YOOg==
X-Forwarded-Encrypted: i=1; AJvYcCViMzFSsIbRQc0SpStOLQT22VMlRjHto1pYPg6H39Ov7zLuynMa0ZSpRvES2HWvVvqVh1uYoRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8V9D5h3VrFtZUiMQ9H6euwYM476JLpUvjq2oagayL0SJEKdQ3
	EFFYOsSWr4l5K1nCCGumYZWXSm0ddMUrRVMyxojXQkcGpdiPDmRGgV4w
X-Gm-Gg: ASbGncuR41wMGk3jvT+htAa4jjl8hUzBuW7TV5kHx5W73DpKpr9wd5R+ZlKpSds+EK0
	Eil18pXjowsFoNwODNfx+rYGLQMG1EMJZbmY4Zy5j+/C6835WE4rLHLWRDyztSe63ilMzm1mFdI
	0oWftB7tBwzmxoo6yawLoKkalN+l/lwkh6evfuDZ3Jlmrw2K3zwBV3FLQ76EIhsN8iQsUBxmar5
	/5BCL99v9EPct8O+CXCNC3ebdJopKTkecGF25yTF5ygLeGvaLG76D9LNo2Oep/Pk/a07ViDbiw3
	UekUmMvUwQX7gJ4/xW8z2HIkGtbWP7oSOi9+tfz63kj7ZoXG/VL1qq96UaM1QwGd0FqKnGhLTmv
	HHhjY1so19XJ+hpUDz5WklucGHwxDjhWG6fvvzSt27GMSbLkpald+WF7hc0trFBp0Wh20DY1xUw
	==
X-Google-Smtp-Source: AGHT+IFqOmFo3m9m1uH4m6G/o8zmkURBdCOT/WGf9A+raEW73lMwTzSH15T/s5dgz5pdWTKLfpVFBw==
X-Received: by 2002:a05:622a:14d4:b0:4b3:4fa9:4cd2 with SMTP id d75a77b69052e-4e4068d9458mr13682061cf.33.1759255232394;
        Tue, 30 Sep 2025 11:00:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fd1dsm98261811cf.12.2025.09.30.11.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:00:31 -0700 (PDT)
Message-ID: <00640a2c-8d8d-454b-924c-81da31e95d95@gmail.com>
Date: Tue, 30 Sep 2025 11:00:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143827.587035735@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.194-rc1.gz
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

