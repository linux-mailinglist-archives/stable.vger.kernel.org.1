Return-Path: <stable+bounces-46000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AD8CDBCE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7F31C22A96
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87F84D3A;
	Thu, 23 May 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMJ1Qw39"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5220DC8;
	Thu, 23 May 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499092; cv=none; b=Xw5RD/mnSD0gcfRLHk5aNmlMBKH8+m8FomRIgOxoDoegMTmJhiFt3+J/12hXSqddW57bp9gbXITAInqJUhyqUaeNfjn+m9pi2jJcVWVCoUs4tfaj8zqAL4HMfZrGOztE+r5pcBEn1Rglep4r1vqHLky6N/fDNCyOs3z/QXU5oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499092; c=relaxed/simple;
	bh=pKD8sIzMjawIjx8TgK8/CugVLHIN9wwV+v7SX4LeI7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It6c6EKOukPS9RrJ1dn3qG04w+Qv2RLBswUscsCCV3JXljnRClb0NA0E0G1ZkxnGwx3Cu/pPod8vOC7Btk+3iBY25Rd9EF8rSLGFFqrk0P3nyziE1EOBmAOhJxAw+VXPU94W2kI/W49rwi37nYxAvGJ4j5z/y2rBEJ8+IjrcnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMJ1Qw39; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794ab0acfbeso9681485a.0;
        Thu, 23 May 2024 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716499089; x=1717103889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTQYbO81rVm1d7lRu0tL1hZxpq81q3UNDF+EXPIQyIs=;
        b=fMJ1Qw39HYbJqCUx6CR85tl74Fze1Rxl38CVv4RPpVd4M7kzsMd0d3zK1wxuOhx1EU
         r7XD8Fr8iarkYwB81CbXHAwmzjl/slVvkCUl9s7F4t16F/WqumEq8UYXuAwUYPoF7DeT
         AaFr4JmNlQB6Eidh50IR8v1496Dtfqf9Yhm6VObFMP2cyn9gG/J9lWmDbgiVFEHDg6vk
         CbbCivMsArNU8N7ggxAPXkbGXo/CpHG/aAihIqw96Nsjmny3xR2c24fR1YSnKpze/gmy
         ZkWGLml88EH4gOdmCdm1oWEmS9Kr0qMuMR18oPd5lfbTOMDvwdZIOUa6H9mkeQPNyhcb
         A2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499089; x=1717103889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTQYbO81rVm1d7lRu0tL1hZxpq81q3UNDF+EXPIQyIs=;
        b=UB6qIbpjf8V0+mNWr/JLWZfmKjyujWTsebOX13Kv0pkzrcZNbacE+deIyIjgBtRdpc
         bqrhSem/hbnwmwJKFUD3khAMFHJ/V7xoMA/0f3MvzN+4nvJA/ExKs5ekAkH68lsaveWf
         i8TQmJZiuGjH/pu6q0GjEprzO9N/+nsyu8O52/aDJLlsYZGD825XyDWBEI6I5JncW3HI
         zgVxKVZz+gOPARvF2Z0O7Ia1ueNl0JRL4+8Vdg3AlEQxXBTYDERYYMHaJhj46u9BbarA
         y0/Ldqp4eDepc9Uz8LodCRyCVaWwyOxeQtqg/XACRk35pVhAjjfoiFGG3rmb4e7cUZrq
         Qr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTmlowK4NPProlDuhhFnUU8p0bbu4V1SgCz9k0/LdOJZLWOmnAdXGSpbxjIpjY2uxySlbqvkk28E4N2l4NlsI9fQZUvC0AETfr47849Gc1sD0TfK/ZijpfbC0PGyjampzwd4ej
X-Gm-Message-State: AOJu0Yzm2tAxG093y9XLamEaS4bb5qakNHjkodK9b7SyxFV2ax7IOjCW
	1bsb03n+4+9+UWaCw1CW7JAsiVLWU4oxjNS1z+9CVpbL+f5PFKop
X-Google-Smtp-Source: AGHT+IEKNgehrfnWFRSEmmW1Nx71a31VIDj9r5mseSzNIQPoMxhkHyzmjwbHsSiL2GY4KaItmoBTqg==
X-Received: by 2002:a05:620a:248f:b0:792:b254:640f with SMTP id af79cd13be357-794ab0f8366mr52098885a.57.1716499089357;
        Thu, 23 May 2024 14:18:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-794abd441b2sm1685985a.130.2024.05.23.14.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 14:18:08 -0700 (PDT)
Message-ID: <44602d92-6908-4dbd-af32-f3cf0c790766@gmail.com>
Date: Thu, 23 May 2024 14:18:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130330.386580714@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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


