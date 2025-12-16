Return-Path: <stable+bounces-202738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AFCC53A9
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20306300CE08
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19571E9915;
	Tue, 16 Dec 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgeR1Za7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3633E364
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921122; cv=none; b=Kf27LPbXQ3u2keaZ0ZwhIkkkV89zO5eC9XuI0FVljBJ1FeLTvY9cAJ53GcLEGt7k9O2RyJ0cYyTPIIC6JC1zop+QLZoX3rPTbaNaJfIe+jhtnl4jkNJbDVPDB6No+hXTMwfgf5/G+fD1w/Os+GhAwtXPedgVNrekwVOsCLdte88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921122; c=relaxed/simple;
	bh=IrzwS6C5aI7fipV7HbMn9GfkbRo3LcMiD0elXuzsMdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEUP/CtGbwGGBOmUuC3BQToIVYyUAKuHczWshsnULIyKnp+/WbLzmGD/EuxB/HUh9wF/78NdWpo6parzCTya7moakGd++Ec7eZj3Rs0NZ/x2mmIFDNbipSgJdKhItfEVNBC3+PPDprtqNDfI8bX5p1WDjaSln3fmdIzfFTDG9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgeR1Za7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f1b1948ffaso37752111cf.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765921103; x=1766525903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FDuJHVI3P4lF6qM6POX+953ahYksqf7lfbvS1w+/rg=;
        b=FgeR1Za717v7uG/trH+J8tnqY+DTl/P4v55FaMcUXioduRcpG6UruPYySPMOmVe+2B
         SJxWz4uz39xJMmvCrg1TsmCVa9i2yYMrkkTnir/Ah6pfGc5ivnyKnmNXgzJmbOZZkQA8
         5y6k3qEKVJWQL9OlNcReLPjIbo9xCJjWXTXmGMgyEQveF0GkGubgsChDdKRUMjlObwJH
         c2u5R9U4+mgWRttMxHgZN0tj6b/zqKLIRrPSlIlz/2cRhEFb2hg/xHJBuOloAsl5nG8A
         wx1fD2Gl/zfBB17bXcp1ZkVJhzqipftKQUiT24Rw8prUjggx64DPb0JBW+QTtbCFpJ4k
         ShXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765921103; x=1766525903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FDuJHVI3P4lF6qM6POX+953ahYksqf7lfbvS1w+/rg=;
        b=qMePQRbwzmY4aLtCoLEPiFjt42hX1OYdD00WAeXHwpIneAE1CGSstwupc16uZzz55y
         ek+TqIc2TTlngfT7Sre6RrOBWTuqSpfEi5Ewwj1xfmDEq4avdKSwnv+Ura5DZIEt/ZJc
         KDLfD+pCirKTQtXULSOM1xzJuLSty5kuoNFffrnh0ARpv1fy52mrcdT2UgCEgqp0UbBG
         NbVBPI44wM+qKO1JGvBffY5J92kRthot4fr82iEhX3ZpRN3bqVsxGFengKeoSg3qEP4w
         zCQE/CXU5lKEI/IhUNtp8734R0DxN7spXBdoKT06XSVr0FUCobOCNugPf27X2u2VWdCZ
         LmQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4tuNlKfZ0wxVcEwilUV9QwZbBeggQS4KMN+D5Z6hrOOd5AxO7eLJxTQHGEUdSDyK8eeqLhp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxeGRj3ajzWhbJakkVMty3tYi/8toeiSyNSAbivtyF08vFmSI
	A885DIPsY84hakI0gDSAz6LnfCRjagsXM5syj0y/ostWDGhdB+d+P2RVseGN2w==
X-Gm-Gg: AY/fxX50p1g/36JHTuXTHRg9X/Kj7ehC6Cie4jSRO+Al1Z6zDP9u0aPUY6pdSbJQMIF
	TjT89C9QCg6Q0oWtvSw6RAjy5dDDfDhE6dRuKRF616l39St5mN/KKyj4IJZrPiPaupjK49xrCdG
	QUvflIBxYfFFIyt178UOdfrUTAnSkp52OWgrrbnlLz6ucSIiYNs+wJ99lISegAbCJxLrqV+oJfE
	1VPV879Wna3xGRtFqMBaohkAT/ca/0r8uDKNt1aAmjnyaQtolb0FMk3bPKIfE1iGwdKx5ganjAT
	gnmGOyJp00bHU6nvsIlaPmszhY7OzSaqErDZymFLfD+WwzhtfzUiVrx7AnJrtCRE4qpaxZe4YrY
	feIWB6QEwVTe3yTDbsikzba4YZCi9yF75aKHX473FdD5bmjGk3JytqM9J3Ky4B5VqS+DCpHaeQU
	46lL+JLTKCYQtQQmtMteKwXg3Ui93uTjOUH/sY/w==
X-Google-Smtp-Source: AGHT+IEnyi5xvLj4o52rVDCfep2kB9HscHAQcdZPennsWNgyCwdgrfXSc1zozSGCq0Do8l5Ss1AufA==
X-Received: by 2002:ac8:7f03:0:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4f1d066fd5bmr202028001cf.81.1765921102543;
        Tue, 16 Dec 2025 13:38:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b6a80fsm81763976d6.18.2025.12.16.13.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:38:21 -0800 (PST)
Message-ID: <b60ffaaf-fe92-41d3-a394-e82f2d27a402@gmail.com>
Date: Tue, 16 Dec 2025 13:38:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251216111947.723989795@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 03:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.13 release.
> There are 506 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Dec 2025 11:18:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.13-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

