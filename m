Return-Path: <stable+bounces-73686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13496E6C0
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294CC286C39
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994FBA4A;
	Fri,  6 Sep 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KX80Jl9X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857C11CA0
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582077; cv=none; b=L1AApxKlnZfc6z9ZGWe/qw+QsZFOjeC/IiaHSo28/11EsLwK6p2dIuoCRwuBevVMDKR8cPDABkCiIU4i4X4BfI/p7bwlsVFnDiyWRqHeiHMxb3cnllRWfvlW1oL/Jq1muHioAIMs0uuXekTrNqNOh76H9zxAD3ZxseenNopMdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582077; c=relaxed/simple;
	bh=owTR+a0uY+nKjkw0GbPFXLIcZhI8MxnMvnqAe5CWDhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQGRsxFzSnk3Ffg1x6ZFsRAQ9tmgPzR37dsnWFZacX8mxiG4VrGtA+5KnWNjS7Hqeokha9WWamUlXU1PpKDdDmwCTqS+FP4m93m5cdloEkPf24lVLmByd5vPfejj4xtpZn6Vd/wUgxKCNMTFVtISYkuNpUdK38ZMEVlsZsjs1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KX80Jl9X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71788bfe60eso1202536b3a.1
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725582074; x=1726186874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AutCiUe8QcaHzt6zZlpNdtcoMSCN8KlIsK8hvG2I9jE=;
        b=KX80Jl9XuC3xbqb5ntRHqM48gC2Jalof2RDsMNSdDv3OqdlRL99UD7Ia5/0vHF2NUx
         +vuO5YFtx7LQYXmVOsH/Oe1ZbEQITKK0mJ71CxjXSQwcY4mwnGJaY24jP6zro+wsNAAP
         qt4pl08KfpnnlydHzWr7yotGN/ku+CoOpUEzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582074; x=1726186874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AutCiUe8QcaHzt6zZlpNdtcoMSCN8KlIsK8hvG2I9jE=;
        b=WU6xWnENKKwIKDqO0Xe/fn0dgS0oBsHCevCpGtcpms5Fj5mimfNBDWJSx9EexY8KCU
         hK8WlRlyrDpQWpF1HLclFkbVyYO0G3PwzTWrF70ELk+vQSHbCWt+deJVhbunR103GWJg
         +oC4t8l8vbgEzgAo0sZOZh3y2dGVN6S0DGn3IAKG2P4yxjdRrMA05nAwbUu57GygRGHt
         1Vz/sHsPAOBWZbCsp2wxvOVr0oO2d3sseMwP8xyP3qTeB3FfzcS4rG+u5KNUQMgxQm9k
         jkYD8anraFKlrVo6jafqUONGi4G09U0s0DUfCenWmoT+jiQq6spyIVZ0H6V4TtsLE8a2
         BfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVedVhWS7vLBNEbb94MezhwerrWy3yzFYCFNJoboTC+IdkLtWG2JMiii7ccLcJDJElFouqEkgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxex7XdrKZ6JJHiVkKWFqXWTpzsRH9RT9zvTmw8+pgBb948XmzJ
	/0KOTRHsOIZC0MOGVav4UW2+UtwYkbu3DpW+ucwrGBgff1ak10q1KqLIgRq027o=
X-Google-Smtp-Source: AGHT+IHL5DQmqDs0xR0qRNRgvtwm405Z12O4psQBNLfl+Fy2KC516a+TBgAQgdkhSe+GEQBfilqryw==
X-Received: by 2002:a05:6a00:9194:b0:717:8dd1:c309 with SMTP id d2e1a72fcca58-718d5e1d033mr982487b3a.9.1725582074494;
        Thu, 05 Sep 2024 17:21:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8da85sm3932700a12.37.2024.09.05.17.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:21:14 -0700 (PDT)
Message-ID: <dd107d79-35d6-490f-9c0c-d824f32dcdc1@linuxfoundation.org>
Date: Thu, 5 Sep 2024 18:21:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/132] 6.6.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 03:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.50-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

