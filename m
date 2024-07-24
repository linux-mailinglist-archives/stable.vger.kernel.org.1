Return-Path: <stable+bounces-61299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E75593B37F
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD632284085
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94B15B547;
	Wed, 24 Jul 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dG3GE7Ql"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80415B541
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834422; cv=none; b=bmppu0gGdXGOAI/SxkgtR5wRrcwawLwZO0+o5nJVVKipY66J4GZB4gq0ql52Qr8AbPjZcpF/O4zt9Lqpy1EEpReeH7gvVDRN+58oAM3Az1FTL77OcTjm50hXU6K5SplHDipZqlfRMXJfuaWZ39vjKv52pBNoaUsFUeK/jRT7qqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834422; c=relaxed/simple;
	bh=hOiV8755ngc0sIs6g41+2/lS4DWadZVscPT7P0F62i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4d/iBQSWfs42l2zZQFozwjRem6wfxDNH+avUv4bhQAbwls/hRu0U080jqGm+A7AJaObqRf3D44qXU25mr+JnnQ01r9MDc/Cthl58lmR3i1MLz9RiMtd6xAVeRUkYBDbt4UZZaZK+SP8C5GA0d3kVzPPkSL2BVXJ3gIR28bSpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dG3GE7Ql; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f70a7470d3so37339439f.0
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834420; x=1722439220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82dy9mZKo2zcgFYmuz7GnMY2lJ2OItmiPUYNnGgMWCU=;
        b=dG3GE7QlVuEd5GiRPfZdKcRZfX5MpSRk11Ze7azF6aCpiuMITFktuKSDcTgT9yVad4
         uQqSb4p6nZaV2rryJ2ec5gUhivfiKc/Q4ayKvmj+oCTSF4Uv351LcbhS9zM63LBQTa0t
         iSFNxq/8sTFg+B4t747PCB6kq/TSIqfzp/WDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834420; x=1722439220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82dy9mZKo2zcgFYmuz7GnMY2lJ2OItmiPUYNnGgMWCU=;
        b=ZQekC9cegExonAF9qVgISnKScI2ZpWS/JYi/CNC+AY5DtGk3XT59A4FSVmhM2O9YJO
         gwOraQfd1vogN7nGnyg35PNYyGdFkryuvJ+uUtKEfYeTSAbCTdd84PV+aKnZ6WGFT7pK
         h66PKBYQ5zA6zxIQIFv7Gnz2cif7c214rWVFQia0jUHTV2Ln64+pqPM1gfkGHxOp9PKM
         e22A18Hg0Lt2anwbp3W4/3HrtaNUF/Cj6lB/lzSTxpVu77QwADkG3/5msy4tHNWHmGHs
         DGPw0pGReKmaC3AwPeyjy6MSvWmMvcGQXegSP2wznds9gsIVFvS3tgnmTIc9rR6YdXgd
         kmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvO0wJCHknkA4P0MlR7BnvTdmWmIUXVbCL1b0mJceYufQtasDaCk0ZOxXZBgD2vQXGugCD0oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAjmG+WG7/HDDSsMgZ0eu/TYM8oMVasGiSY+ZFpStOBwYB1/u
	/8UiXJNMN9Bjua/FnuystMu+/SQuIJp8hLa4eb1YPkvtYFkXcku2veJWnzMJzCs=
X-Google-Smtp-Source: AGHT+IFlqZ25PE52Kwlz1STx1vDkygQoeHCGfiy+yguaY9+XTj2Eb/g0CwlJmwsN+B8v0pn4jmldEg==
X-Received: by 2002:a5d:9396:0:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-81f7be6a8f2mr11152539f.2.1721834419757;
        Wed, 24 Jul 2024 08:20:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f715eeb73sm53776039f.38.2024.07.24.08.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:20:19 -0700 (PDT)
Message-ID: <35b1fe1b-d062-4fce-9b9f-a74c84466f00@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:20:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.42-rc1.gz
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

