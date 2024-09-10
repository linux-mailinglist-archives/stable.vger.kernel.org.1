Return-Path: <stable+bounces-75760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A8D97449F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED91C251FD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D671AAE3F;
	Tue, 10 Sep 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gc6Ucx6s"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAF1AAE08
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002742; cv=none; b=uxKDnMKRha3NE+AGop+FdHXveCYlaqKPWMmWpKdvPMC8jYlpUP1SqQNnnarMROYKGkHzxm4XAfRZfNM/+c604NH8SQboI7IdQqfyV21H/ZjiM/K+aiwR2HWd2FF7U8mbyP8TSIMenaQPriDptCD/oKkXXMguPmlY6duKej/tz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002742; c=relaxed/simple;
	bh=ik3UKsltknlff9FD/NaLT46PtwDaXCHPQhKMj6WoIpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiPOb7eEawlEJWanQ8h+5X7jIgii6q8JOuPRJeDraeHC9is2vDVLrWGgl0hPAgGPMTkGq4mxpe0U26WhOATLErmj2kGo0i/oxkWPrWI1WUwr0i0ajQ/NhTfWTEJafG2m0QbOSFUpowU/eccGud8pyJvTtG8W491jeoeIHuAOxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gc6Ucx6s; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso206358939f.2
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726002739; x=1726607539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rPGjGCzv+oasSI6pVCkPDSWf7w4QJh8MFoceYLzhS4=;
        b=gc6Ucx6sw+nXlHdj5XKtTZRxbWiiCgEpQJZKirbbIho8/gEDgg7K7jaVd34cJ+/NjB
         tb2Le5jJDLYbL2WegJcQwxSLEW3BotGYFVdYzrJYk34qF3lnQvE3maNAhBDmS9P89/iB
         7gasOlN/b+pic1ddr7Fy5KZ8dc0srEyXkkYsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002739; x=1726607539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rPGjGCzv+oasSI6pVCkPDSWf7w4QJh8MFoceYLzhS4=;
        b=Np7u88sHCQXfvhJGptDtB5Bcu6TlCFBGk/bz+DRcpA5qwjhvVSF0mq34YiFVIYGDFu
         PybLjVgYhMc9pEwmS0CjdOvMSrk/IVTIQz+xGfnHmthyoR9HGFq4znPD1IXmJx1Fbbfn
         USLGkuPdVC5WiML5lCS70zVG0sHKKYZFWFM0oNrw9Rg8SbdsNC4+ox+1RJ/GQSXEmn2D
         R5YRVl2MLMxxrZoNw8QRNSqBszqcfpT4g4tzEvr9OyJVyeypE9Zq9t9HOgf1inX2gNwR
         ertgv9MYwqu8XpfBgCeobpR0h/afPI/BdiX8NmOLA87c9hRIROW6bdHO4wPHOFzRBfKS
         OtHw==
X-Forwarded-Encrypted: i=1; AJvYcCWctNidRyFT5OKjaZfDlO2RBW+EOqMDxcp0z51HpN9CWTQAbydHtviH3KdyMsdVzv9uV2WTk7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuw7k0kyMVd1U9+M51fI4vscB8EKukVcLJmNeRDvv3sPRsL83F
	uvzE9l0m/bWvyM83NLfBiYSAK95nHYaMF9cJLE5idYekmPh68Jgv6qUknYGYBXg=
X-Google-Smtp-Source: AGHT+IEBXCGJfpx6uQrNCJWbyWaXdkVnusVExeZjTk7LweFyaAVp0ZTqw7/koXWoG3nviMKixvHXGQ==
X-Received: by 2002:a05:6602:1583:b0:82a:ab20:f4bf with SMTP id ca18e2360f4ac-82aab20f590mr1225176939f.1.1726002739074;
        Tue, 10 Sep 2024 14:12:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa77b5ed4sm220908339f.53.2024.09.10.14.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:12:18 -0700 (PDT)
Message-ID: <cb8e0e51-a934-4aaa-91dc-c4530ece99c7@linuxfoundation.org>
Date: Tue, 10 Sep 2024 15:12:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I am seeing a modpost error when I install the kernel. Looks
ERROR: modpost: module ad7606_par uses symbol ad7606_reset from namespace IIO_AD7606, but does not import it.
make[1]: *** [scripts/Makefile.modpost:133: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1825: modules] Error 2

I am seeing a modpost error when I install the kernel. Looks
like thge following commit is the problem.

> 
> Guillaume Stols <gstols@baylibre.com>
>      iio: adc: ad7606: remove frstdata check for serial mode
> 

thanks,
-- Shuah



