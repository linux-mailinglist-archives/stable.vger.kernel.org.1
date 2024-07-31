Return-Path: <stable+bounces-64807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C25943781
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E9B283DE4
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29580168C26;
	Wed, 31 Jul 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca9RYeeg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD613C8F4;
	Wed, 31 Jul 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459839; cv=none; b=TltGIYjwHfbvq/8qqIGzvDE6ltTsDIDmCYQxGhVO3AcqtxQGFN255Zcx0xheRp4oS1+6eSr0AcmgWaA89u4bUhpS1U14g7LGgjCsiBBTYrthK1TQO17doDGCy0D5hHRJEiRzzSs3s4rXn7dKDEGtwunwHFBFHjX4LAjPpGyYhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459839; c=relaxed/simple;
	bh=AUkJ686A8RH4qcFlXPTcSnFatT/ytf00l23UxvbQAAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXJmLP08J2tCs3tzhVod3t+b1bLnEuEJyFbYdT0B9+aQcYrZr5Gg+dn5JmVnj+UesLSt2EBF6oHh5NdZQoG1ujnoOiHgeFAqbefEI69brHq5W5hXblmr1TCnE0N34J/4RlugVPll8RE/QyGFS/+o7NzXMK/7cl2nEmlbJaWP27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca9RYeeg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso4155260a91.3;
        Wed, 31 Jul 2024 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459838; x=1723064638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HPGA+i9bLxv8+ywKzP8zynz5mLJCS77FFmzEIhkQ6g=;
        b=Ca9RYeegsC4kUwSHnRfR1Yx2SjRyoEHm4NRDdMFU5bMBo9xnfcRVAq94cbO7+zCy1g
         8lbgrywfnGkEBbliD2jkRRWhckkfU0AWBbd2TJSkU8q/t8vJQzatVnyvBhatL03amVeV
         5kK5JDiy+JUIZYvM1O10bRhGy2KLZdrZ53nEXvqo/d1+2NAFKgHFtDPXHBv6oWvILtWQ
         8KkeTIoE5wmmMGqCEnKt2oCjIQcS9t1sqRlYzxuVCFTh3Ui6L5O0ogbO0v28upcFpkb6
         1OYVe/xYQ/ltuuVaSnbjwfKJBPQ1bCsxOi5jFAplYZnkCVNPAPQFS6ChCtsKTf/eWoME
         FYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459838; x=1723064638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HPGA+i9bLxv8+ywKzP8zynz5mLJCS77FFmzEIhkQ6g=;
        b=fDA/TXD0qaSFLxKPoKwdLp49ej5bw9Fwrnlc+8I49aEgYee17gxkW1PBXWadBWvWEL
         QhDqv03HF/ZJgoIBMy3A0T1mrouTAj2DEKggRC0GpZxVDV6UDRuCj3kubQByLXYpIHDO
         5UtoON+ikMrtj3eGu+EK4+KQM8SyM1eA0zFxCIphGjAYY4Zv5f2Zm9kBZKnxUA+2yoeq
         zUgK4SjGpJXXjhsDQI+Nh6Mnbq9dRHEVCn3mBIF2U586ZT9qfJ7ii+DnyvwJ03p5XkNh
         D3dW/+6DaRvf2OBvjlo+HyV975QV7v/fD0iUa8lwl2DOZGjB2+gsu66hEbWqX+dw4Hpy
         gSDA==
X-Forwarded-Encrypted: i=1; AJvYcCUL442njezhaIW66ZqSdnDLRTaeyuaDIYGBp7w19//aBiGeqie4RCyg1weUQCcjJ3NhqYEnBTbmyPptatQ6GzIvGS4f2BMdcZtFjc/AvdSdO577prQYCQ5wziW9H/AbiLho6D16
X-Gm-Message-State: AOJu0YzkS30dMGIl2XF1QIB1kTAqtG/wZ1lmVUWRu7QrSqLrVapmhIsx
	4hq9mHnqbV9bHavhhkohB9pii/N3qgA0QbpXS4Oz+l3NqwxMaFGk
X-Google-Smtp-Source: AGHT+IFk10AYWxbSh1MmvpWEmpv9q0UkSPOj4nAsBLWAvUgWZuIy6nbW6vx6nkjdyo27E1GFlvccQg==
X-Received: by 2002:a17:90a:a110:b0:2c9:a56b:8db6 with SMTP id 98e67ed59e1d1-2cfe7b73301mr634074a91.37.1722459837737;
        Wed, 31 Jul 2024 14:03:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cfcb85b7a5sm2146765a91.1.2024.07.31.14.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:03:57 -0700 (PDT)
Message-ID: <66c69c35-6486-4b84-9315-3a88232694be@gmail.com>
Date: Wed, 31 Jul 2024 14:03:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 03:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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


