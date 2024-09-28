Return-Path: <stable+bounces-78190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64A9890B0
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D4F1C210DA
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23413B2A5;
	Sat, 28 Sep 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="goJ2hNqC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39B2940F
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543656; cv=none; b=ZZ+LGD/70QgvG1v6OkRVSZjAC4ymVMGAaX95vJFaeE9sWd+h8tiquBY7yynEjSDfiGJimv3lILXs/ZlKQ7yXWJB8UnUOhUqjQ/vAuL7Z+n9CoTbEFgpKfkg50E06iIAIQR+ImVsxbqusfsvlcd22pAkxniLm42pJG87QL4CmayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543656; c=relaxed/simple;
	bh=8h0mqtSR3cJMDeaf3gQShuu3Hb4p9VvJuvHRFRnHAPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pl/FuiVPz00s7YI45h8nh13naLWVO6aBvkE+L4gBtlu5/Sn6uQgez2Ie+l+P/QcsMy42Dh63v0uc+cgBHYImyuLcmGu4qIyDXkm7F4uouD2NxnE2yfNZwBaTVrTUwjaUItq8EsWuvd34ZEFznLGw6eK2oGavktMMi2XtjEDvO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=goJ2hNqC; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82aac438539so157355839f.1
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543654; x=1728148454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLNwBHV8ycc1jDSNmRLEZAE/y0F/roWJNJrPGAjRslk=;
        b=goJ2hNqC3p6zXmejcxBnKLqlx40aVm8ktE4wOMNmHLPhc4KZozZe8BAWd1wGqCtyBF
         PtmVRvxqYs4+h+bpVkrHMYiup085NURLyZYKggeAHA9d5Q9JRUwJbwhpVueLjYUNeBGl
         QEfOXl0qqZ2IfwrdAg7/hQEB+sWR4Ifx+Pmow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543654; x=1728148454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLNwBHV8ycc1jDSNmRLEZAE/y0F/roWJNJrPGAjRslk=;
        b=PA+yS5qsB2iW/mfIS/qEHaMEN6XyWF3JkL2SO1ev0XcVA+8h+SJe1Kg08addDx5z8k
         xD3KPbAR/hiXjTinJz0oze0NL6PCWBUuLYrSiBuV8Q7XD6h28IXNdHzgUo/ZMRpuwWoa
         +Y4vgJOnhoPrXf1JecKtLxzzglN+57YlGXndvgRVBY+S4XyGeJhQF/IP8XnhQbFURV8i
         svKVmJ3lkJkdDGMz6J7pdVFoXEfUrb1l6V0o2oCImUvTyP5lrxmI1p5DCeotHjFDMpiQ
         CawmBP6bLP3Tg75nTYE2C2qXCfkwfQknDs7MApBrnj6EfHgYdZk8bmHRoRUPHAzX45fW
         Nf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCqCbW5iRecJBxv+28TbXvfUYu58FdPhuI1QuxSNHvHUGBLZgl4icjuTpG7DF3xih3jU3D3BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2eb0FU31CixNCGrvdldyOVMB0/xqH+e9L+8xP1zwFFfgj0U6
	nccem8Zgt4tY/gvl9aFAwPIDz1fKs7HQQM0UaQgYPB0ZIaBbiBycpYJ+mnpoGR4=
X-Google-Smtp-Source: AGHT+IE9RveJoVWD7x2Ya2Bk/5CQLau7MKHDHNVEjxKmy7eCb4AU9uRuLzGDwv4IfvytwQOrO/ivTg==
X-Received: by 2002:a05:6602:2c84:b0:807:f0fb:1192 with SMTP id ca18e2360f4ac-834931ae42amr706616839f.1.1727543654576;
        Sat, 28 Sep 2024 10:14:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88884a6a5sm1185351173.43.2024.09.28.10.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:14:14 -0700 (PDT)
Message-ID: <7343743c-c44d-4dff-931f-80f782634fb5@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:14:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

