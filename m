Return-Path: <stable+bounces-69242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68A953AD0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC91B20ACD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA3BA53;
	Thu, 15 Aug 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai1e7fav"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792311DDF5;
	Thu, 15 Aug 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749695; cv=none; b=rALY4o05slsS2j3FSzu7S3sxxDsHeKHaRSMS/+AkF3TtY+8c63MPTihx1GYDokvKJnBBlURKj3ZmYYXqSkQGLjwxbEy6VcolzNfP21iVQJ4MIoFrlDIMTRzxSYWu9wkz+1jfqUp2/G01phcWuFSHifL5a+RXVC+0/ClLsybRRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749695; c=relaxed/simple;
	bh=L8EPgfErufotgtcVogDTGa11kdtq+O4nYORBDNA/Lgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgfjtflPYdqLCsLV12V+0TTF4n9zPG6LeCWQ6YzPy0PaiofGvanlFbYkdNp59A6PYH4szpd88lNHMr5V7qrG/mnlXvrzBR3nYL4/Jro3UPQ7bSXi7Tjcv5f2ULJPhMYGyeIHRHFr9X6edHgDhm9aadgAQ8CuYAfsp7kKqcGx9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai1e7fav; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd70ba6a15so11587815ad.0;
        Thu, 15 Aug 2024 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749694; x=1724354494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Umz9hDXFSz3YBUb9yk0tQ3KFZaZp7tJt+ZRbi1r2fU0=;
        b=ai1e7favJeZcz+fFusvJ18pV9sDRABySy8b5+urVJvhfxWrlalfW1I7MZsm30Q1LEw
         DMtb3Kl9tPpcmdCAF9ipUulRK+3AF6fmd94xztYO6+jnKw9sWagOXQWfSb8YCnI/FoX5
         CJQuys845WNP7Yi5RpZfnAXAEf6/T9uwVe62to+HNBhLgI13+cqYXJSX3kSx6itYH55M
         gInAhPDbQW6Ixyv5+lnUtNrZmMkAYtErJqQD4WvsGZN7LC+pyzQJaemAd7smo43Ko+5K
         0QYmpgt3jWYjgN1u9xrY2JY5drribsnB4PPKPhSL+RK6ok1/6zFzNV7pjfGZyjKix3HQ
         qkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749694; x=1724354494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umz9hDXFSz3YBUb9yk0tQ3KFZaZp7tJt+ZRbi1r2fU0=;
        b=Oh8M1bJ2fnHk7T6Klw6qW5YrbiLn0I9npwsX60hCabjLdDYk2p1MscPrp/Y9VQz8In
         oE7v4J5tE/5DYveG35atVOM4z1xZIHRaMLAFrv9waEa5Ll5WhJua13WLHwUKkafrh2C1
         0WVCmMaVJfyjLwOpoJYfcluE7Jyrt5Rg7iMNueyBzYlEHgPA2bzLCfa4MDj3E7uKV0YW
         5kCr/wbpgnNd2o6XJFanRRD7niUOiR7/Z40yhzzilNEI4nUrluI6Pjzrwbn+bpFGCtK4
         vZg+5Hd+ztnE2vDepMWNbW6M6aQmlvjB5tEy7gT8S2s6KkO4kk/qDP6zYyqzcM9eD8RP
         He1w==
X-Forwarded-Encrypted: i=1; AJvYcCWn++ABYWo4aWRvpZN09PV27sut7dfwO6NRpPksKlE31i+m8dH7EOKzoKShs+ZVagcmETNbFsj2vQ3NPHc5Cqm/qRJdMfFKv3xKJ84U/RO/M0zSvAElcKc6Z6o3UdRY30dMlz9D
X-Gm-Message-State: AOJu0YymxvO/WRFw8lmPpu/qie9+hZLNOWNwrfdbV8x2mm5hiU4AbxxS
	toCVsTWVwejpEMX5TpNLt42vLATvR5PViwH+RpjQeOlonqzzDByk
X-Google-Smtp-Source: AGHT+IF7fvFs+8/4+eEtd/uO/sToK/u6WOiwUJ3JPwO8p43BjJXgCpRgn8uVmQNMyQanV4QZgamreg==
X-Received: by 2002:a17:902:f68c:b0:201:febc:436a with SMTP id d9443c01a7336-20203e868dbmr7931075ad.15.1723749693535;
        Thu, 15 Aug 2024 12:21:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03a1468sm13274725ad.271.2024.08.15.12.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 12:21:33 -0700 (PDT)
Message-ID: <d203bdb1-1ee3-4de5-9d20-1e2b08e710e7@gmail.com>
Date: Thu, 15 Aug 2024 12:21:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/259] 5.4.282-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131902.779125794@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.282 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.282-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


