Return-Path: <stable+bounces-94472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D49D4465
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092201F21B82
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBEE1BDAB5;
	Wed, 20 Nov 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EvsoNYXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB141925AC
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144789; cv=none; b=tJtD3ToUZdpQlan1CxHoaMLVpH39+0JWZcK9kMC51UbiKy3ZRj3VY3jmAa6VOZcaYebxXS6DgbzrHvHCYwJDB+Fy36ib6WzeR0t+iNzn5drX2lUHN0TeLT9fvdHqWBfzJpbdCovqh4ZxJzPfkKD7czh4sjH5C7bfKVG5h6+v8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144789; c=relaxed/simple;
	bh=L+1vPU8iD+DS0o0p4K0V83tfmB6n4Px8DPutjFQDicA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL4dangLwS7kUxTKKBTODIeFMFFif89eVx5qcugOSLv6uy4jmRfBJyJa6YuPqdfBps38y2h8ReKnvfupGE605gxgyT7zL9/klf8VstcofxWdyEkrYfJr4wUmrGnG0MeWN+0KDxHiyFRHpuiZ3mw+0A9AXPV9K4DA/pmfrMz963Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EvsoNYXf; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6e960fb5dso1093605ab.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144787; x=1732749587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+giK/ELPAcyHUjRKfZAXji3lVew14WmyxLefpLGtglI=;
        b=EvsoNYXfPtG78JQ9nSLXCtmCTlOonnBAU0tIbjpEAY4ZMkGRPGHWN7/Y4BRYtsbVHe
         B7tAwcncsmyB/oW49Ls3BPG8Sh4qDyfVsOayOXafbdpFHgAonk2UDiu0LFxi6Dv4M5zs
         hL8LIAcZAGeipfcdJI9xMaMj/uJtiVD9A9FBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144787; x=1732749587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+giK/ELPAcyHUjRKfZAXji3lVew14WmyxLefpLGtglI=;
        b=Qot77zeFVKoYLa7+QqBt5BVX3Wv+HrjL6P4hAMJikhOLQW5mCCfIwMh449ydHkjPuF
         XvjEhD1rpUDGo5Sq2g2bp9Y8jszcd7E8dDHYXHzlS4b2CQMpGVDrnEx3MvaMIPDrmPqZ
         2PyqWiKBN0HS3xuGj5paT9qHio0cKO2UTD5gLMF/AfvOVMsKwqD7TPJHHy1ByG2MTeCr
         qPSYIUCssFjqdkMAhi8n8KmleFeCP3w+7DYxz/SpmYSlEE6kDt3CEvQFbUHvGqSwrM/+
         0am83ZqKauqThomqUefSwzGwaEhvehLuxilpWztueUTWZRG6laF6AphimW3/EFWX8V9P
         ozYA==
X-Forwarded-Encrypted: i=1; AJvYcCVNniqqXsj/YlmO90dQ8Nm4ZxTIQ+GtFQD0eRQu7sxArvJvU9sgEyCrg+UOzA+t/7GykOIjcEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPEkTaOLh0Vlfs8Ho3WsASLQXe6h5fl/rIRSqFvl51eMaIyaA
	SDMO/B5msSn7nrfnqGSLkAxvACbY1U50RlhXXT66saQN3vF25UX6qiHWYiam5CI=
X-Google-Smtp-Source: AGHT+IGtmIuZiiAkhRZ1DYVcTmSOeSFCial+bj0SazLudqMOLZCZt1tnwDQnoatujtj0YTJ4Q9UkRg==
X-Received: by 2002:a05:6e02:20c9:b0:3a7:8bb5:3fe1 with SMTP id e9e14a558f8ab-3a78bb54052mr29359015ab.12.1732144786685;
        Wed, 20 Nov 2024 15:19:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a748091bccsm33805385ab.46.2024.11.20.15.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:19:46 -0800 (PST)
Message-ID: <b1465833-d406-4011-a733-f86d4145e157@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:19:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120124100.444648273@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.1-rc1.gz
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

