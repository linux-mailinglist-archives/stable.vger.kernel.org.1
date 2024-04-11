Return-Path: <stable+bounces-39239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7738A229D
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC77F1C20336
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664B4AEFE;
	Thu, 11 Apr 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxmSpXlm"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7C47F6F
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879478; cv=none; b=QU5V+pCnBcl8tBZOPnes3x6D4USpC9vnWR3jaKtD9FaJIddDM0k/K5T1+lNTApWnxiUm09eRpC3IndAYCMSWskqmeTIZpq3JjqbQOorIeeQZkYzVT5urRJ6Vw+0CA5y3cJPmtp2J4J+bZDmPj4VHN6qgyeGHLINQeX8iiqOPOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879478; c=relaxed/simple;
	bh=5n/c10tZw8i8ramDDL8gGaAfX2dPojeKb0kPmPkSSRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4hmBcpJ4cfuvTECHwhyxIJXTUipnxdQ6qIGhMQD1c5qtdkfKhPvTeGC5mo1i2Trv+d+CXrzd2eB7QiyBM3pdboTn2Fvjd5HOC5adq3Whn2ckISq9LiVwqlMvv3Sa7k0smjZZRQqGOZ/DamAtOkZch6TRlxUNc4rKVoKicvH+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxmSpXlm; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a1c0bf9faso296365ab.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879476; x=1713484276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTOuSbb8hB+vYzGueSyEZMnAtdrSDuj/9HdWkOKBA30=;
        b=GxmSpXlm5JWGeS61UaT5VjpJFM7Dr/iTtUJgdr0aGjKIE7rRqt2F53hC1NxEuhFDN7
         1aayl2Fe13Pr9TcXVnUCH0UxawBEOUUgVwlJyN+0uoNGiOrbcXItwsHVrWrHQ339Nqx7
         Ss0T6v8vYFxj/vz0+s9Qe7PapOpy5iojZv4rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879476; x=1713484276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTOuSbb8hB+vYzGueSyEZMnAtdrSDuj/9HdWkOKBA30=;
        b=PStfugQDzVTNuqSStWgHt1yp3ZD55ucTF3H8c7Ohb+R5ncvH2/oimxVTfsYyH3KAR2
         Oex/qQOSUCj1RtD/xX5Q6Q4BUGLwK/eVFCa0wT8FF81HE3BBGWv7tj2HMgesJGTRB2jU
         s68RGovZJsasPW5rp0hd9GCJ892OSCukJRN3LYu0wDcfyeDTKCxRfd1ssDLnwEJsWU5x
         XXPN6nrKDCUuUmu3cVoYL7fx6ibI9jSIQL0ZwGB0wMbzN5Bzxqi/3wrG7SrMIgXFIQUH
         Qw7NpvxUkBDms7MHXn38Ica05OnyVUCMkyEvn0FW3UBXafcApNLCw9H0AfWK1otNHlhR
         CO6w==
X-Forwarded-Encrypted: i=1; AJvYcCX3n2pe7xLUwYWVhOXVEUJOx1wfHTRE0/1GqERHTM2ZDU/7I8KbmBCUQ8pjovet3o3CPol+Mfj1LBwFTlacD+Sf0e7+NJCv
X-Gm-Message-State: AOJu0YyoiWd97s48IhFF5rs/Df+V7OQsZiMksnDasKYYt0cp6G9ofR3R
	kEpcKrN7bzL/PpcMOHbfyGQaCElpkQ00Iu/AGCSPnC55qJggjiBI1/bs35Q0Y5w=
X-Google-Smtp-Source: AGHT+IELDyd3FIIEpM35tZjAK3mc3g8KNLKNwq9rZRUw1w9eybeYd4+fTEfh95HgJWqypKO3mqmkXw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr1352400ioh.1.1712879476075;
        Thu, 11 Apr 2024 16:51:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id is13-20020a056638850d00b004829581b0d4sm680676jab.111.2024.04.11.16.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:51:15 -0700 (PDT)
Message-ID: <2fc1e5fa-07ef-4045-ae31-654a14844efa@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:51:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

