Return-Path: <stable+bounces-107771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B05A03338
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAF3163BDC
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAA1E1A23;
	Mon,  6 Jan 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwkgpLUT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6711E1021
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205499; cv=none; b=ug6KkCxFbYLT0c0TbwOLYMxlGXu+20FmA3v/jxwqWPhuajiJx2Iebv55IpRrTcyZtoma2rXUEn2p+ZvWrm6/gPczFlEB74ClSGc23H6yoeke1ZJ1sBGS4dgCy2H1xLAEFdk2C99NQ7JEbKM51Mq1OrrPozhqWHJxzqG4Jx662Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205499; c=relaxed/simple;
	bh=gO2Bm1IZF3AWN3dj/3Xdr2Av4Jtxxm2g8RH7nthTdU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1RV0UZtAjSSOSveWHOSs+4tYPFz71J3e7Ou9ftNSShvuFpH5zyK1tpIWMbf3GDnJDvpD5Ac084THB/Y1w0zNk3U7orwcS28qMVt4MEi38Qzim1+0s/neOzCYlK0D/YZC0l3sp7WOhT5hZsPfmjNuR8IBZGTxQl61SqvxD2fYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwkgpLUT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844de072603so1363056539f.0
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736205496; x=1736810296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZAGLmj9Hq6ZyNiaxFkgAyqEQnJO2cAbCGC7nBnlbbM=;
        b=UwkgpLUTAl0ga3ORpPYeiS4FO+w45+lGZY04nl1weIFCwYYCZKd6ZxElxBgpDd2IRY
         JMo2OQCNawgt8vwAoV4ECNzOFGR7XUC3wBH8NZq1Mect5iyGzdftK/bzxitrx0ebk5np
         C/nGMTh2LfHhI+gp72zJMCNvMKOcqiGj6vDyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205496; x=1736810296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZAGLmj9Hq6ZyNiaxFkgAyqEQnJO2cAbCGC7nBnlbbM=;
        b=Z4//Dis6djqSE6OZdVBrxzYUajITNow5wQxUiSngWBEmGYbPL6dMYCWhmzlLWVtPcz
         eo81lf2fKaKRuCCTfs3hx4irrN5lgvS042jU5zPwZ3JdeJ62bDIUEo/Glojj6NnvDJz0
         og1xrop1U/soCcUv9o9rmGiA31UgjwjmRaaDu5qxDk88w/JelRlezrNUFqtg3K8LvWGj
         Z0m0h2eK4yb8gVLAFO2Q2bM+kMJ+h3XPIzNj++ezcwru9yKxtvQx26QhmsfUw4I97m72
         IiRcnfIhZuhJV7JYEQipzFzuGrXeIm6n18bqlMtmGipiYLnE7Yfi5lP+PPp3FkcFfzuj
         nYOA==
X-Forwarded-Encrypted: i=1; AJvYcCWULMpWBQGwWtHawPn27sU9/y/ODNDIxeYsffQeq8wJOQYWk7B4WRb0zqF9zQV88i2HfnHWT0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/TGUfhYpTRRNlfoYOesLfmVwny1CqkrGgVEgpYpffR1Fk0XO
	yDoNQH4Tt7e2Mmey2+pXOADDBzMV4QdQsDMFSB0mQkUsjCyyqQWcoQR6sY0WCvA=
X-Gm-Gg: ASbGncvqEcHOw31nK7feNVtvfXzYguUpmTCSqN4WpsJAFFf7SqgHfJmWAtXSsuJmmPb
	LAyRCp+qhfetnemj1Vxrs3MNaSSahC5PC3Vu/1pOwIiOYLSSaa4EfCgatJFVeEIjrmqKgsM0nO/
	4nnSzjLkhz6CUp0q6mT0qXqdJdWqMP3HvwcXS6sldrfFRPvRDgC8+IlxCtz1zc/dL8vFfeysCtY
	2CyVpumx4usGbFoD3KnjhZeqQXn89Tc4fSSYJ+4fzw6rTb8Uq64iKHJakxuyAkwLtrY
X-Google-Smtp-Source: AGHT+IHuFKZJjaLxLujpfcuZqDgfl4m/olLWGIl7JgnrVzG5vQ9yEEu78XPtGOihdsgSwtamgMbsYw==
X-Received: by 2002:a92:c24c:0:b0:3a7:c5cb:8bf3 with SMTP id e9e14a558f8ab-3c2d277f5aamr476694085ab.9.1736205496621;
        Mon, 06 Jan 2025 15:18:16 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c199922sm9743651173.103.2025.01.06.15.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:18:16 -0800 (PST)
Message-ID: <5c3ac106-f18e-4237-83ff-52398839f635@linuxfoundation.org>
Date: Mon, 6 Jan 2025 16:18:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 08:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compile failed during modpost stage:

   MODPOST Module.symvers
ERROR: modpost: "i915_gem_object_set_to_cpu_domain" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "intel_ring_begin" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "shmem_unpin_map" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "intel_gvt_set_ops" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "intel_gvt_clear_ops" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "i915_gem_object_alloc" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "intel_runtime_pm_get" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "i915_gem_object_create_shmem" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "i915_gem_object_pin_map" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
ERROR: modpost: "__px_dma" [drivers/gpu/drm/i915/kvmgt.ko] undefined!

I am looking into this to find the problem commit.

thanks,
-- Shuah


