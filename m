Return-Path: <stable+bounces-4787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B96680643F
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE31B211E8
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CD139F;
	Wed,  6 Dec 2023 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pjq2Lmv5"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB61B5
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 17:42:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d626e4f79so3937145ab.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826979; x=1702431779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm1V9f+oUMjohhZksyZB+sIfcQOdDZTpiTzY7f5JIGA=;
        b=Pjq2Lmv5vuWTYrj8aXeeuf3rOSnSNhDs5weYgIzYmdDuUy00i5tshq9l/rFQaENxcG
         vnMn2JeTYS2JcFbxjZl/rC34NWVDVbfZ5xh9lbVC2PJ/Q4Rt0rS4l9P0eOaWaz7uBBWb
         rIK+19093400XNFyI+uRfB7yi5HyBogmMVIws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826979; x=1702431779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm1V9f+oUMjohhZksyZB+sIfcQOdDZTpiTzY7f5JIGA=;
        b=Ikki26mAiWySNXFHzATWJ8iONn2u4AsUs7fO5dZKyuLzrXyStjyZcvU3UVH5Wi4aDB
         Fj1ioJnYqkLdQcAYUPDYiBq8WK1TlkkkIm8HJemr7xUME2DvskV4Ab3TQcqWUAoVOeJn
         /AHfV3QP6BiNqESKEAI+gPM6NR0NLNtWxJ4iUedHh6mfcx5B6DOaHyKIaY2KEuBbF+K4
         E2SVoizGN5ACETh9npy9WO5+c6n98d8OzbrxNk6cnRM2/yn3AQtxuLY1ahR1L+jR9Ofe
         uyuSrLaQuGMCs0zL5dNV7xc9sDrprYuYFvZiI2fz9j2TvRz9EVIOOGNLKA4X84DaXW+u
         RnEA==
X-Gm-Message-State: AOJu0Yxdx+gPNI8yJvNfAH8qN23W4YbauAMbKyMMJgZv3UiXm/5TAKIe
	XPAEmqiTD4gUFHGLbeV6EUVA6w==
X-Google-Smtp-Source: AGHT+IEZV9QsCtUCG41Rwf5DS0/ayUasKhUxGXYpxOJu29ansePzFwZheB2UEsbVjklK6ZmE7lxGcQ==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr583643iok.1.1701826978793;
        Tue, 05 Dec 2023 17:42:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o2-20020a02cc22000000b004665ad49d39sm3423615jap.74.2023.12.05.17.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:42:58 -0800 (PST)
Message-ID: <321a5f0b-e7c3-4d23-9fe8-b4fde383a171@linuxfoundation.org>
Date: Tue, 5 Dec 2023 18:42:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 20:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
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

