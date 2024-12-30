Return-Path: <stable+bounces-106562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0D9FE985
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6737518819CF
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5B19DFAB;
	Mon, 30 Dec 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEJJhid/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61E1AAA2C;
	Mon, 30 Dec 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581124; cv=none; b=JDuw1TyClhJet5fK2MwLlIjKsV5d76jKlWGl1QIwh0s2FRtqGdLECWzkSFm6IWAyLVIg0DoY1ukHsL4CmdzZ9T/5BsX59zu5TiK3Ub/CwvQE0SSgW5jVH3Xr2zXUntf5bpINDBhgLqY8tpckkeSIAHT1Owj5mVo8ZxD3JDBPezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581124; c=relaxed/simple;
	bh=HIhOlTdMGVlskCBikR4qRKesMCFZR98N2pPB+yB/2cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmibGpD2MwuSBCddb6fNXioJ4w21/sle1C4NOpSxTeNJiSDogWdkFqoUHUHGXBofvqlQFdBi/ZGYEY8fgHhVFkkTWnmpX0pB6gjeB513OzjmSxSh/HwnWfcsOv1q5NkVUiCoKUaaPZK7mZsKVAWNnM3P7IvsXZdJuo4VXTGXt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEJJhid/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46788c32a69so115916991cf.2;
        Mon, 30 Dec 2024 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735581122; x=1736185922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYSd9A7AF3xQpqmlOyuSY8eMHWA0vaOmsSMGJUj6h/Q=;
        b=PEJJhid/0ADQ+65I5WMzljHvlILuO1mC/HkM10ZO19ny0Zpy31PMvuJjbARsEcPZHO
         C/rDKbXXcLizwOE8afUQbRxIai7y0kaVsFPG0t9bg/EjdPNakAWR0aWHAZCWaA7AxnIv
         0Ho1a1bJ5AjdKHdWJUNeTBkPSiLwgZTp9cEXd5fyc5biq74xKVRkZ4YcMRmAAo9y/31t
         gTeJe3NukrCx+X8Ou2Mchlajn7ydOMJqm93WRSLzc/Q8fLtuWhuf9Y6ioLFy6rcibOPT
         lC+wnIsZoFrKALZDRMLQHOEHAmr/YElHomRHfPhur+YQae/HeXWKeaXuqSwnX0Y5WjMO
         saHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735581122; x=1736185922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYSd9A7AF3xQpqmlOyuSY8eMHWA0vaOmsSMGJUj6h/Q=;
        b=V7RwwZrTDvFqTpOjP4a0aSpy7Q+aZCrQ8dF755myb4kE96136kru2LbefGm6ducGoq
         7E5T1Af/CMLScxjA5hmnB75V1FL0lne5kWV+7Zs7amY9mDY0jhls7KLVMKmuuV/5mtg3
         FJzM/xW82xAM8Jf3dittlsIiE5QLmCZchNt6DocCXBwEhs/vFN+PWHktLcbsaukDbdzc
         fjZc9eR6VlSVAIBOpmHELAj0gRLYQoGGBlzubceoo3yQgbNNzIR+SJeeffZSjhbzOrJW
         Y22F5KJyB5Kd55GIM4qoTMAYepYUK42/a+SBWrevtGYcYzYBJSgie1ATCwBCGT/Y9Il0
         /jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykJ2E2lH6ZTlm9Vvg6YL/QAus4XrRqGyHOBFr46bUBw2tqFt2znC4kmdYLvBIZNlkz/0Rp7Or@vger.kernel.org, AJvYcCWWuzA+kfwwX1B1I6a5UXHfE6LcpBSqOSfbaJXcln4YkxPANwcpns7x2kVN+rQqTE4VeXqX1LsCywGYkss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyHmUdI+8jnAZ/r8SAvJtBKCzpzMh0nguLLX3jV86zIx/JZZF
	YgG5a9P4wSUoGUZF9pedkdepdRNrEQAqIPjoqpPsYzVIA/E9THPd
X-Gm-Gg: ASbGnctUS9v9SeyMmE+tTya0FUQJ8V/K/ncZD5GcaU28IBe6OPx5kOMAo0SLVjD/fnU
	XEcWxpIDIRuvH0gLn7hL8GRfxP9LdROntQTtcgNZGkmHPzUVHnlEPMuxupGxmoABqSR6l97qGdV
	aPAy0d/zhwpxbsj13g+0dY/N+tAHql4gxshObnQrcgN2udy6BAL1cVdhh6o/MaxX1HQAjmUiFAZ
	V5cmR2l6WNxNNbcHqUP0hvfFS7n3Yb1e5CjVu2rkL9BPjJjr36yrl2MfF+EC/hnRKjJL1B3bo0p
	84vUd+ai
X-Google-Smtp-Source: AGHT+IFHCp+Gz629eJ4WSSf954j66vHSHiT7HV15E5avPD/rA/NBaRA0H5e4/BtJZjRKBCEXUboVYA==
X-Received: by 2002:ac8:59d3:0:b0:466:b122:5143 with SMTP id d75a77b69052e-46a4a8cc456mr554241721cf.16.1735581121844;
        Mon, 30 Dec 2024 09:52:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cb04sm107513581cf.8.2024.12.30.09.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 09:52:01 -0800 (PST)
Message-ID: <7b5e04ea-9ccf-45bb-b3e1-51a0fae633c2@gmail.com>
Date: Mon, 30 Dec 2024 09:51:58 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/86] 6.6.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241230154211.711515682@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/24 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.69 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.69-rc1.gz
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

