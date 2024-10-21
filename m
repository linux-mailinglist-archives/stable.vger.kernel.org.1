Return-Path: <stable+bounces-87645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42E9A9352
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC2283B5D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE21FEFC1;
	Mon, 21 Oct 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dU3avb9D"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A281FDF98
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549761; cv=none; b=FJ0iuFD0w5Q7md82W0xCBfzxywdZ1mxB1bXame1oiuBtu/fHgLqyRyO86PFOrhsui3VXuTdu1gR9fKY9v1eQGeIdGbT7fwrR3+xSoxGvgFAd/nkB6D40VjttqOokFvpOhCosBUhCmY0+51bB+2XN/7DZGUjx+/2gJFg3fjdvIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549761; c=relaxed/simple;
	bh=DK5cAoaLipLQJ1Qq11dmR38yV4BdPfJO6Co5qz6yZms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SN/Y3PUFX5ye+vf/pdR5rO0MPR0o34RKHZ9gi5WqzZ0EDyb8bHkuYkzaE8p16ob9/MBsalTuKEa2GADOAb5rlUJD+30qNAu/OXtZuwXROWwY0l94qUPQbHrz6HAeowe1AyB8J8Te3yEIfSzky2KmZnMhJaziU/O1FKWJ7FXA22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dU3avb9D; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83ac05206e8so122929939f.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729549757; x=1730154557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA4XM5hTiGNOd+KQ3u3JDVeWEwmpgPZoFJVi0gICoWw=;
        b=dU3avb9DlJ5lt7m1IhWT0B0X0PRM9XWtSThrVY1rHd1jwO0XBOf9wB9FeH+eAJDzcx
         YERoORGw2jyZ0afLaG0mNh2tWZEfQCVO9+u8nEBwq931ZsbTyU/cuyhCduzSi2GTKz8b
         eiA9OSmNgUOqTlKFLuAO4SX1eW73ANAHLszPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549757; x=1730154557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA4XM5hTiGNOd+KQ3u3JDVeWEwmpgPZoFJVi0gICoWw=;
        b=d7VZJJWZV8ZGoH2Un4bltz5TS71U8e5u1ai1rUJztbHtq6FkQR89SKY8eB+mjT3TrS
         0AbrlH23SFSdN3BvYZFkRPw2ADCQLfDSbuL1Hbk+Z2xZHOilIEah5/9w3w8OIJxf1B+N
         keNDAK2FhyViW/gDnlhrVpTn8a4GQFisLQGU3cD19j5Sb65QeWvftx5fdOklYytUKt/A
         2NBPKgbaJpU5Lvx58G6GUPFmTNecQm1lvl1nbOfffMYtHyhj3DjPPY2DHIB4N+r4lKRl
         HKIHZ9JbyemBYwxHd2IcHqQmTdUhQ8d24LWvY8Va+zMx/6FzRZShpXK2lJp/QqYUChJt
         Ra1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSiCGJarvpOs4tdUsp8mMTKvDTjxBe6UOAdBV/vOUJ268R937NLyOq/bh6FMfADm+b+VDpOF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GqLdOLPKGcH/E+nAUnsRh1xWc4WuM/ISC/oniQw5t1V8zNyk
	9JTZLysKHmnprYSjkkQM4j0kFT0fAqYoC6vP+jLukvBN8Q5oHlwh4AjVWcQ+pv0=
X-Google-Smtp-Source: AGHT+IE+r2Sv2Vi8956gLES8UxPVDLR8WmGuc8PVr3WktKjFjqRF4T4ZtzxG0LU9kkxugixlftUMTA==
X-Received: by 2002:a05:6602:6d16:b0:835:4d27:edf6 with SMTP id ca18e2360f4ac-83aba5f2764mr1039351939f.7.1729549757368;
        Mon, 21 Oct 2024 15:29:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a60947bsm1235916173.116.2024.10.21.15.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:29:16 -0700 (PDT)
Message-ID: <6049fc80-b936-496b-b1d0-134de9fc19dc@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:29:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.5 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

