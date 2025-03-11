Return-Path: <stable+bounces-124049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F3A5CB19
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7173B2F5F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DE26039E;
	Tue, 11 Mar 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPjj7huh"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC711F9D6
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711681; cv=none; b=ngaAVwd244u5UfqPhYqCTGsAOPNoICGL6FR5ezIn8aY4njkwOBMFdAonFYxtccjn0pg06IO2VqmsYP4CxvxYhYul4VzIC2TAbJK1xBL0nvmZsdQFT36WXiKOjTHt2ics75+gVjNlPQW/WGov1Wcmty569hZqxPkuY6DUK6NPjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711681; c=relaxed/simple;
	bh=ltNZnId99TBG9+FOkJZg7yKI5tAEjGEUIIVmvk4BJ3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8t8gicbh2UlBX/bm66ZO/sGEA9LTBZydJh5Q7NLzxHwYPr1Gy4rfiLX2cR7pnGOgi7iVMqtjq3Dl7oBTTHZtkrid4Mj31+QE9ZjXGT7/XiHvs2muBLPW0lxPeIH46rJ3XEZQml4RWPBr4AF3yy4SUfR9pTSwZMikJ5SeenG89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPjj7huh; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso23089605ab.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711678; x=1742316478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIelccZHQZk2+ndDXbKBajYZKbjgA8vG2Sfh/B1954k=;
        b=XPjj7huh0UWY8rBTAPtUrrk5XGDnbNtWe/3/Sc0NJQMMON4I0ifrOBcBsBnSTTt0vd
         JED+mmJHNTsACoXCJD764houPlEs/lUi7UUMdJ4DFWFFhSS209GbibSTGuO5JIIMaWgL
         jd56XhOPhuwCfcSbDj9Xx7AnmA6NpUHXfgOZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711678; x=1742316478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIelccZHQZk2+ndDXbKBajYZKbjgA8vG2Sfh/B1954k=;
        b=BHWTvAXh1fXcFLN8d/AI3aXEkofFNOzx3GGE+x2q7Kd+Nxv70RXGTCabTpuFnSgNtG
         wUo43rM5qmDfQmJTppGWAr6Q+0TUboFl+yhjhaKgm8nA1BfYjwjYK7V00Ff5cZ2Ig43l
         IQ3aYlYenJPqPThcxTUTNo9kdN2yDOXqGghA+XkW5GyeqhiJ6JXrsxUCVK0do8nBMDPe
         xvm1Xn7eCbPCJdQIHD/4l1T5UxhPTMZoDVA2mIyHpl/VwOtFVwDpm11Qd74blk44hyXH
         ar1baWZWKVMfadBOnH/cJ18TTbPmjZt/l+fULAHYqZsfKHpBCncMTU03GIosuyGJs6RY
         V8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUihvzhjPQQ+uStIsVTi3cwDzL7thhCPi9YMylHKy3UoxwvBgGAlAzmDzOUNzDRC2e/vaqjGbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3TenPJoPHJh7qVbMyL1ZD9ggt5bsj80HIAwUCztLUyMQXuKL
	KV4Hw/0OqFoWA6+KCBIBSOU3ct/JbSZLo8n7Y8MUqQ6Xe58lDr+xhQ+iJR9M3fs=
X-Gm-Gg: ASbGncuj03SGo0tfFM2B6k8x8HQT2NvAjVTaaKkLKehZnYA+74E02/BsY39n+Evj5a+
	GHtM0TE7IbfvcetBhUiS5Kai8kiBVvw8lBf9IWSpoE0auw1SMUrrA0ytvpQHGuvR2HGWboNanUU
	z9V8lQJJnq45gcqOBX2/EMHvD87XRTzvcxN110+oHIcpjmSeCdeoQipdRMuqg2VRgxg7PiUhkb5
	IrXzcbvl8wB+y03Lzwn0qqPCRbGqNeSCOnHsEJchbJaBKPFS/HbHWijToWQxko5znhXB88Jghx+
	xDnPDFBXqYRg5n3pb3z4vg5ni4IB71zV8jcYLqBdealu2APZZJZkhEFmBc1TuT6XkA==
X-Google-Smtp-Source: AGHT+IFDdRp0z25FQZ/a/6jHqnCfBwxjRuZ+/4KP0GXCpPYNTXRmWcdeY+uBSojv6boITzpPUPC1iw==
X-Received: by 2002:a05:6e02:2142:b0:3cf:c7d3:e4b with SMTP id e9e14a558f8ab-3d441a12ceemr239262975ab.21.1741711677772;
        Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43fd73234sm24748195ab.0.2025.03.11.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
Message-ID: <fde3d71f-a152-40f1-905d-1aadef6175a9@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:47:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 10:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 620 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.179-rc1.gz
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

