Return-Path: <stable+bounces-182973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD877BB13D5
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7641890313
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C27284896;
	Wed,  1 Oct 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8au/F/y"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2D2749CF
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335665; cv=none; b=fJKgjPphvRM8+cb5l0rt8s7U/o79nM7DDKf7QE07MzHeOsH8B2TyzDbLWccVdd0WQE+QiXNs4m3qx2EjUXAIOhO1oq6GrDpRyMVtzumDwHM9GomhWnnfYZG2x3vKpW0WKZw4N/hByHRlx8iY4HfpvO5yKhw16mvKmEUaYumhzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335665; c=relaxed/simple;
	bh=dQwY8oJbnBTTFC31L8Jg28jquYZBGcZkQ4P0+XW1Rns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD30IfWdVK34m+slY0z1skShIYD0R3cqXa6bh43Z83G10mDxUNxIkzTGJNgsLuDfprAyfkESlglbGZTIEplBqzDYwjg+as+Imv0LZSHdf1qDG+3nPxjexUwsxaJr/ETzC89Q0DNUaAkIHYuYkLpkaQjzTvjJ6750st2P419TUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8au/F/y; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42791510fe3so4949355ab.0
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335662; x=1759940462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0Bk/1XsHqvwUKw08M8vbOlRk6GNltlYfeCC1qY6aTs=;
        b=e8au/F/y2X6fLRFel6ap370XESBKRXRqzllUi0I2WONmo6tWiCWtXrSwUCu0UunMlk
         vLB+z55t2XlXGJVCUIWgiH1Q6gQyCam3b+TavnFIlMvYF8aI6M2xmpJvpdn7N9TIKU2z
         1Gs5ueS6y6FlQ3rBQmPp3LbH8AanW42ARTthw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335662; x=1759940462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0Bk/1XsHqvwUKw08M8vbOlRk6GNltlYfeCC1qY6aTs=;
        b=IqwGAyD+RzX4jYeoHwlWQA5TrwQqq9qGt/8JsEN8x8Sa/eDVAVzs+/wyCiCCN8lRb/
         AoLGiJbHLtAtr4FEn8eUFc7XUVO5g7N7YRswYwtxLGmMXHUiZ3+WDlzjZRLjZUNmX+we
         4eu4gfB7i76Ls7Y13t3zBP+i9q+kWCfUL+srhyeerhCiachS278U0fQV5R/nXmPNnwSt
         gYglnFTDdWPTDvu+OL1DTtjE1LJPyLbXigdXQsfAHxXwVNpCOKVW9c3TUz2zF4ontsG0
         m3QA/rXE+kJFZdbjUzZpYoeYbrOZEEkaK4myDa+TPSyG2hCSCVlydrOZB4w3m23/s90C
         QJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCVo3ZIIEXwhDMI0F5bmiSK0YmXIBy0ENGN+Aq/UG40j8ahdMQ8jW5IkB0HYZ/Ft6yxkZEN8SOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3NjuwvSeCaHLyYc6eDy2fSjDtA74YEMrbVGz03IY13IWPGRK
	9XXERo7y15wVL5IqfkFghBO+DP01ZlxmXnIRAAIL2Q7FQs3A/EcoMQrVRBGv3Kbn8pKBBAUTIrZ
	SBLXT
X-Gm-Gg: ASbGncuxIR4j/boi2uA/OpqElGeUcekdY2E3g2UnvP7gAL5zoyL2DHbEB8vTWh4J2aU
	OMG1aF3v5DDDBz1vIXuvuC7xhjdl2qlYRZHNgYBrh7sKwYZcbKAdwIGltVemeyuuWha7D415JEn
	FyBJTEEF3TAW7u/4Y9JfcHjZzAjbrILZ+YYpjw14MtmBPGc2SxGFFoSjkbEmvYCVaTaCzvdVPwa
	YrWYAcIDHDsAL4l2WLdLp/Qi9Pokc0+jBAbW9q4E98/3IPdpNCnlLTGclCUu9wFO80/gJRhA9wp
	8cFuuchpyVceiKCC175CpXuS/C2eCtHWQmRrMrnX/v4NgOaBlNOPDOtczhIPP6+W5ftR/ED335r
	tzmiPsiEGdrwDYJJWpk88UmQKrzHhuLqgMVGXxatZX9FBArUpFpf+YBdzJp0=
X-Google-Smtp-Source: AGHT+IE5vkMaEzImU6yFMmEFTvIP5csOxBViu8ui15pbJItIu0M0O39f8AHeTTk0IGXWIMdNvHoLTA==
X-Received: by 2002:a05:6e02:214d:b0:423:2666:4687 with SMTP id e9e14a558f8ab-42d8b1e1a49mr2165795ab.15.1759335662156;
        Wed, 01 Oct 2025 09:21:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b281664sm299785ab.25.2025.10.01.09.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:21:01 -0700 (PDT)
Message-ID: <1b7e8b60-faee-418c-ad23-c2e659ffd03c@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:21:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/81] 5.4.300-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.300 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.300-rc1.gz
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

