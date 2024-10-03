Return-Path: <stable+bounces-80611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B498E788
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B7DB24C75
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE7EC2;
	Thu,  3 Oct 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ML4NqDVb"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D6629
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914045; cv=none; b=CDpSgNBnwg2rItTgyNMxO4zds/Qxo47+j/Pz7c/faVd7VKGqcQqSyTqEKLD4HVq9P8CyBcY8LdTKSVUS7wzmeW5CX+SY/PVM1n3CzCBrHhe1UW2M0ZSHfYUpYU4qVpoL0RzhLCMATCD634w/qcc7P3/sBtensivrD1qLABDAUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914045; c=relaxed/simple;
	bh=KbnyX+ke6vCrBQO7YCH7P70zqCNUK2YM+P2HzLj5PpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C21MtfUeXKgQukyqIi8arGLpGhlb+IoCxMevUo7is0yCG28Iyl0wUeh8LiRNZ6rFy31eW7B3BFxQDW/ESCBsgYH9fnROx50PwvVcBF/LsaJEPXeH33ZknLZr64XtZ25oRuy1TN4tjHcVY7Qpuuo/OXWcLaqhiwWJ9s99DFB9GDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ML4NqDVb; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8349389f9b8so21387539f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727914042; x=1728518842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ys1N4TFcbAfveAyNDv0d6+oCrQY2Yusy+lDeHbpoqc=;
        b=ML4NqDVbcn47uZOXp9sELoKo1ThxQEblNhb3SqCSDdd4ZVPdLpu2n+/0/snI45Cnev
         H2HiZaXPcWGr9f9vmwCwDsm0x1opS3b9Wgz73luJ28wCnfowrmjL39myN7dTANGd8ilz
         MBYqfz0SrHhwZ0n1D4DAc91V6X9ML2JG3B208=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727914042; x=1728518842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ys1N4TFcbAfveAyNDv0d6+oCrQY2Yusy+lDeHbpoqc=;
        b=HJEC5pjKNbMnY+Jkm5NpUaKXKp70S7WT5WGIYdF6zvZK7xNSrrF17ve2msfnOmLkbg
         NIPMssSzjkM1K8p6KfvQQ8JND5v4GAeoa4ZfD1b0+avqjiG09E7i89JALW5CI/05RXbi
         VFcpft3fwFYNbdYiwtunRiBIWThXxTe3wd14RgFs2EEunQuxcGRXIoZeWo/PXWZ6y8vY
         3RCcsn1Is9ytw48PsesYO5Mcmm3nXtUHKd/UvxR4sSaclxtGBiLLm0rwdsK6z1mc2IEc
         TzKkmIcFUPMOjms1e+Zoz4x6FkArHzlXf9ocWzRgzBJCj2tiy/e00fA3OyfRO9F2v6oC
         tsDg==
X-Forwarded-Encrypted: i=1; AJvYcCXyU46axGnxhaalAualICCsT5l1JIYT6iroGcrsyyToF87SWxuIylTKnZgssBin1bwLISPAAWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eR96Y408sfjtPt/KRqCMkf09BBbcB2///6YlPlC3/zTkwiyc
	mre3VZ4QRkMJw/JDiylv6JZD3q5GhoecwYO3GpTvRls1vVdXkvpGX+P5lyW8u2Oc9YJ52s/Z4gF
	Y
X-Google-Smtp-Source: AGHT+IETx/9SIddamSPDhDCVVZ1ODHhRsUEsQ4/pDsFSxBCTAfy/o2mUqa6femcwhdISZPK1VNCLAQ==
X-Received: by 2002:a05:6602:60cc:b0:82a:9cab:9be1 with SMTP id ca18e2360f4ac-834d84c847fmr408199239f.12.1727914042518;
        Wed, 02 Oct 2024 17:07:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe37c65sm1755839f.48.2024.10.02.17.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 17:07:22 -0700 (PDT)
Message-ID: <a9f2e3c6-7e4e-4fbd-8a79-b3fc011412e2@linuxfoundation.org>
Date: Wed, 2 Oct 2024 18:07:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/538] 6.6.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
 <e500ad8b-07d6-413e-8fc6-2a9afd5593de@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e500ad8b-07d6-413e-8fc6-2a9afd5593de@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 17:57, Shuah Khan wrote:
> On 10/2/24 06:53, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.6.54 release.
>> There are 538 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compile failed on my system.
> 
> libbpf.c: In function ‘bpf_object__create_map’:
> libbpf.c:5215:50: error: ‘BPF_F_VTYPE_BTF_OBJ_FD’ undeclared (first use in this function)
>   5215 |                         create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
>        |                                                  ^~~~~~~~~~~~~~~~~~~~~~
> libbpf.c:5215:50: note: each undeclared identifier is reported only once for each function it appears in
> 
> I think this is the commit. I am going to drop this and see
> if it compiles.
> 
>> Martin KaFai Lau <martin.lau@kernel.org>
>>      libbpf: Ensure undefined bpf_attr field stays 0
>>
> 

Sorry - not the above. Here is the one:

> Kui-Feng Lee <thinker.li@gmail.com>
>      libbpf: Find correct module BTFs for struct_ops maps and progs.

Upstream commit:
9e926acda0c2e ("libbpf: Find correct module BTFs for struct_ops maps and
  progs.)"
thanks,
-- Shuah


