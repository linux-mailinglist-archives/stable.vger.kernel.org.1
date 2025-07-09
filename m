Return-Path: <stable+bounces-161500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F83AFF476
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494C53B4F2C
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA1C241CB2;
	Wed,  9 Jul 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+X/+IDN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075E23B619
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099134; cv=none; b=Id66Pa7zlSXwKCZ4/ZMD560Hu90m7l4Ub2L3R9TCX24hs+NKSPkBAwyo+zao29MxmC3hDaxLudBhhGnJZi2MYsB4wVu8Q0AVvd6tF4rLsv2IOrannOBvamKHEUoeZpFU+k1x8FzkowSxndZuGSLtvCTDsIUX7irzuXqTkbN9fLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099134; c=relaxed/simple;
	bh=BuNQ2mYEgeP55do80Pv8brcXDATJKUwOVb1q83oWXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1y0fRyeqbc8x8uF6Dt/BWrXoJjh9uCs/hZ8KHda/y/0z5FyicaGH6gTSknSnwMSWSbasTtLgODh6xCcj3nGdLBjxHThgWAfGDq3fp1SEbVR+4hO6913pimZFp1O0XI+jFtHAxMZAmJP8qPIAo64Gt7ip3K1SrAyqlgQZcN+wGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+X/+IDN; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso2010325ab.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752099131; x=1752703931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIxrKC669NC+k5Q2PskeXiZ3z1OvgkVukHTfy6+bNlo=;
        b=I+X/+IDN82xp9qgiblUQMIoPwRk7bbi1lCVQhSan2ILZctDPWaB8OYM364r7tzn+2h
         Bzet52gA74afzCWMB09TWlcj44a4vv3eXFMH9ojhgYlITxLbqq/gmV5HRoBpCHfHEuMm
         USS6NqWfSDD4I2oHdRQzPfFhqxLZ0Nghx3Hbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099131; x=1752703931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIxrKC669NC+k5Q2PskeXiZ3z1OvgkVukHTfy6+bNlo=;
        b=TX1camQ3Vn6sFs8bEraD+FGYFAF/e0tFFeeDo00ycTkAUe/A33rd+7m1rFgeO92SlO
         6xxF4QQpaVH09t+KdtKSwNdZEtaBLBIPB835BK5qNYKr4ZXRxobPrmjAacoz7bUxEZLb
         iE1EXnckRSewwDOY5V4vbF00Z41cyJU8M0pRiNgDNBlvhSgmLMsga6pJ8CEz5cx/ea01
         ii4FlKYNk8XAeDR8uuPTRXtwhwJbTjL7O9iyKWG7R9mz9JmsY9RwsIrM0CtD/TIPrt4v
         bhnovjGem/zX6491/CdzLWubuuuAnx1+CJKjJP9bIs2IgmrzU2fED8DedH1ExXa+7hcd
         R7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUt6BxqfZPuRhuyIAs04iEl6VxQLTbz8ru9nkS3cyyfWfGanb6ndb6GvX3J3e4JrsmuZXvaShg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SmtI6bMK0CWjT1RzNq+kHwf8pmylvG/x7UwUxSBJNLMJLcnB
	tIi1eN2bW3PtpN5vdv3HeZlwzS8bjpjIgZwH58Ovl1oE6lKJSm8Ey/dLaAkS+l/kC6Q=
X-Gm-Gg: ASbGnctWrbrRRtuNVhNuY1iZWlNSypMNtyr1kR4V63BzgNNl6aVKZM8LO001tMEavzq
	sbjLoTCPIJf4l3OpYHbBNj5XyG/hd+Pho6WUw1+tKV0PtCI5y/Zz7qtpJqFsMJoxOhksxaR1Fot
	oszcPv3cu5T3TJDaOZFy2Ueh+QZF6bGVEJbyBt+KUgmPN0oZrqQJmKzzzsWInT42cs9XU2gel1S
	bHFF+R/xSLsD0VEembFvJlzF0O70Q8dP7j92+2Ab/7czfQyDiQyxpS2m6p4DlFCds18ZF0T62Jx
	dfIgwiBBXlu4nS5uHvrrHFOQtVaEpMDPdOTTTNrur9qHDQnxMgH4fyRNb6OJuig8mvGPBslLxLJ
	Pvo/bG4W4
X-Google-Smtp-Source: AGHT+IHaIzZWNqOEEpYPr9Qs9PHjSIXPHby13nHFbqDrTCwo6xB3iLAn/fUooRUkfxxOIKQ+Pk7Eiw==
X-Received: by 2002:a05:6602:14ce:b0:861:d71f:33e3 with SMTP id ca18e2360f4ac-8796938fe79mr35681539f.5.1752099131134;
        Wed, 09 Jul 2025 15:12:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055659d231sm45091173.52.2025.07.09.15.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:12:10 -0700 (PDT)
Message-ID: <0e3d9928-cd18-4683-a71f-bc7b0d9a83f3@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:12:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

