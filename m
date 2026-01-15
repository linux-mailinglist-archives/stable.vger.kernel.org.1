Return-Path: <stable+bounces-209973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B209D29435
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2342830115F3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15530ACFF;
	Thu, 15 Jan 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/C1fJh+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28432C316
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519959; cv=none; b=S+OmIdCCTfLieyyum7Pk/EhrYnD8ymMvbequl0HwGa6yjNhoMi7T3pg8lXeTYn0qhsyGDHbh3fLueWvyzw9gCd+5ngQNJnX4FyoY79NmbX4gcjgad7zXyh3PSCazKuZyTKQvoohwIqZDnJw/N+C2OKum2s6naR1ZZS1IZ5kvOuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519959; c=relaxed/simple;
	bh=Rh4+Y6I5pI3J/iLpB/fv9hVazc5LVudqjRdfh0ZEMiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYXKK8tD7bjCxZrYZpS3iZCKkM7o5/KueBQbBpm3ojMSHo3K9gbSDuPSXQ8QEPVolPAeuRNb8NyFnJmEy/Ffaum2kteaBe95l5A39BRimnpW0RmfrG+qiGh0tmJAVjBFf963JMd2YpXyyEJ2Z+JX8lThpB5yIFRsPxsDNHOeuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/C1fJh+; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so852268eec.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 15:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519957; x=1769124757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbhFmf+s9AJ+hr5baQrnrCRHAGqVTHtYjCq9UgpdDaQ=;
        b=e/C1fJh+xy7UbyTc8Hl14gJipHDoj1HjcYSfjlOV1mMu8ouoPF8u3YoL1Pw2CI1ec8
         OrsupSMY/wGuvZIYNL9TfLTDd3UKsu5Hb0oay4unwQptlDGTxsZxv4GKGVEbcNoxTaJr
         GNFo5wT4TIIH8ek8vVzTJ9//ghy8UFFwVy1ovO3VT9BAJssTV+rK9vFVUomSJ8fxMOZI
         lyaZfbj9EeKI/7x6+SVpoJoX+tBBl4sN57uTAo1mEfM3MzMj2wAZznBz+h5946So6FVH
         6Fdzbhy+wguvpi8rNULf2T6xzde2Q1GO+TBjVcfDpEWuYKUV/PO1TLTfUcCMIVxYIH82
         o90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519957; x=1769124757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbhFmf+s9AJ+hr5baQrnrCRHAGqVTHtYjCq9UgpdDaQ=;
        b=rFGF+tOQWapUOuMHkR2x2hdyDc3dYX9eLrqlhmFaZhfYZiX9yL/MS+pO6Z5fP11bLh
         6bEHbV7CIgwsZZ6wtDR+Wo9vG6eAqOzYMRvLfd7SMlUlqwlCTf+8TwpxvaDfJmqSIPdk
         ItheN27tulcfi9pgiPNDn6p6CwzSJUXgxLDGOYbKpOzVtFn/vw2XqJjMt+t24VTaX8hf
         RYWRGRQBpNgRqorsG4aDhtNZ9kE9FmOa3StiBjHanAuS+J8Qh5zJSuUtU7URG8uTYMe6
         iCZgFeQp10FSsJhoLxVl7dnxYFbYitlFmZoXq8Nsev83key2/YsMDQl+RCX4hnIiAneC
         zgig==
X-Forwarded-Encrypted: i=1; AJvYcCXDCAw9VOJZljeEBAuVEwKKePT1bZdCi2Z1ILNwLP2M22j1MF8d/Q5vmG2FptY65gLVApLkV7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPg852ZbOToJsjBFmVCEkux1UsFaDyme8oBzcCfEb/XoMCCln
	u+RkQpMJc8Z66mLA98KTXBJjAuZyhG8qC6YUCpgc2QPMhZxIn2wzo8Cz
X-Gm-Gg: AY/fxX4wSswdKXjoVt0cAdH5jxPy4yNFQ1UAV3W4WKQyFTnH2uv+Kn0dJKX9+a+5o4X
	1FcWsFkAN0FUojjeatCEnmrCAvA6XYjN8/kuF0AXkE/XKNyKK9g7DYyHMcXiFElibZAiQn7SYP5
	xk1BNs4AGLhiK3GPCWVUqinjASiJxl2xmzaYivkigurBCy+B29tyMSbY3RdcGVff3YY2N3B25kI
	KpNolhiuDrH3/PCeu1p2LM3PflnuQYOHFQzCH4IoFQ9ogPqHnPuPWPmUPhf2NheIit0TtluE3OZ
	2XxF4EGFIziRpenWe0RG74mvs1Hg0SGDHRu7Uvx7Dy79JpizT4wm1rS+RRCt4RCXo//bZpko6Zl
	CxEkPwuFx6vs9KjJnBlQV4FkggwTJlddQ1wusZKGDlSX2BSqS32iy/I3Z8Vjvhfury6j0FQj3lU
	Ytu3QH95Ohlplanr+vVLNPhYahlcK1kUbMtxGI2A==
X-Received: by 2002:a05:7300:7494:b0:2a4:3594:72e3 with SMTP id 5a478bee46e88-2b6b3f2a8d7mr1242978eec.18.1768519956756;
        Thu, 15 Jan 2026 15:32:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b365564csm704078eec.27.2026.01.15.15.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:32:36 -0800 (PST)
Message-ID: <ae8d6ec3-8331-49dd-9880-2f8427994e6b@gmail.com>
Date: Thu, 15 Jan 2026 15:32:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164202.305475649@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

