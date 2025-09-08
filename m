Return-Path: <stable+bounces-178989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BCB49D1F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9969016F529
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315572EE29F;
	Mon,  8 Sep 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbC0xkR8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839E1F0E2E
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371931; cv=none; b=RtC6wVfcCx2UZwv1ljxQJ7DpF0FFTy1dJxu3XL45x32lB1vuNr2LfJxcEn+ZvQDgaiTFPyTYLrO5UOBmqFDcpF4Y6Z+PYgBpFzLjj+69/3UJRKW81+7AojAKspnNBloqXSxfMMy1wiZvxhdwbm85ic+rAzOtpKopOxmDcqI+OBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371931; c=relaxed/simple;
	bh=hfXJRklhNrqNgOO3gqE89RdVEWhgtTk71OX57h5wA2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXk0pwkRlV6CakfTwv7iTOMQC0tq/m1B601F7g47djb8pA5XLQtn31h914+93vflIoMzzYt47oNdC/ORNbCCFsKSor5IhbMGwfouqESkQIsFVERo66lv1T1zRXisQXTLQborPcsGscUnLMBshfzAn+9li3asz7yQLZIP2aXw5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbC0xkR8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-40809f7ffc7so6283965ab.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371928; x=1757976728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K80z516Bkbs5y8nHg9W5TbWub0+guzt3PhdAiDrzrS0=;
        b=IbC0xkR8Tc//ihHMs9bNL5jF09t9Y+VdCautYVZJL9hypI095UFoNFfPhgF0gNkGdv
         B70ufS1SPGIXdX/DRIJ0GLOQEUSB4q14XCBGKi0D2frDFlSQdQqWkjzmxvTyPDPKmfRf
         Wx9TrQTNsxvGfeL1Wat67AzKhkmjFG+FRXvvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371928; x=1757976728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K80z516Bkbs5y8nHg9W5TbWub0+guzt3PhdAiDrzrS0=;
        b=gHceoV/C6gpKu7ZLZZozAeH2Huv4esRsMjE/NZiWoxip3i4O6BPXbKPrcby9gaPIvN
         B4X4P5jWh2T5vcI9lC/peNTs2GbWeRX8r3O5hF+Uzjptbhya2FxfiKTNeRAmj2bZkPbR
         NrwaHNiuySCcfKHFtOepSyInMbBul0KyDQfzC+iC3yKRAT2DhuGLBrEy+eKWMdF62RjS
         JeTyPCLzrB+YDNwSnt/Tq7gAEB9CJiOY+8L1nLDWnno5vTl2dFUYDPrnrSinw4Ri+UwZ
         q9tY6Lp1OUwG1SINRC1QvP3R390PFrUiwkNhF2HbUKYHKOqKIpdoNa4fKYSFmeqyu9+K
         jeIg==
X-Forwarded-Encrypted: i=1; AJvYcCVfGc8px7Y9DpsMZR0KQzA4PAkQ4DWDz4bUUMj+gs8DIir/SvntRnulU4AVyN/52LZek8m9mJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9FCFOt4vQ3ZGvpx8NX8wbnHPr2DDTrU1gS1cWumO243MZBpN
	4vAem465/iIfWB83RyhtYl3F2tzvqU5TZdWgQ7lGU396omX00slG9rxMZpXSLAXuQhzKWe6N3+p
	OZE4L
X-Gm-Gg: ASbGncuf2umGpITSVhIgHOtbLr5neFRMVGUpyvjbJ5ZDBX0YRuy3nXzpfuEI56uihfE
	ukab2JOJ7vkvWpWb1DM286pp3t4UKU6h025pVWczoTU6psqtau7I2S/2ZILFbmcM071erlcemOb
	ly3baR9qe+IHDx1Vx9pptAP605p24dj41TbFvWxItWdpCaWLIl9XxE4Pfh+4WPLVdLs+NTmE0kp
	0ddan1NYE3boAR/013ILamATiesjG2KiDF35/potRqDEUxe176qTfIOKLkGTR5unUXD+ylyMHwD
	olC8PX0V8YMMUVFXVrA7lSRc4/mnTxVp3nOcm0kE93Q8MMB6adzElKbmPxItFs88ZNWxiam4FQS
	H9CRaO6eNx3mLtonfQRdx105Lxr8wT1vrWUkD0XtM5hWhIQ==
X-Google-Smtp-Source: AGHT+IG0SswkXVluvMIZNs4Sx5AK4Z0SqnwhuqTZrY+edeQ0Pv/2bKDY5ow0cu/a/aQmpuNgAXzn7Q==
X-Received: by 2002:a05:6e02:19cd:b0:407:dc0b:7ba2 with SMTP id e9e14a558f8ab-407dc0b7d0cmr83195055ab.3.1757371928306;
        Mon, 08 Sep 2025 15:52:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104c4caa4asm4555133173.41.2025.09.08.15.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:52:07 -0700 (PDT)
Message-ID: <3ad4dd69-7a3d-4708-bbb6-308e7d1b4183@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:52:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.299 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.299-rc1.gz
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

