Return-Path: <stable+bounces-142870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4EAAFDAA
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1704F1BA2C68
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553D2777F5;
	Thu,  8 May 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkzQtZO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46D1D514B
	for <stable@vger.kernel.org>; Thu,  8 May 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715679; cv=none; b=Fu9LSt5cJ0d5HTN5Cz1v6OO8jnvSPn5DmwS90JBO34hDvlOgmxrsNjUOR0vBfUCceeL8EjgjRc9kHMcPJ/q0X3UnONDiXCSlSAzxHBXxnDIyn2CMzBPuTKIjBQnoC4n99udpbXwlPCxuaF9erwVc77mKwUZ+YlrHoGCdBRS7T1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715679; c=relaxed/simple;
	bh=OP0WRNpQ3AhTCII2JqnV9mcyFJ8DbeYGPnHp7gBLYfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db25L151KQwTGnlR9dSib1T1nIq0jxG9Vx+/bGElNtEgDFuJx4rT8cBzqnDsLqlORYGcLtZgE9fHeuccFhKCUxmf9LAIVXrFD7X4KTWEuDCV5+l1vPOHcopzAgdC+U62O/ZorBJOEsSTCVy+voljzJN7sRSEdNm51krpAGF3nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QkzQtZO8; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d071fcd89bso473741fac.3
        for <stable@vger.kernel.org>; Thu, 08 May 2025 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746715676; x=1747320476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbKXS17FLCeINM3f26BpfyHxYt8ulznWKq5GCJKKZ7s=;
        b=QkzQtZO8aY6n3+WjKEIL7hwWinNpcpRYlo4iqe/lflSF9tRKi/cvmluvESHQi1feNi
         9iRHotQSUD4gIyl32OQV9tzXIvCaVzNzZmnN1dKRkJixlXjtQi+feAlCtfmMQ/ctMN6h
         ZoEIMxcI60owOdTWdo3u5OqfdKfEppQnGcx0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715676; x=1747320476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbKXS17FLCeINM3f26BpfyHxYt8ulznWKq5GCJKKZ7s=;
        b=n2nx7P1/YBHKmD4ajcZnhikKbgsJ2DxGEc9K2CqwVyDCMFTyyhdOd66y1sMm0Ik3Qk
         C4aUEZ2qpQuPsFUXOmkFlQsN6F8UQKgtTTecrbij6NylVNAzWKyNPBn60aNiCJDCF/GW
         V+t4r+CXIJ5cI6lWDkt5CiLY3phbfYCauZmLhfeZTc2dFNqlOzqxPNVd8FiSeFVs6ywe
         XyaBepLj4JlTkuhIbEjRJWtZu+CWwPj5T4H/WfQeECW2De4y+D12EvIPRPqYrxEan3bT
         rfxrvNAsp1zA7Lo1VZ2OmVaKgaoK7Fn5YqNR5DLMYnpnuWvsrkHmhRQwxasboqwpz3RY
         Q2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFzPBh0Xl6A09w5BGP1/C/MQMmdPWyW31BNrTFRU7ZwLdJYGOMsNYWWBDFJt4db8AxrcTC39E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRu8T+iHeDAYEljxYtOsXbPpoaSlnvn3R326WoxLuXJ9F+zr61
	IqTLdrSpc8UZHS+9vwu0CXaMZ9klDJwGr7DwZESWbwwSfpMzNrYBl5bG2IHlQZk=
X-Gm-Gg: ASbGncu/k0mCAB8c0Binci+4FfGo2fgl7ZX+2tefYYHZfNT0aiS5z4Hw/Cgb71Hlh/N
	EopxuswqDLuehqSGT2y2G6U3zta8rZYjEYobo3ALXj55PE9i4QUEa6Vz+8veeZhkU3RGzotyP/R
	Xlbo3SDloNqD4/IDyIRO+1WqejdxyGtIaUYqZZ3fgpvaSTrsecSy5TkNN+vM3ex09YRmLHCAGDU
	rarbSaoeU4/9+uGZP5+aJjjhx5preUFUcB2XxzQ84VtK/uOsvhK60zHT3nljk5ZE808/NGTDD0r
	JMs+Z9vjpjF/khNlKskd7h7gm7CcXLMcGRg36AwTC/70QdSbJpw=
X-Google-Smtp-Source: AGHT+IGEA5a4mOTrYmH7D6XLU6ZecdwkH7ReVPSCIEcHWSuV4+go/qkk5dvHLhAUPmYAL8ZzKUhwxw==
X-Received: by 2002:a05:6871:20d:b0:2d4:d393:8e47 with SMTP id 586e51a60fabf-2db5bd5c4d3mr4693133fac.4.1746715676231;
        Thu, 08 May 2025 07:47:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a91977bsm3220210173.54.2025.05.08.07.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:47:55 -0700 (PDT)
Message-ID: <e6503d21-6e95-44d4-bf84-9412d61d7605@linuxfoundation.org>
Date: Thu, 8 May 2025 08:47:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/164] 6.12.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 12:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.28 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

