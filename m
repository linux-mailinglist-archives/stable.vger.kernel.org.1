Return-Path: <stable+bounces-160098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D70AF7F61
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FBB7B6F2C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C41E9B3D;
	Thu,  3 Jul 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn5hSX/b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F321ADB5;
	Thu,  3 Jul 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564857; cv=none; b=hfzwyzSOfUq6dhKfG8Ddkc9tqGUxfZxmsb7l/MHlcL7pfGFVSqLcqFVkyVGAyG+d7YrKiL76hKwwMUl174LZ7L4q33wdKpt1oSijv/PvBtN/TPfAAX/rCU/B4EdBs1wCtvPPBnjkxtZJES2XY25Q+bMHb+ZU0E+Er8bKaU3eag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564857; c=relaxed/simple;
	bh=z/XqvfHH+o8HjoNd37Jvcw+MMU7RQAv24xWmlnpctdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ1GIninRj8Y44EUR6rD6Ji3rC/EAH4jHU7IEH//hAeWwaD/FqH5TEJ33ix6LCF0YN2Lp6Zpm5ZnMTLLAX8WCNTnK9frGvEwHUWOYfBBpgyaZfrGGZ2KLe/ygY3euJhtn5OGDvqHYdstvTXDHLrXmdap9nYrFcKDnrvwQ6V0QiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn5hSX/b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so1903605ad.3;
        Thu, 03 Jul 2025 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751564855; x=1752169655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=conF8W0S8vt5NV1q5V+4xWgkkTW7kP77L1ugaCqJfE8=;
        b=kn5hSX/bVqZLeE+bYOJyV7ikcjJ9j04uUgm7x8hxgPUVkgGdGHEImyALFDD/RQjU+q
         H4kMr/JNIPiICIKfIG4cGk3vqmgDYNV7lm8i9/yi1/LozxDyfoeVgnOPjcNIlTbwlxvm
         DpG2Gn84xITE4nS2DC5BRSYpD4rjlDjUPV5dP4BFjUVaWcX/+5FkZro4Gaf2iHPPjMkt
         kSgZD2bMSl8EjIbiWqGPPOCMnCVRUNUA9H0KMyoYNH5iyZsdFfeP5PirhIkAfX5Qsg4U
         IPfvvW7UPeWc576NocfGDSc9+uDgA/5y3XzVhT+JOaNUZC/ASZwzuGo2+/fZUKq3ZEhD
         v3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751564855; x=1752169655;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=conF8W0S8vt5NV1q5V+4xWgkkTW7kP77L1ugaCqJfE8=;
        b=KPF8Mmb0WR+iSmth7MUPp6LylBgnRF5HISP/InskFfdeop8SBGpetK2FLTvxnb4ojO
         AJnYC/lG93MxRxMyrsPBIXT1Qb/GtAVo6AlGVT/fHKKSBcM8LlVoIFWr+RvITWIrRc+L
         pnH6d06txPSfgu7/imD0T4oiba5QWHHwco6uTNt9rCQFUGJuRJNBpX/9BajC29fADqyA
         PGLUa+Eq8W4X1DVsrKmz/PNwTevp/YgOyYKTmOKPeutXf6xj/pnHM41Unl8wYKngdNQ0
         Z/AMhA8TEJkOaCqvsKA0cXS2u7Da5twXrXwvn+Q5PoydEhPNNco2lYofvqF5Avka/o81
         i57Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX2j7+uRKoQ4YHnp1R0Up73Gwj/D2rikRJQGiaAfFUDzl5xKEv/+rI+KfreqeVUki8m/B8NiEa@vger.kernel.org, AJvYcCWc9rDD7wlM5RYo93cLpqLeo7BlQEHhEeS55SglrmifuW5yl3Gu1dhn7bi03i+k0Xdgfuy3rvGkaQVlBMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsCjI/ubewdLy2R40OXoO7rkBrHyb0d2sTU0rKpNIwYCn+vIS
	UZL3dabyiMY3bvEXgMqunB5VbnHISQ5A2QcpLwwx9uyxPF1ar2unIwdl
X-Gm-Gg: ASbGnct4Jdng2fZzqAzSu/4tVEUcmYDqpRfhkWOikobRL/PpUlIoN2dMHoCEwAfDJpz
	Zwltru5wS4wG0s25UoOqVn6SpIkeBMvJlSwBkxB4LVOUf/hgcZSuSvah3QvsfLlmxkWwup+aUEn
	tUZX4Ci4VCAteaOetjGeEk2GA/+O+zPUJSqyTtuJdUddF7fklncRRADx3exP9kKLdNpQh4pMnno
	PYBWW0FW4/Mak4Naa46Lj//6T5KixdtV4t/UvXrSsPjQtM2Ty+JYPuNMMHjCByrsj0Sov1sqijt
	SUsMnCV0mMnGjIsGKLjTTU206FOdoxoa1ltoH7rNUrZhTf5BZ9UEWYfyF3HK80dSlf2hDvmEWJa
	SW+L+P7nOpvbnIw==
X-Google-Smtp-Source: AGHT+IHOiMYHe86AtIZKT/Bf2Qkx52cYDf7+LG9U2zlC2Y3YltBfnE0ONWF+I6yPXSLPMfQJutsvyA==
X-Received: by 2002:a17:903:3510:b0:234:f4da:7eed with SMTP id d9443c01a7336-23c79819bcemr71828105ad.44.1751564855378;
        Thu, 03 Jul 2025 10:47:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457b27fsm1000005ad.159.2025.07.03.10.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 10:47:34 -0700 (PDT)
Message-ID: <dab3ecdd-5375-49f0-b4e0-5b51dbb1fe3b@gmail.com>
Date: Thu, 3 Jul 2025 10:47:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143941.182414597@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.96 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.96-rc1.gz
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

