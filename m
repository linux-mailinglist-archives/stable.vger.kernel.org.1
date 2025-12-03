Return-Path: <stable+bounces-199946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06BCA2008
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 00:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C967300EE52
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226F2F25E7;
	Wed,  3 Dec 2025 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3kXn5XO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB92EA14E
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806124; cv=none; b=s3wdWp2dfVFZUgzKgWGErsiVUNfI+ldp9N9Kdt57XjGqZwAOY8BPLBArf3DqjfV5iw61oPc0C/GsHNy1xNefodtD9DiOhtq7o1RNoGNkGEPwLTYy5STkFcbwgdCbUu+8Q6H0jnf2xVr7pZMIomNzERwpuAA6Qgm2SzkAdbdGpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806124; c=relaxed/simple;
	bh=TI2fK4uIvAg0wDiX9zvQGGRTrBKJrR/dr0pn6GaiD3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMJpd69EPVcC9Ht6Rgi2PmfR9Y1O1xrpv3nQ/e9TmjLPHnOhE87BZ/SpWi/7XyYDrVkA99MAFtDBbuC7LcBGICnE52Ypivkt1WYirD3V2I75puYRvoD5hf4i2QjxdQUi2zqMfqSPEYfrjQFiIHIGB6MALFm8x+kakuE5HqHItlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3kXn5XO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6cc366884so169949a34.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764806121; x=1765410921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um5TvcK5XxLxS4nCrV10IJfKpreOaPQmAH0ISfnvY/4=;
        b=Q3kXn5XOnLIdLE5m4JITDrQpHCBe5+lB9i+g6oNQ5jmv0sghfd2k9UFf6WsTbyDhx4
         WYdL83pe3DIZaChEeejmaUBkbiPER/hlqcaGlMFPQLBmnBZrp2cKLCSsaOWgjcckimXv
         fMwTW3bI5kpybDtgOTOvNuI6ZARJNba9jexjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764806121; x=1765410921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um5TvcK5XxLxS4nCrV10IJfKpreOaPQmAH0ISfnvY/4=;
        b=nVPMOHowrkCRuPw8sCSSKPO81eFhl1WKHONfw79K+uGIT4Xu8VWv+EqiOop97J/dMT
         YhRe3vsEu0Xzx3Sk8g1iOD0WxrGgMsU+YUOAx8ZcBCMFzC6YmZf/nzAO9ufbDcAIWMGW
         zWBszy4+KqhqGa5hcbkoGdXV6/kXwUCIwgDN/hQKhGsZe2qDlrUvtpmGyfCNWmPY0QNj
         E5UmrnrA8yARkeIqltHV7Fh8WXhz/vNgNf6IE3EJozJJRooT4tjdRkiu0jzDF7dQL20a
         pwGgPUKfg5DwrfUv3OviBpYLzUaZjr5Hx4ROCgwNcbaqXfBeGEUwQRxaA0vZK41q1gr6
         EKfw==
X-Forwarded-Encrypted: i=1; AJvYcCUJPsKdGTb9tuFzIaQ49OBcWhCSJdGtu58d01yxBjC8L6ZDCgUseWc8vaGQaAQOdX8X3gD8DRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqdDhoDss72qVItHQ/uBBKQQyHubmsrl8Pum1SO+WkTuCi2PQ
	ovWv8RqMdoyHQpuGiNx9B221hThdWb+NWAcNdGH7QRdANacpJgXmB8r93u+hRU1Hrko=
X-Gm-Gg: ASbGncsM3UtYLvCvFJxbpRCNzh1xzX1os+ee7mM+nKrwYdA3FMGr69y1kDAojjsqbmb
	gnJ67/ATOqpRWmpnB9dUQs0AkuAxRgjBFNEu4Gw4I5RrKoHcucPj1WSG2MW0XhjBWml3JOeRC7O
	+ArAmsigajMCOV6Ot8jCFtWqryOsvd2tb34d0Bwc5f6bvUe/EQvDJCZyAdLmR1SVsweHdPKpriR
	wkdAIDDcp2TXXgxDOSxMOaHSMzk5+/GX6R+BaoJTjJWkT1ZK01Zl9RNRxz3Q0TOxVkeWZ4xCffR
	Fo1lDRvleOaPZspmMY2x95DiXMUkQe/Qnvb/t/izADZWcmyhL5gLDrQCWiiA09msO0JYFIxkG1n
	l+jYDnpHflw81dEQtW/Za6RzcR0O+vp7FYXKJqzvzTermKinB8ho558RGtlh2sV/O/SUXJyEvqP
	0n0RUlfdoWAlh0z1YQPj9/tmc=
X-Google-Smtp-Source: AGHT+IEUp+ZDnKfcWMM2+K6BqrUk9DPE8wqWpq75W8szfOEgMKPkZovh9najOUi2FHBPAkVEK54MsQ==
X-Received: by 2002:a05:6830:6502:b0:7c5:3045:6c6f with SMTP id 46e09a7af769-7c94dc04ca3mr3907160a34.20.1764806121487;
        Wed, 03 Dec 2025 15:55:21 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc2b36sm6629525eaf.12.2025.12.03.15.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 15:55:21 -0800 (PST)
Message-ID: <4ca25a40-ef8f-4190-931d-c44c7800e5de@linuxfoundation.org>
Date: Wed, 3 Dec 2025 16:55:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/568] 6.1.159-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.159-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

