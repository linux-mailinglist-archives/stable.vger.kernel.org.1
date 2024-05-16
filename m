Return-Path: <stable+bounces-45318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529E38C7AC0
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB831F2271F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24728382;
	Thu, 16 May 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlaNABtO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856784C90;
	Thu, 16 May 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878644; cv=none; b=FWGdt9dTwXhkizorz0x8LHfgPhQvQ8CMVfCHYJtZuEC1oDma6Q01Ewi1PpihOQLANFBzbpzZmLfEWNKt8wANt1x34Dcqq2/VXTq63q9Ovfg7TyBUz1XrojM5durmJyZMPTXFmAgjGmVwhxMxhzd1Cmhcb5AAqmRkBjFXogHW+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878644; c=relaxed/simple;
	bh=eFFVQcl1g3izW1Ue47+S2VYYVJe/1FsMDD82U9A3EGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URBv/TxX+0durcUh26mEf+UibXeIWj1U4vzlRmqM3H/BlAF7NFOoGJJulCziwuPTKIJdViVn+bONhiVjCtI5RortWINVzRWlbiVHZNIH38JJXKkr2tbfoBsRVJcKKP1YfngPfWrZ+YtEz6v01hSesDTDweN0u9lYe8BM6evRR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlaNABtO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f447260f9dso417973b3a.0;
        Thu, 16 May 2024 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715878642; x=1716483442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2bhLOB5Q9K5+OsYlbLnqM08/oUvfJSr9geEiHh0y64=;
        b=MlaNABtOZxzFHmDildmD6pf8tWVfLwqv9adZv0TvuAnY5anMm15aJxHQYOu9YdTEx+
         f+fxLA2QFFq8UqOTTj2HlnmdBynMs8/HoF9bCydSZWjAvg2ALU1W6v+WhuaHzj6vJVr7
         kaMHIkTzz6bAKyJkBpHYgjIcCfBDlr+U8fQ4iOxqrPQumd2UlK/hGvgwXsyiiQsFcpEP
         10ih66mTEVMvi52k9wdG8HU51sIvFSE5oai4Ct9FzTeJ4eWkCE4mFLfF+xSZZHuRv6yX
         0h7uAhmwlWWm1XV8491C2hjg+Ts/P5xzI4iWkXttFPopK3apBS2HIczTjZa5ssFNstyC
         mRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878642; x=1716483442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2bhLOB5Q9K5+OsYlbLnqM08/oUvfJSr9geEiHh0y64=;
        b=xDMbzTs/fMHwuS9k5rczEOwtWaaNc5sIpIkS7bNlyxo6x42KKEetPQRm09rWUFuzYC
         cBK4kVeGw1J/RzIEh5i2f056e+lSygiJxeWvuG+DGtj8x50mWkDDTfHni9LCeUB5c/Wi
         N+v0ienyATOjbaMVyTzdL7I8tToz7/RtlYi3DxjIIFA09q1qM1j1xd44eCig/7REhIvR
         hX++Qlrr747Xgqe3Yzz3r5e7/n80io5TQCbR4l8qprlVb//bTEslvoCqjxmOsFSq2lyN
         r4XBavjOyS7P06w8CkOl7yKzfU9bn2vKfvKhLLb41vwNLoxDPAXJG5A/0mKqfYvEGGVf
         hSAA==
X-Forwarded-Encrypted: i=1; AJvYcCW6HD2XPu3HLv7CxxY3moDBKpdxdJgs00xurmE44Qc+PsTLpWAFno5Mof/7pgQlpBu+bUwfanCaS+Z+u9IVDg42vPX6SfyHZDr0xYtjze/8Q+oZFkFW4R/y0k+OLbtoZn3MIjhA
X-Gm-Message-State: AOJu0YwfOfgzr1sIq/3ZtjYOe4uwjpkuVk/cG5arkLUqtJwfVwC73MrB
	Zt1dD3Ix3GecAtDnQdjZ1+VQIuON+r0KDBw5T/oDehNIdkLrSqbq
X-Google-Smtp-Source: AGHT+IHlh7QdmSS3WTCAoIXebwSunD1syWEbtM4hHp4cPjVxYk8uj2sH9HnFjZi2zCTFzp0kyKDsNw==
X-Received: by 2002:a05:6a20:43a8:b0:1af:e09d:d98 with SMTP id adf61e73a8af0-1afe09d1066mr19267558637.60.1715878641527;
        Thu, 16 May 2024 09:57:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f684d88710sm1306325b3a.80.2024.05.16.09.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:57:20 -0700 (PDT)
Message-ID: <9086d2fb-e464-42b5-a264-1000917c6bbd@gmail.com>
Date: Thu, 16 May 2024 09:57:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/244] 6.1.91-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240516091232.619851361@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240516091232.619851361@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 02:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 May 2024 09:11:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


